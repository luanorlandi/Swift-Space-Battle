-- point out the cursor position
function onPointerEvent(x, y)
	x, y = window.layer:wndToWorld(x, y)
	input.pointerPos.x = x
	input.pointerPos.y = y
end

function onMouseLeftEvent(down)
	if down == true then
		input.pointerPressed = true
		input.pointerReleased = false
	else
		input.pointerPressed = false
		input.pointerReleased = true
	end
end

function onMouseMiddleEvent(down)
	if down == true then
		input.pointerPressed = true
		input.pointerReleased = false
	else
		input.pointerPressed = false
		input.pointerReleased = true
	end
end

function onMouseRightEvent(down)
	if down == true then
		input.pointerPressed = true
		input.pointerReleased = false
	else
		input.pointerPressed = false
		input.pointerReleased = true
	end
end