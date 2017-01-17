local expType1Size = Vector:new(150 * window.scale, 150 * window.scale)
local expType2Size = Vector:new(250 * window.scale, 250 * window.scale)

expType1 = MOAITileDeck2D:new()
expType1:setTexture("texture/effect/expType1.png")
expType1:setSize(8, 8)
expType1:setRect(-expType1Size.x, -expType1Size.y, expType1Size.x, expType1Size.y)

expType2 = MOAITileDeck2D:new()
expType2:setTexture("texture/effect/expType2.png")
expType2:setSize(7, 7)
expType2:setRect(-expType2Size.x, -expType2Size.y, expType2Size.x, expType2Size.y)

Explosion = {}
Explosion.__index = Explosion

function Explosion:new(deck, pos, duration, frames)
	local E = {}
	setmetatable(E, Explosion)

	E.remapper = MOAIDeckRemapper.new ()
	E.remapper:reserve(frames)
	
	E.sprite = MOAIProp2D.new()
	changePriority(E.sprite, "effect")
	E.sprite:setDeck(deck)
	E.sprite:setRemapper(E.remapper)
	
	E.pos = pos
	
	E.duration = duration
	E.frames = frames
	
	E.curve = MOAIAnimCurve.new()
	E.curve:reserveKeys(E.frames)
	
	local t = 0.0
	for i = 1, E.frames, 1 do
		-- index, time in curve, value, mode
		E.curve:setKey(i, t, i)
		t = t + E.duration / E.frames
	end
	
	E.anim = MOAIAnim:new()
	E.anim:reserveLinks(1)
	E.anim:setLink(1, E.curve, E.remapper, 1)
	E.anim:setSpan(E.duration)
	
	E.complete = false
	
	E.sprite:setLoc(E.pos.x, E.pos.y)
	window.layer:insertProp(E.sprite)
	
	return E
end

ExplosionType1 = {}
ExplosionType1.__index = ExplosionType1

function ExplosionType1:new(pos, duration)
	local E = {}
	E = Explosion:new(expType1, pos, duration, 64)
	setmetatable(E, ExplosionType1)
	
	return E;
end

ExplosionType2 = {}
ExplosionType2.__index = ExplosionType2

function ExplosionType2:new(pos, duration)
	local E = {}
	E = Explosion:new(expType2, pos, duration, 49)
	setmetatable(E, ExplosionType2)
	
	return E;
end