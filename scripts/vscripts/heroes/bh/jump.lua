if bh_jump == nil then
	 bh_jump = class({})
end
function bh_jump:GetCastAnimation()  
    return ACT_DOTA_CAST_ABILITY_1  
end
function bh_jump:CastFilterResultTarget( hTarget )
	if hTarget:HasModifier("modifier_markenemy") or hTarget:HasModifier("modifier_markfriend") then
		return UF_SUCCESS
	else
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
function bh_jump:GetCustomCastErrorTarget( hTarget )
	if hTarget:HasModifier("modifier_markenemy") or hTarget:HasModifier("modifier_markfriend") then
		return ""
	elseif self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	elseif hTarget:IsAncient() then
		return "#dota_hud_error_cant_cast_on_ancient"
	elseif hTarget:IsCreep() then
		return "#dota_hud_error_cant_cast_on_creep"
	elseif hTarget:IsMagicImmune() then
		return "#dota_hud_error_target_magic_immune"
	else
		return "#error_cant_have_mark"
	end
	return ""
end
function bh_jump:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability = self
	local ability_level = ability:GetLevel()
	local abs = target:GetAbsOrigin()
	local damage = ability:GetLevelSpecialValueFor("damage",ability_level)
	if target:HasModifier("modifier_markenemy") or target:HasModifier("modifier_markfriend") then
		Timers:CreateTimer({
    		endTime = 0.3,
    		callback = function()
      			if target:GetTeamNumber() ~= caster:GetTeamNumber() then
					caster:SetAbsOrigin(abs)
					FindClearSpaceForUnit(caster, abs, true)
					local damageTable = {
						victim = target,
						attacker = caster,
						damage = damage,
						damage_type = DAMAGE_TYPE_MAGICAL,
					}
					ApplyDamage(damageTable)
				else
					caster:SetAbsOrigin(abs)
					FindClearSpaceForUnit(caster, abs, true)
				end
    		end
  		})
	end
end