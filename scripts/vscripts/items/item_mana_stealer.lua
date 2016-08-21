if item_mana_stealer == nil then
	item_mana_stealer = class({})
end

LinkLuaModifier("modifier_mana_stealer_passive","items/item_mana_stealer.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mana_stealer_purge","items/item_mana_stealer.lua",LUA_MODIFIER_MOTION_NONE)

function item_mana_stealer:GetIntrinsicModifierName()
	return "modifier_mana_stealer_passive"
end

function item_mana_stealer:OnSpellStart()
	if self:GetCurrentCharges() <= 0 then
		return nil
	else
		
		local target = self:GetCursorTarget()
		if target == nil then
			return nil
		else
			self:SetCurrentCharges(self:GetCurrentCharges() - 1)
			target:AddNewModifier(self:GetCaster(), self, "modifier_mana_stealer_purge", {duration = 4.5})
			target:Purge(true,false,false,false,false)
		end
	end
end

------------------------------------------------------------------------------------------------------------

if modifier_mana_stealer_passive == nil then
	modifier_mana_stealer_passive = class({})
end

function modifier_mana_stealer_passive:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, MODIFIER_PROPERTY_STATS_AGILITY_BONUS, MODIFIER_EVENT_ON_ABILITY_EXECUTED, MODIFIER_EVENT_ON_ATTACK_LANDED }
	return funcs
end

function modifier_mana_stealer_passive:IsHidden(  )
	return true
end

function modifier_mana_stealer_passive:GetModifierBonusStats_Intellect()
	return 30
end

function modifier_mana_stealer_passive:GetModifierBonusStats_Agility()
	return 35
end

function modifier_mana_stealer_passive:OnAttackLanded()
	local caster = self:GetParent() 
	local target = caster:GetAttackTarget()
	if target == nil then
		return nil
	else
		target:SetMana(target:GetMana() - 50)

		if target:GetMana() <= 120 then
			ApplyDamage({victim = target, attacker = caster, damage = 50, damage_type = DAMAGE_TYPE_PHYSICAL})
		end
	end
end

function modifier_mana_stealer_passive:OnAbilityExecuted(event)
	if IsServer() then
		local target = self:GetAbility():GetCursorTarget()

		if target == nil then
			return nil
		elseif target:GetMana() >= target:GetMana() * 0.12
			local mana = nil
			if target:HasModifier("modifier_mana_stealer_purge") then
				mana = event.ability:GetManaCost(event.ability:GetLevel()) * 0.26
			else 
				mana = event.ability:GetManaCost(event.ability:GetLevel()) * 0.18
			end
			target:SetMana(target:GetMana() - mana)
			self:GetParent():SetMana(self:GetParent():GetMana() + mana)
			print(mana)
		end
	end
end

------------------------------------------------------------------------------------------------------------

if modifier_mana_stealer_purge == nil then
	modifier_mana_stealer_purge = class({})
end

function modifier_mana_stealer_purge:IsDebuff()
	return true
end

function modifier_mana_stealer_purge:GetTexture()
	return "item_mana_stealer"
end

function modifier_mana_stealer_purge:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
	return funcs
end

function modifier_mana_stealer_purge:GetModifierMoveSpeedBonus_Percentage()
	return -32
end