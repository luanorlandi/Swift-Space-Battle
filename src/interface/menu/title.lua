local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/logo/title.png")
deck:setRect(-300 * window.scale, -150 * window.scale, 300 * window.scale, 150 * window.scale)

Title = {}
Title.__index = Title

function Title:new(pos)
	local T = {}
	setmetatable(T, Title)
	
	T.sprite = MOAIProp2D.new()
	changePriority(T.sprite, "interface")
	T.sprite:setDeck(deck)
	
	T.sprite:setLoc(pos.x, pos.y)
	window.layer:insertProp(T.sprite)
	
	return T
end

function Title:clear()
	window.layer:removeProp(self.sprite)
end