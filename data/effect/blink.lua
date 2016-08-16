function increaseWhite(sprite, duration)
	local start = gameTime
	local complete = 0
	
	while complete < 1 do
		coroutine.yield()
		
		complete = (gameTime - start) / duration

		if complete > 1 then
			complete = 1
		end
		
		sprite:setColor(complete, 1, 1, complete)
	end
end