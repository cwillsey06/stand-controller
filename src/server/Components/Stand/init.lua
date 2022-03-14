-- Stand.lua
-- Coltrane Willsey
-- 2022-03-13 [20:19]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Trove = require(Packages.trove)

local Modules = common.Modules
local LoadAnimation = require(Modules.loadanimation)
local Tween = require(Modules.tween)

local Stand = {}
Stand.__index = Stand
Stand.Tag = "PlayerStand"

function Stand:Attack(attackType: string)

end

function Stand.new()
    local self = setmetatable({}, Stand)
    self._trove = Trove.new()



    return self
end

function Stand:Destroy()
    
end

return Stand
