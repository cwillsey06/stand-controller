-- StandController.lua
-- Coltrane Willsey
-- 2022-03-13 [13:33]

local Player = game:GetService("Players").LocalPlayer
local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Promise = require(Packages.promise)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common.Modules
local bind = require(Modules.bind)

local ServerStandController

local StandController = Knit.CreateController { Name = "StandController"; }

function StandController.CreateActions()
    local actions = {
        bind({ Enum.UserInputType.MouseButton1; }, function(_inputObject)
            StandController.StandService.Attack(Player, "Attack1")
        end)
    }
    
    for _, action in ipairs(actions) do
        StandController.Trove:Add(action, "unbind")
    end
end

function StandController.Start(desiredStand: string)
    ServerStandController = StandController.StandService.SetStand(Player, desiredStand)
    StandController.CreateActions()
end

function StandController:Destroy()
    StandController.Trove:Destroy()
end

-- Knit

function StandController:KnitInit()
end

function StandController:KnitStart()
    StandController.StandService = Knit.GetService("StandService")
    StandController.Trove = Trove.new()
    task.defer(function()
        local connection
        if Player.Character or Player.CharacterAdded:Wait() then
            connection = Player.Character:WaitForChild("Humanoid").Died:Connect(function()
                StandController:Destroy()
                connection:Disconnect()
            end)
        end
    end)
end

return StandController
