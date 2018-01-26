local DEFAULT_LANGUAGE = "en"
language = {}

require "file/language/cs"
require "file/language/da"
require "file/language/de"
require "file/language/el"
require "file/language/en"
require "file/language/es"
require "file/language/fr"
require "file/language/hu"
require "file/language/id"
require "file/language/it"
require "file/language/nb"
require "file/language/nl"
require "file/language/pt"
require "file/language/ru"
require "file/language/sv"
require "file/language/uk"

button = {}

require "file/button"


function readLanguageFile()
    local path = locateSaveLocation()

    -- probably an unexpected host (like html)
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

    -- probably an unexpected host (like html)
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
    if lang == nil then
        -- set current language
        -- try to find a language saved in a file, then by OS, then use default
        strings = language[readLanguageFile()] or
            language[MOAIEnvironment.languageCode] or
            language[DEFAULT_LANGUAGE]
    elseif language[lang] ~= nil then
        strings = language[lang]
    end
    
    strings.url = "https://github.com/luanorlandi/Swift-Space-Battle"
    strings.button = button;
end

changeLanguage();
