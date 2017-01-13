require "data/effect/blend"

local deckLua = MOAIGfxQuad2D.new()
deckLua:setTexture("texture/logo/lua.png")
deckLua:setRect(-screen.width/2, -screen.height/2, screen.width/2, screen.height/2)

local deckMOAI = MOAIGfxQuad2D.new()
deckMOAI:setTexture("texture/logo/moai.png")
deckMOAI:setRect(-screen.width/2, -screen.height/2, screen.width/2, screen.height/2)

local whiteScreen = MOAIGfxQuad2D.new()
whiteScreen:setTexture("texture/effect/whitescreen.png")
whiteScreen:setRect(-screen.width/2, -screen.height/2, screen.width/2, screen.height/2)

Intro = {}
Intro.__index = Intro

function Intro:new(pos)
	local I = {}
	setmetatable(I, Intro)
	
	-- fundo branco
	I.background = MOAIProp2D.new()
	changePriority(I.background, "interface")
	I.background:setDeck(whiteScreen)
	
	layer:insertProp(I.background)
	
	I.logos = {}
	
	-- logo da linguagem lua
	local lua = MOAIProp2D.new()
	changePriority(lua, "interface")
	lua:setDeck(deckLua)
	
	lua:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
	lua:setColor(1, 1, 1, 0)
	layer:insertProp(lua)
	
	table.insert(I.logos, lua)
	
	-- logo da engine MOAI
	local moai = MOAIProp2D.new()
	changePriority(moai, "interface")
	moai:setDeck(deckMOAI)
	
	moai:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
	moai:setColor(1, 1, 1, 0)
	layer:insertProp(moai)
	
	table.insert(I.logos, moai)
	
	I.start = 0.8				-- tempo para comecar
	I.fadeDuration = 0.8	-- tempo de duracao para o efeito de transparencia
	I.logoDuration = 1.2	-- tempo que o logo fica na tela
	I.waitDuration = 0.2	-- tempo entre os logos
	
	I.thread = coroutine.create(function()
		I:loop()
	end)
	coroutine.resume(I.thread)
	
	return I
end

function Intro:loop()
	-- espera para iniciar a intro ---------------------
	local waitingStart = gameTime
	while gameTime - waitingStart < self.start do
		coroutine.yield()
	end
		
	for i = 1, table.getn(self.logos), 1 do
		coroutine.yield()
		-- logo aparecendo ---------------------------------
		local blendThread = coroutine.create(function()
			blend(self.logos[i], self.fadeDuration)
		end)
		coroutine.resume(blendThread)
		
		while coroutine.status(blendThread) ~= "dead" do
			coroutine.yield()
			coroutine.resume(blendThread)
		end
		
		-- deixa o logo por um tempo -----------------------
		waitingStart = gameTime
		while gameTime - waitingStart < self.logoDuration do
			coroutine.yield()
		end
		
		-- logo desaparecendo ------------------------------
		local blendThread = coroutine.create(function()
			blendOut(self.logos[i], self.fadeDuration)
		end)
		coroutine.resume(blendThread)
		
		while coroutine.status(blendThread) ~= "dead" do
			coroutine.yield()
			coroutine.resume(blendThread)
		end
		
		-- espera para o proximo logo ----------------------
		local waitingStart = gameTime
		while gameTime - waitingStart < self.waitDuration do
			coroutine.yield()
		end
	end
	
	-- remove os logos -------------------------------------
	for i = 1, table.getn(self.logos), 1 do
		layer:removeProp(self.logos[1])
		table.remove(self.logos, 1)
	end
end

function Intro:clean()
	layer:removeProp(self.background)
	
	for i = 1, table.getn(self.logos), 1 do
		layer:removeProp(self.logos[1])
		table.remove(self.logos, 1)
	end
end