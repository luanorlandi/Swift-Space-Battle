require "shot/shotLaserBlue"
require "shot/shotLaserRed"
require "shot/shotLaserGreen"
require "shot/shotLaserCyan"
require "shot/shotLaserMagenta"
require "shot/shotStar"

Shot = {}
Shot.__index = Shot

function Shot:new(deck, pos)
	local S = {}
	setmetatable(S, Shot)
	
	S.sprite = MOAIProp2D.new()	
	changePriority(S.sprite, "shot")
	S.sprite:setDeck(deck)
	
	S.dmg = 20
	
	S.pos = pos
	S.spd = Vector:new(0, 0)
	S.area = Area:new(Vector:new(0, 0))
	
	S.sprite:setLoc(S.pos.x, S.pos.y)
	window.layer:insertProp(S.sprite)
	
	return S
end

function Shot:move()
	self.pos:sum(self.spd)
	self.sprite:setLoc(self.pos.x, self.pos.y)
end

function Shot:destroy()
	window.layer:removeProp(self.sprite)
end

function shotsMove()
	local s = 1
	while s <= table.getn(playerShots) do
		playerShots[s]:move()
		if not shotCheckDistant(playerShots, s) then
			s = s + 1
		end
	end
	
	s = 1
	while s <= table.getn(enemiesShots) do
		enemiesShots[s]:move()
		if not shotCheckDistant(enemiesShots, s) then
			s = s + 1
		end
	end

	if not player.spawning and player.spawned then
		shotsCheckCollision(enemiesShots, player)
	end

	for i = 1, table.getn(enemies), 1 do
		if not enemies[i].spawning and enemies[i].spawned then
			shotsCheckCollision(playerShots, enemies[i])
		end
	end
end

function shotsCheckCollision(shots, ship)
	local s = 1
	local hit = false
	
	while s <= table.getn(shots) and not hit do
		local shot = shots[s]
		
		if shot.area:detectCollision(Vector:new(0, 1), shot.pos, ship.area, ship.aim, ship.pos) then
		hit = true
			ship:damaged(shot.dmg)
			
			Shot.destroy(shot)
			table.remove(shots, s)
		else
			s = s + 1
		end
	end
end

function shotCheckDistant(shots, s)
	if shots[s].pos.x > window.width or
		shots[s].pos.x < -window.width or
		shots[s].pos.y > window.height or
		shots[s].pos.y < -window.height then
		
		Shot.destroy(shots[s])
		table.remove(shots, s)
		
		return true
	end
	
	return false
end

function shotsClear()
	for i = 1, table.getn(playerShots), 1 do
		window.layer:removeProp(playerShots[1].sprite)
		table.remove(playerShots, 1)
	end
	
	for i = 1, table.getn(enemiesShots), 1 do
		window.layer:removeProp(enemiesShots[1].sprite)
		table.remove(enemiesShots, 1)
	end
end
