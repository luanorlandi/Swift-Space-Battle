require "effect/blend"

local background = MOAIGfxQuad2D.new()
background:setTexture("texture/effect/blackscreen.png")
background:setRect(-screen.width/2, -screen.height/2, screen.width/2, screen.height/2)

BlackScreen = {}
BlackScreen.__index = BlackScreen

function BlackScreen:new(duration)
	local B = {}
	setmetatable(B, BlackScreen)
	
	B.duration = duration
	
	B.sprite = MOAIProp.new()
	B.sprite:setDeck(background)
	changePriority(B.sprite, "interface")
	layer:insertProp(B.sprite)
	
	return B
end

function BlackScreen:fadeOut()
	local thread = MOAICoroutine.new()
	thread:run(function()
		blendOut(self.sprite, self.duration)
	end)
end