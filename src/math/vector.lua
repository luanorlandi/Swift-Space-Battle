Vector = {}
Vector.__index = Vector

function Vector:new(a, b)
	local V = {}
	setmetatable(V, Vector)
	
	V.x = a
	V.y = b
	
	return V
end

function Vector:sum(b)
	self.x = self.x + b.x
	self.y = self.y + b.y
end

function Vector:equal(b)
	self.x = b.x
	self.y = b.y
end

function Vector:norm()
	return math.sqrt((self.x)^2 + (self.y)^2, 2)
end

function Vector:normalize()
	local norm = self:norm()
	if norm ~= 0 then
		self.x = self.x / norm
		self.y = self.y / norm
	end
end