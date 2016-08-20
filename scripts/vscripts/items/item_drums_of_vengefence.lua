if item_drums_of_vengefence == nil then
	item_drums_of_vengefence = class({})
end

LinkLuaModifier("modifier_drums_of_vengefence_passive","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_passive_aura_emmiter","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_passive_aura","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_negative","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_aura","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drums_of_vengefence_aura_negative","items/item_drums_of_vengefence.lua",LUA_MODIFIER_MOTION_NONE)

function item_drums_of_vengefence:GetIntrinsicModifierName()
    return "modifier_drums_of_vengefence_passive_aura_emmiter"
end

function item_drums_of_vengefence:OnSpellStart()
	local charges = self:GetCurrentCharges()
	if charges <= 0 then
		return nil
	end
	self:SetCurrentCharges(charges - 1)
	self:GetCaster():AddNewModifier(self:GetCaster(),self,"modifier_drums_of_vengefence",{duration = 5.5})
	self:GetCaster():AddNewModifier(self:GetCaster(),self,"modifier_drums_of_vengefence_negative",{duration = 5.5})
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence == nil then
	modifier_drums_of_vengefence = class({})
end

function modifier_drums_of_vengefence:IsAura()
	return true
end

function modifier_drums_of_vengefence:IsPurgable()
    return false
end

function modifier_drums_of_vengefence:IsHidden()
	return true
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

function modifier_drums_of_vengefence_aura:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_drums_of_vengefence_aura:GetEffectName()
    return "particles/econ/courier/courier_onibi/courier_onibi_blue_ambient_b.vpcf"
end

function modifier_drums_of_vengefence_aura:GetTexture()
    return "item_drums_of_vengefence"
end

function modifier_drums_of_vengefence_aura:IsHidden()
	return false
end

function modifier_drums_of_vengefence_aura:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
	return funcs
end

function modifier_drums_of_vengefence_aura:GetModifierAttackSpeedBonus_Constant(params)
	return 30
end

function modifier_drums_of_vengefence_aura:GetModifierMoveSpeedBonus_Percentage(params)
	return 30
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence_negative == nil then
	modifier_drums_of_vengefence_negative = class({})
end

function modifier_drums_of_vengefence_negative:IsAura()
	return true
end

function modifier_drums_of_vengefence_negative:IsHidden()
	return true
end

function modifier_drums_of_vengefence_negative:IsPurgable()
    return false
end

function modifier_drums_of_vengefence_negative:GetAuraRadius()
    return 1020
end

function modifier_drums_of_vengefence_negative:GetModifierAura()
    return "modifier_drums_of_vengefence_aura_negative"
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

function modifier_drums_of_vengefence_aura_negative:GetTexture()
    return "item_drums_of_vengefence"
end

function modifier_drums_of_vengefence_aura_negative:GetEffectName()
    return "particles/units/unit_greevil/loot_greevil_death_cloud.vpcf"
end

function modifier_drums_of_vengefence_aura_negative:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_drums_of_vengefence_aura_negative:IsHidden()
	return false
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

---------------------------------------------------------------------------------------

if modifier_drums_of_vengefence_passive_aura_emmiter == nil then
	modifier_drums_of_vengefence_passive_aura_emmiter = class({})
end

function modifier_drums_of_vengefence_passive_aura_emmiter:IsAura()
	return true
end

function modifier_drums_of_vengefence_passive_aura_emmiter:IsHidden()
	return true
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_drums_of_vengefence_passive_aura_emmiter:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT, MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, MODIFIER_PROPERTY_STATS_AGILITY_BONUS, MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
	return funcs
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierConstantHealthRegen(params)
	return 3.55
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierPhysicalArmorBonus(params)
	return 3
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierPreAttack_BonusDamage(params)
	return 3
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierBonusStats_Strength(params)
	return 6
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierBonusStats_Agility(params)
	return 3
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierBonusStats_Intellect(params)
	return 9
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierAttackSpeedBonus_Constant(params)
	return 5
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierMoveSpeedBonus_Percentage(params)
	return 5
end

function modifier_drums_of_vengefence_passive_aura_emmiter:IsPurgable()
    return false
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetAuraRadius()
    return 1020
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetModifierAura()
    return "modifier_drums_of_vengefence_passive_aura"
end
   
function modifier_drums_of_vengefence_passive_aura_emmiter:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_drums_of_vengefence_passive_aura_emmiter:GetAuraDuration()
    return 0.5
end

---------------------------------------------------------------------

if modifier_drums_of_vengefence_passive_aura == nil then
	modifier_drums_of_vengefence_passive_aura = class({})
end

function modifier_drums_of_vengefence_passive_aura:GetTexture()
    return "item_drums_of_vengefence"
end

function modifier_drums_of_vengefence_passive_aura:GetEffectName()
    return "particles/units/unit_greevil/loot_greevil_ambient_rare_sparks.vpcf"
end

function modifier_drums_of_vengefence_passive_aura:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_drums_of_vengefence_passive_aura:IsHidden()
	return false
end

function modifier_drums_of_vengefence_passive_aura:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
	return funcs
end

function modifier_drums_of_vengefence_passive_aura:GetModifierConstantHealthRegen(params)
	return 3.55
end

function modifier_drums_of_vengefence_passive_aura:GetModifierPhysicalArmorBonus(params)
	return 3
end

function modifier_drums_of_vengefence_passive_aura:GetModifierAttackSpeedBonus_Constant(params)
	return 5
end

function modifier_drums_of_vengefence_passive_aura:GetModifierMoveSpeedBonus_Percentage(params)
	return 5
end