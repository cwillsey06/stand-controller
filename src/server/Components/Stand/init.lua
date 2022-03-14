-- Stand.lua
-- Coltrane Willsey
-- 2022-03-13 [20:19]

local Animations = require(script.Animations)
local Attacks = require(script.Attacks)

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Component = require(Packages.component)
local Trove = require(Packages.trove)
local Knit = require(Packages.knit)

local Modules = common.Modules
local RaycastHitbox = require(Modules.RaycastHitbox)
local LoadAnimation = require(Modules.loadanimation)
local new = require(Modules.new)

Knit.OnStart():await()
local StandService = Knit.GetService("StandService")

local Stand = Component.new { Tag = "PlayerStand" }

function Stand:Attack(attackType: string)
    local attack = (Attacks[attackType] or Attacks.fallbackAttack1)
    local anim = LoadAnimation(attack.animation)
    self:EnableHitbox(attack.damage)
    anim:Play()
    task.defer(function()
        anim.Stopped:Wait()
        self:DisableHitbox()
    end)
end

function Stand:EnableHitbox(damage: number?)
    self.Hitbox:HitStart()
    self._currentDamage = damage or 20
end

function Stand:DisableHitbox()
    self.Hitbox:HitStop()
end

function Stand:Weld()
    new("WeldConstraint", self.Stand.PrimaryPart, {
        Name = "StandWeld";
        Part0 = self.Stand.HumanoidRootPart;
        Part1 = self.Owner.Character.HumanoidRootPart;
    })

    local charCF = self.Owner.Character:GetPrimaryPartCFrame()
    local offset = CFrame.new(1.5, 1, 1.5)
    self.Stand:SetPrimaryPartCFrame(charCF * offset)
end

function Stand:init()
    LoadAnimation(self.Stand, Animations.fallbackIdle)

    self.Hitbox = RaycastHitbox.new()
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {self.Owner.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    self.Hitbox.RaycastParams = params

    self._trove:Add(self.Hitbox.OnHit:Connect(function(_, hit)
        hit:TakeDamage(self._currentDamage)
    end), "Disconnect")
end

function Stand.new(stand: Model)
    local self = setmetatable({}, Stand)
    self._trove = Trove.new()

    self.Stand = stand
    self.Owner = StandService.GetPlayerFromStand(stand)

    return self
end

function Stand:Destroy()
    self._trove:Destroy()
end

return Stand
