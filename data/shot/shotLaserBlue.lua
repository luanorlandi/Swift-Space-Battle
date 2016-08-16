local laserSize = Vector:new(5 * screen.scale, 20 * screen.scale)

local laserDeck = MOAIGfxQuad2D.new()
laserDeck:setTexture("texture/shot/laserblue.png")
laserDeck:setRect(-laserSize.x, -laserSize.y, laserSize.x, laserSize.y)

ShotLaserBlue = {}
ShotLaserBlue.__index = ShotLaserBlue

function ShotLaserBlue:new(pos)
	local S = {}
	S = Shot:new(laserDeck, pos)
	setmetatable(S, ShotLaserBlue)
	
	S.dmg = 20
	
	S.area.size = Rectangle:new(Vector:new(0, 0), laserSize)
	S.area:newRectangularArea(Vector:new(0, 0), Vector:new(1 * laserSize.x, 1 * laserSize.y))
	
	return S
end

function ShotLaserBlue:move()
	Shot.move(self)
end