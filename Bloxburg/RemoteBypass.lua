local remotes = {}

for i, v in next, getconnections(game:GetService("ReplicatedStorage").Modules.DataService.DescendantAdded) do
    if getupvalues(v.Function)[2] then
        local raw_hashes = getupvalue(v.Function, 1)
        local keys_hashes = getupvalue(getupvalue(getupvalue(getupvalue(v.Function, 3).WaitEvent, 1), 1), 1)

        for i, v in next, keys_hashes do
            remotes[i] = raw_hashes[v]
        end
    end
end

remotes["ExitBuildMode"]:FireServer() -- go in build mode then execute this remote to test
