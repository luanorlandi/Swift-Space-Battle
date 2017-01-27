local deckSize = Vector:new(50 * window.scale, 50 * window.scale)

local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/ship/ship8.png")
deck:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local deckDmg = MOAIGfxQuad2D.new()
deckDmg:setTexture("texture/ship/ship8dmg.png")
deckDmg:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

local muzzleflash = MOAIGfxQuad2D.new()
muzzleflash:setTexture("texture/effect/muzzleflash.png")
muzzleflash:setRect(-deckSize.x, -deckSize.y, deckSize.x, deckSize.y)

EnemyType4 = {}
EnemyType4.__index = EnemyType4

function EnemyType4:new(pos)
	local E = {}
	E = Enemy:new(deck, pos)
	setmetatable(E, EnemyType4)
	
	E.name = "EnemyType4"
	E.type = 4
	
	E.deck = deck
	E.deckDmg = deckDmg
	
	E.hp = 20
	E.maxHp = 20

	E.maxAcc = 0.15 * window.scale
	E.dec = E.maxAcc / 3
	E.maxSpd = 1.2 * window.scale
	E.minSpd = E.maxAcc / 5
	E.area.size = Rectangle:new(Vector:new(0, 0), deckSize)
	E.area:newRectangularArea(Vector:new(0, 0.3 * deckSize.y), Vector:new(0.75 * deckSize.x, 0.2 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0, 0), Vector:new(1.0 * deckSize.x, 0.2 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0, -0.1 * deckSize.y), Vector:new(0.5 * deckSize.x, 0.5 * deckSize.y))
	E.area:newRectangularArea(Vector:new(0.9 * deckSize.x, 0.25 * deckSize.y), Vector:new(0.1 * deckSize.x, 0.65 * deckSize.y))
	
	E.shotType = ShotLaserMagenta
	E.shotSpd = 7 * window.scale
	E.fireRate = 0.3
	
	table.insert(E.wpn, Vector:new(0, 0.80 * E.area.size.size.y))
	
	E.flaDuration = 0.5
	table.insert(E.fla, Vector:new(0, 0.80 * E.area.size.size.y))
	
	E.spawnDuration = 1.5
	
	E.score = 80
	
	local spawnThread = coroutine.create(function() Ship.spawnSize(E) end)
	coroutine.resume(spawnThread)
	table.insert(E.threads, spawnThread)
	
	-- EnemyType4 attributes
	E.closeToTarget = 15 * window.scale
	E.shotRange = 40 * window.scale
	
	-- blink ability
	E.blinkCd = 3.5
	E.blinkLast = E.spawnTime
	E.blinkActive = false
	E.blinkDuration = 1
	E.blinkShotClose = 200 * window.scale
	
	return E
end

function EnemyType4:move()
	if player.spawned then
		if not near(self.pos.x, player.pos.x, self.closeToTarget) then
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
	
	self:checkBlink()
	
	Ship.move(self)
end

function EnemyType4:shoot()
	if player.spawned and near(self.pos.x, player.pos.x, self.shotRange) then
		Ship.shoot(self, enemiesShots)
	end
end

function EnemyType4:damaged(dmg)
	Ship.damaged(self, dmg)
end

function EnemyType4:muzzleflash()
	Ship.muzzleflashType1(self)
end

function EnemyType4:checkBlink()
	-- check if blink ability is available and should be used
	if self.blinkLast <= gameTime - self.blinkCd and not self.blinkActive and not self.spawning then
		if self:shotClose() then
			local blinkThread = coroutine.create(function()
				self.spawned = false
				self:blink()
				self.spawned = true
			end)
			coroutine.resume(blinkThread)
			table.insert(self.threads, blinkThread)
		end
	end
end

function EnemyType4:shotClose()
	for i = 1, #playerShots, 1 do
		if near(self.pos.y, playerShots[i].pos.y, self.blinkShotClose) then
			if near(self.pos.x, playerShots[i].pos.x, self.shotRange) then
				return true
			end
		end
	end
	
	return false
end

function EnemyType4:blink()
	self.blinkActive = true
	self.blinkLast = gameTime
	
	local resizing = self.sprite:moveScl(-1, -1, self.blinkDuration / 2)
	while resizing:isActive() do
		coroutine.yield()
	end
	
	self.pos.y = -self.pos.y
	self.pos.x = player.pos.x
	self.sprite:moveRot(180, 0)
	self.aim.y = -self.aim.y
	
	local resizing = self.sprite:moveScl(1, 1, self.blinkDuration / 2)
	while resizing:isActive() do
		coroutine.yield()
	end
		
	self.blinkActive = false
end