require "interface/intro/introInterface"

function introLoop()
	intro = Intro:new()
	
	if MOAIEnvironment.osBrand ~= nil then
		while coroutine.status(intro.thread) ~= "dead" and not input.pointerReleased do
			coroutine.yield()
			
			coroutine.resume(intro.thread)
		end
	else
		-- probably html host
		while coroutine.status(intro.thread) ~= "dead" and not input.pointerPressed do
			coroutine.yield()
			
			coroutine.resume(intro.thread)
		end
	end
	
	input.pointerPressed = false
	input.pointerReleased = false
	
	intro:clear()
	
	local menuThread = MOAICoroutine.new()
	menuThread:run(menuLoop)
end