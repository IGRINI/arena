function modifier_item_orb_of_legacy_on_orb_impact(keys)	
	if keys.target.GetInvulnCount == nil then
		if keys.target:HasModifier("modifier_item_orb_of_legacy_ranged") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_orb_of_legacy_ranged", nil)
		elseif keys.target:HasModifier("modifier_item_orb_of_legacy_melee") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_orb_of_legacy_melee", nil)
		else
			if keys.caster:IsRangedAttacker() then
				keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_orb_of_legacy_ranged", nil)
			else
				keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_orb_of_legacy_melee", nil)
			end
		end
	end
end
function modifier_item_orb_of_legacy_on_interval_think(keys)	
	local damage_to_deal = keys.PoisonDamagePerSecond * keys.PoisonDamageInterval
	local current_hp = keys.caster:GetHealth()
	ApplyDamage({victim = keys.target, attacker = keys.caster, damage = damage_to_deal, damage_type = DAMAGE_TYPE_MAGICAL,})
end
function modifier_item_orb_of_legacy_lifesteal_on_orb_impact(keys)
	if keys.target.GetInvulnCount == nil then
 		keys.ability:ApplyDataDrivenModifier(keys.attacker, keys.attacker, "modifier_item_orb_of_legacy_lifesteal", {duration = 0.03})
	end
end