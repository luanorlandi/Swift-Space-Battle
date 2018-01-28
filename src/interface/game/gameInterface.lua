require "interface/game/gameText"
require "interface/game/lives"
require "interface/game/borderHp"
require "interface/game/scoreText"
require "interface/game/gameOver"
require "interface/game/buttons"

GameInterface = {}
GameInterface.__index = GameInterface

function GameInterface:new(lives)
	local G = {}
	setmetatable(G, GameInterface)

	G.textSize = math.floor(40 * window.scale)
	G.font = MOAIFont.new()
	G.font:loadFromTTF("font//NotoSans-Regular.ttf", G.textSize, 72)
	
	G.threads = {}
	
	G.borderHp = BorderHp:new()
	table.insert(G.threads, G.borderHp.thread)
	
	G.lives = Lives:new(lives)
	
	-- configure score to be in the top right corner
	G.score = Score:new(0, Vector:new(0, 0), G.font)
	G.score.scoreText.text:setRect(-window.width/2, -window.height/2,
						window.width/2 - 0.1 * window.width/2,
						window.height/2 - 0.1 * window.width/2)
	G.score.scoreText.text:setAlignment(MOAITextBox.RIGHT_JUSTIFY, MOAITextBox.LEFT_JUSTIFY)
	
	G.combo = Score:new("x1", Vector:new(0, 0), G.font)
	G.combo.scoreText.text:setVisible(false)
	G.combo.scoreText.text:setRect(-window.width/2, -window.height/2,
						window.width/2 - 0.1 * window.width/2,
						window.height/2 - 0.25 * window.width/2)
	G.combo.scoreText.text:setAlignment(MOAITextBox.RIGHT_JUSTIFY, MOAITextBox.LEFT_JUSTIFY)
	
	G.scoreEarnedPos = Vector:new(window.width/2 - 0.55 * window.width/2, window.height/2 - 0.30 * window.width/2)
	
	G.scoreAnimTable = {}

	G.buttons = Buttons:new()
	G.buttons:showButtons()
	
	G.gameOver = nil
	
	return G
end

function GameInterface:scoreAnim(score, pos)
	scoreAnimThread = coroutine.create(function()
		showScoreAnim(score, pos, self.font)
	end)
	coroutine.resume(scoreAnimThread)
	table.insert(self.threads, scoreAnimThread)
end

function GameInterface:scoreEarnedAnim(score)	
	scoreAnimThread = coroutine.create(function()
		showScoreEarnedAnim(score, self.font)
	end)
	coroutine.resume(scoreAnimThread)
	table.insert(self.threads, scoreAnimThread)
end

function GameInterface:showGameOver(score)
	self.gameOver = GameOver:new(score, self.font)
end

function GameInterface:clear()
	self.borderHp:clear()
	self.lives:clear()
	self.score:clear()
	self.combo:clear()
	self.buttons:clear()

	if self.gameOver ~= nil then
		self.gameOver:clear()
	end
	
	for i = 1, #self.scoreAnimTable, 1 do
		self.scoreAnimTable[i]:clear()
	end
end