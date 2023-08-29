local function removeIndexesFromString(stringToRemove, index1, index2)
    local part1 = string.sub(stringToRemove, 1, index1)
    local part2 = string.sub(stringToRemove, index2 + 1, string.len(stringToRemove))

    return part1 .. part2
end
local function addCharacterByIndex(stringToAdd, index, char)
    local part1 = string.sub(stringToAdd, 1, index)
    local part2 = string.sub(stringToAdd, index + 1, string.len(stringToAdd))

    return part1 .. char .. part2
end
local function cleanTableIndexing(code)
    local code = code
    local findStart, findEnd

    repeat
        findStart, findEnd = string.find(code, '%["')
        if not findStart or not findEnd then
            break
        end

        code = removeIndexesFromString(code, findStart - 1, findEnd)
        if string.match(string.sub(code, findStart - 2, findStart - 1), "%w") then
            code = addCharacterByIndex(code, findStart - 1, ".")
        end

        local findEndingStart, findEndingEnd = string.find(code, '"]')
        code = removeIndexesFromString(code, findEndingStart - 1, findEndingEnd)
    until not findStart or not findEnd

    return code
end

return cleanTableIndexing, {
    addCharacterByIndex = addCharacterByIndex,
    removeIndexesFromString = removeIndexesFromString
}

--[[
    Usage:
    Just run the function cleanTableIndexing (first argument that gets returned) with 1 argument: your source code you want to clean the table indexing

    Example:
    local result = cleanTableIndexing('   local hi = { ["Hi"] = { ["Bye"] = "NO" } }  print(hi["Hi"]["Bye"])   ')

    Returned string (beautified):
    local hi = {
        Hi = {
            Bye = "NO"
        }
    }

    print(hi.Hi.Bye)

    Why is this helpful?
    Well, maybe you are rewriting your sources and want to switch from table["test"] to just indexing it direct like this table.test

    made by Hold#4564
    :D
]]
