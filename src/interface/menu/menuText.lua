local textSize = math.floor(45 * window.scale)
local menuFont = MOAIFont.new()
menuFont:loadFromTTF("font//zekton free.ttf", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-ãõç", textSize, 72)

MenuText = {}
MenuText.__index = MenuText

function MenuText:new(text, pos)
	-- create a label in position "pos"
	local T = {}
	setmetatable(T, MenuText)
	
	T.string = "" .. text
	T.pos = pos
	
	T.selectable = true
	
	T.text = MOAITextBox.new()
	T.text:setFont(menuFont)
	T.text:setString(T.string)
	T.text:setTextSize(textSize, 72)
	T.text:setYFlip(true)
	T.text:setRect(-window.width/2, -window.height/2, window.width/2, window.height/2)
	T.text:setLoc(pos.x, pos.y)
	T.text:setAlignment(MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY)
	changePriority(T.text, "interface")
	layer:insertProp(T.text)
	
	return T
end

function MenuText:selection()
	-- make the animation of selecting this a option
	if self.selectable then
		self.text:seekColor(1, 0, 0, 1, MOAIEaseType.EASE_IN)
	end
end

function MenuText:removeSelection()
	if self.selectable then
		self.text:seekColor(1, 1, 1, 1, MOAIEaseType.EASE_IN)
	end
end

function MenuText:setPos(pos)
	self.pos = pos
	self.text:setLoc(pos.x, pos.y)
end