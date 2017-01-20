function onKeyboardEvent(key, down)
	if down == true then
		if key == 119 or key == 87 then input.up = true				-- w
		elseif key == 115 or key == 83 then input.down = true		-- s
		elseif key == 97 or key == 65 then input.left = true 		-- a
		elseif key == 100 or key == 68 then input.right = true		-- d

		elseif key == 32 then input.space = true			-- space
		elseif key == 8 then input.cancel = true			-- backspace
		elseif key == 27 then input.cancel = true end		-- esc
	else
		if key == 119 or key == 87 then input.up = false 			-- w
		elseif key == 115 or key == 83 then input.down = false 		-- s
		elseif key == 97 or key == 65 then input.left = false 		-- a
		elseif key == 100 or key == 68 then input.right = false		-- d

		elseif key == 32 then input.space = false			-- space
		elseif key == 8 then input.cancel = false			-- backspace
		elseif key == 27 then input.cancel = false end		-- esc
	end
end