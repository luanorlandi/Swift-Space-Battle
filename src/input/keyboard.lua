function onKeyboardEvent(key, down)
	if down == true then
		if key == 119 or key == 87 then input.up = true				-- w
		elseif key == 115 or key == 83 then input.down = true		-- s
		elseif key == 97 or key == 65 then input.left = true 		-- a
		elseif key == 100 or key == 68 then input.right = true end	-- d
	else
		if key == 119 or key == 87 then input.up = false 			-- w
		elseif key == 115 or key == 83 then input.down = false 		-- s
		elseif key == 97 or key == 65 then input.left = false 		-- a
		elseif key == 100 or key == 68 then input.right = false end	-- d
	end
end