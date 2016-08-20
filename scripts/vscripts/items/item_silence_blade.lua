require('libraries/timers')

if item_silence_blade == nil then
	item_silence_blade = class({})
end

LinkLuaModifier("modifier_silence_blade_passive","items/item_silence_blade.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_silence_blade_bonus","items/item_silence_blade.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_silence_blade_shadow_walk","items/item_silence_blade.lua",LUA_MODIFIER_MOTION_NONE)

function item_silence_blade:GetIntrinsicModifierName()
	return "modifier_silence_blade_passive"
end

function item_silence_blade:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_ABILITY_EXECUTED, MODIFIER_EVENT_ON_ATTACK_LANDED, MODIFIER_EVENT_ON_ATTACK_ALLIED }
	return funcs 
end

function item_silence_blade:OnSpellStart()
	self.caster = self:GetCaster()
	self.caster:EmitSound("DOTA_Item.InvisibilitySword.Activate")

    Timers:CreateTimer({
        endTime = 0.1,
        callback = function()
            self.caster:AddNewModifier(self.caster, self, "modifier_silence_blade_shadow_walk", {duration = 17.2})
        end
    })
end

function item_silence_blade:OnAttackAllied()
	if self.caster:HasModifier("modifier_silence_blade_shadow_walk") then
		self.target:AddNewModifier(self.caster,self,"modifier_silence_blade_bonus",{duration = 2.8})
	end
end

function item_silence_blade:OnAbilityExecuted()
	if self.caster:HasModifier("modifier_silence_blade_shadow_walk") then
		self.caster:RemoveModifierByName("modifier_silence_blade_shadow_walk")
	end
end

function item_silence_blade:OnAttackLanded()
	if self.caster:HasModifier("modifier_silence_blade_shadow_walk") then 
		self.caster:RemoveModifierByName("modifier_silence_blade_shadow_walk")
		self.target = self.caster:GetAttackTarget()
		local damage_table = { victim = self.target, attacker = params.attacker, damage = 220, damage_type = DAMAGE_TYPE_PHYSICAL }
		ApplyDamage(damage_table)
	else
		return nil
	end
end

------------------------------------------------------------------------------------------------------------

if modifier_silence_blade_passive == nil then
	modifier_silence_blade_passive = class({})
end

function modifier_silence_blade_passive:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE, MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, MODIFIER_PROPERTY_STATS_AGILITY_BONUS }
	return funcs
end

function modifier_silence_blade_passive:IsHidden()
	return true
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

--------------------------------------------------------------------------------------------------------

if modifier_silence_blade_bonus == nil then
	modifier_silence_blade_bonus = class({})
end

function modifier_silence_blade_bonus:GetTexture()
	return "item_silence_blade"
end

function modifier_silence_blade_bonus:IsDebuff()
	return true
end

function modifier_silence_blade_bonus:IsPurgable()
	return true
end

function modifier_silence_blade_bonus:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end
 
function modifier_silence_blade_bonus:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_silence_blade_bonus:CheckState()
	local states = { [MODIFIER_STATE_SILENCED] = true, [MODIFIER_STATE_PASSIVES_DISABLED] = true }
	return states
end

---------------------------------------------------------------------------------------------------------

if modifier_silence_blade_shadow_walk == nil then
	modifier_silence_blade_shadow_walk = class({})
end

function modifier_silence_blade_shadow_walk:GetTexture()
	return "item_silence_blade"
end

function modifier_silence_blade_shadow_walk:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
	return funcs
end

function modifier_silence_blade_shadow_walk:GetModifierMoveSpeedBonus_Percentage()
	return 30
end

function modifier_silence_blade_shadow_walk:GetModifierInvisibilityLevel()
	return 1
end