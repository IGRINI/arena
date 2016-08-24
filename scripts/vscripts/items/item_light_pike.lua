if item_light_pike == nil then
	item_light_pike = class({})
end

LinkLuaModifier("modifier_light_pike_passive","items/item_light_pike.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_light_pike_chance","items/item_light_pike.lua",LUA_MODIFIER_MOTION_NONE)

function item_light_pike:GetIntrinsicModifierName()
	return "modifier_light_pike_passive"
end

function item_light_pike:OnSpellStart(event)
	if IsServer() then
		if self:IsCooldownReady() then
			local target = self:GetCursorTarget()

			self:StartCooldown(self:GetCooldown(self:GetLevel()))
			target:SetHealth(target:GetHealth() / 2)
		end
	end
end

------------------------------------------------------------------------------------------------

if modifier_light_pike_passive == nil then
	modifier_light_pike_passive = class({})
end

function modifier_light_pike_passive:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_light_pike_passive:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE, MODIFIER_EVENT_ON_ATTACK_LANDED, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
	return funcs
end

function modifier_light_pike_passive:IsHidden(  )
	return true
end

function modifier_light_pike_passive:GetModifierPreAttack_BonusDamage()
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	if not damage == nil then
		damage = damage
	else
		damage = 30
	end
	return damage
end

function modifier_light_pike_passive:GetModifierAttackSpeedBonus_Constant()
	local atk = self:GetAbility():GetSpecialValueFor("atk")
	if not atk == nil then
		atk = atk
	else
		atk = 35
	end
	return atk
end

function modifier_light_pike_passive:GetModifierPhysicalArmorBonus()
	local armor = self:GetAbility():GetSpecialValueFor("armor")
	if not armor == nil then
		armor = armor
	else
		armor = 2
	end
	return armor
end

function modifier_light_pike_passive:OnCreated(kv)
	self.creep_damage = 0
end

function modifier_light_pike_passive:OnRefresh(kv)
	self.creep_damage = 0
end

function modifier_light_pike_passive:OnAttackLanded(event)
	if IsServer() and event.attacker == self:GetParent() then

		local caster = self:GetParent()
		local target = caster:GetAttackTarget()

		if target:IsCreep() then
			if caster:IsRangedAttacker() then
				self.creep_damage = 130
			elseif not caster:IsRangedAttacker() then
				self.creep_damage = 170
			end
		elseif not target:IsCreep() then
			self.creep_damage = 0
		end

		local chance = self:GetAbility():GetSpecialValueFor("chance")
		if not chance == nil then
			chance = chance
		else
			chance = 25
		end

		local duration = self:GetAbility():GetSpecialValueFor("d_duration")
		if not duration == nil then
			duration = duration
		else
			duration = 0.1
		end

		local damage_b = self:GetAbility():GetSpecialValueFor("damage_b")
		if not damage_b == nil then
			damage_b = damage_b
		else
			damage_b = 125
		end


		if RollPercentage(chance) then
			

			target:AddNewModifier(caster,self:GetAbility(),"modifier_light_pike_chance",{duration = duration})
			ApplyDamage({ victim = target, attacker = caster, damage = damage_b, damage_type = DAMAGE_TYPE_PHYSICAL })
		end
	end
end

function modifier_light_pike_passive:GetModifierDamageOutgoing_Percentage()
	return self.creep_damage
end

------------------------------------------------------------------------------------------------

if modifier_light_pike_chance == nil then
	modifier_light_pike_chance = class({})
end

function modifier_light_pike_chance:IsDebuff(  )
	return true
end

function modifier_light_pike_chance:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_light_pike_chance:IsPurgable()
	return false
end

function modifier_light_pike_chance:GetTexture(  )
	return "item_light_pike"
end

function modifier_light_pike_chance:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
	return funcs
end

function modifier_light_pike_chance:GetModifierPhysicalArmorBonus()
	local disarmor = self:GetAbility():GetSpecialValueFor("disarmor")
	if not disarmor == nil then
		disarmor = disarmor
	else
		disarmor = -2
	end
	return disarmor
end