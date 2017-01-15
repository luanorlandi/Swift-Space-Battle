require "shot/shot"
require "effect/blend"
require "effect/explosion"

require "ship/player"
require "ship/enemies"
require "ship/enemyType1"
require "ship/enemyType2"
require "ship/enemyType3"
require "ship/enemyType4"
require "ship/enemyType5"

local muzzleflashSize = Vector:new(10 * window.scale, 10 * window.scale)

local muzzleflash = MOAIGfxQuad2D.new()
muzzleflash:setTexture("texture/effect/muzzleflash.png")
muzzleflash:setRect(-muzzleflashSize.x, -muzzleflashSize.y, muzzleflashSize.x, muzzleflashSize.y)

-- Ship ------------------------------
Ship = {}
Ship.__index = Ship

function Ship:new(deck, pos)
	local S = {}
	setmetatable(S, Ship)
	
	S.name = "Ship"
	S.type = 0
	
	S.sprite = MOAIProp2D.new()
	changePriority(S.sprite, "ship")
	S.sprite:setDeck(deck)
	S.deck = deck
	S.deckDmg = deck
	
	S.hp = 100
	S.maxHp = 100
	
	S.dmgLast = gameTime	-- last time that receive damage
	S.regenRate = 20		-- hp regeneration per second
	S.regenCd = 2.5			-- cooldown to start regenerating hp
	
	S.status = "alive"
	
	S.pos = pos
	S.spd = Vector:new(0, 0)
	S.acc = Vector:new(0, 0)
	S.maxAcc = 0.1 * window.scale
	S.dec = S.maxAcc / 3
	S.maxSpd = 2 * window.scale
	S.minSpd = S.maxAcc / 5
	S.area = Area:new(Vector:new(0, 0))
	
	S.shotType = ShotLaserBlue
	S.shotSpd = 8 * window.scale
	S.fireLast = gameTime
	S.fireRate = 0.4
	
	S.aim = Vector:new(0, 1)
	S.wpn = {}				-- positions of where the shots appear
	
	S.flaDuration = 0.08
	S.fla = {}				-- positions of where the muzzle flashs appear
	
	S.spawning = true
	S.spawned = true
	S.spawnTime = gameTime
	S.spawnDuration = 1
	
	S.destroy = false
	S.expType = ExplosionType1
	S.expDuration = 0.8
	
	S.score = 100
	
	S.rot = S.sprite:moveRot(0, 0.1)
	
	-- table with the threads created by the object, so can be resumed
	S.threads = {}
	
	-- table with the sprites created by the threads, so can be removed
	S.threadsSprites = {}
	
	S.sprite:setLoc(S.pos.x, S.pos.y)
	layer:insertProp(S.sprite)
	
	return S
end

function Ship:move()
	-- define acceleration
	if self.acc.x == 0 and self.spd.x > 0 then self.acc.x = -self.dec end
	if self.acc.x == 0 and self.spd.x < 0 then self.acc.x = self.dec end
	if self.acc.y == 0 and self.spd.y > 0 then self.acc.y = -self.dec end
	if self.acc.y == 0 and self.spd.y < 0 then self.acc.y = self.dec end

	-- chech if exceed maximum acceleration
	if self.acc:norm() > self.maxAcc then
		self.acc:normalize()
		self.acc.x = self.acc.x * self.maxAcc
		self.acc.y = self.acc.y * self.maxAcc
	end
	
	-- define speed
	self.spd:sum(self.acc)
	
	-- check if speed is almost zero
	if self.spd.x < self.minSpd and self.spd.x > -self.minSpd then self.spd.x = 0 end
	if self.spd.y < self.minSpd and self.spd.y > -self.minSpd then self.spd.y = 0 end
	
	-- chech if exceed maximum speed
	if self.spd:norm() > self.maxSpd then
		self.spd:normalize()
		self.spd.x = self.spd.x * self.maxSpd
		self.spd.y = self.spd.y * self.maxSpd
	end
	
	-- define position
	self.pos:sum(self.spd)
	
	-- check if exceed the window size
	Ship.moveLimit(self)
	
	self.sprite:setLoc(self.pos.x, self.pos.y)
end

function Ship:moveLimit()
	if self.pos.x > window.width/2 + self.area.size.size.x then
		self.pos.x = -window.width/2 - self.area.size.size.x
	else if self.pos.x < -window.width/2 - self.area.size.size.x then
			self.pos.x = window.width/2 + self.area.size.size.x
		end
	end
end

function Ship:shoot(shots)
	if not self.rot:isActive() and not self.spawning and self.spawned and gameTime - self.fireLast >= self.fireRate then
		for i = 1, table.getn(self.wpn), 1 do
			Ship.newShot(self, shots, self.wpn[i])
		end
		
		local muzzleflashThread = coroutine.create(function() self:muzzleflash() end)
		coroutine.resume(muzzleflashThread)
		table.insert(self.threads, muzzleflashThread)
		
		self.fireLast = gameTime
	end
end

function Ship:newShot(shots, pos)
	local shot = self.shotType:new(Vector:new(self.pos.x + pos.x, self.pos.y + self.aim.y * pos.y))
	
	shot.spd.x = self.aim.x * self.shotSpd
	shot.spd.y = self.aim.y * self.shotSpd
	
	table.insert(shots, shot)
end

function Ship:moveLimit()
	if self.pos.x > window.width/2 + self.area.size.size.x then
		self.pos.x = -window.width/2 - self.area.size.size.x
	else if self.pos.x < -window.width/2 - self.area.size.size.x then
			self.pos.x = window.width/2 + self.area.size.size.x
		end
	end
end

function Ship:destroy()
	-- remove ship sprite
	layer:removeProp(self.sprite)
	
	-- remove all sprite effects created by his threads
	for i = 1, table.getn(self.threadsSprites), 1 do
		layer:removeProp(self.threadsSprites[1])
		table.remove(self.threadsSprites, 1)
	end
end

function Ship:spawnSize()
	self.sprite:moveScl(-1, -1, 0)
	local resizing = self.sprite:moveScl(1, 1, self.spawnDuration)

	while resizing:isActive() do
		coroutine.yield()
	end
	
	self.spawning = false
end

function Ship:damaged(dmg)
	-- receive a damage, create a animation effect for the hit

	self.hp = self.hp - dmg
	self.dmgLast = gameTime
	
	local damageThread = coroutine.create(function() 
		self.sprite:setDeck(self.deckDmg)
		
		for i = 0, dmg, 20 do
			coroutine.yield()
		end
		self.sprite:setDeck(self.deck)
	end)
	table.insert(self.threads, damageThread)
	
	if self.hp <= 0 then
		self.status = "dead"
	end
end

function Ship:explode()
	self.spawned = false
	self.sprite:moveScl(-1, -1, self.expDuration/2)

	local explosion = self.expType:new(Vector:new(self.pos.x, self.pos.y), self.expDuration)
	table.insert(self.threadsSprites, explosion)

	explosion.anim:start()
	
	while explosion.anim:isActive() do
		coroutine.yield()
	end
	layer:removeProp(explosion.sprite)
	self.destroy = true
end

function Ship:muzzleflashType1()
	local mf = {}
	
	for i = 1, table.getn(self.fla), 1 do
		local flash = MOAIProp2D.new()
		changePriority(flash, "effect")
		table.insert(self.threadsSprites, flash)
		
		flash:setDeck(muzzleflash)
		flash:setLoc(self.pos.x + self.fla[i].x, self.pos.y + self.aim.y * self.fla[i].y)
		flash:moveScl(-1, -1, self.flaDuration)
		layer:insertProp(flash)
		
		table.insert(mf, flash)
	end
	
	local start = gameTime
	
	while gameTime - start < self.flaDuration do
		coroutine.yield()
		for i = 1, table.getn(mf), 1 do
			mf[i]:setLoc(self.pos.x + self.fla[i].x, self.pos.y + self.aim.y * self.fla[i].y)
		end
	end

	while table.getn(mf) ~= 0 do
		layer:removeProp(mf[1])
		table.remove(mf, 1)
	end
end

function Ship:muzzleflashType2(deck)
	local flash = MOAIProp2D.new()
	changePriority(flash, "effect")
	table.insert(self.threadsSprites, flash)
	
	flash:setDeck(deck)
	flash:setLoc(self.pos.x, self.pos.y)
	if self.aim.y < 0 then flash:moveRot(180, 0) end
	
	local blendThread = coroutine.create(function() blendOut(flash, self.flaDuration) end)
	coroutine.resume(blendThread)
	
	layer:insertProp(flash)
	
	local start = gameTime
	
	while gameTime - start < self.flaDuration and coroutine.status(blendThread) ~= "dead" do
		coroutine.yield()
		coroutine.resume(blendThread)
		flash:setLoc(self.pos.x, self.pos.y)
	end
	
	layer:removeProp(flash)
end

function Ship:hpRegen()
	local lastRegen = gameTime
	
	while self.status ~= "dead" do
		coroutine.yield()
		
		if gameTime > self.dmgLast + self.regenCd and self.hp < self.maxHp then
			local hpHeal = self.regenRate * (gameTime - lastRegen)
			self.hp = self.hp + hpHeal
			
			if self.hp > self.maxHp then
				-- check for overheal
				self.hp = self.maxHp
			end
		end
		
		lastRegen = gameTime
	end
end

function newEnemy(type, pos)
	table.insert(enemies, type:new(pos))
end

function shipsMove()
	player:move()
	
	for i = 1, table.getn(enemies), 1 do
		enemies[i]:move()
	end
end

function enemiesShoot()
	for i = 1, table.getn(enemies), 1 do
		enemies[i]:shoot()
	end
end

function shipsCheckStatus()
	-- check if the player died
	if player.status == "dead" then
		if player.spawned then
			local explodeThread = coroutine.create(function() Ship.explode(player) end)
			table.insert(player.threads, explodeThread)
		end
	end

	-- check if an enemy died
	local e = 1
	while e <= table.getn(enemies) do
		local ship = enemies[e]
		
		if ship.status ~= "dead" then
			e = e + 1
		else
			table.remove(enemies, e)
			table.insert(deadShips, ship)
			
			playerData:scoreEnemy(ship.score, ship.pos)
			spawner:decrease(ship.type, ship.pos.y)
			
			local explodeThread = coroutine.create(function() Ship.explode(ship) end)
			table.insert(ship.threads, explodeThread)
		end
	end
	
	-- check if the player exploded
	if player.destroy then
		Ship.destroy(player)
		playerData:dead()
	end
	
	-- check if any enemy dead has exploded
	local d = 1
	while d <= table.getn(deadShips) do
		local ship = deadShips[d]
		
		if ship.destroy then
			
			Ship.destroy(ship)
			table.remove(deadShips, d)
		else
			d = d + 1
		end
	end
end

function shipsClear()
	Ship.destroy(player)
	
	for i = 1, table.getn(enemies), 1 do
		Ship.destroy(enemies[1])
		table.remove(enemies, 1)
	end
	
	for i = 1, table.getn(deadShips), 1 do
		Ship.destroy(deadShips[1])
		table.remove(deadShips, 1)
	end
end