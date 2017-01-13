require "data/input/keyboard"
require "data/input/mouse"
require "data/input/touch"

Input = {}
Input.__index = Input

function Input:new()
	I = {}
	setmetatable(I, Input)
	
	I.up = false
	I.down = false
	I.left = false
	I.right = false
	
	I.pointerPos = Vector:new(0, 0)
	I.pointerPressed = false
	
	return I
end

function Input:keyboard()
	if MOAIInputMgr.device.keyboard then
		MOAIInputMgr.device.keyboard:setCallback(onKeyboardEvent)
	end
end

function Input:mouse()
	if MOAIInputMgr.device.pointer then
		MOAIInputMgr.device.pointer:setCallback(onPointerEvent)
		MOAIInputMgr.device.mouseLeft:setCallback(onMouseLeftEvent)
	end
end

function Input:touch()
	if MOAIInputMgr.device.touch then
		MOAIInputMgr.device.touch:setCallback(onTouchEvent)
	end
end