require "effect/blend"

Score = {}
Score.__index = Score

function Score:new(score, pos, font)
	local S = {}
	setmetatable(S, Score)
	
	S.number = score
	S.scoreFontSize = math.floor(40 * window.scale)
	S.scoreText = GameText:new("" .. S.number, font, S.scoreFontSize, pos)
	
	return S
end

function Score:setScore(score)
	self.number = score
	self.scoreText.text:setString("" .. self.number)
end

function Score:setCombo(combo)
	self.number = combo
	self.scoreText.text:setString("x" .. self.number)
end

function showScoreAnim(score, pos, font)
	-- animate the score
	local scoreProp = Score:new(score, pos, font)
	scoreProp.scoreText.text:setTextSize(math.floor(0.8 * scoreProp.scoreFontSize))
	
	table.insert(interface.scoreAnimTable, scoreProp)
	
	local duration = 1.5
	
	local over = false
	
	-- therad to remove label with effect
	local blendThread = coroutine.create(function() 
		blendOut(scoreProp.scoreText.text, duration)
	end)
	coroutine.resume(blendThread)
	
	while not over do
		coroutine.yield()
		coroutine.resume(blendThread)
		
		if coroutine.status(blendThread) == "dead" then
			over = true
		end
	end
	
	window.layer:removeProp(scoreProp.scoreText.text)
end

function showScoreEarnedAnim(score, font)
	-- animate the score in the corner
	local scoreProp = Score:new("+" .. score, interface.scoreEarnedPos, font)
	scoreProp.scoreText.text:setTextSize(math.floor(0.8 * scoreProp.scoreFontSize))
	
	table.insert(interface.scoreAnimTable, scoreProp)
	
	local duration = 1.5
	
	local over = false
	
	local blendThread = coroutine.create(function() 
		blendOut(scoreProp.scoreText.text, duration)
	end)
	coroutine.resume(blendThread)
	
	local moveThread = coroutine.create(function()
		local pos = Vector:new(interface.scoreEarnedPos.x, interface.scoreEarnedPos.y)				-- posicao atual
		local endPos = Vector:new(interface.scoreEarnedPos.x, 1.1 * interface.scoreEarnedPos.y)		-- posicao final
		local startTime = gameTime																	-- inicio do movimento
		
		while gameTime - startTime < duration do
			coroutine.yield()
			
			-- check how much has been concluded of the movement by
			local complete = (gameTime - startTime) / duration
			
			-- apply that much in position
			pos.x = (endPos.x - interface.scoreEarnedPos.x) * complete + interface.scoreEarnedPos.x
			pos.y = (endPos.y - interface.scoreEarnedPos.y) * complete + interface.scoreEarnedPos.y
			
			scoreProp.scoreText.text:setLoc(pos.x, pos.y)
		end
	end)
	
	coroutine.resume(moveThread)
	
	while not over do
		coroutine.yield()
		coroutine.resume(blendThread)
		coroutine.resume(moveThread)
		
		if coroutine.status(blendThread) == "dead"
		and	coroutine.status(moveThread) == "dead" then
			over = true
		end
	end
	
	window.layer:removeProp(scoreProp.text)
end

function Score:clear()
	self.scoreText:clear()
end