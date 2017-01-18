require "loop/thread"
require "scenario/stage1"
require "ship/ship"
require "shot/shot"
require "math/vector"
require "spawn/spawner"
require "player/data"
require "player/level"
require "interface/game/gameInterface"
require "effect/blackscreen"

-- save a local score, useful for unexpected host (like html)
highestScore = 0

function gameLoop()
	local blackscreen = BlackScreen:new(3)
	blackscreen:fadeOut()
	
	spawner = Spawner:new()
	
	playerData = PlayerData:new()
	playerLevel = Level:new(spawner)
	
	interface = GameInterface:new(playerData.lives)

	map = Stage1:new()

	player = Player:new(Vector:new(0, 0))
	playerShots = {}

	enemies = {}
	enemiesShots = {}

	deadShips = {}

	playerData.active = true

	input.cancel = false
	
	while playerData.active do
		coroutine.yield()
		
		shipsMove()
		enemiesShoot()
		
		shotsMove()
		shipsCheckStatus()
		
		map:move()
		
		player:shoot()
		
		spawner:spawn()
		
		resumeThreads()
		
		if interface.gameOver ~= nil then
			interface.gameOver:checkSelection()
			interface.gameOver:checkPressed()
		end

		if input.cancel then
			input.cancel = false
			
			playerData:backToMenu()
		end
	end

	playerData = nil
end