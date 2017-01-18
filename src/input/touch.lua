local borderSize = window.height/12
local cUp = Vector:new(0, (window.height/2 + borderSize) / 2)
local dUp = Vector:new(window.width/2, (window.height/2 - borderSize) / 2)

local cDown = Vector:new(0, (-window.height/2 - borderSize) / 2)
local dDown = Vector:new(window.width/2, (window.height/2 - borderSize) / 2)

local cLeft = Vector:new(-window.width/4, 0)
local dLeft = Vector:new(window.width/4, borderSize)

local cRight = Vector:new(window.width/4, 0)
local dRight = Vector:new(window.width/4, borderSize)

local rectUp = Rectangle:new(cUp, dUp)
local rectDown = Rectangle:new(cDown, dDown)

local rectLeft = Rectangle:new(cLeft, dLeft)
local rectRight = Rectangle:new(cRight, dRight)

-- save what each touch pressed (up, down, left or right)
local touches = {}

function onTouchEvent(event, idx, x, y, tapCount)
	x, y = window.layer:wndToWorld(x, y)
	input.pointerPos.x = x
	input.pointerPos.y = y

	-- calculate which button was touched
	local up = false
	local down = false
	local left = false
	local right = false

	if rectUp:pointInside(input.pointerPos) then
		up = true
		
		if touches[idx] ~= nil and not touches[idx] == "up" then
			touches[idx] = "up"
		end
	elseif rectDown:pointInside(input.pointerPos) then
		down = true
		
		if touches[idx] ~= nil and not touches[idx] == "down" then
			touches[idx] = "down"
		end
	elseif rectLeft:pointInside(input.pointerPos) then
		left = true
		
		if touches[idx] ~= nil and not touches[idx] == "left" then
			touches[idx] = "left"
		end
	elseif rectRight:pointInside(input.pointerPos) then
		right = true
		
		if touches[idx] ~= nil and not touches[idx] == "right" then
			touches[idx] = "right"
		end
	end

	if event == MOAITouchSensor.TOUCH_DOWN then
		input.pointerPressed = true
		input.pointerReleased = false
		touches[idx] = Vector:new(x, y)

		if up then
			input.up = true
			touches[idx] = "up"
		elseif down then
			input.down = true
			touches[idx] = "down"
		elseif left then
			input.left = true
			touches[idx] = "left"
		elseif right then
			input.right = true
			touches[idx] = "right"
		end
	end
	
	if event == MOAITouchSensor.TOUCH_UP then
		input.pointerPressed = false
		input.pointerReleased = true

		if touches[idx] ~= nil then
			if touches[idx] == "up" then input.up = false
			elseif touches[idx] == "down" then input.down = false
			elseif touches[idx] == "left" then input.left = false
			elseif touches[idx] == "right" then input.right = false end
		end

		touches[idx] = nil
	end
end

function onBackButtonPressed()
	input.cancel = true

	-- return true to override the back button press and prevent
	-- the system from handling it
	if playerData ~= nil then
		return true
	else 
		return false
	end
end