local replicatedStorage = game:GetService("ReplicatedStorage")
local dataService = replicatedStorage.Modules.DataService

local remoteAdded = getconnections(dataService.DescendantAdded)[1].Function
local hashRemotes = getupvalue(remoteAdded, 1)
local hashNames = getupvalue(getupvalue(remoteAdded, 2), 1)

local remotes = {}

for hash, name in next, hashNames do
    remotes[name:gsub("F_", "")] = hashRemotes[hash]
end

--[[
    to print all remotes run this:
    table.foreach(remotes, print)

    a remote to test this (must be in the pizza delivery job)
    local result = remotes.UsePizzaMoped:InvokeServer({})
]]

return remotes
