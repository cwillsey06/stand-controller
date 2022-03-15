-- StandService.lua
-- Coltrane Willsey
-- 2022-03-14 [21:40]

--[[
    -- TODO: Add documentation
--]]

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Component = require(Packages.component)
local Knit = require(Packages.knit)

local Modules = common.Modules
local new = require(Modules.new)

local StandService = Knit.CreateService {
    Name = "StandService";
    Client = {};
}



--

function StandService:KnitInit()
end

function StandService:KnitStart()
end

return StandService
