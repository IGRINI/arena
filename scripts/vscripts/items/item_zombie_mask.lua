if item_zombie_mask == nil then
	item_zombie_mask = class({})
end

LinkLuaModifier("modifier_zombie_mask","items/item_zombie_mask",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zombie_mask_buff","items/item_zombie_mask",LUA_MODIFIER_MOTION_NONE)

function item_zombie_mask:GetIntrinsicModifierName()
	return "modifier_zombie_mask"
end

function item_zombie_mask:OnSpellStart(event)
	print('spell started')
	local caster = self:GetCaster()
	caster:AddNewModifier(caster,self,"modifier_zombie_mask_buff",{duration = 7.2})
end
-------------------------------------------------------------------------------------------------

if modifier_zombie_mask == nil then
	modifier_zombie_mask = class({})
end

function modifier_zombie_mask:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_MULTIPLE 
end

function modifier_zombie_mask:IsHidden()
	return true
end

function modifier_zombie_mask:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_SPELL_START
	}
	return funcs
end

function modifier_zombie_mask:OnAttackLanded(event)
	print('attack landed')
	local attacker = event.attacker
	local caster = self:GetCaster()
	if attacker == self:GetParent() then
		local target = event.target
		local lifestealS = 0

		if attacker:GetPrimaryAttribute() == 0 then
			lifestealS = attacker:GetBaseStrength() - attacker:GetBaseStrength() / 3
		elseif attacker:GetPrimaryAttribute() == 1 then
			lifestealS = attacker:GetBaseAgility() - attacker:GetBaseAgility() / 3
		else
			lifestealS = attacker:GetBaseIntellect() - attacker:GetBaseIntellect() / 3
		end

		if lifestealS <= 0 then
			lifestealS = 0
		end

		local lifesteal = (12 + lifestealS) * event.damage * 0.01

		if caster:HasModifier("modifier_zombie_mask_buff") then
			lifesteal = lifesteal * 1.5
		end

		attacker:Heal(lifesteal,self)

		local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControlEnt(particle, 0, attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	end
end

function modifier_zombie_mask:IsPurgable()
	return false
end

function modifier_zombie_mask:GetModifierBonusStats_Strength(params)
	local levelpower = 15 + (self:GetParent():GetLevel() * 1.5)
	if self:GetParent():HasModifier("modifier_zombie_mask_buff") then
		levelpower = levelpower * 2.3
	end
	
	return levelpower
end
function modifier_zombie_mask:GetModifierBonusStats_Agility(params)
	local levelpower = 15 + (self:GetParent():GetLevel() * 1.5)
	if self:GetParent():HasModifier("modifier_zombie_mask_buff") then
		levelpower = levelpower * 2.3
	end
	
	return levelpower
end
function modifier_zombie_mask:GetModifierBonusStats_Intellect(params)
	local levelpower = 15 + (self:GetParent():GetLevel() * 1.5)
	if self:GetParent():HasModifier("modifier_zombie_mask_buff") then
		levelpower = levelpower * 2.3
	end
	
	return levelpower
end
function modifier_zombie_mask:GetModifierPreAttack_BonusDamage(params)
	local levelpower = 15 + (self:GetParent():GetLevel() * 1.5)
	if self:GetParent():HasModifier("modifier_zombie_mask_buff") then
		levelpower = levelpower * 2.3
	end
	
	return levelpower
end

----------------------------------------------------------------------------------------

if modifier_zombie_mask_buff == nil then
	modifier_zombie_mask_buff = class({})
end

function modifier_zombie_mask_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function modifier_zombie_mask_buff:IsPurgable()
	return true
end

function modifier_zombie_mask_buff:IsHidden()
	return false
end

function modifier_zombie_mask_buff:GetTexture()
	return	"item_zombie_mask"
end