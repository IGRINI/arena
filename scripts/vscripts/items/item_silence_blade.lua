if item_silence_blade == nil then
	item_silence_blade = class({})
end

LinkLuaModifier("modifier_silence_blade_passive","items/item_silence_blade.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_silence_blade_bonus","items/item_silence_blade.lua",LUA_MODIFIER_MOTION_NONE)

function item_silence_blade:GetIntrinsicModifierName()
	return modifier_silence_blade_passive
end

function item_silence_blade:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_ABILITY_EXECUTED, MODIFIER_EVENT_ON_ATTACK_LANDED }
	return funcs 
end

function item_silence_blade:OnSpellStart()
	self:GetCaster():EmitSound("DOTA_Item.InvisibilitySword.Activate")
    
    --Start Shadow Blade's effect after the fade delay.
    Timers:CreateTimer({
        endTime = 0.1,
        callback = function()
            self:ApplyDataDrivenModifier(self:GetCaster(), self:GetCaster(), "modifier_silence_blade_bonus", nil)
        end
    })
end

function item_silence_blade:OnAbilityExecuted()
	if self:GetCaster():HasModifier("modifier_silence_blade_bonus") then
		self:GetCaster():RemoveModifierByName("modifier_silence_blade_bonus")
	end
end

function item_silence_blade:OnAttackLanded()
	-- body
end

------------------------------------------------------------------------------------------------------------

if modifier_silence_blade_passive == nil then
	modifier_silence_blade_passive = class({})
end

function modifier_silence_blade_passive:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE, MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, MODIFIER_PROPERTY_STATS_AGILITY_BONUS }
	return funcs
end

function modifier_silence_blade_passive:GetModifierPreAttack_BonusDamage()
	return 60
end

function modifier_silence_blade_passive:GetModifierMoveSpeedBonus_Percentage()
	return 6
end

function modifier_silence_blade_passive:GetModifierAttackSpeedBonus_Constant()
	return 60
end

function modifier_silence_blade_passive:GetModifierPercentageManaRegen()
	return 200
end

function modifier_silence_blade_passive:GetModifierBonusStats_Intellect()
	return 30
end

function modifier_silence_blade_passive:GetModifierBonusStats_Agility()
	return 20
end