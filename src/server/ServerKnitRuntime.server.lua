local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Component = require(Packages.component)
local Knit = require(Packages.knit)

function loadComponents(src: Instance)
    for _, component in ipairs(src:GetChildren()) do
        if component:IsA("ModuleScript") then
            Component.new(require(component))
        end
    end
end

Knit.AddServices(script.Parent.Services)
Knit:Start()
:andThen(function()
    loadComponents(script.Parent.Components)
end)
:catch(warn)