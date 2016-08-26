require('libraries/timers')

if phantom_assassin_oppression == nil then
	phantom_assassin_oppression = class({})
end

LinkLuaModifier("modifier_pa_oppression","heroes/PhantomAssassin/phantom_assassin_oppression.lua",LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_oppression:OnSpellStart(  )
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	target:AddNewModifier(self:GetCaster(),self,"modifier_pa_oppression",{duration = self:GetLevelSpecialValueFor("duration",self:GetLevel())})
end

------------------------------------------------------------------------------------------------------------------------------------------------

if modifier_pa_oppression == nil then
	modifier_pa_oppression = class({})
end

function modifier_pa_oppression:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_pa_oppression:IsDebuff(  )
	return true
end

function modifier_pa_oppression:GetTexture(  )
	return "phantom_assassin_oppression"
end

function modifier_pa_oppression:OnCreated(  )
		local target = self:GetParent()
		local caster = self:GetAbility():GetCaster()
		local armor = target:GetPhysicalArmorValue()

		local dpa = armor * self:GetAbility():GetLevelSpecialValueFor("dpa",self:GetAbility():GetLevel())
		local dpa2 = dpa / self:GetAbility():GetLevelSpecialValueFor("duration",self:GetAbility():GetLevel())
		self.damage_timer = Timers:CreateTimer(0,function()
		ApplyDamage({victim = target, attacker = caster, damage = dpa2, damage_type = DAMAGE_TYPE_PHYSICAL})
		return 0.5
	end)
end

function modifier_pa_oppression:OnDestroy(  )
	Timers:RemoveTimer(self.damage_timer)
end