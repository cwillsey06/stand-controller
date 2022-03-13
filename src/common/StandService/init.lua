-- StandService.lua
-- Coltrane Willsey
-- 2022-03-13 [00:09]

local ContactServer = script.Parent.ContactServer

local common = game.ReplicatedStorage.common
local Packages = common.Packages
local Trove = require(Packages.trove)

-- SERVER
local StandService = {}
StandService.__index = StandService

function StandService.GetStand(desiredStand: string)
    local stands = game.ServerStorage.private.Assets.Stands
    return (stands[desiredStand or "Default"] or stands.Default):Clone()
end

-- CLIENT
StandService.Client = {}
StandService.Client.__index = StandService.Client
StandService.Server = setmetatable({}, {
    __index = function(t, k, ...)
        return ContactServer:InvokeServer(t._client, k, ...)
    end
})

function StandService.Client:Start(desiredStand: string)
    self.Stand = self.Server.GetStand(desiredStand)
end

function StandService.Client.InitClient(client: Player, desiredStand: string?)
    local self = setmetatable({}, StandService.Client)
    self._trove = Trove.new()
    self._client = client

    self:Start(desiredStand)
    return self
end

function StandService.Client:Destroy()
    self._trove:Destroy()
end

local rs = game:GetService("RunService")
if rs:IsServer() then
    return StandService
else
    return StandService.Client
end