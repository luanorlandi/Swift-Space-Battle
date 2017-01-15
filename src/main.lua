--[[
--------------------------------------------------------------------------------
This is a free game developed by Luan Orlandi in project of scientific research
at ICMC-USP, guided by Leandro Fiorini Aurichi and supported by CNPq

For more information, access https://github.com/luanorlandi/Swift-Space-Battle 
--------------------------------------------------------------------------------
]]

MOAILogMgr.setLogLevel(MOAILogMgr.LOG_NONE)

require "math/area"
require "math/util"
require "screen/screen"

screen = Screen:new()
layer = screen:newWindow()

require "interface/priority"
require "loop/ingame"
require "loop/inmenu"
require "loop/inintro"

require "input/input"

input = Input:new()

input:keyboard()
input:mouse()
input:touch()

local timeThread = MOAICoroutine.new()
timeThread:run(getTime)

local introThread = MOAICoroutine.new()
introThread:run(introLoop)

--local menuThread = MOAICoroutine.new()
--menuThread:run(menuLoop)

--local mainThread = MOAICoroutine.new()
--mainThread:run(gameLoop)