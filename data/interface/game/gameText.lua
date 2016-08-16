GameText = {}
GameText.__index = GameText

function GameText:new(text, font, size, pos)
	local G = {}
	setmetatable(G, GameText)
	
	G.string = text
	
	G.text = MOAITextBox.new()
	changePriority(G.text, "interface")
	G.text:setFont(font)
	G.text:setString(G.string)
	G.text:setTextSize(size)
	G.text:setYFlip(true)
	G.text:setRect(-screen.width/2, -screen.height/2, screen.width/2, screen.height/2)
	G.text:setLoc(pos.x, pos.y)
	G.text:setAlignment(MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY)
	
	layer:insertProp(G.text)
	
	return G
end

function GameText:clean()
	layer:removeProp(self.text)
end