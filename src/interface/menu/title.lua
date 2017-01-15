local deck = MOAIGfxQuad2D.new()
deck:setTexture("texture/logo/title.png")
deck:setRect(-315 * screen.scale, -144.2 * screen.scale, 315 * screen.scale, 144.2 * screen.scale)

Title = {}
Title.__index = Title

function Title:new(pos)
	local T = {}
	setmetatable(T, Title)
	
	T.sprite = MOAIProp2D.new()
	changePriority(T.sprite, "interface")
	T.sprite:setDeck(deck)
	
	T.sprite:setLoc(pos.x, pos.y)
	layer:insertProp(T.sprite)
	
	return T
end

function Title:clean()
	layer:removeProp(self.sprite)
end