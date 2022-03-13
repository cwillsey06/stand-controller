-- StandService.lua
-- Coltrane Willsey
-- 2022-03-13 [13:33]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Promise = require(Packages.promise)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common.Modules
local RaycastHitbox = require(Modules.RaycastHitboxV4)
local LoadAnimation = require(Modules.loadanimation)
local Tween = require(Modules.tween)
local new = require(Modules.new)


local StandService = Knit.CreateService {
    Name = "StandService";
    Client = {};
}

-- Server

function StandService.Attack(player: Player, attackType: string)
    if attackType == "Attack1" then
        print('attack1')
    end
end

function StandService.GetStand(desiredStand: string): Model?
    local Stands = game.ServerStorage.private.Assets.Stands
    return (Stands:FindFirstChild(desiredStand or "Default") or Stands.Default):Clone()
end

-- Client

function StandService.Client.Attack(_, player: Player, attackType: string)
    return StandService.Attack(player, attackType)
end

function StandService.Client.SetStand(_, player: Player, desiredStand: string)
    local stand = StandService.GetStand(desiredStand)
    local standFolder = new("Folder", workspace.PlayerStands, {
        Name = player.Name.."Stand"
    })
    stand.Parent = standFolder

    new("WeldConstraint", stand.PrimaryPart, {
        Name = "StandWeld";
        Part0 = stand.HumanoidRootPart;
        Part1 = player.Character.HumanoidRootPart;
    })

    local charCF = player.Character:GetPrimaryPartCFrame()
    local offset = CFrame.new(1.5, 1, 1.5)
    stand:SetPrimaryPartCFrame(charCF * offset)
    LoadAnimation(stand, 9094993059):Play()

    local connection
    connection = player.Character.Humanoid.Died:Connect(function() 
        standFolder:Destroy()
        connection:Disconnect()
    end)

    return stand
end

-- Knit

function StandService:KnitInit()
    
end

function StandService:KnitStart()
    
end

return StandService
