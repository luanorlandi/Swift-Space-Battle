require "data/interface/menu/menuInterface"
require "data/menu/data"

function menuLoop()
	interface = MenuInterface:new()
	local menuData = MenuData:new()
	
	menuData:createMainMenu()
	
	while menuData.active do
		coroutine.yield()
		
		menuData:checkSelection()
		menuData:checkPressed()
	end
end