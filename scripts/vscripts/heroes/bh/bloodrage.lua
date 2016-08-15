if bh_bloodrage == nil then
	 bh_bloodrage = class({})
end
LinkLuaModifier( "modifier_bh_bloodrage","heroes/bh/bloodrage",LUA_MODIFIER_MOTION_NONE)
function bh_bloodrage:GetCastAnimation()  
    return ACT_DOTA_CAST_ABILITY_2  
end
function bh_bloodrage:OnSpellStart()
	local caster = self:GetCaster()
	local level = self:GetLevel()
	local duration = self:GetLevelSpecialValueFor("duration",level)
	caster:AddNewModifier(caster,self,"modifier_bh_bloodrage",{duration = duration})
end
function bh_bloodrage:IsRefreshable()
	return false
end

if modifier_bh_bloodrage == nil then
	modifier_bh_bloodrage = class({})
end
function modifier_bh_bloodrage:IsHidden()
	return false
end
function modifier_bh_bloodrage:OnCreated( kv )
	self.caster = self:GetAbility():GetCaster()
	self.stacks = self:GetAbility():GetCaster():GetModifierStackCount("modifier_stacks", self.caster)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.ms = self:GetAbility():GetSpecialValueFor("ms")
	self.as = self:GetAbility():GetSpecialValueFor("as")
end
function modifier_bh_bloodrage:OnRefresh( kv )
	self.caster = self:GetAbility():GetCaster()
	self.stacks = self:GetAbility():GetCaster():GetModifierStackCount("modifier_stacks", self.caster)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.ms = self:GetAbility():GetSpecialValueFor("ms")
	self.as = self:GetAbility():GetSpecialValueFor("as")
end
function modifier_bh_bloodrage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_MAX,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end
function modifier_bh_bloodrage:GetModifierAttackSpeedBonus_Constant()
	return self.as + self.stacks * self.as
end
function modifier_bh_bloodrage:GetModifierPreAttack_BonusDamage()
	return self.damage + self.stacks * self.damage
end
function modifier_bh_bloodrage:GetModifierMoveSpeed_Max()
	return 1000
end
function modifier_bh_bloodrage:GetModifierMoveSpeed_Limit()
	return 1000
end
function modifier_bh_bloodrage:GetModifierMoveSpeedBonus_Percentage()
	return self.ms + self.stacks * self.ms
end