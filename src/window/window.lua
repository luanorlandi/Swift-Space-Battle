local ratio = 16 / 9
local defaultWidth = 1280
local defaultHeight = 720

Window = {}
Window.__index = Window

function Window:new()
	local S = {}
	setmetatable(S, Window)

	-- try to get from OS
	if S.width == nil or S.width == 0 or S.height == nil or S.height == 0 then
		S.width, S.height = MOAIGfxDevice.getViewSize()
		
		-- if was not possible, create a window with default resolution
		if S.width == nil or S.width == 0 or S.height == nil or S.height == 0 then
			S.width = defaultWidth
			S.height = defaultHeight
		end
	end

	-- adjust the window to be in proportion (still beaing inside the window)
	if S.height / S.width < ratio then
		S.width = S.height / ratio
	else
		S.height = S.width * ratio
	end
	
	S.scale = S.height / 1280
	
	return S
end

function Window:newWindow()	
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