if ss_manaburn == nil then
	ss_manaburn = class({})
end
function ss_manaburn:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_2
end
function ss_manaburn:CastFilterResultTarget( hTarget )
	if hTarget:IsCreep() or hTarget:IsAncient() then
		return UF_FAIL_CUSTOM
	end
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end
	if hTarget:IsMagicImmune() then
		return UF_FAIL_CUSTOM
	end
	local nResult = UnitFilter( hTarget, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, self:GetCaster():GetTeamNumber() )
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end
function ss_manaburn:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
	if hTarget:IsAncient() then
		return "#dota_hud_error_cant_cast_on_ancient"
	end
	if hTarget:IsCreep() then
		return "#dota_hud_error_cant_cast_on_creep"
	end
	if hTarget:IsMagicImmune() then
		return "#dota_hud_error_target_magic_immune"
	end
	return ""
end
function ss_manaburn:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local max_mana_caster = caster:GetMaxMana()
	local current_mana_target = target:GetMana()
	local level = self:GetLevel()
	local manapct = self:GetLevelSpecialValueFor("manapct",level)
	local msg = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn_msg.vpcf"
	local burn = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf"
	local life = 2.0
	print(level)
	if caster:HasScepter() then
		local manapct = self:GetLevelSpecialValueFor("manapctscptr",level)
	end
	local manaburn = math.min(current_mana_target, max_mana_caster / 100 * manapct)
	local string = string.len( math.floor( manaburn ) ) + 1
	target:ReduceMana(manaburn)
	damageTable = {
		victim = target,
		attacker = caster,
		damage = manaburn,
		damage_type = DAMAGE_TYPE_MAGICAL,
	}
	ApplyDamage( damageTable )

	local numbers = ParticleManager:CreateParticle( msg, PATTACH_OVERHEAD_FOLLOW, target )
	ParticleManager:SetParticleControl( numbers, 1, Vector( 1, manaburn, 0 ) )
    ParticleManager:SetParticleControl( numbers, 2, Vector( life, string, 0 ) )
	local burnpart = ParticleManager:CreateParticle( burn, PATTACH_ABSORIGIN, target )
	
	-- Create timer to properly destroy particles
	Timers:CreateTimer( life, function()
			ParticleManager:DestroyParticle( numbers, false )
			ParticleManager:DestroyParticle( burnpart, false)
			return nil
		end
	)
end