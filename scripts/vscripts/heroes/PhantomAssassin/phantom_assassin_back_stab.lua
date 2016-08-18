if phantom_assassin_back_stab == nil then
	phantom_assassin_back_stab = class({})
end

LinkLuaModifier("modifier_phantom_assassin_back_stab","heroes/PhantomAssassin/phantom_assassin_back_stab",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_back_stab_b","heroes/PhantomAssassin/phantom_assassin_back_stab",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_back_stab_passive","heroes/PhantomAssassin/phantom_assassin_back_stab",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_back_stab_atk_speed","heroes/PhantomAssassin/phantom_assassin_back_stab",LUA_MODIFIER_MOTION_NONE)

function phantom_assassin_back_stab:IsRefreshable()
	return false
end

function phantom_assassin_back_stab:GetIntrinsicModifierName()
	return "modifier_phantom_assassin_back_stab_passive"
end

------------------------------------------------------------------------------------------------------------------------------------

if modifier_phantom_assassin_back_stab == nil then
	modifier_phantom_assassin_back_stab = class({})
end

function modifier_phantom_assassin_back_stab:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
 
function modifier_phantom_assassin_back_stab:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_phantom_assassin_back_stab:IsDebuff()
	return true
end

function modifier_phantom_assassin_back_stab:IsStunDebuff()
	return true
end

function modifier_phantom_assassin_back_stab:GetTexture()
	return "phantom_assassin_back_stab"
end

function modifier_phantom_assassin_back_stab:IsPurgable()
	return true
end

function modifier_phantom_assassin_back_stab:CheckState()
	local states = { [MODIFIER_STATE_STUNNED] = true }
	return states
end

function modifier_phantom_assassin_back_stab:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
	return funcs
end

function modifier_phantom_assassin_back_stab:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------------------------------------------------------------

if modifier_phantom_assassin_back_stab_passive == nil then
	modifier_phantom_assassin_back_stab_passive = class({})
end

function modifier_phantom_assassin_back_stab_passive:IsHidden()
	return true
end

function modifier_phantom_assassin_back_stab_passive:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_ATTACK_LANDED }
	return funcs
end

function modifier_phantom_assassin_back_stab_passive:OnAttackLanded( params )
	local ability = self:GetAbility()
	local target = self:GetParent():GetAttackTarget()
	local caster = self:GetParent()
	if IsServer() then
		if self:GetParent():PassivesDisabled() then
			return nil
		end
		if params.attacker == self:GetParent() then
			-- The y value of the angles vector contains the angle we actually want: where units are directionally facing in the world.
			local victim_angle = params.target:GetAnglesAsVector().y
			local origin_difference = params.target:GetAbsOrigin() - params.attacker:GetAbsOrigin()

			-- Get the radian of the origin difference between the attacker and Riki. We use this to figure out at what angle the victim is at relative to Riki.
			local origin_difference_radian = math.atan2(origin_difference.y, origin_difference.x)
			
			-- Convert the radian to degrees.
			origin_difference_radian = origin_difference_radian * 180
			local attacker_angle = origin_difference_radian / math.pi
			-- Makes angle "0 to 360 degrees" as opposed to "-180 to 180 degrees" aka standard dota angles.
			attacker_angle = attacker_angle + 180.0
			
			-- Finally, get the angle at which the victim is facing Riki.
			local result_angle = attacker_angle - victim_angle
			result_angle = math.abs(result_angle)
			
			if ability:IsCooldownReady() and ( not self:GetParent():IsIllusion() ) then
				if result_angle >= (180 - (ability:GetSpecialValueFor("backstab_angle") / 2)) and result_angle <= (180 + (ability:GetSpecialValueFor("backstab_angle") / 2)) then
					-- Apply extra backstab damage based on Riki's agility
					ApplyDamage({
						victim = target,
					 	attacker = params.attacker,
					  	damage = ability:GetLevelSpecialValueFor("damage_b",ability:GetLevel()),
					 	damage_type = DAMAGE_TYPE_PURE})
					ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))
					target:AddNewModifier(caster,ability,"modifier_phantom_assassin_back_stab_b",{duration = ability:GetLevelSpecialValueFor("duration_b", ability:GetLevel())})
					if target:IsHero() and target:IsRealHero() then
						self:GetParent():AddNewModifier(caster,ability,"modifier_phantom_assassin_back_stab_atk_speed",{})
						caster:SetModifierStackCount("modifier_phantom_assassin_back_stab_atk_speed",caster, caster:GetModifierStackCount("modifier_phantom_assassin_back_stab_atk_speed", self:GetAbility()) + 2)
					end
				end
			end


			if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
				if not target:IsMagicImmune() then
					local target = params.target
					local caster = self:GetParent()
					local chance = self:GetAbility():GetLevelSpecialValueFor("chance",self:GetAbility():GetLevel())
					local damageTable = {
						victim = params.target,
						attacker = self:GetParent(),
						damage = self:GetAbility():GetLevelSpecialValueFor("damage",self:GetAbility():GetLevel()),
						damage_type = DAMAGE_TYPE_PHYSICAL,}
					if RollPercentage(chance) then
						target:AddNewModifier(caster,ability,"modifier_phantom_assassin_back_stab",{duration = self:GetAbility():GetLevelSpecialValueFor("duration", self:GetAbility():GetLevel())})
						ApplyDamage(damageTable)
					else
						chance = chance + self:GetAbility():GetLevelSpecialValueFor("bonus_chance",self:GetAbility():GetLevel())
						if chance >= 100 then
							chance = 100
						end
					end
				end

			elseif self:GetParent():IsIllusion() and not hTarget:IsMagicImmune() then
				local target = params.target
				local caster = self:GetParent()
				local chance = self:GetAbility():GetLevelSpecialValueFor("chance",self:GetAbility():GetLevel())/2
				local damageTable = {
					victim = params.target,
					attacker = self:GetParent(),
					damage = self:GetAbility():GetLevelSpecialValueFor("damage",self:GetAbility():GetLevel())/3,
					damage_type = DAMAGE_TYPE_PHYSICAL}
				if RollPercentage(chance) then
					target:AddNewModifier(caster,ability,"modifier_phantom_assassin_back_stab",{duration = self:GetAbility():GetLevelSpecialValueFor("duration", self:GetAbility():GetLevel())/3})
					ApplyDamage(damageTable)
				else
					chance = chance + self:GetAbility():GetLevelSpecialValueFor("bonus_chance",self:GetAbility():GetLevel())/2
					if chance >= 50 then
						chance = 50
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------

if modifier_phantom_assassin_back_stab_b == nil then
	modifier_phantom_assassin_back_stab_b = class({})
end

function modifier_phantom_assassin_back_stab_b:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
 
function modifier_phantom_assassin_back_stab_b:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_phantom_assassin_back_stab_b:IsDebuff()
	return true
end

function modifier_phantom_assassin_back_stab_b:IsStunDebuff()
	return true
end

function modifier_phantom_assassin_back_stab_b:IsPurgable()
	return false
end

function modifier_phantom_assassin_back_stab_b:GetTexture()
	return "phantom_assassin_back_stab"
end

function modifier_phantom_assassin_back_stab_b:CheckState()
	local states = { [MODIFIER_STATE_STUNNED] = true }
	return states
end

function modifier_phantom_assassin_back_stab_b:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_EVENT_ON_ATTACK_LANDED }
	return funcs
end

function modifier_phantom_assassin_back_stab_b:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

----------------------------------------------------------------------------------------------------------------------------------------

if modifier_phantom_assassin_back_stab_atk_speed == nil then
	modifier_phantom_assassin_back_stab_atk_speed = class({})
end

function modifier_phantom_assassin_back_stab_atk_speed:IsHidden()
	return false
end

function modifier_phantom_assassin_back_stab_atk_speed:GetTexture()
	return "phantom_assassin_back_stab"
end

function modifier_phantom_assassin_back_stab_atk_speed:IsPurgable()
	return true
end

function modifier_phantom_assassin_back_stab_atk_speed:OnCreated( kv )
	self.speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end
function modifier_phantom_assassin_back_stab_atk_speed:OnRefresh( kv )
	self.speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end

function modifier_phantom_assassin_back_stab_atk_speed:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_ATTACK_LANDED, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT_SECONDARY }
	return funcs
end

function modifier_phantom_assassin_back_stab_atk_speed:GetModifierAttackSpeedBonus_Constant_Secondary()
	if IsServer() then
		return self.speed
	end
	return self.speed
end

function modifier_phantom_assassin_back_stab_atk_speed:OnAttackLanded()
	if IsServer() then
		local stacks = self:GetStackCount()
		self:SetStackCount(stacks - 1)
		if stacks <= 1 then
			self:GetParent():RemoveModifierByName("modifier_phantom_assassin_back_stab_atk_speed")
		end
	end
end