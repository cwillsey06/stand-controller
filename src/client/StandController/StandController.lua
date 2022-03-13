-- StandController.lua
-- Coltrane Willsey
-- 2022-03-12 [23:58]

local common = game:GetService("ReplicatedStorage"):WaitForChild("common")
local Packages = common:WaitForChild("Packages")
local Trove = require(Packages.trove)

local StandService = common:WaitForChild("StandService")

local StandController = {}
StandController.__index = StandController

function StandController.init(stand: Model)
    local self = setmetatable({}, StandController)
    self._trove = Trove.new()

    self.Stand = stand

    return self
end

function StandController:Destroy()
    self._trove:Destroy()
end

return StandController