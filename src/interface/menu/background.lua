local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/background/menuBackground.png")
deck:setRect(-window.width/2, -window.height/2, window.width/2, window.height/2)

Background = {}
Background.__index = Background

function Background:new()
	local B = {}
	setmetatable(B, Background)
	
	B.sprite = MOAIProp2D.new()
	changePriority(B.sprite, "interface")
	B.sprite:setDeck(deck)
	
	B.sprite:setLoc(0, 0)
	window.layer:insertProp(B.sprite)
	
	return B
end

function Background:clear()
	window.layer:removeProp(self.sprite)
end