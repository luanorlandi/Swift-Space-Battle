function getTime()
	-- get the time elapsed since the start of the app
	
	while true do
		gameTime = MOAISim.getElapsedTime()
		coroutine.yield()
	end
end

function resumeThreads()
	-- resume important threads of the game
	
	-- player
	local i = 1
	while i <= table.getn(player.threads) do
		coroutine.resume(player.threads[i])
		if coroutine.status(player.threads[i]) ~= "dead" then
			i = i + 1
		else
			table.remove(player.threads, i)
		end
	end

	-- free allocated memory
	i = 1
	while i <= table.getn(player.threadsSprites) do
		if player.threadsSprites[i] == nil then
			table.remove(player.threadsSprites, i)
		else
			i = i + 1
		end
	end
	
	-- enemies
	for i = 1, table.getn(enemies), 1 do
		local j = 1
		while j <= table.getn(enemies[i].threads) do
			coroutine.resume(enemies[i].threads[j])
			if coroutine.status(enemies[i].threads[j]) ~= "dead" then
				j = j + 1
			else
				table.remove(enemies[i].threads, j)
			end
		end
		
		j = 1
		while j <= table.getn(enemies[i].threadsSprites) do
			if enemies[i].threadsSprites[j] == nil then
				table.remove(enemies[i].threadsSprites, j)
			else
				j = j + 1
			end
		end
	end
	
	-- dead enemies
	for i = 1, table.getn(deadShips), 1 do
		local j = 1
		while j <= table.getn(deadShips[i].threads) do
			coroutine.resume(deadShips[i].threads[j])
			if coroutine.status(deadShips[i].threads[j]) ~= "dead" then
				j = j + 1
			else
				table.remove(deadShips[i].threads, j)
			end
		end
		
		j = 1
		while j <= table.getn(deadShips[i].threadsSprites) do
			if deadShips[i].threadsSprites[j] == nil then
				table.remove(deadShips[i].threadsSprites, j)
			else
				j = j + 1
			end
		end
	end
	
	-- interface
	i = 1
	while i <= table.getn(interface.threads) do
		coroutine.resume(interface.threads[i])
		if coroutine.status(interface.threads[i]) ~= "dead" then
			i = i + 1
		else
			table.remove(interface.threads, i)
		end
	end
	
	-- game level
	if coroutine.status(playerLevel.threadCheckLevel) ~= "dead" then
		coroutine.resume(playerLevel.threadCheckLevel)
	end
end