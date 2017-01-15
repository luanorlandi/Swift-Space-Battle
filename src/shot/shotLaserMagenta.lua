local laserSize = Vector:new(5 * window.scale, 15 * window.scale)

local laserDeck = MOAIGfxQuad2D.new()
laserDeck:setTexture("texture/shot/lasermagenta.png")
laserDeck:setRect(-laserSize.x, -laserSize.y, laserSize.x, laserSize.y)

ShotLaserMagenta = {}
ShotLaserMagenta.__index = ShotLaserMagenta

function ShotLaserMagenta:new(pos)
	local S = {}
	S = Shot:new(laserDeck, pos)
	setmetatable(S, ShotLaserMagenta)
	
	S.dmg = 10
	
	S.area.size = Rectangle:new(Vector:new(0, 0), laserSize)
	S.area:newRectangularArea(Vector:new(0, 0), Vector:new(1 * laserSize.x, 1 * laserSize.y))
	
	return S
end

function ShotLaserMagenta:move()
	Shot.move(self)
end