require "input/keyboard"
require "input/mouse"
require "input/touch"

Input = {}
Input.__index = Input

function Input:new()
	I = {}
	setmetatable(I, Input)

	I.keyboard = false
	I.mouse = false
	I.touch = false
	
	I.up = false
	I.down = false
	I.left = false
	I.right = false

	I.cancel = false
	
	I.pointerPos = Vector:new(0, 0)
	I.pointerPressed = false
	I.pointerReleased = false
	
	return I
end

function Input:tryEnableKeyboard()
	if MOAIInputMgr.device.keyboard then
		self.keyboard = true

		MOAIInputMgr.device.keyboard:setCallback(onKeyboardEvent)
	end
end

function Input:tryEnableMouse()
	if MOAIInputMgr.device.pointer then
		self.mouse = true

		MOAIInputMgr.device.pointer:setCallback(onPointerEvent)
		MOAIInputMgr.device.mouseLeft:setCallback(onMouseLeftEvent)
	end
end

function Input:tryEnableTouch()
	if MOAIInputMgr.device.touch then
		self.touch = true

		MOAIInputMgr.device.touch:setCallback(onTouchEvent)
		MOAIAppAndroid.setListener(MOAIAppAndroid.BACK_BUTTON_PRESSED, onBackButtonPressed)
	end
end