ShipClass = {}
ShipClass.__index = ShipClass

function ShipClass:new(class, limit, range)
	-- create a counter for how much ship of type "class" are in the game
	-- "limit" is the limit of ships of type "class"
	-- "range" is the area (rectangle) that the ship spawn
	
	local S = {}
	setmetatable(S, ShipClass)
	
	S.class = class
	
	S.qty = 0
	S.limit = limit
	S.range = range
	
	return S
end

function ShipClass:spawn(pos)
	-- create a ship of this type, in position "pos"
	newEnemy(self.class, pos)
	
	self.qty = self.qty + 1
end

function ShipClass:decrease(side)
	self.qty = self.qty - 1
end

function ShipClass:increaseLimit(n)
	self.limit = self.limit + n
end