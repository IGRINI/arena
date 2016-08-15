LinkLuaModifier("modifier_item_astral_boots","items/item_astral_boots",LUA_MODIFIER_MOTION_NONE)
function swap_to_item(keys, ItemName)
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item == nil then
			local item = keys.caster:AddItem(CreateItem("item_dummy_armlet", keys.caster, keys.caster))
			item:SetPurchaseTime(0)
		end
	end
	
	keys.caster:RemoveItem(keys.ability)
	local newitem = keys.caster:AddItem(CreateItem(ItemName, keys.caster, keys.caster))
	newitem:SetPurchaseTime(0)
	
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_armlet" then
				keys.caster:RemoveItem(current_item)
			end
		end
	end
end


function active_on_spell_start(keys)
	keys.caster:EmitSound("DOTA_Item.GhostScepter.Activate")
	swap_to_item(keys, "item_astral_boots")
end


function on_spell_start(keys)
	while keys.caster:HasAnyAvailableInventorySpace() do
		keys.caster:AddItem(CreateItem("item_dummy_armlet", keys.caster, keys.caster))
	end
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_astral_boots_active" then
				keys.caster:RemoveItem(current_item)
				keys.caster:AddItem(CreateItem("item_astral_boots", keys.caster, keys.caster))
			end
		end
	end
	
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_armlet" then
				keys.caster:RemoveItem(current_item)
			end
		end
	end

	keys.caster:EmitSound("DOTA_Item.GhostScepter.Activate")
	swap_to_item(keys, "item_astral_boots_active")
end
function on_unequip(keys)
	keys.caster:RemoveModifierByName("modifier_item_astral_boots")
end

function createactivemodifier(keys)
	keys.caster:AddNewModifier(keys.caster, nil, "modifier_item_astral_boots", {duration = -1})
end




if modifier_item_astral_boots == nil then
	modifier_item_astral_boots = class({})
end

function modifier_item_astral_boots:IsHidden()
	return false
end

function modifier_item_astral_boots:GetTexture()
	return "item_astral_boots_active"
end

function modifier_item_astral_boots:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end

function modifier_item_astral_boots:GetModifierMagicalResistanceBonus()
	return -65
end

function modifier_item_astral_boots:GetModifierMoveSpeedBonus_Percentage()
	return -20
end

function modifier_item_astral_boots:CheckState()
	local state = {
	[MODIFIER_STATE_ATTACK_IMMUNE] = true,
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_item_astral_boots:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end