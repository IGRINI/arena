if modifier_item_armlet_of_devian == nil then
	modifier_item_armlet_of_devian = class({})
end

function modifier_item_armlet_of_devian:IsHidden()
	return true
end

function modifier_item_armlet_of_devian:IsPurgable()
	return false
end

function modifier_item_armlet_of_devian:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
	}
	return funcs
end

function modifier_item_armlet_of_devian:GetModifierExtraHealthPercentage( params )
	return 0.1
end

function modifier_item_armlet_of_devian:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end



if modifier_item_unholy_armlet_of_devian == nil then
	modifier_item_unholy_armlet_of_devian = class({})
end

function modifier_item_unholy_armlet_of_devian:IsHidden()
	return false
end

function modifier_item_unholy_armlet_of_devian:IsPurgable()
	return false
end

function modifier_item_unholy_armlet_of_devian:GetTexture()
	return "item_armlet_of_devian"
end

function modifier_item_unholy_armlet_of_devian:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
	}
	return funcs
end

function modifier_item_unholy_armlet_of_devian:GetModifierExtraHealthPercentage( params )
	return -0.1
end

function modifier_item_unholy_armlet_of_devian:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end



if modifier_item_arm_armlet_of_devian == nil then
	modifier_item_arm_armlet_of_devian = class({})
end

function modifier_item_arm_armlet_of_devian:IsHidden()
	return true
end

function modifier_item_arm_armlet_of_devian:IsPurgable()
	return false
end

function modifier_item_arm_armlet_of_devian:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_item_arm_armlet_of_devian:GetModifierPhysicalArmorBonus( params )
	return -1
end

function modifier_item_arm_armlet_of_devian:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

