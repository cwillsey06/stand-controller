-- init.lua
-- Coltrane Willsey
-- 2022-03-14 [21:44]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Component = require(Packages.component)
local Trove = require(Packages.trove)

local Modules = common.Modules
local LoadAnimation = require(common.loadanimation)
local new = require(common.new)

local Stand = Component.new { Tag = "PlayerStand"; }

function Stand.new()
    local self = setmetatable({}, Stand)
    self._trove = Trove.new()

    

    return self
end

function Stand:Destroy()
    self._trove:Destroy()
end

return Stand
