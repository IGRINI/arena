if item_light_pike == nil then
	item_light_pike = class({})
end

LinkLuaModifier("modifier_light_pike_passive","items/item_light_pike.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_light_pike_chance","items/item_light_pike.lua",LUA_MODIFIER_MOTION_NONE)

function item_light_pike:GetIntrinsicModifierName()
	return "modifier_light_pike_passive"
end

function item_light_pike:OnSpellStart()
	if self:IsCooldownReady() and IsServer() then
		local target = self:GetCursorTarget()

		if target:IsTree() then
			self:StartCooldown(self:GetCooldown(self:GetLevel()) / 4)
			target:CutDown(self:GetCaster():GetTeamNumber())
		end

		if target:IsCreep() then
			self:StartCooldown(self:GetCooldown(self:GetLevel()))
			target:SetHealth(target:GetHealth() / 2)
		end
	end
end

------------------------------------------------------------------------------------------------

if modifier_light_pike_passive == nil then
	modifier_light_pike_passive = class({})
end

function modifier_light_pike_passive:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_ATTACK_LANDED, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
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
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	if not damage == nil then
		damage = damage
	else
		damage = 30
	end
	return damage
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

function modifier_light_pike_passive:OnAttackLanded(event)
	if IsServer() then
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

		local damage_b = self:GetAbility():GetSpecialValueFor("d_duration")
		if not damage_b == nil then
			damage_b = damage_b
		else
			damage_b = 125
		end


		if RollPercentage(chance) then
			local caster = self:GetParent()
			local target = caster:GetAttackTarget()

			target:AddNewModifier(caster,self:GetAbility(),"modifier_light_pike_chance",{duration = duration})
			ApplyDamage({ victim = target, attacker = caster, damage = damage_b, damage_type = DAMAGE_TYPE_PHYSICAL })
		end
	end
end

------------------------------------------------------------------------------------------------

if modifier_light_pike_chance == nil then
	modifier_light_pike_chance = class({})
end

function modifier_light_pike_chance:IsDebuff(  )
	return true
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