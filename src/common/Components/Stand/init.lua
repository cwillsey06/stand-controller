-- init.lua
-- Coltrane Willsey
-- 2022-03-14 [21:44]

local metadata = require(script.Metadata)

local common = game:GetService("ReplicatedStorage").common

local Packages = common.Packages
local Component = require(Packages.component)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common.Modules
local LoadAnimation = require(Modules.loadanimation)
local new = require(Modules.new)

local Stand = Component.new { Tag = "PlayerStand"; }

function Stand.GetStandMeta(standName: string): {any}?
    return metadata[standName] or metadata.default
end

function Stand:Attack(attackMethod: string)
    local meta = self.GetStandMeta(self.Stand.Name)
    LoadAnimation(self.Stand, meta.Attacks[attackMethod].Animation)
end

function Stand:Init()
    -- Weld to character
    new("WeldConstraint", self.Stand.HumanoidRootPart, {
        Name = "StandWeld";
        Part0 = self.Stand.HumanoidRootPart;
        Part1 = self.Owner.Character.HumanoidRootPart;
    })

    local charCf = self.Owner.Character:GetPrimaryPartCFrame()
    local offset = CFrame.new(1.5, 1.5, 1.5)
    self.Stand:SetPrimaryPartCFrame(charCf * offset)

    -- Play idle animation
    local meta = self.GetStandMeta(self.Stand.Name)
    LoadAnimation(self.Stand, meta.Animations.Idle)

    print('stand component active')
end

function Stand.new(standModel: Model)
    print('stand init')
    local self = setmetatable({}, Stand)
    self._trove = Trove.new()

    local StandService = Knit.GetService("StandService")
    
    self.Stand = standModel
    self.Owner = StandService.GetPlayerFromStand(standModel)

    self:Init()
    return self
end

function Stand:Destroy()
    self._trove:Destroy()
end

return Stand
