function modifier_slark_counter_hit_on_take_hit(keys)
	local caster = keys.caster
	local attacker = keys.attacker
	local ability = keys.ability
	local dmgPrc = keys.dmgpRc
	local damage = caster:GetAttackDamage() * (dmgPrc / 100)
	local agi_1 = "modifier_slark_counter_agi_1"
	local agi_2 = "modifier_slark_counter_agi_2"
	local agi_3 = "modifier_slark_counter_agi_3"
	local texture = nil
	local agi = keys.agiperstack
	local baseAgi = caster:GetBaseAgility()

	if 1 < ability:GetLevel( ) < 3 then
		texture = agi_1
	elseif 3 < ability:GetLevel() < 6 then
		texture = agi_2
	else 
		texture = agi_3
	end

	local current_stack = caster:GetModifierStackCount(texture, caster)
	local ApS = agi * current_stack

	if ability:IsCooldownReady() then

		if not attacker:IsHero() and not attacker:IsTower() then

			ApplyDamage({ victim = attacker, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = ability })
			ability:StartCooldown(keys.ability:GetCooldown(keys.ability:GetLevel()))

			if not caster:HasModifier(texture) then
				ability:ApplyDataDrivenModifier(caster, caster, texture, {})
			else
				caster:SetModifierStackCount(texture, caster, current_stack + 1)
			end
		end
	end

	if attacker:IsHero() then
		ApplyDamage({ victim = attacker, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = ability })
	end
end

function Base(keys)
	if keys.caster:HasItemInInventory("item_agi_booster") or keys.caster:HasItemInInventory("item_eternal_booster") or keys.caster:HasItemInInventory("item_ultimate_booster") and keys.ability:IsCooldownReady() then
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_slark_counter_chance_item", {duration = -1})
		keys.caster:RemoveModifierByName("modifier_slark_counter_chance")
	else
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_slark_counter_chance", {duration = -1})
		keys.caster:RemoveModifierByName("modifier_slark_counter_chance_item")
	end		
end

function modifier_slark_counter_hit_on_take_hit_item(keys)
	local caster = keys.caster
	local attacker = keys.attacker
	local ability = keys.ability
	local dmgPrc = keys.dmgpRc_item
	local damage = caster:GetAttackDamage() * (dmgPrc / 100)
	local texture = "modifier_slark_counter_success"
	local agi = keys.agiperstack
	local baseAgi = caster:GetBaseAgility()

	local current_stack = caster:GetModifierStackCount(texture, caster)
	local ApS = agi * current_stack

	if ability:IsCooldownReady() then

		if not attacker:IsHero() and not attacker:IsTower() then

			caster:PerformAttack(target, true, true, true, true, false)

			if not caster:HasModifier(texture) then
				ability:ApplyDataDrivenModifier(caster, caster, texture, {})
			else
				caster:SetModifierStackCount(texture, caster, current_stack + 1)
			end
		end
	end

	if attacker:IsHero() then
		caster:PerformAttack(attacker, true, true, true, true, false)
		attacker:PerformTaunt()
	end
end