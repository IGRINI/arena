function Base(keys)
	local target = keys.target()
	local ability = keys.ability()
	local kills = target:GetKills()
	local caster = keys.caster()
	local deaths = target:GetDeaths()
	local dpk = keys.dpk
	local dpd = keys.dpd
	local duration = keys.duration

	if kills == nil then
	killls = 1
	end

	if deaths == nil then
	deaths = 1
	end

	local damage = (kills * dpk / (deaths * dpd) / duration)
	local damage_table = { victim = target,attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL }
	ApplyDamage(damage_table)
end