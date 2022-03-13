-- StandService.lua
-- Coltrane Willsey
-- 2022-03-13 [13:33]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Promise = require(Packages.promise)
local Trove = require(Packages.trove)
local Tween = require(Packages.tween)
local Knit = require(Packages.knit)
local new = require(Packages.new)


local StandService = Knit.CreateService {
    Name = "StandService";
    Client = {};
}

-- Server

function StandService.GetStand(desiredStand: string): Model?
    local Stands = game.ServerStorage.private.Assets.Stands
    return (Stands:FindFirstChild(desiredStand or "Default") or Stands.Default):Clone()
end

-- Client

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
