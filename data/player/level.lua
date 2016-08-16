Level = {}
Level.__index = Level

function Level:new(spawner)
	local L = {}
	setmetatable(L, Level)
	
	L.active = true
	
	L.current = 1
	L.max = 20
	
	-- duracao que fica em cada level
	L.duration = 45
	
	L.lastLevelUp = gameTime
	
	L.threadCheckLevel = coroutine.create(function()
		L:checkLevel()
	end)
	coroutine.resume(L.threadCheckLevel)
	
	L.threadLevelUp = coroutine.create(function()
		spawner:levelUp()
	end)
	coroutine.resume(L.threadLevelUp)
	
	return L
end

function Level:checkLevel()
	while self.active do
		coroutine.yield()
		
		if gameTime > self.lastLevelUp + self.duration then
			self.current = self.current + 1
			
			coroutine.resume(self.threadLevelUp)
			
			self.lastLevelUp = gameTime
		end
		
		if self.current == self.max then
			self.active = false
		end
	end
end