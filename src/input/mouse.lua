-- point out the cursor position
function onPointerEvent(x, y)
	x, y = window.layer:wndToWorld(x, y)
	input.pointerPos.x = x
	input.pointerPos.y = y
end

function onMouseLeftEvent(down)
	if down == true then
		input.pointerPressed = true
	else
		input.pointerPressed = false
	end
end

function onMouseMiddleEvent(down)
	if down == true then
		input.pointerPressed = true
	else
		input.pointerPressed = false
	end
end

function onMouseRightEvent(down)
	if down == true then
		input.pointerPressed = true
	else
		input.pointerPressed = false
	end
end