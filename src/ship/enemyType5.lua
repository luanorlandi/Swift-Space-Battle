local deckSize = Vector:new(50 * window.scale, 50 * window.scale)

local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/ship/ship10.png")
deck:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local deckDmg = MOAIGfxQuad2D.new()
deckDmg:setTexture("texture/ship/ship10dmg.png")
deckDmg:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local muzzleflash = MOAIGfxQuad2D.new()
muzzleflash:setTexture("texture/effect/muzzleflashRed.png")
muzzleflash:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

EnemyType5 = {}
EnemyType5.__index = EnemyType5

function EnemyType5:new(pos)
	local E = {}
	E = Enemy:new(deck, pos)
	setmetatable(E, EnemyType5)
	
	E.name = "EnemyType5"
	E.type = 5
	
	E.deck = deck
	E.deckDmg = deckDmg
	
	E.hp = 40
	E.maxHp = 40
	
	E.maxAcc = 0.06 * window.scale
	E.dec = E.maxAcc / 3
	E.maxSpd = 2.2 * window.scale
	E.minSpd = E.maxAcc / 5
	E.area.size = Rectangle:new(Vector:new(0, 0), deckSize)
	E.area:newRectangularArea(Vector:new(0, -0.5 * deckSize.y), Vector:new(0.8 * deckSize.x, 0.3 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0, 0), Vector:new(0.2 * deckSize.x, 0.2 * deckSize.y))
	
	E.area:newRectangularArea(Vector:new(0.7 * deckSize.x, 0.1 * deckSize.y), Vector:new(0.1 * deckSize.x, 0.3 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0.7 * deckSize.x, -0.1 * deckSize.y), Vector:new(0.1 * deckSize.x, 0.3 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0.6 * deckSize.x, 0.6 * deckSize.y), Vector:new(0.2 * deckSize.x, 0.2 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0.6 * deckSize.x, -0.6 * deckSize.y), Vector:new(0.2 * deckSize.x, 0.2 * deckSize.y))
	
	E.shotType = ShotStar
	E.shotSpd = 5 * window.scale
	E.fireRate = 2
	
	table.insert(E.wpn, Vector:new(0, 0.8 * E.area.size.size.y))
	
	E.flaType = muzzleflash
	E.flaDuration = 2
	
	E.score = 75
	
	local spawnThread = coroutine.create(function() Ship.spawnSize(E) end)
	coroutine.resume(spawnThread)
	table.insert(E.threads, spawnThread)
	
	-- EnemyType5 attributes
	E.startPos = Vector:new(pos.x, pos.y)
	E.verticalSizeRange = (window.width / 2) / 14
	E.moveRange = Vector:new((window.width / 2 - E.area.size.size.x) * 0.75, E.verticalSizeRange)
	
	E.acc.x = E.maxAcc
	E.acc.y = E.maxAcc
	
	return E
end

function EnemyType5:move()
	if self.pos.x > self.moveRange.x and self.acc.x >= 0 then
		self.acc.x = -self.maxAcc
	else
		if self.pos.x < -self.moveRange.x and self.acc.x <= 0 then
			self.acc.x = self.maxAcc
		end
	end

	if self.pos.y > self.startPos.y + self.moveRange.y and self.acc.y >= 0 then
		self.acc.y = -self.maxAcc
	else
		if self.pos.y < self.startPos.y - self.moveRange.y and self.acc.y <= 0 then
			self.acc.y = self.maxAcc
		end
	end
	
	Ship.move(self)
end

function EnemyType5:shoot()
	Ship.shoot(self, enemiesShots)
end

function EnemyType5:damaged(dmg)
	Ship.damaged(self, dmg)
end

function EnemyType5:muzzleflash()
	Ship.muzzleflashType2(self, muzzleflash)
end