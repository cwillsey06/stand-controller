local Player = game:GetService("Players").LocalPlayer

local common = game:GetService("ReplicatedStorage"):WaitForChild("common")
local Packages = common:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("knit"))
Knit.OnStart():await()

local StandController = Knit.GetController("StandController")

function InitStand()
    StandController.Start("Default") -- TODO: Add interface to set stand
end

if Player.Character then
    InitStand()
end

Player.CharacterAdded:Connect(InitStand)