function onKeyboardEvent(key, down)
	if down == true then
		if key == 119 or key == 87 then input.up = true end
		if key == 115 or key == 83 then input.down = true end
		if key == 97 or key == 65 then input.left = true end
		if key == 100 or key == 68 then input.right = true end
	else
		if key == 119 or key == 87 then input.up = false end
		if key == 115 or key == 83 then input.down = false end
		if key == 97 or key == 65 then input.left = false end
		if key == 100 or key == 68 then input.right = false end
	end
end