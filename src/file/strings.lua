language = {}

require "file/da"
require "file/de"
require "file/en"
require "file/es"
require "file/fr"
require "file/it"
require "file/pt"
require "file/hu"
require "file/sv"
require "file/nl"
require "file/ru"
require "file/uk"

function readLanguageFile()
	local path = locateSaveLocation()

	-- probably a unexpected host (like html)
	if path == nil then
		return nil
	end

	local file = io.open(path .. "/language.lua", "r")
	local lang = nil

	if file ~= nil then
		lang = file:read()
		io.close(file)
	end
    
    return lang
end

function writeLanguageFile(lang)
	local path = locateSaveLocation()
	
	-- probably a unexpected host (like html)
	if path == nil then
		return nil
	end

	local file = io.open(path .. "/language.lua", "w")
	
	if file ~= nil then
		file:write(lang)
		io.close(file)
	end
end

function changeLanguage(lang)
    if language[lang] ~= nil then
        strings = language[lang]
        strings.url = "https://github.com/luanorlandi/Swift-Space-Battle"
    end
end

-- set current language
-- try to find a language saved in a file, then by OS, then use default
strings = language[readLanguageFile()] or
    language[MOAIEnvironment.languageCode] or
    language["en"]

strings.url = "https://github.com/luanorlandi/Swift-Space-Battle"