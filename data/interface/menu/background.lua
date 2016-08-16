local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/background/menuBackground.png")
deck:setRect(-screen.width/2, -screen.height/2, screen.width/2, screen.height/2)

Background = {}
Background.__index = Background

function Background:new()
	local B = {}
	setmetatable(B, Background)
	
	B.sprite = MOAIProp2D.new()
	changePriority(B.sprite, "interface")
	B.sprite:setDeck(deck)
	
	B.sprite:setLoc(0, 0)
	layer:insertProp(B.sprite)
	
	return B
end

function Background:clean()
	layer:removeProp(self.sprite)
end