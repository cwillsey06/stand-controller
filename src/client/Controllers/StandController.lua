-- StandController.lua
-- Coltrane Willsey
-- 2022-03-14 [21:41]

--[[
    -- TODO: Add documentation
--]]

local common = game:GetService("ReplicatedStorage"):WaitForChild("common")

local Packages = common:WaitForChild("Packages")
local Promise = require(Packages.promise)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common:WaitForChild("Modules")
local LoadAnimation = require(Modules.loadanimation)
local bind = require(Modules.bind)

local StandController = Knit.CreateController { Name = "StandController"; }

function StandController.Start(standName: string?)
    local function main()
        local StandService = Knit.GetService("StandService")
        local _trove = Trove.new()

        -- Initialize stand serverside
        StandService.InitStand(standName)

        -- Setup bindings
        local binds = {
            bind({ Enum.UserInputType.MouseButton1 }, function()
                StandService.Attack("MouseButton1")
            end);
        }

        -- Cleanup jobs
        for _, binding in pairs(binds) do
            _trove:Add(binding, "unbind")
        end
    end

    return Promise.try(main)
end

--

function StandController:KnitInit()
end

function StandController:KnitStart()
end

return StandController
