local lifeIconSize = Vector:new(30 * window.scale, 30 * window.scale)
local lifeIcon = MOAIGfxQuad2D.new()
lifeIcon:setTexture("texture/ship/ship5life.png")
lifeIcon:setRect(-lifeIconSize.x, -lifeIconSize.y, lifeIconSize.x, lifeIconSize.y)

Lives = {}
Lives.__index = Lives

function Lives:new(qty)
	local L = {}
	setmetatable(L, Lives)
	
	L.max = qty
	L.qty = qty
	
	L.icon = {}
	for i = 1, qty, 1 do
		local sprite = MOAIProp2D.new()
		changePriority(sprite, "interface")
		sprite:setDeck(lifeIcon)
		
		sprite:setLoc(iconLifePos(i))
		window.layer:insertProp(sprite)
		
		table.insert(L.icon, sprite)
	end
	
	return L
end

function Lives:decrease()
	if table.getn(self.icon) > 0 then
		window.layer:removeProp(self.icon[table.getn(self.icon)])
		table.remove(self.icon, table.getn(self.icon))
		self.qty = self.qty - 1
	end
end

function iconLifePos(n)
	-- fin position 'n' that the icon will stay
	local d = (window.width / 2) / 5		-- distance between icons
	
	return (window.width / 2) - (n * d), -(window.height / 2) + d
end

function Lives:clear()
	for i = 1, table.getn(self.icon), 1 do
		window.layer:removeProp(self.icon[1])
		table.remove(self.icon, 1)
	end
end