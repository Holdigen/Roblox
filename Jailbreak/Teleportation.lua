-- This is probably outdated and won't work anymore.

--// Services
local pathfindingService = game:GetService("PathfindingService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local marketService = game:GetService("MarketplaceService")
local runService = game:GetService("RunService")
local collectionService = game:GetService("CollectionService")

--// Variables
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local root = humanoidRootPart
local speed = 1

--// Modules
local notification = require(replicatedStorage.Game.Notification)
local ui = require(replicatedStorage.Module.UI)
local characterUtil = require(replicatedStorage.Game.CharacterUtil)
local httpRequest = (syn and syn.request) or httpRequest or request or (http and http.request)
local vehicle = require(replicatedStorage.Game.Vehicle)

--// Skydive/Ragdoll Disabling
require(replicatedStorage.Game.JetPack.JetPack).IsFlying = function()
    return true
end
require(replicatedStorage.Module.AlexRagdoll).IsRagdoll = function()
    return false
end

--// Main Teleportation Library
local blacklistedCars = {}
local rayBlacklisted = {character, workspace.Vehicles}
local roofEscapeDescendants = {}
local roadsPath = {}
local heightExcluded = {}
local playerCollisions = {}

local Configuration = {
    path = pathfindingService:CreatePath({WaypointSpacing = 3}),
    noclipEnabled = false,
    vehicleSpeed = 650,
    playerSpeed = 170,
    yLevel = 2000,
    noclip = false
}
speed = Configuration.playerSpeed

for _, child in next, workspace:GetChildren() do
    if child.Name == "SwingDoor" then
        table.insert(roofEscapeDescendants, child)
        for _, descendant in next, child:GetDescendants() do
            if descendant.Name:find("Part") then
                descendant.CanCollide = false
            end
        end
    end
    if child.Name == "SlideDoor" then
        if child:FindFirstChild("Settings") and child.Settings.Value == "Key:true,Duration:2,TeamBlacklist:Police" then
            child:Destroy()
        end
    end
    if child.Name:find("Road") and child:FindFirstChild("Asphalt") then
        table.insert(roadsPath, child)
    end
    if child.ClassName:find("Part") and child.ClassName ~= "ParticleEmitter" and child.CanCollide == false then
        table.insert(heightExcluded, child)
    end
end

do
    for i, v in next, workspace:GetChildren() do
        if v.Name == "Rain" then
            table.insert(rayBlacklisted, v)
        end
    end
    workspace.ChildAdded:Connect(function(child)
        if child.Name == "Rain" then 
            table.insert(rayBlacklisted, child)
        end
    end)
    player.CharacterAdded:Connect(function(child)
        table.insert(rayBlacklisted, child)
        character = child
        humanoidRootPart = child:WaitForChild("HumanoidRootPart")
        humanoid = child:WaitForChild("Humanoid")

        for _, part in next, child:GetDescendants() do
            if part:IsA("BasePart") and part.CanCollide == true then
                table.insert(playerCollisions, part)
            end
        end
    end)
    humanoid.Died:Connect(function()
        table.clear(playerCollisions)
    end)

    for _, part in next, character:GetDescendants() do
        if part:IsA("BasePart") and part.CanCollide == true then
            table.insert(playerCollisions, part)
        end
    end
end
local noclip = runService.Stepped:Connect(function()
    if Configuration.noclip == true then
        for _, part in next, playerCollisions do
            part.CanCollide = false
        end
    elseif Configuration.noclip == false then
        for _, part in next, playerCollisions do
            part.CanCollide = true
        end
    end
end)

-- // Script
local Library = {}
local Utilities = {}
local LagbackPositions = {
    {
        cframe = CFrame.new(1182, 105, 1250),
        check = "MUSEUM",
        callback = {
            check = function(timePassed)
                return player.Team.Name == "Criminal" and timePassed > 1
            end,
            checkNeeded = true
        }
    },
    {
        cframe = CFrame.new(71, 22, 2290),
        check = "POWER_PLANT",
        callback = {
            check = function(timePassed)
                return player.Team.Name == "Criminal" and timePassed > 3 
            end,
            checkNeeded = true
        }
    },
    {
        cframe = CFrame.new(548, 23, -550),
        check = "TOMB",
        callback = {
            check = function(timePassed)
                return player.Team.Name == "Criminal" and timePassed > 3 
            end,
            checkNeeded = true
        }
    },
}
for _, teleporter in next, collectionService:GetTagged("Teleporter") do
    if teleporter.Name == "Teleporter" then
        local part = teleporter.PrimaryPart or teleporter:FindFirstChildWhichIsA("Part", 1)
        if part then
            table.insert(LagbackPositions, {
                cframe = part.CFrame * CFrame.new(0, 0, 3),
                callback = {
                    check = function(timePassed)
                        return player.Team.Name == "Criminal" and timePassed > 3 
                    end,
                    checkNeeded = false
                }
            })
        end
    end
end

--// Normal functions
local function getInteractions(name)
    local interactions = {}
    for i, v in next, ui.CircleAction.Specs do
        if v.Name == name and v.Enabled == true then
            table.insert(interactions, v)
        end
    end
    return interactions
end

--// Utility functions
function Utilities.isCar()
    local car = vehicle.GetLocalVehiclePacket()
    if car then
        root = vehicle.GetLocalVehiclePacket().Model:WaitForChild("Engine")
        speed = Configuration.vehicleSpeed
    end
    return car
end
function Utilities.checkRoof(position)
    local rayOrigin = position
    local rayDirection = Vector3.new(0, 500, 0)
        
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = rayBlacklisted
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    return raycastResult
end
function Utilities.getFloorPosition(heart)
    local heart = heart or root

    return Vector3.new(math.floor(heart.Position.X), math.floor(heart.Position.Y), math.floor(heart.Position.Z))
end
function Utilities.getNearestCar(carType)
    local carTypes = {}
    table.insert(carTypes, "Heli")
    if carType ~= "Heli" then
        table.insert(carTypes, "Camaro")
    end

    local cars = {}
    for i, v in next, workspace.Vehicles:GetChildren() do
        if table.find(carTypes, v.Name) and v.PrimaryPart and v:FindFirstChild("Seat") and v.Seat:FindFirstChild("Player") and v.Seat:FindFirstChild("Player").Value == false and v:FindFirstChild("Engine") and not Utilities.checkRoof(v.Engine.Position + Vector3.new(0, 5, 0)) and not table.find(blacklistedCars, v) then
            table.insert(cars, v)
        end
    end
    table.sort(cars, function(a, b)
        return player:DistanceFromCharacter(a.PrimaryPart.Position) < player:DistanceFromCharacter(b.PrimaryPart.Position)
    end)

    return cars[1]
end
function Utilities.getNearestLagback()
    local lagbacks = LagbackPositions
    table.sort(lagbacks, function(a, b)
        return player:DistanceFromCharacter(a.cframe.p) < player:DistanceFromCharacter(b.cframe.p)
    end)
    for index, lagback in next, lagbacks do
        if type(lagback.check) == "string" and Utilities.isRobbery(lagback.check) then
            table.remove(lagbacks, index)
        end
    end
    return lagbacks[1]
end
function Utilities.setControls(state)
    local Controls = require(player.PlayerScripts.PlayerModule):GetControls()

    if state == true then
        Controls:Enable()
    elseif state == false then
        Controls:Disable()
    end
end
function Utilities.getXZ(cframe)
    local cframe = cframe

    return Vector3.new(cframe.X, 0, cframe.Z)
end
function Utilities.getGroundPosition(cframe)
    local cframe = typeof(cframe) == "CFrame" and cframe or CFrame.new(cframe)
    local cframeClone = {cframe:components()}
    for _ = 1, 3 do
        table.remove(cframeClone, 1)
    end
    local position = cframe.p

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = heightExcluded
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local distance = 5
    local yLevel = Vector3.new(0, position.Y, 0)
    local raycastResult = nil

    repeat
        yLevel = Vector3.new(0, yLevel.Y - distance, 0)
        raycastResult = workspace:Raycast(position, yLevel, raycastParams)

        task.wait()
    until raycastResult
    
    return CFrame.new(position.X, raycastResult.Position + Vector3.new(0, 2.5, 0), position.Z, unpack(cframeClone)), raycastResult, yLevel
end
function Utilities.getUpperY(position)
    local position = position or humanoidRootPart.Position

    return Vector3.new(position.X, Configuration.yLevel, position.Z)
end
function Utilities.hijackCar(car)
    local function getCurrentHijack()
        for _, interaction in next, getInteractions("Hijack") do
            if interaction.Tag.Parent == car and interaction.Tag.Parent:FindFirstChild("TeamRestrict") and interaction.Tag.Parent.TeamRestrict.Value == "Police" then
                return interaction
            end
        end
    end
    local carInteraction = getCurrentHijack()
    if not carInteraction then
        return true, "No hijack needed."
    end

    repeat
        interaction = getCurrentHijack()
        interaction:Callback(true)
        task.wait(0.1)
    until not getCurrentHijack()

    return true, "Successfully hijacked."
end
function Utilities.enterCar(car)
    local tries = 0
    repeat
        for _, interaction in next, getInteractions("Enter Driver") do
            if interaction.Tag.Parent == car then
                interaction:Callback(true)
            end
        end
        task.wait(0.05)
        tries += 1
    until tries == 10 or Utilities.isCar()
    return Utilities.isCar() and true or false
end
function Utilities.extractTable(usedTable, defaultTable)
    if usedTable == nil or usedTable == {} then
        return defaultTable
    end

    local newTable = {}
    local blacklistedIndexes = {}
    for index, value in next, usedTable do
        newTable[index] = value
        table.insert(blacklistedIndexes, index)
    end
    for index, value in next, defaultTable do
        if not table.find(blacklistedIndexes, index) then
            newTable[index] = value
        end
    end

    return newTable
end
function Utilities.getDistance(position1, position2)
    return (position2 - position1).Magnitude
end
function Utilities.spawnCar()
    replicatedStorage.GarageSpawnVehicle:FireServer("Chassis", "Camaro")

    local _tick = tick()

    repeat task.wait() until Utilities.isCar() or tick() - _tick > 0.5
    if not Utilities.isCar() then
        return false, "Blocking Way."
    end

    return true, "Success."

    --[[
        local function isReady()
            return (garageUi.Left.Categories.Cooldown.Title.Text == "READY")
        end

        if not isReady() then
            return false, "On Cooldown."
        end

        firesignal(garageUi.Center.Portal.Body.ScrollingGrid.Camaro.Activated)

        local _tick = tick()
        repeat task.wait() until Utilities.isCar() or tick() - _tick > 1

        if not Utilities.isCar() then
            return false, "Blocking Way."
        end

        return true, "Success."
    ]]
end
function Utilities.isLagback(lagbackPosition)
    return root.Position:FuzzyEq(lagbackPosition, 0.01)
end
function Utilities.getPathLength(waypoints)
    local length = 0
    for index = 2, #waypoints do
        local waypointNow = typeof(waypoints[index]) == "Vector3" and waypoints[index] or waypoints[index].Position
        local waypointBefore = typeof(waypoints[index - 1]) == "Vector3" and waypoints[index - 1] or waypoints[index - 1].Position
        length = length + Utilities.getDistance(waypointNow, waypointBefore)
    end
    return length
end
function Utilities.isRobbery(storeName)
    local robberyState = game:GetService("ReplicatedStorage").RobberyState
    local robberyConsts = require(game:GetService("ReplicatedStorage").Game.Robbery.RobberyConsts)

    return robberyState:FindFirstChild(robberyConsts.ENUM_ROBBERY[storeName:upper()]).Value == 2
end

--// Library functions
function Library.lagback(cframe, checker)
    local cframe = typeof(cframe) == "CFrame" and cframe or CFrame.new(cframe)

    local disconnect = disconnect or 1
    local _tick = tick()

    local stopLoop = false
    local isChecker = false

    repeat
        if checker.checkNeeded and checker.check(tick() - _tick) then
            isChecker = true
        elseif checker.checkNeeded and not checker.check(tick() - _tick) then
            isChecker = false
        elseif not checker.checkNeeded then
            isChecker = true
        end

        root.CFrame = cframe
        task.wait()
        local lagback = Utilities.isLagback(cframe.p)

        if not lagback then
            stopLoop = true
        end

    until stopLoop and isChecker

    task.wait(0.35)

    return not Utilities.isLagback(cframe.p) and true or false
end
function Library.tween(cframe, settings)
    local cframe = typeof(cframe) == "CFrame" and cframe or CFrame.new(cframe)
    local settings = Utilities.extractTable(settings, {
        speed = Configuration.playerSpeed / 2
    })

    Configuration.noclip = true

    repeat
        local velocity = (cframe.p - root.Position).Unit * settings.speed

        root.Velocity = Utilities.getXZ(velocity)

        task.wait()
    until Utilities.getDistance(root.Position, cframe.p) < 5
    root.Velocity = Vector3.zero
    Configuration.noclip = false
    task.wait()

    root.CFrame = cframe
end
function Library.pathfind(position, settings)
    local position = typeof(position) == "Vector3" and position or Vector3.new(position)
    local settings = Utilities.extractTable(settings, {
        pathSettings = {WaypointSpacing = 3}
    })

    local path = pathfindingService:CreatePath(settings.pathSettings)
    path:ComputeAsync(humanoidRootPart.Position, position)

    if path.Status ~= Enum.PathStatus.Success then
        return false, "No path found."
    end

    for index, path in next, path:GetWaypoints() do
        humanoidRootPart.CFrame = CFrame.new(path.Position) * CFrame.new(0, 3, 0)
        task.wait(0.015 + player:GetNetworkPing())
    end

    return true, "Successfully teleported."
end
function Library.escapeRoof(triedPositions)
    local triedPositions = triedPositions or {}
    local endPositions = {}
    local endPaths = {}
    local endPosition = nil

    local roof = Utilities.checkRoof(humanoidRootPart.Position)

    if not roof then
        return true 
    end

    if roof then
        Utilities.setControls(false)
        noclipEnabled = true

        table.sort(roofEscapeDescendants, function(a, b)
            return player:DistanceFromCharacter(a:FindFirstChildWhichIsA("Part").Position) < player:DistanceFromCharacter(b:FindFirstChildWhichIsA("Part").Position)
        end)

        for spacing = 1, 50, 3 do
            for _, extraPosition in next, { {spacing, 0, 0}, {-spacing, 0, 0}, {0, 0, spacing}, {0, 0, -spacing}, {spacing, 0, -spacing}, {-spacing, 0, spacing}, {-spacing, 0, -spacing}, {spacing, 0, spacing} } do
                local newOutdoorPosition = Utilities.getFloorPosition() + Vector3.new(unpack(extraPosition))
                if not Utilities.checkRoof(newOutdoorPosition) then
                    table.insert(endPositions, newOutdoorPosition)
                end
            end
        end
        for _, door in next, roofEscapeDescendants do
            for spacing = 1, 25, 2.5 do
                for _, extraPosition in next, { {spacing, 0, 0}, {-spacing, 0, 0}, {0, 0, spacing}, {0, 0, -spacing}, {spacing, 0, -spacing}, {-spacing, 0, spacing}, {-spacing, 0, -spacing}, {spacing, 0, spacing} } do
                    local newOutdoorPosition = door:FindFirstChildWhichIsA("Part").Position + Vector3.new(unpack(extraPosition))
                    if not Utilities.checkRoof(newOutdoorPosition) then
                        table.insert(endPositions, newOutdoorPosition)
                    end
                end
            end
        end
    
        table.sort(endPositions, function(a, b)
            return player:DistanceFromCharacter(a) < player:DistanceFromCharacter(b)
        end)

        for _, position in next, endPositions do
            local path = Configuration.path

            path:ComputeAsync(humanoidRootPart.Position, position)

            if path.Status == Enum.PathStatus.Success then
                table.insert(endPaths, {
                    path = path,
                    position = position
                })
                if #endPaths >= 7 then
                    break
                end
            else
                table.insert(triedPositions, position)
            end
        end

        table.sort(endPaths, function(a, b)
            return Utilities.getPathLength(a.path:GetWaypoints()) < Utilities.getPathLength(b.path:GetWaypoints())
        end)
        endPosition = endPaths[1]

        if not endPosition then
            return Library.escapeRoof(triedPositions)
        end

        local waypoints = endPosition.path:GetWaypoints()
        humanoidRootPart.CFrame = CFrame.new( humanoidRootPart.Position + Vector3.new(0, 3, 0) )
        task.wait(0.045)
        for _, waypoint in next, waypoints do
            task.wait(0.045)
            humanoidRootPart.CFrame = CFrame.new( waypoint.Position + Vector3.new(0, 3, 0) )
        end
        task.wait(0.045)
        humanoidRootPart.CFrame = CFrame.new( waypoints[#waypoints].Position + Vector3.new(0, 3, 0) )
    end

    Utilities.setControls(true)
    noclipEnabled = false

    return true
end
function Library.gotoCar()
    local car = Utilities.getNearestCar()
    if not car then
        return false, "No car found."
    end

    humanoidRootPart.Velocity = Vector3.zero
    humanoidRootPart.CFrame = CFrame.new(Utilities.getUpperY(humanoidRootPart.Position))

    task.wait()

    repeat
        car = Utilities.getNearestCar()

        if car then
            humanoidRootPart.Velocity = (Utilities.getXZ(car:WaitForChild("Engine").Position) - Utilities.getXZ(humanoidRootPart.Position)).Unit * speed

            task.wait()
        end
    until not car or Utilities.getDistance(Utilities.getXZ(humanoidRootPart.Position), Utilities.getXZ(car:WaitForChild("Engine").Position)) < 5

    humanoidRootPart.Velocity = Vector3.zero
    task.wait()

    if not car then
        humanoidRootPart.CFrame = Utilities.getGroundPosition(humanoidRootPart.CFrame)

        return false, "No car found."
    end
        
    humanoidRootPart.CFrame = car:WaitForChild("Engine").CFrame * CFrame.new(0, 4, 0)

    return car
end
function Library.exitCar()
    local car = vehicle.GetLocalVehiclePacket()

    if car then
        repeat
            characterUtil.OnJump()
            task.wait()
        until
            not vehicle.GetLocalVehiclePacket()
    end

    root = humanoidRootPart
    speed = Configuration.playerSpeed
end
function Library.teleport(cframe, settings)
    local cframe = typeof(cframe) == "CFrame" and cframe or CFrame.new(cframe)
    local settings = Utilities.extractTable(settings, {
        useCar = nil,
        exitCar = true,
        useLagback = true
    })

    if settings.useLagback then
        local lagback = Utilities.getNearestLagback()

        if 5 < Utilities.getDistance(root.Position, cframe.p) / Configuration.playerSpeed then
            Library.lagback(lagback.cframe, lagback.callback)
        end
    end

    Library.escapeRoof()

    if settings.useCar == false then
        Library.exitCar()
    end
    if not Utilities.isCar() then
        if settings.useCar == true then
            local car = Utilities.spawnCar()

            if not Utilities.getNearestCar() and not car then
                return false, "No car found."
            end
        end
        if settings.useCar ~= false and not Utilities.isCar() then
            do
                local car = Utilities.spawnCar()

                if not car then

                    local nearestCar = Utilities.getNearestCar()
                    if Utilities.getDistance(root.Position, nearestCar.Engine.Position) < Utilities.getDistance(root.Position, cframe.p) or settings.useCar == true then
                        if ((Utilities.getDistance(root.Position, nearestCar.Engine.Position) / Configuration.playerSpeed) + (Utilities.getDistance(root.Position, cframe.p) / Configuration.vehicleSpeed)) < (Utilities.getDistance(root.Position, cframe.p) / Configuration.playerSpeed) or settings.useCar == true then -- idk how i did this but it works
                            local car = Library.gotoCar()
                            if car then
                                Utilities.hijackCar(car)
                                Utilities.enterCar(car) 
                            end
                            if not car and settings.useCar == true then
                                return false, "No car found."
                            end
                        end
                    end
                end
            end
        end
    end
    if root.Anchored == true then
        root.Anchored = false    
    end

    Utilities.setControls(false)

    for _ = 1, 10 do
        root.CFrame = CFrame.new(Utilities.getUpperY())
        task.wait()
    end

    repeat
        local velocity = (Utilities.getUpperY(cframe.p) - root.Position).Unit * speed

        root.Velocity = Utilities.getXZ(velocity)

        task.wait()
    until Utilities.getDistance(Utilities.getXZ(root.Position), Utilities.getXZ(cframe.p)) < 5
    root.Velocity = Vector3.zero

    task.wait()
    for _ = 1, 10 do
        root.CFrame = cframe
        task.wait()
    end
    task.wait(0.1)

    if settings.anchorAfterTeleport then
        root.Anchored = true
    end
    if settings.exitCar then
        Library.exitCar()
    end

    task.wait()

    Utilities.setControls(true)

    return true
end



--[[

Explanation:
This teleportation will first check if something is above the player's head, if so it will find a way to a location where there is nothing above the player's head.
It will teleport always to the sky to bypass the Noclip anti cheat.
It will go and get a vehicle, if a vehicle is able to be spawned this will be done (if you have the setting on), this will make the teleportation faster.
It will teleport to the target position and exit the car if you have the setting on.

Usage:
local position = CFrame.new(0, 25, 0) --Utilities.getGroundPosition( CFrame.new(math.random(-2000, 2000), 100, math.random(-2000, 2000)) ) * CFrame.new(0, 15, 0)
local result1, result2 = Library.teleport(position, {
    useCar = nil, -- if you want to use a car to teleport
    anchorAfterTeleport = false, -- if the car should stay in a fix position after the teleport process
    exitCar = true, -- if you want to exit the car after the teleport process
    useLagback = true -- if the lagback method should be used
})
print(result1, result2) -- true, Successfully teleported. || false, Couldn't find a way out.

]]--
