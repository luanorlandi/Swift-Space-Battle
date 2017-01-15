local deckSize = Vector:new(50 * screen.scale, 50 * screen.scale)

local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/ship/ship6.png")
deck:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local deckDmg = MOAIGfxQuad2D.new()
deckDmg:setTexture("texture/ship/ship6dmg.png")
deckDmg:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

EnemyType1 = {}
EnemyType1.__index = EnemyType1

function EnemyType1:new(pos)
	local E = {}
	E = Enemy:new(deck, pos)
	setmetatable(E, EnemyType1)
	
	E.name = "EnemyType1"
	E.type = 1
	
	E.deck = deck
	E.deckDmg = deckDmg
	
	E.hp = 40
	E.maxHp = 40
	
	E.maxAcc = 0.15 * screen.scale
	E.dec = E.maxAcc / 3
	E.maxSpd = 1.8 * screen.scale
	E.minSpd = E.maxAcc / 5
	E.area.size = Rectangle:new(Vector:new(0, 0), deckSize)
	E.area:newRectangularArea(Vector:new(0, 0), Vector:new(0.4 * deckSize.x, 0.8 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0, 0), Vector:new(0.6 * deckSize.x, 0.4 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0, -0.3 * deckSize.y), Vector:new(0.4 * deckSize.x, 0.8 * deckSize.y))
	
	E.shotType = ShotLaserRed
	E.shotSpd = 8 * screen.scale
	E.fireRate = 0.5
	
	table.insert(E.wpn, Vector:new(0.4 * E.area.size.size.x, 1.0 * E.area.size.size.y))
	table.insert(E.wpn, Vector:new(-0.4 * E.area.size.size.x, 1.0 * E.area.size.size.y))
	
	table.insert(E.fla, Vector:new(0.4 * E.area.size.size.x, 0.6 * E.area.size.size.y))
	table.insert(E.fla, Vector:new(-0.4 * E.area.size.size.x, 0.6 * E.area.size.size.y))
	
	E.score = 65
	
	local spawnThread = coroutine.create(function() 
		blend(E.sprite, E.spawnDuration)
		E.spawning = false
	end)
	coroutine.resume(spawnThread)
	table.insert(E.threads, spawnThread)
	
	-- EnemyType1 attributes
	E.moveRange = 100 * screen.scale
	E.shotRange = (2 / 3) * E.moveRange
	
	return E
end

function EnemyType1:move()
	if player.spawned then
		if self.pos.x >= player.pos.x and self.acc.x >= 0 then
			if self.pos.x < player.pos.x + self.moveRange then
				self.acc.x = self.maxAcc
			else
				self.acc.x = -self.maxAcc
			end
		else
			if self.pos.x > player.pos.x - self.moveRange and self.acc.x <= 0 then
				self.acc.x = -self.maxAcc
			else
				self.acc.x = self.maxAcc
			end
		end
	else
		self.acc.x = 0
		self.acc.y = 0
	end
	
	Ship.move(self)
end

function EnemyType1:shoot()
	if player.spawned then
		local prob = math.random(1, 100)

		if prob <= 5 then	-- 5% shoot probability
			-- ship must be close to the player
			if self.pos.x > player.pos.x - self.shotRange and self.pos.x < player.pos.x + self.shotRange then
				Ship.shoot(self, enemiesShots)
			end
		end
	end
end

function EnemyType1:damaged(dmg)
	Ship.damaged(self, dmg)
end

function EnemyType1:muzzleflash()
	Ship.muzzleflashType1(self)
end