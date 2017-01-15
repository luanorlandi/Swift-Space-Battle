local laserSize = Vector:new(5 * window.scale, 20 * window.scale)

local laserDeck = MOAIGfxQuad2D.new()
laserDeck:setTexture("texture/shot/laserred.png")
laserDeck:setRect(-laserSize.x, -laserSize.y, laserSize.x, laserSize.y)

ShotLaserRed = {}
ShotLaserRed.__index = ShotLaserRed

function ShotLaserRed:new(pos)
	local S = {}
	S = Shot:new(laserDeck, pos)
	setmetatable(S, ShotLaserRed)
	
	S.dmg = 20
	
	S.area.size = Rectangle:new(Vector:new(0, 0), laserSize)
	S.area:newRectangularArea(Vector:new(0, 0), Vector:new(1 * laserSize.x, 1 * laserSize.y))
	
	return S
end

function ShotLaserRed:move()
	Shot.move(self)
end