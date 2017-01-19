PlayerData = {}
PlayerData.__index = PlayerData

function PlayerData:new()
	local P = {}
	setmetatable(P, PlayerData)
	
	P.active = true
	
	P.lives = 3
	
	P.score = 0
	P.combo = 1
	
	P.alive = true
	
	return P
end

function PlayerData:dead()
	if self.lives > 0 then
		self:useLife()
	else
		if self.alive then
			self.alive = false
			self:gameOver()
		end
	end
end

function PlayerData:useLife()
	self.lives = self.lives - 1
	interface.lives:decrease()
	player = Player:new(Vector:new(0, 0))
end

function PlayerData:gameOver()
	playerLevel.active = false
	
	local score = readScoreFile()
	
	score = tonumber(score)
	
	if (score ~= nil and self.score > score) or
		self.score > highestScore then

		writeScoreFile(self.score)
		highestScore = self.score		-- update local save score
		
		interface:showGameOver(self.score)
	else
		interface:showGameOver()
	end
end

function PlayerData:newGame()
	self.active = false
	
	self:clear()
	
	local gameThread = MOAICoroutine.new()
	gameThread:run(gameLoop)
end

function PlayerData:backToMenu()
	self.active = false
	
	self:clear()
	
	local menuThread = MOAICoroutine.new()
	menuThread:run(menuLoop)
end

function PlayerData:scoreEnemy(score, pos)
	interface:scoreAnim(score, pos)
	self:increaseScore(score)
end

function PlayerData:increaseScore(score)
	local scoreCombo = score * self.combo
	
	interface:scoreEarnedAnim(scoreCombo)

	self.score = self.score + scoreCombo
	interface.score:setScore(self.score)
	
	self:increaseCombo()
	interface.combo.scoreText.text:setVisible(true)
end

function PlayerData:increaseCombo()
	interface.combo:setCombo(self.combo)
	self.combo = self.combo + 1
end

function PlayerData:breakCombo()
	self.combo = 1
	interface.combo:setCombo(self.combo)
	interface.combo.scoreText.text:setVisible(false)
end

function PlayerData:clear()
	interface:clear()
	shotsClear()
	shipsClear()
	map:clear()
end

function readScoreFile()
	local path = locateSaveLocation()
	
	-- probably a unexpected host (like html)
	if path == nil then
		return highestScore
	end

	local file = io.open(path .. "\\score.lua", "r")
	
	local score = 0
	 
	if file ~= nil then
		score = file:read()
		
		if score == nil then
			score = 0
		end
		
		io.close(file)
	else
		-- create file
		writeScoreFile(score)
	end
	
	return score
end

function writeScoreFile(score)
	local path = locateSaveLocation()
	
	-- probably a unexpected host (like html)
	if path == nil then
		return nil
	end

	local file = io.open(path .. "\\score.lua", "w")
	
	if file ~= nil then
		file:write(score)
		
		io.close(file)
	end
end