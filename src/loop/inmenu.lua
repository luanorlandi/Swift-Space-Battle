require "interface/menu/menuInterface"
require "menu/data"

function menuDelay(delay)
	local start = MOAISim.getElapsedTime()

	while start + interface.delay > MOAISim.getElapsedTime() do
		coroutine.yield()
	end
end

function menuLoop()
	interface = MenuInterface:new()

	-- make delay before appear text
	menuDelay(interface.delay)

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