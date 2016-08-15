if modifier_item_devotit_core == nil then
	modifier_item_devotit_core = class({})
end

function modifier_item_devotit_core:IsHidden()
	return true
end

function modifier_item_devotit_core:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
	}

	return funcs
end

function modifier_item_devotit_core:GetModifierPercentageCooldown( params )
	return 5
end

function modifier_item_devotit_core:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end