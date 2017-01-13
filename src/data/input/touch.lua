local retUp =   Rectangle:new(Vector:new(screen.width/2, 0.45 * screen.height/2), Vector:new(screen.width/2, 0.45 * screen.height/2))
local retDown = Rectangle:new(Vector:new(screen.width/2, 1.55 * screen.height/2), Vector:new(screen.width/2, 0.45 * screen.height/2))

local retLeft = Rectangle:new (Vector:new(screen.width/4, screen.height/2),      Vector:new(screen.width/4, 0.10 * screen.height/2))
local retRight = Rectangle:new(Vector:new(3 * screen.width/4, screen.height/2),  Vector:new(screen.width/4, 0.10 * screen.height/2))

function onTouchEvent(event, idx, x, y, tapCount)
	if event == MOAITouchSensor.TOUCH_DOWN then
		input.pointerPos.x = x
		input.pointerPos.y = y
		input.pointerPressed = true
		
		if retUp:pointInside(input.pointerPos) then input.up = true end
		if retDown:pointInside(input.pointerPos) then input.down = true end
		if retLeft:pointInside(input.pointerPos) then input.left = true end
		if retRight:pointInside(input.pointerPos) then input.right = true end
	end
	
	if event == MOAITouchSensor.TOUCH_UP then
		input.pointerPressed = false
		
		input.left = false
		input.right = false
		input.up = false
		input.down = false
	end
end