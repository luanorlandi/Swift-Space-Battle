Enemy = {}
Enemy.__index = Enemy

function Enemy:new(deck, pos)
	local E = {}
	E = Ship:new(deck, pos)
	setmetatable(E, Enemy)
	
	if E.pos.y > player.pos.y then
		E.sprite:moveRot(180, 0)
		E.aim.y = -1
	end
	
	return E
end