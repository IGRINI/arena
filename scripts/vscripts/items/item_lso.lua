if item_lso == nil then
	item_lso = class({})
end

function item_lso:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
    return behav
end

LinkLuaModifier("modifier_lso","items/item_lso",LUA_MODIFIER_MOTION_NONE)

function item_lso:GetIntrinsicModifierName()
	return "modifier_lso"
end

---------------------------------------------------------------------------------

if modifier_lso == nil then
	modifier_lso = class({})
end

function modifier_lso:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_lso:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_lso:IsHidden()
	return true
end

function modifier_lso:IsPurgable()
	return false
end

function modifier_lso:GetModifierBonusStats_Strength(params)
	return 12 + (self:GetParent():GetLevel() * 1.2)
end
function modifier_lso:GetModifierBonusStats_Agility(params)
	return 12 + (self:GetParent():GetLevel() * 1.2)
end
function modifier_lso:GetModifierBonusStats_Intellect(params)
	return 12 + (self:GetParent():GetLevel() * 1.2)
end
function modifier_lso:GetModifierPreAttack_BonusDamage(params)
	return 12 + (self:GetParent():GetLevel() * 1.2)
end