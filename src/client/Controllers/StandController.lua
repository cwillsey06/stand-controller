-- StandController.lua
-- Coltrane Willsey
-- 2022-03-14 [21:41]

--[[
    -- TODO: Add documentation
--]]

local common = game:GetService("ReplicatedStorage"):WaitForChild("common")

local Packages = common:WaitForChild("Packages")
local Knit = require(Packages.knit)

local Modules = common:WaitForChild("Modules")
local LoadAnimation = require(Modules.loadanimation)
local bind = require(Modules.bind)

local StandController = Knit.CreateController { Name = "StandController"; }



--

function StandController:KnitInit()
end

function StandController:KnitStart()
end

return StandController
