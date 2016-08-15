if ss_mana_illusion == nil then
	 ss_mana_illusion = class({})
end
function ss_mana_illusion:GetCastAnimation()  
    return ACT_DOTA_CAST_ABILITY_1  
end
function ss_mana_illusion:OnSpellStart()
	local caster = self:GetCaster()
	local player = caster:GetPlayerID()
	local ability = self
	local unit_name = caster:GetUnitName()
	local origin = caster:GetAbsOrigin() + RandomVector(100)
	local duration = ability:GetLevelSpecialValueFor( "duration", ability:GetLevel() )
	local outDamage = ability:GetLevelSpecialValueFor( "outdamage", ability:GetLevel() )
	local incDamage = ability:GetLevelSpecialValueFor( "incdamage", ability:GetLevel() )
	local maxmana = caster:GetMaxMana()
	local outgoingDamage = -100 + (maxmana / outDamage)
	local incomingDamage = maxmana / incDamage
	local illusion = CreateUnitByName(unit_name, origin, true, caster, nil, caster:GetTeamNumber())
	illusion:SetPlayerID(player)
	illusion:SetControllableByPlayer(player, true)
	local casterLevel = caster:GetLevel()
	for i=1,casterLevel-1 do
		illusion:HeroLevelUp(false)
	end
	illusion:SetAbilityPoints(0)
	for abilitySlot=0,15 do
		local ability = caster:GetAbilityByIndex(abilitySlot)
		if ability ~= nil then 
			local abilityLevel = ability:GetLevel()
			local abilityName = ability:GetAbilityName()
			local illusionAbility = illusion:FindAbilityByName(abilityName)
			illusionAbility:SetLevel(abilityLevel)
		end
	end
	for itemSlot=0,5 do
		local item = caster:GetItemInSlot(itemSlot)
		if item ~= nil then
			local itemName = item:GetName()
			local newItem = CreateItem(itemName, illusion, illusion)
			illusion:AddItem(newItem)
		end
	end
	illusion:AddNewModifier(caster, ability, "modifier_illusion", { duration = duration, outgoing_damage = outgoingDamage, incoming_damage = incomingDamage })
	illusion:MakeIllusion()
	print("outgoing damage is " .. outgoingDamage)
	print("incoming damage is " .. incomingDamage)
end
function ss_mana_illusion:IsRefreshable()
	return false
end