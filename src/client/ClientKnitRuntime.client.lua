local common = game:GetService("ReplicatedStorage"):WaitForChild("common")
local Packages = common:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))

Knit.AddControllers(script.Parent:WaitForChild("Controllers"))
Knit:Start():catch(warn)