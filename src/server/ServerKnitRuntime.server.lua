local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Component = require(Packages.component)
local Knit = require(Packages.knit)

function loadModules(src: Instance)
    for _, module in ipairs(src:GetChildren()) do
        if module:IsA("ModuleScript") then
            require(module)
        end
    end
end

Knit.AddServices(script.Parent.Services)
Knit:Start()
:andThen(function()
    loadModules(script.Parent.Components)
end)
:catch(warn)