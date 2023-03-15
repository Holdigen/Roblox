-- services
local replicatedStorage = game:GetService("ReplicatedStorage")

-- variables
local dataService = replicatedStorage.Modules.DataService

local remotes = {}

for _, garbage in next, getgc() do
    if type(garbage) == "function" then
        local info = getinfo(garbage)

        if info.source:find("@") or not islclosure(garbage) then
            continue
        end
        if not info.source:find(dataService.Name) or getconnections(dataService.DescendantAdded)[1 or 2].Function ~= garbage then
            continue
        end

        local hashRemotes = getupvalue(garbage, 1)
        local hashNames = getupvalue(getupvalue(garbage, 2), 1)

        for hash, name in next, hashNames do
            remotes[string.gsub(name, "F_", "")] = hashRemotes[hash]
        end

        break
    end
end

-- Example: remotes.ExitBuild:FireServer({})

return remotes
