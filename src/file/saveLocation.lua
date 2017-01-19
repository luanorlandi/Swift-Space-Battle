function locateSaveLocation()
	-- get all possible file locations
	local document = MOAIEnvironment.documentDirectory
	local cache = MOAIEnvironment.cacheDirectory
	local resource = MOAIEnvironment.resourceDirectory
	local working = MOAIFileSystem.getWorkingDirectory()

	-- priority, get the first that is not nil
	local path = cache or document or resource or working

	if MOAIEnvironment.osBrand == "Windows" and path ~= nil then
		path = path .. "\\My Games\\swift-space-battle"

		-- create a folder at 'path' if none exists
		MOAIFileSystem.affirmPath(path)
	end

	return path
end