require "effect/spawnblink"

local deckSize = Vector:new(60 * window.scale, 60 * window.scale)
local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/ship/ship5.png")
deck:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local deckDmg = MOAIGfxQuad2D.new()
deckDmg:setTexture("texture/ship/ship5dmg.png")
deckDmg:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

Player = {}
Player.__index = Player

function Player:new(pos)
	local P = {}
	P = Ship:new(deck, pos)
	setmetatable(P, Player)
	
	P.name = "Player"
	
	P.deck = deck
	P.deckDmg = deckDmg
	
	P.hp = 100
	P.maxHp = 100
	
	P.maxAcc = 0.25 * window.scale
	P.dec = P.maxAcc / 3
	P.maxSpd = 3.5 * window.scale
	P.minSpd = P.maxAcc / 5
	P.area.size = Rectangle:new(Vector:new(0, 0), deckSize)
	P.area:newRectangularArea(Vector:new(0, -0.4 * deckSize.y), Vector:new(0.8 * deckSize.x, 0.2 * deckSize.y))
	P.area:newRectangularArea(Vector:new(0, 0), Vector:new(0.2 * deckSize.x, 1.0 * deckSize.y))
	
	P.shotType = ShotLaserBlue
	P.shotSpd = 10 * window.scale
	P.fireRate = 0.5
	
	table.insert(P.wpn, Vector:new(0.6 * P.area.size.size.x, 1.0 * P.area.size.size.y))
	table.insert(P.wpn, Vector:new(-0.6 * P.area.size.size.x, 1.0 * P.area.size.size.y))
	
	table.insert(P.fla, Vector:new(0.6 * P.area.size.size.x, -0.1 * P.area.size.size.y))
	table.insert(P.fla, Vector:new(-0.6 * P.area.size.size.x, -0.1 * P.area.size.size.y))
	
	P.spawnDuration = 1.8
	
	P.expType = ExplosionType2
	P.expDuration = 1.2
	
	local spawnThread = coroutine.create(function()
		spawnBlink(P.sprite, P.spawnDuration)
		P.spawning = false
	end)
	coroutine.resume(spawnThread)
	table.insert(P.threads, spawnThread)
	
	-- hp regeneration
	local hpRegenThread = coroutine.create(function()
		Ship.hpRegen(P)
	end)
	coroutine.resume(hpRegenThread)
	table.insert(P.threads, hpRegenThread)
	
	return P
end

function Player:move()
	if self.spawned then
		-- define acceleration
		if input.left == true then self.acc.x = -self.maxAcc else self.acc.x = 0.0 end
		if input.right == true then self.acc.x = self.maxAcc end
		
		-- rotate ship
		if input.up == true and not self.rot:isActive() and self.aim.y == -1 then
			self.rot = self.sprite:moveRot(180, 0.8)
			self.aim.y = 1
		end
		
		if input.down == true and not self.rot:isActive() and self.aim.y == 1 then
			self.rot = self.sprite:moveRot(180, 0.8)
			self.aim.y = -1
		end
	else
		self.acc.x = 0
		self.acc.y = 0
	end
	
	Ship.move(self)
end

function Player:shoot()
	if self.spawned then
		if input.up == true and self.aim.y == 1 or
			input.down == true and self.aim.y == -1 then
			
			Ship.shoot(self, playerShots)
		end
	end
end

function Player:damaged(dmg)
	playerData:breakCombo()

	Ship.damaged(self, dmg)
end

function Player:muzzleflash()
	Ship.muzzleflashType1(self)
end