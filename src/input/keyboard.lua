function onKeyboardEvent(key, down)
	if down == true then
		if key == 119 or key == 87 then input.up = true end		-- w
		if key == 115 or key == 83 then input.down = true end	-- s
		if key == 97 or key == 65 then input.left = true end	-- a
		if key == 100 or key == 68 then input.right = true end	-- d
	else
		if key == 119 or key == 87 then input.up = false end	-- w
		if key == 115 or key == 83 then input.down = false end	-- s
		if key == 97 or key == 65 then input.left = false end	-- a
		if key == 100 or key == 68 then input.right = false end	-- d
	end
end