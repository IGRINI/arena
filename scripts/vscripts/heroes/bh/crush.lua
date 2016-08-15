if bh_crush == nil then
	bh_crush = class({})
end
LinkLuaModifier( "modifier_bh_crush","heroes/bh/crush",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_crush_bush","heroes/bh/crush",LUA_MODIFIER_MOTION_NONE)
function bh_crush:GetIntrinsicModifierName()
	return "modifier_bh_crush"
end
function bh_crush:IsRefreshable()
	return false
end

if modifier_bh_crush == nil then
	modifier_bh_crush = class({})
end
function modifier_bh_crush:IsHidden()
	return true
end
function modifier_bh_crush:OnCreated( kv )
	self.bash = self:GetAbility():GetSpecialValueFor( "bash" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.level = self:GetAbility():GetLevel()
	self.cooldown = self:GetAbility():GetCooldown(self.level)
end
function modifier_bh_crush:OnRefresh( kv )
	self.bash = self:GetAbility():GetSpecialValueFor( "bash" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.level = self:GetAbility():GetLevel()
	self.cooldown = self:GetAbility():GetCooldown(self.level)
end
function modifier_bh_crush:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end
function modifier_bh_crush:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
			if self:GetParent():PassivesDisabled() then
				return 0
			end
			local target = params.target
			local damageTable = {
				victim = params.target,
				attacker = params.attacker,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			if target:IsMagicImmune() then
				return 0
			else
				if self:GetAbility():IsCooldownReady() then
					if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() and target:HasModifier("modifier_markenemy") then
						ApplyDamage(damageTable)
						target:AddNewModifier(params.attacker,self,"modifier_crush_bush",{duration = self.bash})
						self:GetAbility():StartCooldown(self.cooldown)
					end
				end
			end
		end
	end
	return 0
end

if modifier_crush_bush == nil then
	modifier_crush_bush = class({})
end
function modifier_crush_bush:IsDebuff()
	return true
end
function modifier_crush_bush:IsStunDebuff()
	return true
end
function modifier_crush_bush:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
function modifier_crush_bush:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_crush_bush:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
 
	return funcs
end
function modifier_crush_bush:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end
function modifier_crush_bush:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}
 
	return state
end
