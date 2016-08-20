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

function item_silence_blade:OnSpellStart()
	local caster = self:GetCaster()
	local target = caster:GetAttackTarget()

	caster:EmitSound("DOTA_Item.InvisibilitySword.Activate")

    Timers:CreateTimer({
        endTime = 0.1,
        callback = function()
            caster:AddNewModifier(caster, self, "modifier_silence_blade_shadow_walk", {duration = 17.2})
        end
    })
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

function modifier_silence_blade_bonus:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_TAKEDAMAGE }
	return funcs
end

function modifier_silence_blade_bonus:GetTexture()
	return "item_silence_blade"
end

function modifier_silence_blade_bonus:OnTakeDamage(event)
	local damage = event.damage
	local attacker = self:GetParent()
	local ability = self:GetAbility()
	local caster = ability:GetCaster()

	caster.soul_damage = caster.soul_damage or 0
	caster.soul_damage = caster.soul_damage + damage
end

function modifier_silence_blade_bonus:OnDestroy()
	local ability = self:GetAbility()
	local caster = ability:GetCaster()

	ApplyDamage({ victim = self:GetParent(), attacker = caster, damage = caster.soul_damage * 0.4, damage_type = DAMAGE_TYPE_MAGICAL }) 
end

function modifier_silence_blade_bonus:IsDebuff()
	return true
end

function modifier_silence_blade_bonus:IsPurgable()
	return true
end

function modifier_silence_blade_bonus:GetEffectName()
	return "particles/econ/items/silencer/silencer_ti6/silencer_last_word_ti6_silence.vpcf"
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
	local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_INVISIBILITY_LEVEL, MODIFIER_EVENT_ON_ABILITY_EXECUTED, MODIFIER_EVENT_ON_ATTACK_LANDED, MODIFIER_EVENT_ON_ATTACK_ALLIED  }
	return funcs
end

function modifier_silence_blade_shadow_walk:CheckState()
	local states = { [MODIFIER_STATE_INVISIBLE] = true }
	return states 
end

function modifier_silence_blade_shadow_walk:GetModifierMoveSpeedBonus_Percentage()
	return 30
end

function modifier_silence_blade_shadow_walk:GetModifierInvisibilityLevel()
	return 100
end

function modifier_silence_blade_shadow_walk:OnAttackLanded(event)
	local caster = self:GetParent()
	local target = caster:GetAttackTarget()

	caster:RemoveModifierByName("modifier_silence_blade_shadow_walk")

	target:AddNewModifier(caster,self:GetAbility(),"modifier_silence_blade_bonus",{duration = 2.8})
	caster:RemoveModifierByName("modifier_silence_blade_shadow_walk")

	local damage_table = { victim = target, attacker = caster, damage = 220, damage_type = DAMAGE_TYPE_PHYSICAL }
	ApplyDamage(damage_table)
end

function modifier_silence_blade_shadow_walk:OnAbilityExecuted()
	local caster = self:GetParent()
	local target = caster:GetAttackTarget()

	caster:RemoveModifierByName("modifier_silence_blade_shadow_walk")
end