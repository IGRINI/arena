if bh_mark == nil then
	bh_mark = class({})
end
LinkLuaModifier("modifier_markenemy","heroes/bh/mark",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_markfriend","heroes/bh/mark",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stacks","heroes/bh/mark",LUA_MODIFIER_MOTION_NONE)
function bh_mark:GetCooldown( nLevel )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "coldownscepter" )
	end
	return self.BaseClass.GetCooldown( self, nLevel )
end
function bh_mark:GetCastAnimation()  
    return ACT_DOTA_CAST_ABILITY_4  
end
function bh_mark:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end
	if hTarget:IsCreep() or hTarget:IsAncient() then
		return UF_FAIL_CUSTOM
	end
	local nResult = UnitFilter( hTarget, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, self:GetCaster():GetTeamNumber() )
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end
function bh_mark:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
	if hTarget:IsAncient() then
		return "#dota_hud_error_cant_cast_on_ancient"
	end
	if hTarget:IsCreep() then
		return "#dota_hud_error_cant_cast_on_creep"
	end
	return ""
end
function bh_mark:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hAbility = self
	local duration = self:GetSpecialValueFor("duration")
	local durationscepter = self:GetSpecialValueFor("scepterduration")
	if hTarget ~= nil then
		if hTarget:HasModifier("modifier_markenemy") or hTarget:HasModifier("modifier_markfriend") then
			local kek
		else
			local current_stack = hCaster:GetModifierStackCount("modifier_stacks", hCaster)
			if not hCaster:HasModifier("modifier_stacks") then
    			hCaster:AddNewModifier(hCaster,hAbility,"modifier_stacks",{})
			end
			if hCaster:HasScepter() then
				Timers:CreateTimer({
    					endTime = durationscepter,
    					callback = function()
    						local stacks = hCaster:GetModifierStackCount("modifier_stacks", hCaster)
    						if stacks == 1 then
    							hCaster:RemoveModifierByName("modifier_stacks")
    						else
    							hCaster:SetModifierStackCount("modifier_stacks", hCaster, stacks - 1)
    						end
    					end
  					})
			else
				Timers:CreateTimer({
    					endTime = duration,
    					callback = function()
    						local stacks = hCaster:GetModifierStackCount("modifier_stacks", hCaster)
    						if stacks == 1 then
    							hCaster:RemoveModifierByName("modifier_stacks")
    						else
    							hCaster:SetModifierStackCount("modifier_stacks", hCaster, stacks - 1)
    						end
    					end
  					})
			end
			hCaster:SetModifierStackCount("modifier_stacks", hCaster, current_stack + 1)
		end
		if hTarget:GetTeam() ~= hCaster:GetTeam() then
			if hCaster:HasScepter() then
				hTarget:AddNewModifier(hCaster,hAbility,"modifier_markenemy",{duration = durationscepter})
			else
				hTarget:AddNewModifier(hCaster,hAbility,"modifier_markenemy",{duration = duration})
			end
		else
			if hCaster:HasScepter() then
				hTarget:AddNewModifier(hCaster,hAbility,"modifier_markfriend",{duration = durationscepter})
			else
				hTarget:AddNewModifier(hCaster,hAbility,"modifier_markfriend",{duration = duration})
			end
		end
	end
end

if modifier_markenemy == nil then
	modifier_markenemy = class({})
end
function modifier_markenemy:IsHidden()
	return false
end
function modifier_markenemy:IsDebuff()
	return true
end
function modifier_markenemy:IsPurgable()
	return true
end
function modifier_markenemy:GetTexture()
	return "bh_mark"
end
function modifier_markenemy:CheckState()
	local state = {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
	return state
end
function modifier_markenemy:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_markenemy:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
	return funcs
end
function modifier_markenemy:GetModifierMoveSpeedBonus_Percentage()
	return -5
end

if modifier_markfriend == nil then
	modifier_markfriend = class({})
end
function modifier_markfriend:IsHidden()
	return false
end
function modifier_markfriend:IsDebuff()
	return false
end
function modifier_markfriend:IsPurgable()
	return true
end
function modifier_markfriend:GetTexture()
	return "bh_mark"
end
function modifier_markfriend:OnCreated( kv )
	self.regen = self:GetAbility():GetSpecialValueFor( "regen" )
	self.scepterregen = self:GetAbility():GetSpecialValueFor( "scepterregen" )
end
function modifier_markfriend:OnRefresh( kv )
	self.regen = self:GetAbility():GetSpecialValueFor( "regen" )
	self.scepterregen = self:GetAbility():GetSpecialValueFor( "scepterregen" )
end
function modifier_markfriend:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_markfriend:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end
function modifier_markfriend:GetModifierConstantHealthRegen()
	if self:GetCaster():HasScepter() then
		return self.scepterregen
	else
		return self.regen
	end
end

if modifier_stacks == nil then
	modifier_stacks = class({})
end
function modifier_stacks:IsHidden()
	return false
end
function modifier_stacks:IsDebuff()
	return false
end
function modifier_stacks:IsPurgable()
	return false
end
function modifier_stacks:GetAttributes ()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end