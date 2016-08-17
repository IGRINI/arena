if phantom_assassin_wound == nil then
	phantom_assassin_wound = class({})
end
LinkLuaModifier("modifier_pa_wound","heroes/PhantomAssassin/phantom_assassin_wound",LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_wound:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_2
end

function phantom_assassin_wound:OnSpellStart(event)
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	target:AddNewModifier(caster,self,"modifier_pa_wound",{duration = self:GetLevelSpecialValueFor("duration",self:GetLevel())})

	--local nTargetFX = ParticleManager:CreateParticle( "particles\dire_fx\bad_ancient_sauron.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	--ParticleManager:SetParticleControlEnt( target, 1, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetOrigin(), false )
end

--------------------------------------------------------------------------------------------------------------------------------------

if modifier_pa_wound == nil then
	modifier_pa_wound = class({})
end

function modifier_pa_wound:IsDebuff()
	return true
end

function modifier_pa_wound:GetTexture()
	return "phantom_assassin_wound"
end

function modifier_pa_wound:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_MISS_PERCENTAGE, MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE }
	return funcs
end

function modifier_pa_wound:GetModifierTurnRate_Percentage(params)
	return self:GetAbility():GetLevelSpecialValueFor("turn_slow",self:GetAbility():GetLevel())
end

function modifier_pa_wound:GetModifierMoveSpeedBonus_Percentage(params)
	return self:GetAbility():GetLevelSpecialValueFor("slow",self:GetAbility():GetLevel())
end

function modifier_pa_wound:GetModifierMiss_Percentage(params)
	return self:GetAbility():GetLevelSpecialValueFor("miss_chance",self:GetAbility():GetLevel())
end