require "interface/intro/introInterface"

function introLoop()
	intro = Intro:new()
	
	while coroutine.status(intro.thread) ~= "dead" and not input.pointerPressed do
		coroutine.yield()
		
		coroutine.resume(intro.thread)
	end
	input.pointerPressed = false
	
	intro:clear()
	
	local menuThread = MOAICoroutine.new()
	menuThread:run(menuLoop)
end