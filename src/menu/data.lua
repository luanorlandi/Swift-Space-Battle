MenuData = {}
MenuData.__index = MenuData

function MenuData:new()
	local M = {}
	setmetatable(M, MenuData)
	
	M.active = true
	
	M.textBoxPos = {}
	M.textBoxSelected = 0
	
	M.menuFunction = {}
	
	M.resolutionsAvailable = readListOfResolutionsFile()
	
	return M
end

function MenuData:checkSelection()
	local selection = false
	local i = 1

	if MOAIEnvironment.osBrand ~= "Android" or input.pointerPressed then
	
		-- search in each label box which one is selected
		while i <= table.getn(self.textBoxPos) and not selection do
		
			if self.textBoxPos[i]:pointInside(input.pointerPos) then

				if i ~= self.textBoxSelected then
					if self.textBoxSelected ~= 0 then
						interface.textTable[self.textBoxSelected]:removeSelection()
					end
					
					self.textBoxSelected = i
					interface.textTable[self.textBoxSelected]:selection()
				end
				
				selection = true
			else
				i = i + 1
			end
		end
	end
	
	if not selection and self.textBoxSelected ~= 0 then
		interface.textTable[self.textBoxSelected]:removeSelection()
		
		self.textBoxSelected = 0
	end
end

function MenuData:checkPressed()
	-- check if any click/tap happened
	if input.pointerReleased then
		input.pointerReleased = false

		-- check if there is something selected
		if self.textBoxSelected ~= 0 then
			-- make the menu function selected
			self.menuFunction[self.textBoxSelected](self)
		end
	end
end

function MenuData:createMainMenu()
	-- clear previous menu, if any
	self:clearMenu()
	
	if(MOAIEnvironment.osBrand == "Windows") then
		texts = {}		-- has the menu strings
		table.insert(texts, strings.menu.play)
		table.insert(texts, strings.menu.score)
		table.insert(texts, strings.menu.options)
		table.insert(texts, strings.menu.about)
		table.insert(texts, strings.menu.quit)
		
		-- create a new menu
		interface:createMenu(texts)
		
		-- create the label boxes to allow selection
		self:createBoxesMenu(5)
		
		-- define what each menu item will do
		table.insert(self.menuFunction, function() self:newGame() end)
		table.insert(self.menuFunction, function() self:createScoreMenu() end)
		table.insert(self.menuFunction, function() self:createOptionsMenu() end)
		table.insert(self.menuFunction, function()
			print(os.execute("start " .. strings.url))
		end)

		table.insert(self.menuFunction, function() self:exitGame() end)

	elseif(MOAIEnvironment.osBrand == "Android") then
		texts = {}		-- has the menu strings
		table.insert(texts, strings.menu.play)
		table.insert(texts, strings.menu.score)
		table.insert(texts, strings.menu.about)
		table.insert(texts, strings.menu.quit)
		
		-- create a new menu
		interface:createMenu(texts)
		
		-- create the label boxes to allow selection
		self:createBoxesMenu(4)
		
		-- define what each menu item will do
		table.insert(self.menuFunction, function() self:newGame() end)
		table.insert(self.menuFunction, function() self:createScoreMenu() end)
		table.insert(self.menuFunction, function()
			if(MOAIBrowserAndroid.canOpenURL(strings.url)) then
				MOAIBrowserAndroid.openURL(strings.url)
			end
		end)

		table.insert(self.menuFunction, function() self:exitGame() end)

	else	-- probably html host
		texts = {}		-- has the menu strings
		table.insert(texts, strings.menu.play)
		table.insert(texts, strings.menu.score)
		
		-- create a new menu
		interface:createMenu(texts)
		
		-- create the label boxes to allow selection
		self:createBoxesMenu(2)
		
		-- define what each menu item will do
		table.insert(self.menuFunction, function() self:newGame() end)
		table.insert(self.menuFunction, function() self:createScoreMenu() end)
	end
end

function MenuData:createScoreMenu()
	self:clearMenu()
	
	local score = readScoreFile()
	
	texts = {}
	table.insert(texts, score)
	table.insert(texts, strings.menu.back)
	
	interface:createMenu(texts)
	
	interface.textTable[1].selectable = false
	
	self:createBoxesMenu(2)
	
	table.insert(self.menuFunction, function()  end)
	table.insert(self.menuFunction, function() self:createMainMenu() end)
end

function MenuData:createOptionsMenu()
	self:clearMenu()
	
	local width = math.floor(window.width)
	local height = math.floor(window.height)

	texts = {}
	table.insert(texts, strings.menu.resolution .. " (" .. width .. "x" .. height .. ")")
	table.insert(texts, strings.menu.back)
	
	interface:createMenu(texts)
	
	self:createBoxesMenu(2)
	
	table.insert(self.menuFunction, function() self:createResolutionsMenu() end)
	table.insert(self.menuFunction, function() self:createMainMenu() end)
end

function MenuData:createResolutionsMenu()
	self:clearMenu()
	
	-- table with all label that appears in the menu
	local resolutionsTexts = {}
	
	for i = 1, table.getn(self.resolutionsAvailable), 1 do
		
		table.insert(self.menuFunction, function()
			writeResolutionFile(self.resolutionsAvailable[i])
			
			self:createOptionsMenu()
		end)
		
		local width = math.floor(self.resolutionsAvailable[i].x)
		local height = math.floor(self.resolutionsAvailable[i].y)
		
		table.insert(resolutionsTexts, width .. "x" .. height)
	end
	
	-- include the return button at the end
	table.insert(self.menuFunction, function() self:createOptionsMenu() end)
	table.insert(resolutionsTexts, strings.menu.back)
	
	self:createBoxesMenu(table.getn(resolutionsTexts))
	
	interface:createMenu(resolutionsTexts)
end

function MenuData:createBoxesMenu(n)
	-- create 'n' label boxes to selection
	
	for i = 1, n, 1 do
		local center = Vector:new(0, interface.textStart - (i - 1) * interface.textGap)
		
		local box = Rectangle:new(center, Vector:new(window.width / 2, interface.textSize / 2))
	
		table.insert(self.textBoxPos, box)
	end
end

function MenuData:createBoxesMenuCustomStart(start, n)
	-- create 'n' label boxes to selection
	-- starting at 'start'
	
	for i = 1, n, 1 do
		local center = Vector:new(0, start - (i - 1) * interface.textGap)
		
		local box = Rectangle:new(center, Vector:new(window.width / 2, interface.textSize / 2))
	
		table.insert(self.textBoxPos, box)
	end
end

function MenuData:newGame()
	self.active = false
	
	interface:clear()
	
	local gameThread = MOAICoroutine.new()
	gameThread:run(gameLoop)
end

function MenuData:exitGame()
	os.exit(0)
end

function MenuData:clearMenu()
	interface:clearMenu()
	
	self.textBoxSelected = 0
	
	for i = 1, table.getn(self.textBoxPos), 1 do
		table.remove(self.textBoxPos, 1)
	end
	
	for i = 1, table.getn(self.menuFunction), 1 do
		table.remove(self.menuFunction, 1)
	end
end