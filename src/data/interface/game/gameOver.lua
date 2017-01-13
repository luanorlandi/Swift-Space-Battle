local gameOverFontSize = math.floor(70 * screen.scale)
local gameOverFont = MOAIFont.new()
gameOverFont:loadFromTTF("font//RosesareFF0000.ttf", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-", gameOverFontSize, 72)

local textFontSize = math.floor(40 * screen.scale)
local textFont = MOAIFont.new()
textFont:loadFromTTF("font//RosesareFF0000.ttf", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-", textFontSize, 72)

local gameOverTextSize = 70 * screen.scale

GameOver = {}
GameOver.__index = GameOver

function GameOver:new(score)
	-- se receber o parametro score, este metodo mostrara na tela o novo record da partida

	local G = {}
	setmetatable(G, GameOver)
	
	G.gap = 80 * screen.scale
	
	G.gameOverText = GameText:new("GAME OVER", gameOverFont, gameOverFontSize, Vector:new(0, 2 * G.gap))
	G.gameOverText.text:setColor(1, 0, 0)
	
	-- caso nao bateu o record, nao mostra o texto da pontuacao
	G.newRecordText = nil
	G.highestScoreText = nil
	
	local textPos = 0
	
	if score ~= nil then
		G.newRecordText = GameText:new("Novo recorde:", textFont, textFontSize, Vector:new(0, -textPos * G.gap))
		textPos = textPos + 1
		
		G.highestScoreText = GameText:new(score .. " pontos", textFont, textFontSize, Vector:new(0, -textPos * G.gap))
		textPos = textPos + 1
	end
	
	G.playAgainText = GameText:new("Jogar novamente?", textFont, textFontSize, Vector:new(0, -textPos * G.gap))
	textPos = textPos + 1
	
	local yesPos = Vector:new(0, -textPos * G.gap)
	textPos = textPos + 1
	
	local noPos = Vector:new(0, -textPos * G.gap)
	textPos = textPos + 1
	
	G.yesText = GameText:new("Sim", textFont, textFontSize, yesPos)
	G.noText = GameText:new("Nao", textFont, textFontSize, noPos)
	
	G.yesBoxPos = Rectangle:new(yesPos, Vector:new(screen.width / 2, textFontSize / 2))
	G.noBoxPos = Rectangle:new(noPos, Vector:new(screen.width / 2, textFontSize / 2))
	
	G.textBoxSelected = nil
	
	return G
end

function GameOver:checkSelection()
	local cursorPos = Vector:new(input.pointerPos.x - screen.width / 2, -(input.pointerPos.y - screen.height / 2))
	
	local selection = false
	
	if self.yesBoxPos:pointInside(cursorPos) then
		if self.textBoxSelected ~= "yes" then
			if self.textBoxSelected == "no" then
				self:removeSelection("no")
			end
			
			self.textBoxSelected = "yes"
			self:selection("yes")
			
		end
		
		selection = true
	else
		if self.noBoxPos:pointInside(cursorPos) then
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
	if input.pointerPressed then
		input.pointerPressed = false
		
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
		self.yesText.text:seekColor(1, 0, 0, 1, MOAIEaseType.EASE_IN)
	else
		self.noText.text:seekColor(1, 0, 0, 1, MOAIEaseType.EASE_IN)
	end
end

function GameOver:removeSelection(text)
	if text == "yes" then
		self.yesText.text:seekColor(1, 1, 1, 1, MOAIEaseType.EASE_IN)
	else
		self.noText.text:seekColor(1, 1, 1, 1, MOAIEaseType.EASE_IN)
	end
end

function GameOver:clean()
	self.gameOverText:clean()
	
	if self.newRecordText ~= nil then
		self.newRecordText:clean()
	end
	
	if self.highestScoreText ~= nil then
		self.highestScoreText:clean()
	end
	
	self.playAgainText:clean()
	self.yesText:clean()
	self.noText:clean()
end