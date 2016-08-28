function Base_str(keys)
	local caster = keys.caster
	local ability = keys.ability
	local str = "modifier_attribute_boost_strength_stacks"
	local agi = "modifier_attribute_boost_agility_stacks"
	local int = "modifier_attribute_boost_intellect_stacks"

	if not caster:HasModifier(str) then
		ability:ApplyDataDrivenModifier(caster, caster, str, {})
	elseif caster:HasModifier(str) then
		local stacks = caster:GetModifierStackCount(str, caster)
		caster:SetModifierStackCount(str, caster, stacks + 1)
	end
end

function Base_agi(keys)
	local caster = keys.caster
	local ability = keys.ability
	local str = "modifier_attribute_boost_strength_stacks"
	local agi = "modifier_attribute_boost_agility_stacks"
	local int = "modifier_attribute_boost_intellect_stacks"

	if not caster:HasModifier(agi) then
		ability:ApplyDataDrivenModifier(caster, caster, agi, {})
	elseif caster:HasModifier(agi) then
		local stacks = caster:GetModifierStackCount(agi, caster)
		caster:SetModifierStackCount(agi, caster, stacks + 1)
	end
end

function Base_int(keys)
	local caster = keys.caster
	local ability = keys.ability
	local str = "modifier_attribute_boost_strength_stacks"
	local agi = "modifier_attribute_boost_agility_stacks"
	local int = "modifier_attribute_boost_intellect_stacks"

	if not caster:HasModifier(int) then
		ability:ApplyDataDrivenModifier(caster, caster, int, {})
	elseif caster:HasModifier(int) then
		local stacks = caster:GetModifierStackCount(int, caster)
		caster:SetModifierStackCount(int, caster, stacks + 1)
	end
end

function swap_to_item(keys, ItemName)
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item == nil then
			local item = CreateItem("item_dummy_armlet", keys.caster, keys.caster)
			item:SetPurchaseTime(0)
			keys.caster:AddItem(item)
		end
	end
	
	keys.caster:RemoveItem(keys.ability)
	local newitem = CreateItem(ItemName, keys.caster, keys.caster)
	newitem:SetPurchaseTime(0)
	keys.caster:AddItem(newitem)
	
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_armlet" then
				keys.caster:RemoveItem(current_item)
			end
		end
	end
end

function Swap_agi(keys)
	local newItem = "item_attribute_boost_intellect"
    swap_to_item(keys, newItem)
end

function Swap_int(keys)
	local newItem = "item_attribute_boost_strength"
    swap_to_item(keys, newItem)
end

function Swap_str(keys)
	local newItem = "item_attribute_boost_agility"
    swap_to_item(keys, newItem)
end