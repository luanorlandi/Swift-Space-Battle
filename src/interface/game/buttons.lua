local buttonSize = Vector:new(window.scale * 45, window.scale * 45)

local buttonRightDeck = MOAIGfxQuad2D.new()
buttonRightDeck:setTexture("texture/others/buttonRight.png")
buttonRightDeck:setRect(-buttonSize.x, -buttonSize.y, buttonSize.x, buttonSize.y)

local buttonUpDeck = MOAIGfxQuad2D.new()
buttonUpDeck:setTexture("texture/others/buttonUp.png")
buttonUpDeck:setRect(-buttonSize.x, -buttonSize.y, buttonSize.x, buttonSize.y)

local buttonDownDeck = MOAIGfxQuad2D.new()
buttonDownDeck:setTexture("texture/others/buttonDown.png")
buttonDownDeck:setRect(-buttonSize.x, -buttonSize.y, buttonSize.x, buttonSize.y)

local buttonShootDeck = MOAIGfxQuad2D.new()
buttonShootDeck:setTexture("texture/others/buttonShoot.png")
buttonShootDeck:setRect(-buttonSize.x, -buttonSize.y, buttonSize.x, buttonSize.y)

Buttons = {}
Buttons.__index = Buttons

function Buttons:new()
	local B = {}
	setmetatable(B, Buttons)
	
	B.sprite = {}
	B.margin = Vector:new(window.scale * 10, window.scale * 25)
	B.alpha = 0.65

	-- android sprites, useful to change the sprite
	B.androidUpRight = nil
	B.androidUpLeft = nil
	B.androidDownRight = nil
	B.androidDownLeft = nil

    return B
end

function Buttons:showButtons()
	if MOAIEnvironment.osBrand == "Windows" then
		self:windowsCreate()
	elseif MOAIEnvironment.osBrand == "Android" then
		self:androidCreate()
	else
		-- probably html
		self:htmlCreate()
	end
end

function Buttons:androidCreate()
	-- right
	local sprite = MOAIProp2D.new()
	changePriority(sprite, "interface")
	sprite:setDeck(buttonRightDeck)
	
	sprite:setLoc(window.width/2 - buttonSize.x - self.margin.x, 0)
	window.layer:insertProp(sprite)
	
	table.insert(self.sprite, sprite)
	
	-- left
	sprite = MOAIProp2D.new()
	changePriority(sprite, "interface")
	sprite:setDeck(buttonRightDeck)
	sprite:setScl(-1, 1)		-- invert to be left
	
	sprite:setLoc(-window.width/2 + buttonSize.x + self.margin.x, 0)
	window.layer:insertProp(sprite)
	
	table.insert(self.sprite, sprite)
	
	-- shoot up right
	sprite = MOAIProp2D.new()
	changePriority(sprite, "interface")
	sprite:setDeck(buttonShootDeck)
	sprite:setLoc(
		window.width/2 - buttonSize.x - self.margin.x,
		buttonSize.y*2 + self.margin.y)
	window.layer:insertProp(sprite)
	table.insert(self.sprite, sprite)
	self.androidUpRight = sprite
	
	-- shoot down right
	sprite = MOAIProp2D.new()
	changePriority(sprite, "interface")
	sprite:setDeck(buttonDownDeck)
	sprite:setLoc(
		window.width/2 - buttonSize.x - self.margin.x,
		-buttonSize.y*2 -self.margin.y)
	window.layer:insertProp(sprite)
	table.insert(self.sprite, sprite)
	self.androidDownRight = sprite
	
	-- shoot up left
	sprite = MOAIProp2D.new()
	changePriority(sprite, "interface")
	sprite:setDeck(buttonShootDeck)
	sprite:setLoc(
		-window.width/2 + buttonSize.x + self.margin.x,
		buttonSize.y*2 + self.margin.y)
	window.layer:insertProp(sprite)
	table.insert(self.sprite, sprite)
	self.androidUpLeft = sprite
	
	-- shoot down left
	sprite = MOAIProp2D.new()
	changePriority(sprite, "interface")
	sprite:setDeck(buttonDownDeck)
	sprite:setLoc(
		-window.width/2 + buttonSize.x + self.margin.x,
		-buttonSize.y*2 - self.margin.y)
	window.layer:insertProp(sprite)
	table.insert(self.sprite, sprite)
	self.androidDownLeft = sprite
	
	-- set alpha
	for i = 1, #self.sprite do
		self.sprite[i]:setBlendMode(
			MOAIProp.GL_SRC_ALPHA,
			MOAIProp.GL_ONE_MINUS_SRC_ALPHA)
		
		self.sprite[i]:setColor(1, 1, 1, self.alpha)
	end
end

function Buttons:windowsCreate()

end

function Buttons:htmlCreate()

end

function Buttons:androidChangeSprite(aim)
	-- aim = -1 or 1
	-- change the shoot icon to rotate and the rotate to shoot

	if self.androidUpRight ~= nil then
		if aim == 1 then
			self.androidUpRight:setDeck(buttonShootDeck)
			self.androidUpLeft:setDeck(buttonShootDeck)
			self.androidDownRight:setDeck(buttonDownDeck)
			self.androidDownLeft:setDeck(buttonDownDeck)
		else
			self.androidUpRight:setDeck(buttonUpDeck)
			self.androidUpLeft:setDeck(buttonUpDeck)
			self.androidDownRight:setDeck(buttonShootDeck)
			self.androidDownLeft:setDeck(buttonShootDeck)
		end
	else
		return nil
	end
end

function Buttons:clear()
	for i = 1, #self.sprite do
		window.layer:removeProp(self.sprite[i])
	end

	self.androidUpRight = nil
	self.androidUpLeft = nil
	self.androidDownRight = nil
	self.androidDownLeft = nil
end