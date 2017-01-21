Window = {}
Window.__index = Window

function Window:new()
	local W = {}
	setmetatable(W, Window)

	W.ratio = 16 / 9

	-- try to read from a file
	local resolution = readResolutionFile()
	W.width = resolution.x
	W.height = resolution.y
	
	-- if was not possible, try to get from OS
	if W.width == nil or W.width == 0 or W.height == nil or W.height == 0 then
		W.width, W.height = MOAIGfxDevice.getViewSize()
		
		-- if was not possible, create a window with default resolution
		if W.width == nil or W.width == 0 or W.height == nil or W.height == 0 then
			W.width = 1280
			W.height = 720
		end
	end

	if MOAIEnvironment.osBrand ~= "Android" then
		-- adjust the window to be in proportion (still being inside the window)
		if W.height / W.width < W.ratio then
			W.width = W.height / W.ratio
		else
			W.height = W.width * W.ratio
		end
	end
	
	W.scale = W.height / 1280

	MOAISim.openWindow("Swift Space Battle", W.width, W.height)

	viewport = MOAIViewport.new()
	viewport:setSize(W.width, W.height)
	viewport:setScale(W.width, W.height)
	viewport:setOffset ( 0, 0 )

	W.layer = MOAILayer2D.new()
	W.layer:setViewport(viewport)
	
	--MOAIEnvironment.setListener(MOAIEnvironment.EVENT_VALUE_CHANGED, onEventValueChanged)

	MOAIRenderMgr.pushRenderPass(W.layer)
	
	return W
end

function readResolutionFile()
	local path = locateSaveLocation()

	-- probably a unexpected host (like html)
	if path == nil then
		return nil
	end

	local file = io.open(path .. "/resolution.lua", "r")
	
	local resolution = Vector:new(0, 0)
	
	if file ~= nil then
		resolution.x = tonumber(file:read())
		resolution.y = tonumber(file:read())
		
		io.close(file)
	end
	
	return resolution
end

function writeResolutionFile(resolution)
	local path = locateSaveLocation()

	-- probably a unexpected host (like html)
	if path == nil then
		return nil
	end

	local file = io.open(path .. "/resolution.lua", "w")
	
	if file ~= nil then
		file:write(resolution.x .. "\n")
		file:write(resolution.y)
		
		io.close(file)
	end
end

function readResolutionsFile()
	local file = io.open("file/resolutions.lua", "r")
	
	local resolutionsTable = {}

	-- to avoid texts go out of the window
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
		window.width = value
		viewport:setSize(window.width, window.height)
		viewport:setScale(window.width, window.height)
	elseif key == "verticalResolution" then
		window.height = value
		viewport:setSize(window.width, window.height)
		viewport:setScale(window.width, window.height)
	end
end

function showInfo()
	-- show a lot of information about the device
	print("appDisplayName", MOAIEnvironment.appDisplayName)
	print("appVersion", MOAIEnvironment.appVersion)
	print("cacheDirectory", MOAIEnvironment.cacheDirectory)
	print("carrierISOCountryCode", MOAIEnvironment.carrierISOCountryCode)
	print("carrierMobileCountryCode", MOAIEnvironment.carrierMobileCountryCode)
	print("carrierMobileNetworkCode", MOAIEnvironment.carrierMobileNetworkCode)
	print("carrierName", MOAIEnvironment.carrierName)
	print("connectionType", MOAIEnvironment.connectionType)
	print("countryCode", MOAIEnvironment.countryCode)
	print("cpuabi", MOAIEnvironment.cpuabi)
	print("devBrand", MOAIEnvironment.devBrand)
	print("devName", MOAIEnvironment.devName)
	print("devManufacturer", MOAIEnvironment.devManufacturer)
	print("devModel", MOAIEnvironment.devModel)
	print("devPlatform", MOAIEnvironment.devPlatform)
	print("devProduct", MOAIEnvironment.devProduct)
	print("documentDirectory", MOAIEnvironment.documentDirectory)
	print("iosRetinaDisplay", MOAIEnvironment.iosRetinaDisplay)
	print("languageCode", MOAIEnvironment.languageCode)
	print("numProcessors", MOAIEnvironment.numProcessors)
	print("osBrand", MOAIEnvironment.osBrand)
	print("osVersion", MOAIEnvironment.osVersion)
	print("resourceDirectory", MOAIEnvironment.resourceDirectory)
	print("windowDpi", MOAIEnvironment.windowDpi)
	print("verticalResolution", MOAIEnvironment.verticalResolution)
	print("horizontalResolution", MOAIEnvironment.horizontalResolution)
	print("udid", MOAIEnvironment.udid)
	print("openUdid", MOAIEnvironment.openUdid)
end