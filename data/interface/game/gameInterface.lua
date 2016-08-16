require "data/interface/game/gameText"
require "data/interface/game/lives"
require "data/interface/game/borderHp"
require "data/interface/game/scoreText"
require "data/interface/game/gameOver"

GameInterface = {}
GameInterface.__index = GameInterface

function GameInterface:new(lives)
	local G = {}
	setmetatable(G, GameInterface)
	
	G.threads = {}
	
	G.borderHp = BorderHp:new()
	table.insert(G.threads, G.borderHp.thread)
	
	G.lives = Lives:new(lives)
	
	-- configura para o score aparacer no canto
	G.score = Score:new(0, Vector:new(0, 0))
	G.score.scoreText.text:setRect(-screen.width/2, -screen.height/2,
						screen.width/2 - 0.1 * screen.width/2,
						screen.height/2 - 0.1 * screen.width/2)
	G.score.scoreText.text:setAlignment(MOAITextBox.RIGHT_JUSTIFY, MOAITextBox.LEFT_JUSTIFY)
	
	G.combo = Score:new("x1", Vector:new(0, 0))
	G.combo.scoreText.text:setVisible(false)
	G.combo.scoreText.text:setRect(-screen.width/2, -screen.height/2,
						screen.width/2 - 0.1 * screen.width/2,
						screen.height/2 - 0.25 * screen.width/2)
	G.combo.scoreText.text:setAlignment(MOAITextBox.RIGHT_JUSTIFY, MOAITextBox.LEFT_JUSTIFY)
	
	G.scoreEarnedPos = Vector:new(screen.width/2 - 0.55 * screen.width/2, screen.height/2 - 0.30 * screen.width/2)
	
	G.scoreAnimTable = {}
	
	G.gameOver = nil
	
	return G
end

function GameInterface:scoreAnim(score, pos)
	scoreAnimThread = coroutine.create(function()
		showScoreAnim(score, pos)
	end)
	coroutine.resume(scoreAnimThread)
	table.insert(self.threads, scoreAnimThread)
end

function GameInterface:scoreEarnedAnim(score)	
	scoreAnimThread = coroutine.create(function()
		showScoreEarnedAnim(score)
	end)
	coroutine.resume(scoreAnimThread)
	table.insert(self.threads, scoreAnimThread)
end

function GameInterface:showGameOver(score)
	self.gameOver = GameOver:new(score)
end

function GameInterface:clean()
	self.borderHp:clean()
	self.lives:clean()
	self.score:clean()
	self.combo:clean()
	self.gameOver:clean()
	
	for i = 1, table.getn(self.scoreAnimTable), 1 do
		self.scoreAnimTable[i]:clean()
	end
end