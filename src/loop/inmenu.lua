require "interface/menu/menuInterface"
require "menu/data"

function menuLoop()
	interface = MenuInterface:new()
	local menuData = MenuData:new()
	
	menuData:createMainMenu()
	
	while menuData.active do
		coroutine.yield()
		
		menuData:checkPressed()
		menuData:checkSelection()
	end

	input.cancel = false
end