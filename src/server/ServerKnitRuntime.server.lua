local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

Knit.AddServices(script.Parent.Services)
Knit:Start():catch(warn)