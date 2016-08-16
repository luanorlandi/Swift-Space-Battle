function spawnBlink(sprite, duration)
	sprite:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
	sprite:setColor(1, 1, 1, 1)
	
	local start = gameTime
	local complete = 0
	local blinkRate = 0.08
	local blinkLast = gameTime
	local blink = false
	
	while complete < 1 do
		coroutine.yield()
		complete = (gameTime - start) / duration

		if complete > 1 then
			complete = 1
		end
		
		if gameTime - blinkLast > blinkRate then
			if blink then
				blink = false
				sprite:setColor(1, 1, 1, 1)
			else
				blink = true
				sprite:setColor(1, 1, 1, 0)
			end
			
			blinkLast = gameTime
		end
	end
	
	sprite:setColor(1, 1, 1, 1)
end