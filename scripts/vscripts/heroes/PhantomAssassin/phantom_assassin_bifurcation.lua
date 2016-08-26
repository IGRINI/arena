if phantom_assassin_bifurcation == nil then
	phantom_assassin_bifurcation = class({})
end

LinkLuaModifier("modifier_pa_bifurcation","heroes/PhantomAssassin/phantom_assassin_bifurcation.lua",LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_bifurcation:GetCastAnimation()  
    return ACT_DOTA_CAST_ABILITY_1  
end
function phantom_assassin_bifurcation:OnSpellStart()
	local caster = self:GetCaster()
	local player = caster:GetPlayerID()
	local ability = self
	local unit_name = caster:GetUnitName()
	local origin = caster:GetAbsOrigin() + RandomVector(100)
	local duration = ability:GetLevelSpecialValueFor( "duration", ability:GetLevel() )
	local outDamage = ability:GetLevelSpecialValueFor( "damage_outcome", ability:GetLevel() )
	local incDamage = ability:GetLevelSpecialValueFor( "damage_incom", ability:GetLevel() )
	local maxmana = caster:GetMaxMana()
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
	illusion:AddNewModifier(caster, ability, "modifier_illusion", { duration = duration, outgoing_damage = outDamage, incoming_damage = incDamage })
	illusion:AddNewModifier(self:GetCaster(), self, "modifier_pa_bifurcation", {duration = duration})
	illusion:MakeIllusion()
end

function phantom_assassin_bifurcation:IsRefreshable()
	return true
end

-----------------------------

if modifier_pa_bifurcation == nil then
	modifier_pa_bifurcation = class({})
end

function modifier_pa_bifurcation:IsHidden(  )
	return true
end

function modifier_pa_bifurcation:AllowIllusionDuplicate(  )
	return true
end

function modifier_pa_bifurcation:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE,MODIFIER_PROPERTY_MOVESPEED_LIMIT }
	return funcs
end

function modifier_pa_bifurcation:GetModifierMoveSpeedBonus_Percentage_Unique(  )
	return self:GetAbility():GetLevelSpecialValueFor("illusion_ms",self:GetAbility():GetLevel())
end

function modifier_pa_bifurcation:GetModifierMoveSpeed_Limit(  )
	return 820
end