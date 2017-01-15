local deckSize = Vector:new(50 * screen.scale, 50 * screen.scale)

local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/ship/ship9.png")
deck:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local deckDmg = MOAIGfxQuad2D.new()
deckDmg:setTexture("texture/ship/ship9dmg.png")
deckDmg:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

EnemyType2 = {}
EnemyType2.__index = EnemyType2

function EnemyType2:new(pos)
	local E = {}
	E = Enemy:new(deck, pos)
	setmetatable(E, EnemyType2)
	
	E.name = "EnemyType2"
	E.type = 2
	
	E.deck = deck
	E.deckDmg = deckDmg
	
	E.hp = 60
	E.maxHp = 60
	
	E.maxAcc = 0.1 * screen.scale
	E.dec = E.maxAcc / 3
	E.maxSpd = 1.6 * screen.scale
	E.minSpd = E.maxAcc / 5	
	E.area.size = Rectangle:new(Vector:new(0, 0), deckSize)
	E.area:newRectangularArea(Vector:new(0, 0), Vector:new(0.4 * deckSize.x, 0.8 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0, -0.2 * deckSize.y), Vector:new(0.8 * deckSize.x, 0.4 * deckSize.y))
	
	E.shotType = ShotLaserGreen
	E.shotSpd = 8 * screen.scale
	E.fireRate = 0.5
	
	table.insert(E.wpn, Vector:new(0.5 * E.area.size.size.x, 0.8 * E.area.size.size.y))
	table.insert(E.wpn, Vector:new(-0.5 * E.area.size.size.x, 0.8 * E.area.size.size.y))
	
	table.insert(E.fla, Vector:new(0.5 * E.area.size.size.x, 0.2 * E.area.size.size.y))
	table.insert(E.fla, Vector:new(-0.5 * E.area.size.size.x, 0.2 * E.area.size.size.y))
	
	E.score = 50
	
	local spawnThread = coroutine.create(function() Ship.spawnSize(E) end)
	coroutine.resume(spawnThread)
	table.insert(E.threads, spawnThread)
	
	-- EnemyType2 attributes
	E.moveRange = (screen.width / 2 - E.area.size.size.x) * 0.95
	
	return E
end

function EnemyType2:move()
	if self.pos.x > self.moveRange or self.acc.x == 0 then
		self.acc.x = -self.maxAcc
	else
		if self.pos.x < -self.moveRange then
			self.acc.x = self.maxAcc
		end
	end
	
	Ship.move(self)
end

function EnemyType2:shoot()
	local prob = math.random(1, 100)
		
	if prob <= 1 then	-- 1% shoot probability
		Ship.shoot(self, enemiesShots)
	end
end

function EnemyType2:damaged(dmg)
	Ship.damaged(self, dmg)
end

function EnemyType2:muzzleflash()
	Ship.muzzleflashType1(self)
end