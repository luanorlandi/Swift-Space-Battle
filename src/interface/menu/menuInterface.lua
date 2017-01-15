require "interface/menu/background"
require "interface/menu/menuText"
require "interface/menu/title"

local textSize = math.floor(45 * screen.scale)
local menuFont = MOAIFont.new()
menuFont:loadFromTTF("font//zekton free.ttf", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-ãõç", textSize, 72)

local howToPlaySize = Vector:new(0.7 * screen.width/2, 0.7 * screen.width/2)
local howToPlayDeck = MOAIGfxQuad2D.new()
howToPlayDeck:setTexture("texture/others/howToPlay.png")
howToPlayDeck:setRect(-howToPlaySize.x, -howToPlaySize.y, howToPlaySize.x, howToPlaySize.y)

MenuInterface = {}
MenuInterface.__index = MenuInterface

function MenuInterface:new()
	local M = {}
	setmetatable(M, MenuInterface)
	
	-- menu background art
	M.background = Background:new()
	
	M.textTable = {}
	M.textSize = textSize
	M.textGap = 1.75 * M.textSize		-- space between labels
	M.textStart = 50 * screen.scale		-- first text position
	
	M.title = Title:new(Vector:new(0, M.textStart + 220 * screen.scale))
	
	M.howToPlaySprite = nil
	
	return M
end

function MenuInterface:createMenu(menuTable, start)
	-- receive a table with strings of names and texts in menu
	self:cleanMenu()
	
	self.textTable = {}
	
	if start == nil then
		start = self.textStart
	end

	for i = 1, table.getn(menuTable), 1 do
		local pos = Vector:new(0, start - ((i-1) * self.textGap))
		
		local text = MenuText:new(menuTable[i], pos)
		table.insert(self.textTable, text)
	end
end

function MenuInterface:showHowToPlay()
	-- show image with the controls of the ship

	self.howToPlaySprite = MOAIProp2D.new()
	changePriority(self.howToPlaySprite, "interface")
	
	self.howToPlaySprite:setDeck(howToPlayDeck)
	
	local pos = Vector:new(0, -0.25 * screen.height/2)
	
	self.howToPlaySprite:setLoc(pos.x, pos.y)
	layer:insertProp(self.howToPlaySprite)
end

function MenuInterface:cleanMenu()
	for i = 1, table.getn(self.textTable), 1 do
		layer:removeProp(self.textTable[1].text)
		table.remove(self.textTable, 1)
	end
	
	if self.howToPlaySprite ~= nil then
		layer:removeProp(self.howToPlaySprite)
	end
end

function MenuInterface:clean()
	self:cleanMenu()
	self.background:clean()
	self.title:clean()
end