local laserSize = Vector:new(5 * screen.scale, 30 * screen.scale)

local laserDeck = MOAIGfxQuad2D.new()
laserDeck:setTexture("texture/shot/lasercyan.png")
laserDeck:setRect(-laserSize.x, -laserSize.y, laserSize.x, laserSize.y)

ShotLaserCyan = {}
ShotLaserCyan.__index = ShotLaserCyan

function ShotLaserCyan:new(pos)
	local S = {}
	S = Shot:new(laserDeck, pos)
	setmetatable(S, ShotLaserCyan)
	
	S.dmg = 25
	
	S.area.size = Rectangle:new(Vector:new(0, 0), laserSize)
	S.area:newRectangularArea(Vector:new(0, 0), Vector:new(1 * laserSize.x, 1 * laserSize.y))
	
	return S
end

function ShotLaserCyan:move()
	Shot.move(self)
end