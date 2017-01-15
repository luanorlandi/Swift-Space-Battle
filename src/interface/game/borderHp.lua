local borderHpDeck = MOAIGfxQuad2D.new()
borderHpDeck:setTexture("texture/effect/borderhp.png")
borderHpDeck:setRect(-screen.width/2, -screen.height/2, screen.width/2, screen.height/2)

BorderHp = {}
BorderHp.__index = BorderHp

function BorderHp:new()
	local B = {}
	setmetatable(B, BorderHp)
	
	B.active = true
	
	B.sprite = MOAIProp2D.new()
	changePriority(B.sprite, "interface")
	B.sprite:setDeck(borderHpDeck)
	
	B.sprite:setLoc(0, 0)
	layer:insertProp(B.sprite)
	
	B.thread = coroutine.create(function()
		B:showBorderHp()
	end)
	coroutine.resume(B.thread)
	
	return B
end

function BorderHp:showBorderHp()
	self.sprite:setBlendMode(MOAIProp.GL_SRC_ALPHA, MOAIProp.GL_ONE_MINUS_SRC_ALPHA)

	while self.active do
		coroutine.yield()
		
		local hpPercentage = player.hp / player.maxHp
		
		if hpPercentage > 1 then hpPercentage = 1 end
		if hpPercentage < 0 then hpPercentage = 0 end
		
		hpPercentage = 1 - hpPercentage
		
		self.sprite:setColor(1, 1, 1, hpPercentage)
	end
end

function BorderHp:clean()
	layer:removeProp(self.sprite)
end