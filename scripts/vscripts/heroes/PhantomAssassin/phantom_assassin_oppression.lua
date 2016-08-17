require('libraries/timers')

if phantom_assassin_oppression == nil then
	phantom_assassin_oppression = class({})
end

LinkLuaModifier("phantom_assassin_oppression_damage","heroes/PhantomAssassin/phantom_assassin_oppression",LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_oppression:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function phantom_assassin_oppression:OnSpellStart(event)
	local self.target = self:GetCursorTarget()
	local caster = self:GetCaster()
	self.target:AddNewModifier(caster,self,"phantom_assassin_oppression_damage",{duration = self:GetSpecialValueFor("duration")})
end

--------------------------------------------------------------------------------------------------------------------------------------

if phantom_assassin_oppression_damage == nil then
	phantom_assassin_oppression_damage = class({})
end

function phantom_assassin_oppression_damage:IsDebuff()
	return true
end

function phantom_assassin_oppression_damage:GetTexture()
	return "phantom_assassin_oppression"
end

function phantom_assassin_oppression_damage:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function phantom_assassin_oppression_damage:OnCreated()
	local target = self:GetParent()
	local ability = self:GetAbility()
	local caster = ability:GetCaster()
	local kills = target:GetKills()
	local deaths = target:GetDeaths()

	if kills == nil or deaths == nil then
		return nil
	end

	local damage = ((kills * ability:GetSpecialValueFor("dpk")) / deaths * ability:GetSpecialValueFor("dpd")) / ability:GetSpecialValueFor("duration")
	local damage_table = { victim = target,	attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL }
	local delay = ability:GetSpecialValueFor("delay")
	local phantom_assassin_oppression_damage_timer = Timers:CreateTimer(nil, function()
	ApplyDamage(damage_table)
	return delay	
	end)
end

function phantom_assassin_oppression_damage:OnRefresh()
	local target = self:GetParent()
	local caster = self:GetAbility():GetCaster()
	local ability = self:GetAbility()
	local kills = self.target:GetKills()
	local deaths = self.target:GetDeaths()

	if kills == nil or deaths == nil then
		return nil
	end

	local damage = ((kills * ability:GetSpecialValueFor("dpk")) / deaths * ability:GetSpecialValueFor("dpd")) / ability:GetSpecialValueFor("duration")
	local damage_table = { victim = target,	attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL }
	local delay = ability:GetSpecialValueFor("delay")
	local phantom_assassin_oppression_damage_timer = Timers:CreateTimer(nil, function()
	ApplyDamage(damage_table)
	return delay	
	end)
end

function phantom_assassin_oppression_damage:OnDestroy()
	Timers:RemoveTimer(phantom_assassin_oppression_damage_timer)
end