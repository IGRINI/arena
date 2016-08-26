require('libraries/timers')

if phantom_assassin_oppression == nil then
	phantom_assassin_oppression = class({})
end

LinkLuaModifier("modifier_pa_oppression","heroes/PhantomAssassin/phantom_assassin_oppression.lua",LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_oppression:OnSpellStart(  )
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	local kills = target:GetPlayerID():GetKills()
	local deaths = target:GetDeaths()
	local dpd = kills * self:GetLevelSpecialValueFor("dpd",self:GetLevel())
	local dpk = deaths * self:GetLevelSpecialValueFor("dpk",self:GetLevel())
	local damageperkill = (dpd * dpk) / self:GetLevelSpecialValueFor("duration",self:GetLevel())
	target:AddNewModifier(self:GetCaster(),self,"modifier_pa_oppression",{duration = self:GetLevelSpecialValueFor("duration",self:GetLevel())})
	print(kills)
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
	return self:GetAbility()
end

function modifier_pa_oppression:OnCreated(  )
	local target = self:GetParent()
	local caster = self:GetAbility():GetCaster()
	local kills = target:GetPlayerID():GetKills()
	local deaths = target:GetDeaths()
	local dpd = kills * self:GetLevelSpecialValueFor("dpd",self:GetLevel())
	local dpk = deaths * self:GetLevelSpecialValueFor("dpk",self:GetLevel())
	local damageperkill = (dpd * dpk) / self:GetLevelSpecialValueFor("duration",self:GetLevel())
	local damage_timer = Timers:CreateTimer(0,function()
		ApplyDamage({victim = target, attacker = caster, damage = damageperkill, damage_type = DAMAGE_TYPE_MAGICAL})
	return 0.5
	end)
end

function modifier_pa_oppression:OnRefresh(  )
	local target = self:GetParent()
	local caster = self:GetAbility():GetCaster()
	local kills = target:GetPlayerID():GetKills()
	local deaths = target:GetDeaths()
	local dpd = kills * self:GetLevelSpecialValueFor("dpd",self:GetLevel())
	local dpk = deaths * self:GetLevelSpecialValueFor("dpk",self:GetLevel())
	local damageperkill = (dpd * dpk) / self:GetLevelSpecialValueFor("duration",self:GetLevel())
	local damage_timer = Timers:CreateTimer(0,function()
		ApplyDamage({victim = target, attacker = caster, damage = damageperkill, damage_type = DAMAGE_TYPE_MAGICAL})
	return 0.5
	end)
end

function modifier_pa_oppression:OnDestroy(  )
	Timers:RemoveTimer(damage_timer)
end