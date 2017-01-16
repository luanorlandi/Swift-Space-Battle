Scenario = {}
Scenario.__index = Scenario

function Scenario:new(deck, pos)
	local S = {}
	setmetatable(S, Scenario)
	
	S.sprite = MOAIProp2D.new()
	changePriority(S.sprite, "scenario")
	S.sprite:setDeck(deck)
	
	S.pos = pos
	S.spd = Vector:new(0, 0)
	
	S.startPos = Vector:new(pos.x, pos.y)
	
	S.size = Vector:new(window.width / 2, window.height / 2)
	S.limit = 2 * S.size.y
	
	S.sprite:setLoc(S.pos.x, S.pos.y)
	window.layer:insertProp(S.sprite)
	
	return S
end

function Scenario:move()
	if self.pos.y > self.startPos.y - self.limit then
		self.pos:sum(self.spd)
	else
		self.pos.y = self.startPos.y
	end
	
	self.sprite:setLoc(self.pos.x, self.pos.y)
end

function Scenario:clear()
	window.layer:removeProp(self.sprite)
end