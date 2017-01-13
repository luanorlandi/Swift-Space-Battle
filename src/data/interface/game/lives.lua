local lifeIconSize = Vector:new(30 * screen.scale, 30 * screen.scale)
local lifeIcon = MOAIGfxQuad2D.new()
lifeIcon:setTexture("texture/ship/ship5.png")
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
		layer:insertProp(sprite)
		
		table.insert(L.icon, sprite)
	end
	
	return L
end

function Lives:decrease()
	if table.getn(self.icon) > 0 then
		layer:removeProp(self.icon[table.getn(self.icon)])
		table.remove(self.icon, table.getn(self.icon))
		self.qty = self.qty - 1
	end
end

function iconLifePos(n)
	-- acha a posicao "n" que o icone deve ser colocado
	local d = (screen.width / 2) / 5		-- distancia entre cada icone
	
	return (screen.width / 2) - (n * d), -(screen.height / 2) + d
end

function Lives:clean()
	for i = 1, table.getn(self.icon), 1 do
		layer:removeProp(self.icon[1])
		table.remove(self.icon, 1)
	end
end