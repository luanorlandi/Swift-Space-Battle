require "scenario/scenario"

local littleStarsDeck = MOAIGfxQuad2D.new()
littleStarsDeck:setTexture("texture/scenario/littleStars.png")
littleStarsDeck:setRect(-window.width / 2, -window.height / 2, window.width / 2, window.height / 2)

local bigStarsDeck = MOAIGfxQuad2D.new()
bigStarsDeck:setTexture("texture/scenario/bigStars.png")
bigStarsDeck:setRect(-window.width / 2, -window.height / 2, window.width / 2, window.height / 2)

Stage1 = {}
Stage1.__index = Stage1

function Stage1:new()
	local S = {}
	setmetatable(S, Stage1)
	
	S.name = "Stage1"
	
	S.scenarios = {}
	
	local bigSpd = (-2) * window.scale
	local smallSpd = bigSpd * 0.95
	
	local downSmaller = Scenario:new(littleStarsDeck, Vector:new(0, 0))
	downSmaller.spd.y = smallSpd
	table.insert(S.scenarios, downSmaller)
	
	local upSmaller = Scenario:new(littleStarsDeck, Vector:new(0, window.height))
	upSmaller.spd.y = smallSpd
	table.insert(S.scenarios, upSmaller)
	
	local downBigger = Scenario:new(bigStarsDeck, Vector:new(0, 0))
	downBigger.spd.y = bigSpd
	table.insert(S.scenarios, downBigger)
	
	local upBigger = Scenario:new(bigStarsDeck, Vector:new(0, window.height))
	upBigger.spd.y = bigSpd
	table.insert(S.scenarios, upBigger)
	
	return S
end

function Stage1:move()
	for i = 1, table.getn(self.scenarios), 1 do
		self.scenarios[i]:move()
	end
end

function Stage1:clear()
	for i = 1, table.getn(self.scenarios), 1 do
		self.scenarios[1]:clear()
		table.remove(self.scenarios, 1)
	end
end