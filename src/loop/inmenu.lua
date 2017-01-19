require "interface/menu/menuInterface"
require "menu/data"

function menuLoop()
	interface = MenuInterface:new()
	local menuData = MenuData:new()
	
	menuData:createMainMenu()
	
	while menuData.active do
		coroutine.yield()

		-- touch requires to be in this order		
		menuData:checkPressed()

		-- prevent check in case of quit or new game started
		if menuData.active then
			menuData:checkSelection()
		end
	end
end