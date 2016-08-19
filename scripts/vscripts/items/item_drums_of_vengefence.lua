if item_drums_of_vengefence == nil then
	item_drums_of_vengefence = class({})
end

LinkLuaModifier("modifier_asara_ring","items/item_asara_ring.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_passive","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_asara_ring_aura","items/item_asara_ring.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_negative","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_aura","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_aura_negative","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)

function item_drums_of_vengefence:GetIntrinsicModifierName()
	local mods = { "modifier_asara_ring", "modifier_drums_of_vengefence_passive" }
    return mods 
end

function item_drums_of_vengefence:OnSpellStart()
	local charges = self:GetCurrentCharges()
	if charges <= 0 then
		return nil
	end
	self:GetAbility():SetCurrentCharges(charges = charges - 1)
	self:GetCaster():AddNewModifier(self:GetCaster(),self,"modifier_drums_of_vengefence",{duration = 5.5})
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence == nil then
	modifier_drums_of_vengefence = class({})
end

function modifier_drums_of_vengefence:IsAura()
	return true
end

function modifier_drums_of_vengefence:GetTexture()
    return "item_drums_of_vengefence"
end

function modifier_drums_of_vengefence:IsPurgable()
    return false
end

function modifier_drums_of_vengefence:GetAuraRadius()
    return 1020
end

function modifier_drums_of_vengefence:GetModifierAura()
    return "modifier_drums_of_vengefence_aura"
end
   
function modifier_drums_of_vengefence:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_drums_of_vengefence:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_drums_of_vengefence:GetAuraDuration()
    return 0.5
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence_aura == nil then
	modifier_drums_of_vengefence_aura = class({})
end

function modifier_drums_of_vengefence_aura:GetEffectName()
    return "particles/units/heroes/hero_huskar/loot_greevil_ambient_rare_sparks.vpcf"
end

function modifier_drums_of_vengefence:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_asara_ring_aura:GetEffectName()
    return "particles/units/unit_greevil/huskar_berserker_blood_hero_effect.vpcf"
end

function modifier_drums_of_vengefence_aura:IsHidden()
	return true
end

function modifier_drums_of_vengefence_aura:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
	return funcs
end

function modifier_drums_of_vengefence_aura:GetModifierConstantHealthRegen(params)
	return 3.35
end

function modifier_drums_of_vengefence_aura:GetModifierPhysicalArmorBonus(params)
	return 3.4
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence_negative == nil then
	modifier_drums_of_vengefence_negative = class({})
end

function modifier_drums_of_vengefence_negative:IsAura()
	return true
end

function modifier_drums_of_vengefence_negative:GetTexture()
    return "item_asara_ring"
end

function modifier_drums_of_vengefence_negative:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_drums_of_vengefence_negative:GetEffectName()
    return "particles/units/unit_greevil/loot_greevil_death_cloud.vpcf"
end

function modifier_drums_of_vengefence_negative:IsPurgable()
    return false
end

function modifier_drums_of_vengefence_negative:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_drums_of_vengefence_negative:GetModifierAura()
    return "modifier_asara_ring_aura"
end

function modifier_drums_of_vengefence_negative:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end
   
function modifier_drums_of_vengefence_negative:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_drums_of_vengefence_negative:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_drums_of_vengefence_negative:GetAuraDuration()
    return 0.5
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence_aura_negative == nil then
	modifier_drums_of_vengefence_aura_negative = class({})
end

function modifier_drums_of_vengefence_aura_negative:GetEffectName()
    return "particles/units/unit_greevil/loot_greevil_ambient_rare_sparks.vpcf"
end

function modifier_drums_of_vengefence_aura_negative:IsHidden()
	return true
end

function modifier_drums_of_vengefence_aura_negative:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
	return funcs
end

function modifier_drums_of_vengefence_aura_negative:GetModifierMoveSpeedBonus_Percentage(params)
	return -25
end

function modifier_drums_of_vengefence_aura_negative:GetModifierAttackSpeedBonus_Constant(params)
	return -25
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence_passive == nil then
	modifier_drums_of_vengefence_passive = class({})
end

function modifier_drums_of_vengefence_passive:IsHidden()
	return true
end

function modifier_drums_of_vengefence_passive:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT, MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, MODIFIER_PROPERTY_STATS_AGILITY_BONUS, MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
	return funcs
end

function modifier_drums_of_vengefence_passive:GetModifierConstantHealthRegen(params)
	return 3.35
end

function modifier_drums_of_vengefence_passive:GetModifierPhysicalArmorBonus(params)
	return 3.4
end

function modifier_drums_of_vengefence_passive:GetModifierPreAttack_BonusDamage(params)
	return 3.4
end

function modifier_drums_of_vengefence_passive:GetModifierBonusStats_Strength(params)
	return 6.5
end

function modifier_drums_of_vengefence_passive:GetModifierBonusStats_Agility(params)
	return 3.2
end

function modifier_drums_of_vengefence_passive:GetModifierBonusStats_Intellect(params)
	return 9.9
end

function modifier_drums_of_vengefence_passive:GetModifierAttackSpeedBonus_Constant(params)
	return 30
end

function modifier_drums_of_vengefence_passive:GetModifierMoveSpeedBonus_Percentage(params)
	return -25
end