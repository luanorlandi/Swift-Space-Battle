local deckSize = Vector:new(50 * window.scale, 50 * window.scale)

local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/ship/ship7.png")
deck:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local deckDmg = MOAIGfxQuad2D.new()
deckDmg:setTexture("texture/ship/ship7dmg.png")
deckDmg:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local muzzleflash = MOAIGfxQuad2D.new()
muzzleflash:setTexture("texture/effect/muzzleflashCyan.png")
muzzleflash:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

EnemyType3 = {}
EnemyType3.__index = EnemyType3

function EnemyType3:new(pos)
	local E = {}
	E = Enemy:new(deck, pos)
	setmetatable(E, EnemyType3)
	
	E.name = "EnemyType3"
	E.type = 3
	
	E.deck = deck
	E.deckDmg = deckDmg
	
	E.hp = 40
	E.maxHp = 40

	E.maxAcc = 0.03 * window.scale
	E.dec = E.maxAcc / 3
	E.maxSpd = 1 * window.scale
	E.minSpd = E.maxAcc / 5
	E.area.size = Rectangle:new(Vector:new(0, 0), deckSize)
	E.area:newRectangularArea(Vector:new(0.4 * deckSize.x, 0), Vector:new(0.2 * deckSize.x, 0.8 * deckSize.y))
	E.area:newRectangularArea(Vector:new(-0.4 * deckSize.x, 0), Vector:new(0.2 * deckSize.x, 0.8 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0, -0.7 * deckSize.y), Vector:new(0.2 * deckSize.x, 0.3 * deckSize.y))
	
	E.shotType = ShotLaserCyan
	E.shotSpd = 15 * window.scale
	E.fireRate = 1.5
	
	table.insert(E.wpn, Vector:new(0, 0.3 * E.area.size.size.y))
	
	E.flaDuration = 0.5
	
	E.spawnDuration = 1.5
	
	E.score = 100
	
	local spawnThread = coroutine.create(function() 
		blend(E.sprite, E.spawnDuration)
		E.spawning = false
	end)
	coroutine.resume(spawnThread)
	table.insert(E.threads, spawnThread)
	
	-- EnemyType3 attributes
	E.playerSize = 45 * window.scale
	E.shotRange = 40 * window.scale
	E.waitToMove = 10
	
	return E
end

function EnemyType3:move()
	if player.spawned then
		if self.fireLast < gameTime - self.waitToMove then
			if self.pos.x < player.pos.x then
				self.acc.x = self.maxAcc
			else
				self.acc.x = -self.maxAcc
			end
		else
			self.acc.x = 0
		end
	else
		self.acc.x = 0
		self.acc.y = 0
	end
	
	Ship.move(self)
end

function EnemyType3:shoot()
	if player.spawned then 
		if player.spd.x == 0 and near(self.pos.x, player.pos.x, self.playerSize) then
			Ship.shoot(self, enemiesShots)
		else
			if player.spd.x ~= 0 then
				local d1 = math.abs(self.pos.y) / self.shotSpd
				local d2 = (self.pos.x - player.pos.x) / player.spd.x
				
				if near(d1, d2, math.abs(self.shotRange / player.spd.x))then
					Ship.shoot(self, enemiesShots)
				end
			end
		end
	end
end

function EnemyType3:damaged(dmg)
	Ship.damaged(self, dmg)
end

function EnemyType3:muzzleflash()
	Ship.muzzleflashType2(self, muzzleflash)
end