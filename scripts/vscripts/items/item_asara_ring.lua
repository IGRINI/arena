if item_asara_ring == nil then
	item_asara_ring = class({})
end

LinkLuaModifier("modifier_asara_ring","items/item_asara_ring.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_asara_ring_aura","items/item_asara_ring.lua",LUA_MODIFIER_MOTION_NONE)

function item_asara_ring:GetIntrinsicModifierName()
    return "modifier_asara_ring"
end

---------------------------------------------------------------------

if modifier_asara_ring == nil then
	modifier_asara_ring = class({})
end

function modifier_asara_ring:IsAura()
	return true
end

function modifier_asara_ring:GetTexture()
    return "item_asara_ring"
end

function modifier_asara_ring:IsPurgable()
    return false
end

function modifier_asara_ring:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_asara_ring:GetModifierAura()
    return "modifier_asara_ring_aura"
end

function modifier_asara_ring:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end
   
function modifier_asara_ring:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_asara_ring:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_asara_ring:GetAuraDuration()
    return 0.5
end

---------------------------------------------------------------------

if modifier_asara_ring_aura == nil then
	modifier_asara_ring_aura = class({})
end

function modifier_asara_ring_aura:GetEffectName()
    return "particles/units/unit_greevil/loot_greevil_ambient_rare_sparks.vpcf"
end

function modifier_asara_ring_aura:IsHidden()
	return true
end

function modifier_asara_ring_aura:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
	return funcs
end

function modifier_asara_ring_aura:GetModifierConstantHealthRegen(params)
	return 3.35
end

function modifier_asara_ring_aura:GetModifierPhysicalArmorBonus(params)
	return 3.4
end