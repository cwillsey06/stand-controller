-- StandService.lua
-- Coltrane Willsey
-- 2022-03-13 [00:09]

local ContactServer = script.ContactServer

local common = game.ReplicatedStorage.common
local Packages = common.Packages
local Trove = require(Packages.trove)
local tween = require(Packages.tween)
local new = require(Packages.new)

-- SERVER
local StandService = {}
StandService.__index = StandService

function StandService.GetStand(desiredStand: string)
    local stands = game.ServerStorage.private.Assets.Stands
    return (stands[desiredStand or "Default"] or stands.Default):Clone()
end

function StandService.SetStand(Player: Player, Stand: Model)
    local PlayerStand = new("Folder", workspace.PlayerStands, {
        Name = Player.Name;
    })
    Stand.Parent = PlayerStand

    task.defer(function()
        local active = new("BoolValue", PlayerStand, {
            Name = "active";
            Value = true;
        })
        task.wait()
        local character = Player.Character
        local cf = character:GetPrimaryPartCFrame()

        while active.Value do
            tween(Stand.PrimaryPart, CFrame, (cf * CFrame.new(3, 3.5, -1.5)), 0.05, Enum.EasingStyle.Cubic)
            task.wait()
        end
    end)
end


-- CLIENT
StandService.Client = {}
StandService.Client.__index = StandService.Client
StandService.Client.__newindex = function(t, k, ...)
    return ContactServer:InvokeServer(t._client, k, ...)
end

function StandService.Client:Start(desiredStand: string)
    self.Stand = self:GetStand(desiredStand)
    self:SetStand(self._client, self.Stand)
end

function StandService.Client.init(desiredStand: string?)
    local self = setmetatable({}, StandService.Client)
    self._trove = Trove.new()
    self._client = game.Players.LocalPlayer

    self:Start(desiredStand)
    return self
end

function StandService.Client:Destroy()
    self._trove:Destroy()
end

local rs = game:GetService("RunService")
if rs:IsClient() then
    return StandService.Client
else
    return StandService
end