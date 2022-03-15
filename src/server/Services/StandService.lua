-- StandService.lua
-- Coltrane Willsey
-- 2022-03-14 [21:40]

--[[
    -- TODO: Add documentation
--]]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Component = require(Packages.component)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common.Modules
local new = require(Modules.new)

local StandService = Knit.CreateService {
    Name = "StandService";
    Client = {};
}

-- Server

function StandService._ServerAttack(client: Player, attackMethod: string)
    local stand = StandService.GetStandFromPlayer(client)
    assert(stand, "Stand does not exist!")

    local baseCmpt = require(common.Components.Stand)
    local standComponent = baseCmpt:FromInstance(stand)

    standComponent:Attack(attackMethod)
end

function StandService._ServerInitStand(client: Player, standName: string?)
    local _trove = Trove.new()

    -- Create stand folder
    local standFolder = new("Folder", workspace.PlayerStands, {
        Name = client.Name;
    })

    -- Get stand model
    local private = game.ServerStorage.private
    local Stands = private.Assets.Stands
    
    local standModel = (Stands:FindFirstChild(standName or "Default") or Stands.Default):Clone()
    standModel.Name = "Stand"
    standModel.Parent = standFolder
    print(standModel.Parent:GetFullName())

    -- Set stand component
    local CollectionService = game:GetService("CollectionService")
    CollectionService:AddTag(standModel, "PlayerStand")

    -- Cleanup jobs
    _trove:Add(standFolder)
    
    local function Destroy()
        _trove:Destroy()
    end
    
    _trove:Add(client.CharacterRemoving:Connect(Destroy))
end

function StandService.GetPlayerFromStand(stand: Model): Player?
    local folderName = stand.Parent.Name
    local playerName = folderName:sub(-#folderName, -6)
    return game.Players:FindFirstChild(playerName)
end

function StandService.GetStandFromPlayer(player: Player): Model?
    local playerName = player.Name
    local folderName = playerName.. "Stand"
    local folder = workspace.PlayerStands:FindFirstChild(folderName)
    if not folder then return end
    return folder:FindFirstChild("Stand")
end

-- Client

function StandService.Client.Attack(_, client: Player, standName: string?)
    StandService._ServerAttack(client, standName)
end

function StandService.Client.InitStand(_, client: Player, standName: string?)
    StandService._ServerInitStand(client, standName)
end

--

function StandService:KnitInit()
end

function StandService:KnitStart()
end

return StandService
