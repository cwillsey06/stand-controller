local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common

local packages = common.Packages
local Promise = require(packages.promise)

local StandService = require(common.StandService)
local DesiredStand = "Default"

StandService.init(DesiredStand)