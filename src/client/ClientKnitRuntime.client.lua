-- ClientKnitRuntime.client.lua
-- Coltrane Willsey
-- 2022-03-14 [21:34]

local common = game:GetService("ReplicatedStorage"):WaitForChild("common")
local Packages = common:WaitForChild("Packages")
local Knit = require(Packages.knit)

Knit.AddControllers(script.Parent.Controllers)
Knit.Start()
:andThen(function()
    print("Knit Client Started")
end)
:catch(warn)