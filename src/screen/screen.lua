local ratio = 16 / 9
local defaultWidth = 1280
local defaultHeight = 720

Screen = {}
Screen.__index = Screen

function Screen:new()
	local S = {}
	setmetatable(S, Screen)

	-- try to read from a file
	local resolution = readResolutionFile()
	S.width = resolution.x
	S.height = resolution.y
	
	-- if was not possible, try to get from OS
	if S.width == nil or S.width == 0 or S.height == nil or S.height == 0 then
		S.width, S.height = MOAIGfxDevice.getViewSize()
		
		-- if was not possible, create a window with default resolution
		if S.width == nil or S.width == 0 or S.height == nil or S.height == 0 then
			S.width = defaultWidth
			S.height = defaultHeight
		end
	end

	-- adjust the window to be in proportion (still beaing inside the screen)
	if S.height / S.width < ratio then
		S.width = S.height / ratio
	else
		S.height = S.width * ratio
	end
	
	S.scale = S.height / 1280
	
	return S
end

function Screen:newWindow()	
	MOAISim.openWindow("Swift Space Battle", self.width, self.height)

	MOAIEnvironment.setListener(MOAIEnvironment.EVENT_VALUE_CHANGED, onEventValueChanged)
	
	viewport = MOAIViewport.new()
	viewport:setSize(self.width, self.height)
	viewport:setScale(self.width, self.height)

	layer = MOAILayer2D.new()
	layer:setViewport(viewport)
	
	MOAIEnvironment.setListener(MOAIEnvironment.EVENT_VALUE_CHANGED, onEventValueChanged)

	MOAIRenderMgr.pushRenderPass(layer)
	
	return layer
end

function readResolutionFile()
	local file = io.open("file/options.lua", "r")
	
	local resolution = Vector:new(0, 0)
	
	if file ~= nil then
		resolution.x = tonumber(file:read())
		resolution.y = tonumber(file:read())
		
		io.close(file)
	end
	
	return resolution
end

function writeResolutionFile(resolution)
	local file = io.open("file/options.lua", "w")
	
	if file ~= nil then
		file:write(resolution.x .. "\n")
		file:write(resolution.y)
		
		io.close(file)
	end
end

function readListOfResolutionsFile()
	local file = io.open("file/listOfResolutions.lua", "r")
	
	local resolutionsTable = {}

	-- to avoid texts go out of the screen
	local limit = 7 	-- limit of options available
	
	if file ~= nil then
		repeat
			local width = file:read()
			local height = file:read()
		
			if width ~= nil and height ~= nil then
				table.insert(resolutionsTable, Vector:new(width, height))
			end
		until (width == nil and height == nil) or (table.getn(resolutionsTable) >= limit)
		
		io.close(file)
	end
	
	return resolutionsTable
end

function onEventValueChanged(key, value)
	-- callback function
	-- if the window size changed, it will be called

	if key == "horizontalResolution" then
		screen.width = value
		viewport:setSize(screen.width, screen.height)
		viewport:setScale(screen.width, screen.height)
	elseif key == "verticalResolution" then
		screen.height = value
		viewport:setSize(screen.width, screen.height)
		viewport:setScale(screen.width, screen.height)
	end
end