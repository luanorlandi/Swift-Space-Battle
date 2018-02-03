GameOver = {}
GameOver.__index = GameOver

function GameOver:new(score, font)
	-- if receive a score, it will show a new record

	local G = {}
	setmetatable(G, GameOver)
	
	G.gap = 80 * window.scale

	G.gameOverFontSize = math.floor(70 * window.scale)
	G.textFontSize = math.floor(40 * window.scale)
	G.gameOverText = GameText:new(strings.game.gameOver, font, G.gameOverFontSize, Vector:new(0, 2 * G.gap))
	G.gameOverText.text:setColor(1, 0, 0)
	
	-- if did not scored a new record, do not show a score label
	G.newRecordText = nil
	G.highestScoreText = nil
	
	local textPos = 0
	
	if score ~= nil then
		G.newRecordText = GameText:new(strings.game.record, font, G.textFontSize, Vector:new(0, -textPos * G.gap))
		textPos = textPos + 1
		
		G.highestScoreText = GameText:new(tostring(score), font, G.textFontSize, Vector:new(0, -textPos * G.gap))
		textPos = textPos + 1
	end
	
	G.playAgainText = GameText:new(strings.game.again, font, G.textFontSize, Vector:new(0, -textPos * G.gap))
	textPos = textPos + 1
	
	local yesPos = Vector:new(0, -textPos * G.gap)
	textPos = textPos + 1
	
	local noPos = Vector:new(0, -textPos * G.gap)
	textPos = textPos + 1
	
	G.yesText = GameText:new(strings.game.yesAnswer, font, G.textFontSize, yesPos)
	G.noText = GameText:new(strings.game.noAnswer, font, G.textFontSize, noPos)
	
	G.yesBoxPos = Rectangle:new(yesPos, Vector:new(window.width / 2, G.textFontSize / 2))
	G.noBoxPos = Rectangle:new(noPos, Vector:new(window.width / 2, G.textFontSize / 2))
	
	G.textBoxSelected = nil
	
	return G
end

function GameOver:checkSelection()
	local selection = false
	
	if self.yesBoxPos:pointInside(input.pointerPos) then
		if self.textBoxSelected ~= "yes" then
			if self.textBoxSelected == "no" then
				self:removeSelection("no")
			end
			
			self.textBoxSelected = "yes"
			self:selection("yes")
			
		end
		
		selection = true
	else
		if self.noBoxPos:pointInside(input.pointerPos) then
			if self.textBoxSelected ~= "no" then
				if self.textBoxSelected == "yes" then
					self:removeSelection("yes")
				end
			
				self.textBoxSelected = "no"
				self:selection("no")
			end
			
			selection = true
		end
	end
	
	if not selection and self.textBoxSelected ~= nil then
		self:removeSelection(self.textBoxSelected)
		
		self.textBoxSelected = nil
	end
	
end

function GameOver:checkPressed()
	if input.pointerReleased then
		input.pointerReleased = false
		
		if self.textBoxSelected ~= nil then
			if self.textBoxSelected == "yes" then
				playerData:newGame()
			else
				if self.textBoxSelected == "no" then
					playerData:backToMenu()
				end
			end
		end
	end
end

function GameOver:selection(text)
	if text == "yes" then
		self.yesText.text:seekColor(1, 0, 0, 1, 0, MOAIEaseType.FLAT)
	else
		self.noText.text:seekColor(1, 0, 0, 1, 0, MOAIEaseType.FLAT)
	end
end

function GameOver:removeSelection(text)
	if text == "yes" then
		self.yesText.text:seekColor(1, 1, 1, 1, 0, MOAIEaseType.FLAT)
	else
		self.noText.text:seekColor(1, 1, 1, 1, 0, MOAIEaseType.FLAT)
	end
end

function GameOver:clear()
	self.gameOverText:clear()
	
	if self.newRecordText ~= nil then
		self.newRecordText:clear()
	end
	
	if self.highestScoreText ~= nil then
		self.highestScoreText:clear()
	end
	
	self.playAgainText:clear()
	self.yesText:clear()
	self.noText:clear()
end