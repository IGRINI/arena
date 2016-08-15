if modifier_item_armlet_of_azrael == nil then
	modifier_item_armlet_of_azrael = class({})
end

function modifier_item_armlet_of_azrael:IsHidden()
	return true
end

function modifier_item_armlet_of_azrael:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
	}
	return funcs
end

function modifier_item_armlet_of_azrael:GetModifierSpellAmplify_Percentage( params )
	return math.floor(2)
end

function modifier_item_armlet_of_azrael:GetModifierPercentageCooldown( params )
	return 10
end

function modifier_item_armlet_of_azrael:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end



if modifier_item_unholy_armlet_of_azrael == nil then
	modifier_item_unholy_armlet_of_azrael = class({})
end

function modifier_item_unholy_armlet_of_azrael:IsHidden()
	return false
end

function modifier_item_unholy_armlet_of_azrael:GetTexture()
	return "item_armlet_of_azrael"
end

function modifier_item_unholy_armlet_of_azrael:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
	}
	return funcs
end

function modifier_item_unholy_armlet_of_azrael:GetModifierSpellAmplify_Percentage( params )
	return math.floor(5)
end

function modifier_item_unholy_armlet_of_azrael:GetModifierPercentageCooldown( params )
	return 20
end

function modifier_item_unholy_armlet_of_azrael:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

