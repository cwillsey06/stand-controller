-- StandService.lua
-- Coltrane Willsey
-- 2022-03-13 [13:33]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Component = require(Packages.component)
local Promise = require(Packages.promise)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common.Modules
local RaycastHitbox = require(Modules.RaycastHitbox)
local LoadAnimation = require(Modules.loadanimation)
local Tween = require(Modules.tween)
local new = require(Modules.new)

local StandComponent = require(script.Parent.Parent.Components.Stand)

local StandService = Knit.CreateService {
    Name = "StandService";
    Client = {};
}

-- Server

function StandService.Attack(player: Player, attackType: string)
    local stand = Component:FromInstance(StandService.GetStandFromPlayer(player))
    stand:Attack(attackType)

function StandService.SetStand(player: Player, desiredStand: string)
    -- setup
    local stand = StandService.GetStand(desiredStand)
    stand.Name = "Stand"

    -- create player folder

    local standFolder = new("Folder", workspace.PlayerStands, {
        Name = player.Name.."Stand"
    })
    stand.Parent = standFolder

    -- weld to character

    new("WeldConstraint", stand.PrimaryPart, {
        Name = "StandWeld";
        Part0 = stand.HumanoidRootPart;
        Part1 = player.Character.HumanoidRootPart;
    })

    local charCF = player.Character:GetPrimaryPartCFrame()
    local offset = CFrame.new(1.5, 1, 1.5)
    stand:SetPrimaryPartCFrame(charCF * offset)
    LoadAnimation(stand, 9094993059):Play()

    -- set component tag
    local CollectionService = game:GetService("CollectionService")
    CollectionService:AddTag(stand, "PlayerStand")
end

function StandService.GetStand(desiredStand: string): Model?
    local Stands = game.ServerStorage.private.Assets.Stands
    return (Stands:FindFirstChild(desiredStand or "Default") or Stands.Default):Clone()
end

function StandService.GetPlayerFromStand(stand: Model): Player?
    local folderName = stand.Parent.Name
    local playerName = folderName:gsub("Stand", '')
    return game.Players:FindFirstChild(playerName)
end

function StandService.GetStandFromPlayer(player: Player): Model?
    local playerName = player.Name
    local folderName = playerName.. "Stand"
    return workspace.PlayerStands:FindFirstChild(folderName)
end

-- Client

function StandService.Client.Attack(_, player: Player, attackType: string)
    StandService.Attack(player, attackType)
end

function StandService.Client.SetStand(_, player: Player, desiredStand: string)
    StandService.SetStand(player, desiredStand)
end

-- Knit

function StandService:KnitInit()
    
end

function StandService:KnitStart()
    
end

return StandService
