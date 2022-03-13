local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common

local packages = common.Packages
local Promise = require(packages.promise)

local Stand = require(script.Stand)
local DesiredStand = "Default"

Promise.try(function()
    local requestStand = common:WaitForChild("RequestStand")
    return requestStand:InvokeServer(DesiredStand)
end)
:andThen(function(stand)
    Stand.new(stand)
end)
:catch(warn)