require "data/ship/ship"
require "data/spawn/shipClass"

Spawner = {}
Spawner.__index = Spawner

function Spawner:new()
	--cria um gerador de naves, que controla o numero de naves no jogo
	local S = {}
	setmetatable(S, Spawner)
	
	S.rate = 3
	S.normalRate = 3
	S.fastRate = S.rate * (3/4)
	S.veryFastRate = S.rate * (2/4)
	S.last = gameTime + 2				-- 2 segundos iniciais sem aparecer inimigos
	
	S.areaAll, S.areaBack, S.areaCenter = spawnAreas()
	
	S.total = 0
	S.limit = 0
	S.totalUp = 0
	S.totalDown = 0
	S.maxSide = 0			-- limite de diferenca para naves do mesmo lado
	
	S.shipsClass = {}
	
	S.shipsAvailables = {}
	
	return S
end

function Spawner:spawn()
	-- verifica se ha naves para serem criadas
	if gameTime - self.last > self.rate and self.total < self.limit then
		-- define qual lado deve criar a nave, se os dois forem validos, seleciona um deles aleatoriamente]
		-- lado para cima, -1 = para baixo
		local side = math.random(1, 2)
		if side == 2 then side = -1 end
		
		if self.totalUp < self.totalDown - self.maxSide then
			side = 1
		else
			if self.totalDown < self.totalUp - self.maxSide then
				side = -1
			end
		end
		
		if side == 1 then
			self.totalUp = self.totalUp + 1
		else
			self.totalDown = self.totalDown + 1
		end
		
		self.total = self.total + 1
		
		-- define qual nave sera criada
		local rand = math.random(1, table.getn(self.shipsAvailables))	-- sorteia uma nave disponivel para criar
		
		local ship = self.shipsAvailables[rand]	-- pega a classe da nave selecionada para criar
		
		-- define onde a nave sera criada
		local pos = randomPosition(side, self.shipsClass[ship].range)
		-- cria a nave e remove ela do vetor de naves disponiveis
		self.shipsClass[ship]:spawn(pos)
		table.remove(self.shipsAvailables, rand)
		
		self.last = gameTime
	end
	
	self:changeRate()
end

function Spawner:decrease(class, side)
	--diminui a quantidade de naves da classe "class", do lado "side"
	self.total = self.total - 1
	
	if side > 0 then
		self.totalUp = self.totalUp - 1 
	else
		self.totalDown = self.totalDown - 1
	end
	
	self.shipsClass[class]:decrease(side)
	
	self:insertShipClass(class, 1)
end

function Spawner:insertShipClass(class, qty)
	for i = 1, qty, 1 do
		table.insert(self.shipsAvailables, class)
	end
end

function spawnAreas()
	local highestX = 0.9 * (screen.width/2)
	
	local lowestY = 0.4 * (screen.height/2)
	local highestY = 0.9 * (screen.height/2)
	local halfY = (highestY - lowestY) / 2 + lowestY

	local all = Rectangle:new(Vector:new(0, halfY), Vector:new(highestX, halfY - lowestY))
	
	highestX = 0.8 * (screen.width/2)
	
	lowestY = 0.75 * (screen.height/2)
	highestY = 0.9 * (screen.height/2)
	halfY = (highestY - lowestY) / 2 + lowestY
	
	local back = Rectangle:new(Vector:new(0, halfY), Vector:new(highestX, halfY - lowestY))
	
	highestX = 0.6 * (screen.width/2)
	
	lowestY = 0.5 * (screen.height/2)
	highestY = 0.8 * (screen.height/2)
	halfY = (highestY - lowestY) / 2 + lowestY
	
	local center = Rectangle:new(Vector:new(0, halfY), Vector:new(highestX, halfY - lowestY))
	
	return all, back, center
end

function randomPosition(side, range)
	--retorna uma posicao aleatoria que esta dentro da area "range", no lado "side"
	local pos = Vector:new(0, 0)
	
	pos.x = math.random(range.center.x - range.size.x, range.center.x + range.size.x)
	pos.y = math.random(range.center.y - range.size.y, range.center.y + range.size.y)
	
	pos.y = pos.y * side
	
	return pos
end

function Spawner:changeRate()
	if self.total == 0 and self.rate ~= self.veryFastRate then
		self.rate = self.veryFastRate
	else if self.total == 1 and self.rate ~= self.fastRate then 
		self.rate = self.fastRate
		else
			self.rate = self.normalRate
		end
	end
end

function Spawner:levelUp()
	-- essa funcao avanca de nivel cada vez que for resumida
	
	-- level 1
	self.normalRate = 3
	self.fastRate = self.rate * (4/4)
	self.veryFastRate = self.rate * (4/4)
	
	self.limit = 2
	self.maxSide = 2
	
	table.insert(self.shipsClass, 2, ShipClass:new(EnemyType2, 2, self.areaAll))
	
	self:insertShipClass(2, self.shipsClass[2].limit)
	coroutine.yield()
	
	-- level 2
	self.normalRate = 2.9
	self.fastRate = self.rate * (4/4)
	self.veryFastRate = self.rate * (3/4)
	
	table.insert(self.shipsClass, 1, ShipClass:new(EnemyType1, 1, self.areaAll))
	
	self:insertShipClass(1, self.shipsClass[1].limit)
	coroutine.yield()
	
	-- level 3
	self.normalRate = 2.8
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	
	table.insert(self.shipsClass, ShipClass:new(EnemyType3, 1, self.areaBack))
	
	self:insertShipClass(3, self.shipsClass[3].limit)
	coroutine.yield()
	
	-- level 4
	self.normalRate = 2.7
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	
	table.insert(self.shipsClass, ShipClass:new(EnemyType4, 1, self.areaAll))
	
	self:insertShipClass(4, self.shipsClass[4].limit)
	coroutine.yield()
	
	-- level 5
	self.normalRate = 2.6
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	
	table.insert(self.shipsClass, ShipClass:new(EnemyType5, 1, self.areaCenter))
	
	self:insertShipClass(5, self.shipsClass[5].limit)
	coroutine.yield()

	-- level 6
	self.normalRate = 2.5
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	
	self.limit = 3
	
	for i = 1, table.getn(self.shipsClass), 1 do
		self.shipsClass[i]:increaseLimit(1)
		self:insertShipClass(i, 1)
	end
	coroutine.yield()
	
	-- level 7
	self.normalRate = 2.4
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	
	self.shipsClass[1]:increaseLimit(1)
	self:insertShipClass(1, 1)
	
	self.shipsClass[3]:increaseLimit(1)
	self:insertShipClass(3, 1)
	
	self.shipsClass[4]:increaseLimit(1)
	self:insertShipClass(4, 1)
	
	self.shipsClass[5]:increaseLimit(1)
	self:insertShipClass(5, 1)
	coroutine.yield()
	
	-- level 8
	self.normalRate = 2.3
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	coroutine.yield()
	
	-- level 9
	self.normalRate = 2.2
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	coroutine.yield()
	
	-- level 10
	self.normalRate = 2.1
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	
	self.limit = 4
	coroutine.yield()
	
	-- level 11
	self.normalRate = 2.0
	self.fastRate = self.rate * (3/4)
	self.veryFastRate = self.rate * (2/4)
	coroutine.yield()
	
	-- level 12
	self.normalRate = 1.9
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (2/4)
	coroutine.yield()
	
	-- level 13
	self.normalRate = 1.8
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (2/4)
	
	self.limit = 5
	self.maxSide = 1
	coroutine.yield()
	
	-- level 14
	self.normalRate = 1.7
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (1/4)
	coroutine.yield()
	
	-- level 15
	self.normalRate = 1.6
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (1/4)
	
	self.limit = 6
	coroutine.yield()
	
	-- level 16
	self.normalRate = 1.5
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (1/4)
	
	self.limit = 7
	coroutine.yield()
	
	-- level 17
	self.normalRate = 1.4
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (1/4)
	
	self.limit = 8
	coroutine.yield()
	
	-- level 18
	self.normalRate = 1.3
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (1/4)
	
	self.limit = 9
	coroutine.yield()
	
	-- level 19
	self.normalRate = 1.2
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (1/4)
	
	self.limit = 10
	coroutine.yield()
	
	-- level 20
	self.normalRate = 1.0
	self.fastRate = self.rate * (2/4)
	self.veryFastRate = self.rate * (1/4)
	
	self.limit = 10
end