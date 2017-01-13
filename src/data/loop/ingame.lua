require "data/loop/thread"
require "data/scenario/stage1"
require "data/ship/ship"
require "data/shot/shot"
require "data/math/vector"
require "data/spawn/spawner"
require "data/player/data"
require "data/player/level"
require "data/interface/game/gameInterface"
require "data/effect/blackscreen"

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
	end
end