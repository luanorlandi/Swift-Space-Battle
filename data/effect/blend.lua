function blend(sprite, duration)
	sprite:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
	sprite:setColor(1, 1, 1, 0)
	
	local start = gameTime
	local complete = 0
	
	while complete < 1 do
		coroutine.yield()
		
		complete = (gameTime - start) / duration

		if complete > 1 then
			complete = 1
		end
		
		sprite:setColor(1, 1, 1, complete)
	end
end

function blendOut(sprite, duration)
	sprite:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
	sprite:setColor(1, 1, 1, 1)
	
	local start = gameTime
	local complete = 1
	
	while complete > 0 do
		coroutine.yield()
		
		complete = 1 - (gameTime - start) / duration

		if complete < 0 then
			complete = 0
		end
		
		sprite:setColor(1, 1, 1, complete)
	end
end