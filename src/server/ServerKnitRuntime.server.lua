-- ServerKnitRuntime.server.lua
-- Coltrane Willsey
-- 2022-03-14 [21:35]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Loader = require(Packages.loader)
local Knit = require(Packages.knit)

Knit.AddServices(script.Parent.Services)
Knit.Start()
:andThen(function()
    print("Knit Server Started")
    Loader.LoadChildren(common.Components)
end)
:catch(warn)