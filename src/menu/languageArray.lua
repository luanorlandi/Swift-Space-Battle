local languageArray

local function convertLanguageToArray()
    local texts = {}
    
    for ISO, value in pairs(language) do
        local text = {ISO = ISO, name = value.name}
        table.insert(texts, text)
    end
    
    return texts
end

local function compareLanguage(languageA, languageB)
    return languageA.name < languageB.name
end

local function sortLanguageArray(languageArray)
    table.sort(languageArray, compareLanguage)
end

function getLanguageArraySorted()
    languageArray = convertLanguageToArray()

    sortLanguageArray(languageArray)

    return languageArray
end
