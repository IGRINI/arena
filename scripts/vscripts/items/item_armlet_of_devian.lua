LinkLuaModifier("modifier_item_armlet_of_devian","items/modifier_item_armlet_of_devian",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_unholy_armlet_of_devian","items/modifier_item_armlet_of_devian",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arm_armlet_of_devian","items/modifier_item_armlet_of_devian",LUA_MODIFIER_MOTION_NONE)
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
	keys.caster:EmitSound("DOTA_Item.Armlet.DeActivate")
	swap_to_item(keys, "item_armlet_of_devian")
end


function on_spell_start(keys)
	while keys.caster:HasAnyAvailableInventorySpace() do
		keys.caster:AddItem(CreateItem("item_dummy_armlet", keys.caster, keys.caster))
	end
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_armlet_of_devian_active" then
				keys.caster:RemoveItem(current_item)
				keys.caster:AddItem(CreateItem("item_armlet_of_devian", keys.caster, keys.caster))
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

	keys.caster:EmitSound("DOTA_Item.Armlet.Activate")
	swap_to_item(keys, "item_armlet_of_devian_active")
end
function on_interval_think_arm(keys)
	keys.caster:AddNewModifier(keys.caster,nil,"modifier_item_arm_armlet_of_devian",{duration = -1})
end
function apply_tick_agi_on_interval_think(keys)
	if keys.ability.ArmletTicksActive == nil or keys.ability.ArmletTicksActive < keys.UnholyTicksToFullEffect then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_armlet_of_devian_active_tick", {duration = -1})
		if keys.ability.ArmletTicksActive == nil then
			keys.ability.ArmletTicksActive = 1
		else
			keys.ability.ArmletTicksActive = keys.ability.ArmletTicksActive + 1
		end
	end
end
function on_unequip(keys)
	if keys.ability.ArmletTicksActive ~= nil then
		
		for i=1, keys.ability.ArmletTicksActive, 1 do
			keys.caster:RemoveModifierByName("modifier_item_armlet_of_devian_active_tick")
		end
		keys.ability.ArmletTicksActive = nil
	end
end

function createmodifier(keys)
	keys.caster:AddNewModifier(keys.caster,nil,"modifier_item_armlet_of_devian",{duration = -1})
end

function createactivemodifier(keys)
	keys.caster:AddNewModifier(keys.caster, nil, "modifier_item_unholy_armlet_of_devian", {duration = -1})
end

function hpdrain(keys)
	local new_hp = keys.caster:GetHealth() - (100 + (keys.caster:GetMaxHealth() / 100 * 5))

	if new_hp < 1 then
		new_hp = 1
	end

	keys.caster:SetHealth(new_hp)
end