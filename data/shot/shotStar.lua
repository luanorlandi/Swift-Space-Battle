local size = Vector:new(16 * screen.scale, 16 * screen.scale)

local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/shot/starshot.png")
deck:setRect(-size.x, -size.y, size.x, size.y)

ShotStar = {}
ShotStar.__index = ShotStar

function ShotStar:new(pos)
	local S = {}
	S = Shot:new(deck, pos)
	setmetatable(S, ShotStar)
	
	S.dmg = 15
	
	S.area.size = Rectangle:new(Vector:new(0, 0), size)
	S.area:newRectangularArea(Vector:new(0, 0), Vector:new(1 * size.x, 1 * size.y))
	
	return S
end

function ShotStar:move()
	Shot.move(self)
end