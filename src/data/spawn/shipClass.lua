ShipClass = {}
ShipClass.__index = ShipClass

function ShipClass:new(class, limit, range)
	--cria um contador para quantas naves do tipo "class" ha no jogo
	--"limit" eh o limite dessa nave que pode haver
	--"range" eh a area (retangulo) que a nave surge
	
	local S = {}
	setmetatable(S, ShipClass)
	
	S.class = class
	
	S.qty = 0
	S.limit = limit
	S.range = range
	
	return S
end

function ShipClass:spawn(pos)
	--cria uma nave desse tipo, na posicao "pos"
	newEnemy(self.class, pos)
	
	self.qty = self.qty + 1
end

function ShipClass:decrease(side)
	self.qty = self.qty - 1
end

function ShipClass:increaseLimit(n)
	self.limit = self.limit + n
end