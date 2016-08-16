if ss_equality == nil then
	ss_equality = class({})
end
LinkLuaModifier("modifier_equality_enemy","heroes/ss/equality",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_equality_caster","heroes/ss/equality",LUA_MODIFIER_MOTION_NONE)
function ss_equality:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_4
end
function ss_equality:CastFilterResultTarget( hTarget )
	if hTarget:IsCreep() or hTarget:IsAncient() then
		return UF_FAIL_CUSTOM
	end
	if hTarget:GetTeam() == self:GetCaster():GetTeam() then
		return UF_FAIL_FRIENDLY
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
function ss_equality:GetCustomCastErrorTarget( hTarget )
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
function ss_equality:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local duration = self:GetLevelSpecialValueFor("duration",self:GetLevel())
	hCaster:AddNewModifier(hCaster,self,"modifier_equality_caster",{duration = duration})
	hTarget:AddNewModifier(hCaster,self,"modifier_equality_enemy",{duration = duration})
end

if modifier_equality_enemy == nil then
	modifier_equality_enemy = class({})
end
function modifier_equality_enemy:IsHidden()
	return false
end
function modifier_equality_enemy:IsDebuff()
	return true
end
function modifier_equality_enemy:IsPurgable()
	return false
end
function modifier_equality_enemy:GetTexture()
	return "storm_spirit_static_remnant"
end
function modifier_equality_enemy:OnCreated( kv )
	if IsServer() then
		self.target = self:GetAbility():GetCursorTarget()
		self.maxmana = self.target:GetMaxMana()
		self.pct = self:GetAbility():GetSpecialValueFor("mana")
	end
end
function modifier_equality_enemy:OnRefresh( kv )
	if IsServer() then
		self.target = self:GetAbility():GetCursorTarget()
		self.maxmana = self.target:GetMaxMana()
		self.pct = self:GetAbility():GetSpecialValueFor("mana")
	end
end
function modifier_equality_enemy:GetAttributes ()
    return MODIFIER_ATTRIBUTE_PERMANENT
end
function modifier_equality_enemy:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_BONUS
	}
	return funcs
end
function modifier_equality_enemy:GetModifierManaBonus()
	return -((self.maxmana/100)*self.pct)
end

if modifier_equality_caster == nil then
	modifier_equality_caster = class({})
end
function modifier_equality_caster:IsHidden()
	return false
end
function modifier_equality_caster:IsDebuff()
	return false
end
function modifier_equality_caster:IsPurgable()
	return false
end
function modifier_equality_caster:GetTexture()
	return "storm_spirit_static_remnant"
end
function modifier_equality_caster:OnCreated( kv )
	if IsServer() then
		self.target = self:GetAbility():GetCursorTarget()
		self.maxmana = self.target:GetMaxMana()
		self.pct = self:GetAbility():GetSpecialValueFor("mana")
	end
end
function modifier_equality_caster:OnRefresh( kv )
	if IsServer() then
		self.target = self:GetAbility():GetCursorTarget()
		self.maxmana = self.target:GetMaxMana()
		self.pct = self:GetAbility():GetSpecialValueFor("mana")
	end
end
function modifier_equality_caster:GetAttributes ()
    return MODIFIER_ATTRIBUTE_PERMANENT
end
function modifier_equality_caster:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_BONUS
	}
	return funcs
end
function modifier_equality_caster:GetModifierManaBonus()
	return ((self.maxmana/100)*self.pct)
end