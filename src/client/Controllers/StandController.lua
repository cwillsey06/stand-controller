-- StandController.lua
-- Coltrane Willsey
-- 2022-03-13 [13:33]

local Player = game:GetService("Players").LocalPlayer
local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Promise = require(Packages.promise)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local StandController = Knit.CreateController { Name = "StandController"; }


function StandController.Start(desiredStand: string)
    StandController.StandService.SetStand(Player, desiredStand)
end

-- Knit

function StandController:KnitInit()
end

function StandController:KnitStart()
    StandController.StandService = Knit.GetService("StandService")
end

return StandController
