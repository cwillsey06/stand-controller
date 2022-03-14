-- StandService.lua
-- Coltrane Willsey
-- 2022-03-13 [13:33]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Knit = require(Packages.knit)

local Modules = common.Modules
local new = require(Modules.new)

local StandComponent = require(script.Parent.Parent.Components.Stand)

local StandService = Knit.CreateService {
    Name = "StandService";
    Client = {};
}

-- Server

function StandService.Attack(player: Player, attackType: string)
    local stand = StandComponent:FromInstance(StandService.GetStandFromPlayer(player))
    stand:Attack(attackType)
end

function StandService.SetStand(player: Player, desiredStand: string)
    -- setup
    local stand = StandService.GetStandModel(desiredStand)
    stand.Name = "Stand"

    -- create player folder

    local standFolder = new("Folder", workspace.PlayerStands, {
        Name = player.Name.."Stand"
    })
    stand.Parent = standFolder

    -- set component tag
    local CollectionService = game:GetService("CollectionService")
    CollectionService:AddTag(stand, "PlayerStand")
end

function StandService.GetStandModel(desiredStand: string): Model?
    local Stands = game.ServerStorage.private.Assets.Stands
    return (Stands:FindFirstChild(desiredStand or "Default") or Stands.Default):Clone()
end

function StandService.GetPlayerFromStand(stand: Model): Player?
    local folderName = stand.Parent.Name
    local playerName = folderName:sub(-#folderName, -6)
    return game.Players:FindFirstChild(playerName)
end

function StandService.GetStandFromPlayer(player: Player): Model?
    local playerName = player.Name
    local folderName = playerName.. "Stand"
    return workspace.PlayerStands:FindFirstChild(folderName).Stand
end

-- Client

function StandService.Client.Attack(client: Player, attackType: string)
    StandService.Attack(client, attackType)
end


function StandService.Client.SetStand(client: Player, desiredStand: string)
    StandService.SetStand(client, desiredStand)
end

-- Knit

function StandService:KnitInit()
end

function StandService:KnitStart()
    print("StandService started")
end

return StandService
