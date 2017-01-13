function getTime()
	-- pega o tempo que se passou desde que o aplicativo iniciou
	
	while true do
		gameTime = MOAISim.getElapsedTime()
		coroutine.yield()
	end
end

function resumeThreads()
	-- resume as thread importantes para o jogo
	
	-- jogador
	local i = 1
	while i <= table.getn(player.threads) do
		coroutine.resume(player.threads[i])
		if coroutine.status(player.threads[i]) ~= "dead" then
			i = i + 1
		else
			table.remove(player.threads, i)
		end
	end
	-- elimina a memoria alocada para gravar onde os sprites criados pelas threads da nave
	i = 1
	while i <= table.getn(player.threadsSprites) do
		if player.threadsSprites[i] == nil then
			table.remove(player.threadsSprites, i)
		else
			i = i + 1
		end
	end
	
	-- inimigos
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
	
	-- inimigos mortos
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
	
	-- nivel no jogo
	if coroutine.status(playerLevel.threadCheckLevel) ~= "dead" then
		coroutine.resume(playerLevel.threadCheckLevel)
	end
end