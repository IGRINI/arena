LinkLuaModifier("modifier_item_armlet_of_azrael","items/modifier_item_armlet_of_azrael",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_unholy_armlet_of_azrael","items/modifier_item_armlet_of_azrael",LUA_MODIFIER_MOTION_NONE)
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


function active_on_spell_start(keys)
	keys.caster:EmitSound("DOTA_Item.Armlet.DeActivate")
	swap_to_item(keys, "item_armlet_of_azrael")
end


function on_spell_start(keys)
	while keys.caster:HasAnyAvailableInventorySpace() do
		local item = CreateItem("item_dummy_armlet", keys.caster, keys.caster)
		item:SetPurchaseTime(0)
		keys.caster:AddItem(item)
	end
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_armlet_of_azrael_active" then
				keys.caster:RemoveItem(current_item)
				local itemgg = CreateItem("item_armlet_of_azrael", keys.caster, keys.caster)
				itemgg:SetPurchaseTime(0)
				keys.caster:AddItem(itemgg)
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
	swap_to_item(keys, "item_armlet_of_azrael_active")
end
function on_interval_think_mana(keys)
	local new_mp = keys.caster:GetMana() - (keys.UnholyManaDrainPerSecond * keys.UnholyManaDrainInterval)
	local new_hp = keys.caster:GetHealth() - (keys.UnholyHpDrainPerSecond * keys.UnholyManaDrainInterval)
	
	if new_mp < 0 then
		new_mp = 0
	end

	if new_hp < 1 then
		new_hp = 1
	end

	keys.caster:SetHealth(new_hp)
	keys.caster:SetMana(new_mp)
end
function apply_tick_int_on_interval_think(keys)
	if keys.ability.ArmletTicksActive == nil or keys.ability.ArmletTicksActive < keys.UnholyTicksToFullEffect then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_armlet_of_azrael_active_tick", {duration = -1})
		if keys.ability.ArmletTicksActive == nil then
			keys.ability.ArmletTicksActive = 1
		else
			keys.ability.ArmletTicksActive = keys.ability.ArmletTicksActive + 1
		end
		local currentMP = keys.caster:GetMana()
		local maxMP = keys.caster:GetMaxMana()
		local mana_bonus_interval_ratio = (keys.UnholyBonusInt / keys.UnholyTicksToFullEffect) * 12
		
		local amount_to_mana = ((currentMP + mana_bonus_interval_ratio) / (maxMP + mana_bonus_interval_ratio)) * maxMP - currentMP
		
		keys.caster:SetMana(currentMP + amount_to_mana)
	end
end
function on_unequip(keys)
	if keys.ability.ArmletTicksActive ~= nil then
		
		for i=1, keys.ability.ArmletTicksActive, 1 do
			keys.caster:RemoveModifierByName("modifier_item_armlet_of_azrael_active_tick")
		end
		for i=1, keys.ability.ArmletTicksActive, 1 do
			local currentMP = keys.caster:GetMana()
			local maxMP = keys.caster:GetMaxMana()
			local mana_bonus_interval_ratio = (keys.UnholyBonusInt / keys.UnholyTicksToFullEffect) * 12
			local amount_to_mana = ((currentMP + mana_bonus_interval_ratio) / (maxMP + mana_bonus_interval_ratio)) * maxMP - currentMP
			local new_mp = currentMP - amount_to_mana
			if new_mp < 0 then
				new_mp = 0
			end
			keys.caster:SetMana(new_mp)
		end
		keys.ability.ArmletTicksActive = nil
	end
end

function createmodifier(keys)
	keys.caster:AddNewModifier(keys.caster,nil,"modifier_item_armlet_of_azrael",{duration = -1})
end

function createactivemodifier(keys)
	keys.caster:AddNewModifier(keys.caster, nil, "modifier_item_unholy_armlet_of_azrael", {duration = -1})
end