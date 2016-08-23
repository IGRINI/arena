function Base(keys)
	local caster = keys.caster
	local ability = keys.ability
	local str = "modifier_attribute_boost_stats_stacks"

	if not caster:HasModifier(str) then
		ability:ApplyDataDrivenModifier(caster, caster, str, {})
	elseif caster:HasModifier(str) then
		local stacks = caster:GetModifierStackCount(str, caster)
		caster:SetModifierStackCount(str, caster, stacks + 1)
	end
end