local listPriority = {
	["scenario"] = 1,
	["ship"] = 2,
	["shot"] = 3,
	["effect"] = 5,
	["interface"] = 6
}

function changePriority(sprite, priority)
	sprite:setPriority(listPriority[priority])
end