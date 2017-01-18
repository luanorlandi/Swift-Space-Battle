local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/background/menuBackground.jpg")
deck:setRect(-window.width/2, -window.height/2, window.width/2, window.height/2)

local deckGlow = MOAIGfxQuad2D.new()
deckGlow:setTexture("texture/background/menuBackgroundGlow.jpg")
deckGlow:setRect(-window.width/2, -window.height/2, window.width/2, window.height/2)

Background = {}
Background.__index = Background

function Background:new()
	local B = {}
	setmetatable(B, Background)
	
	B.sprite = MOAIProp2D.new()
	changePriority(B.sprite, "interface")
	B.sprite:setDeck(deck)
	B.sprite:setLoc(0, 0)

	B.sprite:setBlendMode(MOAIProp.GL_SRC_ALPHA,
		MOAIProp.GL_ONE_MINUS_SRC_ALPHA)

	--B.sprite:setColor(0.05, 0.05, 0.05, 1)
	--B.sprite:seekColor(1, 1, 1, 1, 1.0)
	
	B.spriteGlow = MOAIProp2D.new()
	changePriority(B.spriteGlow, "interface")
	B.spriteGlow:setDeck(deckGlow)
	B.spriteGlow:setLoc(0, 0)

	B.spriteGlow:setBlendMode(MOAIProp.GL_SRC_ALPHA,
		MOAIProp.GL_ONE_MINUS_SRC_ALPHA)

	B.spriteGlow:setColor(0.05, 0.05, 0.05, 1) -- start dark
	B.spriteGlow:seekColor(1, 1, 1, 1, 5.0, MOAIEaseType.SOFT_EASE_OUT)
	B.spriteGlow:seekColor(1, 1, 1, 0, 10.0, MOAIEaseType.SOFT_EASE_OUT)

	window.layer:insertProp(B.sprite)
	window.layer:insertProp(B.spriteGlow)
	
	return B
end

function Background:clear()
	window.layer:removeProp(self.sprite)
	window.layer:removeProp(self.spriteGlow)
end