require "effect/blend"

local deckLua = MOAIGfxQuad2D.new()
deckLua:setTexture("texture/logo/lua.png")
deckLua:setRect(-window.scale * 200, -window.scale * 200, window.scale * 200, window.scale * 200)

local deckMOAI = MOAIGfxQuad2D.new()
deckMOAI:setTexture("texture/logo/moai.png")
deckMOAI:setRect(-window.scale * 250, -window.scale * 250, window.scale * 250, window.scale * 250)

local whiteScreen = MOAIGfxQuad2D.new()
whiteScreen:setTexture("texture/effect/whitescreen.png")
whiteScreen:setRect(-window.width/2, -window.height/2, window.width/2, window.height/2)

Intro = {}
Intro.__index = Intro

function Intro:new(pos)
	local I = {}
	setmetatable(I, Intro)
	
	-- white background
	I.background = MOAIProp2D.new()
	changePriority(I.background, "interface")
	I.background:setDeck(whiteScreen)
	
	window.layer:insertProp(I.background)
	
	I.logos = {}
	
	-- Lua language logo
	local lua = MOAIProp2D.new()
	changePriority(lua, "interface")
	lua:setDeck(deckLua)
	
	lua:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
	lua:setColor(1, 1, 1, 0)
	window.layer:insertProp(lua)
	
	table.insert(I.logos, lua)
	
	-- MOAI engine logo
	local moai = MOAIProp2D.new()
	changePriority(moai, "interface")
	moai:setDeck(deckMOAI)
	
	moai:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
	moai:setColor(1, 1, 1, 0)
	window.layer:insertProp(moai)
	
	table.insert(I.logos, moai)
	
	I.start = 0.8			-- time to start
	I.fadeDuration = 0.8	-- duration of the fade effect
	I.logoDuration = 1.2	-- duration of the logo with no effect
	I.waitDuration = 0.2	-- duration between end and bengin of logos
	
	I.thread = coroutine.create(function()
		I:loop()
	end)
	coroutine.resume(I.thread)
	
	return I
end

function Intro:loop()
	-- wait to start intro ---------------------------------
	local waitingStart = gameTime
	while gameTime - waitingStart < self.start do
		coroutine.yield()
	end
		
	for i = 1, #self.logos, 1 do
		coroutine.yield()
		-- logo fade inn ------------------------------------
		local blendThread = coroutine.create(function()
			blend(self.logos[i], self.fadeDuration)
		end)
		coroutine.resume(blendThread)
		
		while coroutine.status(blendThread) ~= "dead" do
			coroutine.yield()
			coroutine.resume(blendThread)
		end
		
		-- keep the logo for some time ---------------------
		waitingStart = gameTime
		while gameTime - waitingStart < self.logoDuration do
			coroutine.yield()
		end
		
		-- logo fade out -----------------------------------
		local blendThread = coroutine.create(function()
			blendOut(self.logos[i], self.fadeDuration)
		end)
		coroutine.resume(blendThread)
		
		while coroutine.status(blendThread) ~= "dead" do
			coroutine.yield()
			coroutine.resume(blendThread)
		end
		
		-- wait for the next logo --------------------------
		local waitingStart = gameTime
		while gameTime - waitingStart < self.waitDuration do
			coroutine.yield()
		end
	end
	
	-- remove logos -------------------------------------
	for i = 1, #self.logos, 1 do
		window.layer:removeProp(self.logos[1])
		table.remove(self.logos, 1)
	end
end

function Intro:clear()
	window.layer:removeProp(self.background)
	
	for i = 1, #self.logos, 1 do
		window.layer:removeProp(self.logos[1])
		table.remove(self.logos, 1)
	end
end