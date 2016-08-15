function mana_attack(keys)
	local manapct = keys.ability:GetLevelSpecialValueFor("manapct",keys.ability:GetLevel())
	local damageTable = {
				victim = keys.target,
				attacker = keys.caster,
				damage = ((keys.caster:GetMaxMana() / 100) * manapct),
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
	ApplyDamage(damageTable)
end