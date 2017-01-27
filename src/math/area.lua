require "math/vector"
require "math/rectangle"

Area = {}
Area.__index = Area

function Area:new(size)
	local A = {}
	setmetatable(A, Area)

	A.size = Rectangle:new(Vector:new(0, 0), Vector:new(size.x, size.y))
	A.hitbox = {}
	
	return A
end

function Area:newRectangularArea(c, v)
	local rectangle = Rectangle:new(c, v)
	table.insert(self.hitbox, rectangle)
end

function Area:detectCollision(orientationA, posA, b, orientationB, posB)
	-- self = area A
	-- b = area B
	-- orientation = if it is inverted

	local sizeA = self.size:copy(orientationA, posA)
	local sizeB = b.size:copy(orientationB, posB)
	local intersection = false
	
	if sizeA:intersection(sizeB) then
		local i = 1
		while not intersection and i <= #self.hitbox do
			local rectangleA = self.hitbox[i]:copy(orientationA, posA)
			
			local j = 1
			while not intersection and j <= #b.hitbox do
				local rectangleB = b.hitbox[j]:copy(orientationB, posB)
				
				intersection = rectangleA:intersection(rectangleB)
				j = j + 1
			end
			i = i + 1
		end
	end
	
	return intersection
end