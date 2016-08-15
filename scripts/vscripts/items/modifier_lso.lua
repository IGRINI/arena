if modifier_lso == nil then
	modifier_lso = class({})
end

function modifier_lso:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
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
	return 12 + (self:GetParent():GetLevel() * 0.5)
end
function modifier_lso:GetModifierBonusStats_Agility(params)
	return 12 + (self:GetParent():GetLevel() * 0.5)
end
function modifier_lso:GetModifierBonusStats_Intellect(params)
	return 12 + (self:GetParent():GetLevel() * 0.5)
end
function modifier_lso:GetModifierPreAttack_BonusDamage(params)
	return 12 + (self:GetParent():GetLevel() * 0.5)
end