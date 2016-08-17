require('libraries/timers')

if phantom_assassin_oppression == nil then
	phantom_assassin_oppression = class({})
end

LinkLuaModifier("phantom_assassin_oppression_damage","heroes/PhantomAssassin/phantom_assassin_oppression",LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_oppression:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function phantom_assassin_oppression:OnSpellStart(event)
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	target:AddNewModifier(caster,self,"phantom_assassin_oppression_damage",{duration = self:GetSpecialValueFor("duration")})
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
	local kills = target:GetKills()
	local caster = ability:GetCaster()
	local deaths = target:GetDeaths()

	if kills == nil then
		killls = 1
	end

	if deaths == nil then
		deaths = 1
	end

	local damage = ((kills * ability:GetSpecialValueFor("dpk")) / deaths * ability:GetSpecialValueFor("dpd")) / ability:GetSpecialValueFor("duration")
	local damage_table = { victim = target,	attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL }
	local delay = ability:GetSpecialValueFor("delay")
	self.phantom_assassin_oppression_damage_timer = Timers:CreateTimer(0, function()
	ApplyDamage(damage_table)
	return delay	
	end)
end

function phantom_assassin_oppression_damage:OnRefresh()
	local id = self:GetParent():GetPlayerID()
	local kills = self:GetKills()
	local target = self:GetParent()
	local ability = self:GetAbility()
	local caster = ability:GetCaster()
	local deaths = target:GetDeaths()

	if kills == nil then
		killls = 1
	end

	if deaths == nil then
		deaths = 1
	end

	local damage = ((kills * ability:GetSpecialValueFor("dpk")) / deaths * ability:GetSpecialValueFor("dpd")) / ability:GetSpecialValueFor("duration")
	local damage_table = { victim = target,	attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL }
	local delay = ability:GetSpecialValueFor("delay")
	self.phantom_assassin_oppression_damage_timer = Timers:CreateTimer(0, function()
	ApplyDamage(damage_table)
	return delay	
	end)
end

function phantom_assassin_oppression_damage:OnDestroy()
	Timers:RemoveTimer(self.phantom_assassin_oppression_damage_timer)
end