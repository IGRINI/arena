if modifier_zombie_mask == nil then
	modifier_zombie_mask = class({})
end

function modifier_zombie_mask:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
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
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_zombie_mask:OnAttackLanded(event)
	print('attack landed')
	local attacker = event.attacker
	if attacker == self:GetParent() then
		local target = event.target
		local lifestealS = 0
		print('lifesteal')

		if attacker:GetPrimaryAttribute() == 0 then
			lifestealS = attacker:GetBaseStrength() - attacker:GetBaseStrength() / 3
		elseif attacker:GetPrimaryAttribute() == 1 then
			lifestealS = attacker:GetBaseAgility() - attacker:GetBaseAgility() / 3
		else
			lifestealS = attacker:GetBaseIntellect() - attacker:GetBaseIntellect() / 3
		end
		print(lifestealS)

		if lifestealS <= 0 then
			lifestealS = 0
		end

		local lifesteal = (12 + lifestealS) * event.damage * 0.01

		attacker:Heal(lifesteal,self)

		local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControlEnt(particle, 0, attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
        else print('lol 2')
	end
end

function modifier_zombie_mask:IsPurgable()
	return false
end

function modifier_zombie_mask:GetModifierBonusStats_Strength(params)
	return 15
end
function modifier_zombie_mask:GetModifierBonusStats_Agility(params)
	return 15
end
function modifier_zombie_mask:GetModifierBonusStats_Intellect(params)
	return 15
end
function modifier_zombie_mask:GetModifierPreAttack_BonusDamage(params)
	return 15
end