-- StandService.lua
-- Coltrane Willsey
-- 2022-03-13 [13:33]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Promise = require(Packages.promise)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common.Modules
local RaycastHitbox = require(Modules.RaycastHitbox)
local LoadAnimation = require(Modules.loadanimation)
local Tween = require(Modules.tween)
local new = require(Modules.new)


local StandService = Knit.CreateService {
    Name = "StandService";
    Client = {};
}

-- Server

function StandService.Attack(player: Player, attackType: string)
    local stand = StandService.GetPlayerStand(player).Stand
    if attackType == "Attack1" then
        local anim = LoadAnimation(stand, 9096907964)
        anim:Play()
    end
end

function StandService.GetPlayerStand(player: Player): Model?
    return workspace.PlayerStands:FindFirstChild(player.Name.. "Stand")
end

function StandService.GetStand(desiredStand: string): Model?
    local Stands = game.ServerStorage.private.Assets.Stands
    return (Stands:FindFirstChild(desiredStand or "Default") or Stands.Default):Clone()
end

-- Client

function StandService.Client:Attack(player: Player, attackType: string)
    return StandService.Attack(player, attackType)
end

function StandService.Client.SetStand(_, player: Player, desiredStand: string)
    -- setup
    local stand = StandService.GetStand(desiredStand)
    stand.Name = "Stand"

    -- create player folder

    local standFolder = new("Folder", workspace.PlayerStands, {
        Name = player.Name.."Stand"
    })
    stand.Parent = standFolder

    -- cleanup
    Trove = Trove.new()
    Trove:AttachToInstance(standFolder)
    
    Trove:Add(player.Character.Humanoid.Died:Connect(function() 
        standFolder:Destroy()
    end))

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

    -- raycasthitbox
    local hitbox = RaycastHitbox.new(stand)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {player.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    hitbox.RaycastParams = params

    hitbox.Visualizer = true -- DEBUG

    local currentDamage = 20

    Trove:Add(hitbox)
    Trove:Add(hitbox.OnHit:Connect(function(hit)
        hit:TakeDamage(currentDamage)
    end), "Disconnect")

    return self
end

-- Knit

function StandService:KnitInit()
    
end

function StandService:KnitStart()
    
end

return StandService
