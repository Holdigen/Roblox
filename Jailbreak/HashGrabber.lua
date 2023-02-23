-- services
local replicatedStorage = game:GetService("ReplicatedStorage")

-- debug library
local getupvalues = (debug and debug.getupvalues) or getupvalues
local getupvalue = (debug and debug.getupvalue) or getupvalue
local getconstants = (debug and debug.getconstants) or getconstants
local getconstant = (debug and debug.getconstant) or getconstant

-- variables
local modules = {
    alexChassis2 = require(replicatedStorage.Module.AlexChassis2),
    sidebarUi = require(replicatedStorage.Game.SidebarUI),
    teamUi = require(replicatedStorage.Game.TeamChooseUI),
    gunshopUi = require(replicatedStorage.Game.GunShop.GunShopUI),
    heli = require(replicatedStorage.Game.Vehicle.Heli)
}
local hashes = {}

local network = getupvalue(getupvalue(modules.alexChassis2.SetEvent, 1)["FireServer"], 1)
local remote = getupvalue(network, 2)
local rawHashes = getupvalue(network, 3)

local ids = {}
do
    for hash, id in next, rawHashes do
        ids[id] = hash
    end
end

-- ignore (testing) --
for i, v in next, ids do
    if i:find("!4849") then
        --print(v, "lol")
        --setclipboard(v)
    end
end
--do return end
-- ignore --

-- functions
local function getHash(func, blacklisted)
    blacklisted = blacklisted or {}

    local constants = getconstants(func)

    for index, constant in next, constants do
        constants[index] = tostring(constant)
        if table.find(ids, constant) and not table.find(blacklisted, constant) then
            return constant, constant, 1
        end
    end
    do
        local char1, char2 = nil, nil

        for index, constant in next, constants do
            if string.len(constant) == 1 then
                if char1 then
                    char2 = constant
                else
                    char1 = constant
                end
            end
        end

        if char1 and char2 then
            for hash, id in next, rawHashes do
                if string.sub(hash, 1, 1) == char1 and string.sub(hash, string.len(hash), string.len(hash)) == char2 and not table.find(blacklisted, hash) then
                    return hash, char1, 2
                end
            end
        end
    end
    do
        local chars1, char2 = nil, nil

        for index, constant in next, constants do
            if string.len(constant) == 2 then
                chars1 = constant
            elseif string.len(constant) == 1 then
                char2 = constant
            end
        end

        if chars1 and char2 then
            for hash, id in next, rawHashes do
                if string.sub(hash, 1, 2) == chars1 and string.sub(hash, string.len(hash), string.len(hash)) == char2 and not table.find(blacklisted, hash) then
                    return hash, char2, 3
                end
            end
        end
    end
    do
        local char1, chars2 = nil, nil

        for index, constant in next, constants do
            if string.len(constant) == 1 then
                char1 = constant
            elseif string.len(constant) == 2 then
                chars2 = constant
            end
        end

        if char1 and chars2 then
            for hash, id in next, rawHashes do
                if string.sub(hash, 1, 1) == char1 and string.sub(hash, string.len(hash) - 1, string.len(hash)) == chars2 and not table.find(blacklisted, hash) then
                    return hash, char1, 4
                end
            end
        end
    end 
    do
        local chars1, chars2 = nil, nil

        for index, constant in next, constants do
            if string.len(constant) == 2 then
                if chars1 then
                    chars2 = constant
                else
                    chars1 = constant
                end
            end
        end

        if chars1 and chars2 then
            for hash, id in next, rawHashes do
                if string.sub(hash, 1, 2) == chars1 and string.sub(hash, string.len(hash) - 1, string.len(hash)) == chars2 and not table.find(blacklisted, hash) then
                    return hash, chars1, 5
                end
            end
        end
    end
    for _, constant in next, constants do
        if string.len(constant) > 2 then
            for id, hash in next, ids do
                if string.sub(hash, 1, string.len(constant)) == constant and not table.find(blacklisted, hash) then
                    return hash, constant, 8
                elseif string.sub(hash, string.len(hash) - string.len(constant) + 1, string.len(hash)) == constant and not table.find(blacklisted, hash) then
                    return hash, constant, 9
                end
            end
        end
    end

    for i = 1, #constants do
        for d = 1, #constants do
            local triedHash = constants[i] .. constants[d]

            if rawHashes[triedHash] and not table.find(blacklisted, triedHash) then
                return triedHash, constants[i], 6
            end
        end
    end

    local opportunities = {}
    local function getOpportunities(constant)
        local opportunities = {}

        for i = 0, string.len(constant), 1 do
            local opportunity = string.sub(constant, i, i + 3)

            if opportunity == opportunity:lower() then
                table.insert(opportunities, opportunity)
                table.insert(opportunities, string.reverse(opportunity))
            end
        end

        return opportunities
    end
    for index, constant in next, constants do
        for _, opportunity in next, getOpportunities(constant) do
            if string.len(opportunity) > 2 then
                table.insert(opportunities, opportunity)
            end
        end
    end

    for _, opportunity in next, opportunities do
        for hash, id in next, rawHashes do
            if hash:find(opportunity) and not table.find(blacklisted, hash) then
                return hash, opportunity, 7
            end
        end
    end

    return false
end

-- garbage collector hashes
for _, garbage in next, getgc() do
    if type(garbage) == "function" then
        local info = getinfo(garbage)

        if not info.source:find("@") and islclosure(garbage) and info.source:find(".") then
            local constants = getconstants(garbage)

            if table.find(constants, "Enter") and table.find(constants, "IsVehicle") and table.find(constants, "Duration") then
                hashes["Hijack"] = getupvalue(getupvalue(garbage, 1), 1)
                hashes["Eject"] = getupvalue(getupvalue(garbage, 1), 2)
                hashes["Enter"] = getupvalue(getupvalue(garbage, 1), 3)
            end
            if table.find(constants, "GetLocalEquipped") and table.find(constants, "Reloading") then
                hashes["Arrest"] = getupvalue(garbage, 7)
            end
            if table.find(constants, "SewerHatch") and table.find(constants, "Pull Open") then
                hashes["Escape"] = getproto(garbage, 1)
            end
            if info.name == "attemptPunch" then
                hashes["Punch"] = garbage
            end
            if info.name == "attemptDropRope" then
                hashes["ToggleRope"] = getupvalue(garbage, 1)
            end
            if info.name == "attemptFireMissle" then
                hashes["FireMissle"] = getupvalue(garbage, 1)
            end
            if info.name == "attemptDropBomb" then
                hashes["DropBomb"] = getupvalue(garbage, 1)
            end
            if info.name == "toggleHeadlights" then
                hashes["ToggleLights"] = garbage
            end
            if table.find(constants, "Rob") and table.find(constants, "IsRob") and table.find(constants, "Duration") then
                local hash, founder, line = getHash(getupvalue(garbage, 1))
                
                hashes["EndRob"] = hash
                hashes["StartRob"] = getHash(getupvalue(garbage, 1), {hash})
            end
        end
    end
end
do
    -- leave team (call before join team)
    hashes["LeaveTeam"] = getproto(getproto(modules.sidebarUi.Init, 2), 1)

    -- join team (call after leave team)
    hashes["JoinTeam"] = getproto(modules.teamUi.Show, 4)

    -- heli
    -- gun keys
    --[[ do incorrect hashes returned; will fix soon
        local hashes = {}
        local hash, founder, line = getHash(getproto(modules.gunshopUi.displayList, 1), hashes)
        hashes["EquipGun"] = hash
        table.insert(hashes, hash)
        
        local hash, founder, line = getHash(getproto(modules.gunshopUi.displayList, 1), hashes)
        hashes["BuyGun"] = hash
        table.insert(hashes, hash)

        local hash, founder, line = getHash(getproto(modules.gunshopUi.displayList, 1), hashes)
        hashes["UnequipGun"] = hash
    end ]]
end

-- auto filling hash ids
for name, func in next, hashes do
    if rawHashes[func] then
        hashes[name] = rawHashes[func]
    else
        hashes[name] = rawHashes[getHash(func)]
    end
end

-- return remote and hashes
return remote, hashes