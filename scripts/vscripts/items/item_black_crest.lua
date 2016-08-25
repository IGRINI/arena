if item_black_crest == nil then
	item_black_crest = class({})
end

LinkLuaModifier("modifier_black_crest_aura_emmiter_t","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_aura_emmiter","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_aura_team","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_aura_enemy","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_freeze","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_armor","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_disarmor","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)

function item_black_crest:GetIntrinsicModifierName()
	return "modifier_black_crest_aura_emmiter"
end

function item_black_crest:OnSpellStart(  )
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		target:AddNewModifier(caster,self,"modifier_black_crest_freeze",{duration = 1})
	elseif target:GetTeamNumber() == caster:GetTeamNumber() then
		target:AddNewModifier(caster,self,"modifier_black_crest_armor",{duration = 5})
	end
end

function item_black_crest:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_EVASION_CONSTANT, MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_MANA_BONUS, MODIFIER_PROPERTY_STATS_STRENGHT_BONUS, MODIFIER_PROPERTY_STATS_AGILITY_BONUS, MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE }
	return funcs
end

function item_black_crest:OnCreated(  )
	self.mp_hp = 666
	self.int = 80
	self.stats = 50
	self.regen = 100
	self.armor = 30
	self.evasion = 30

	if not self:GetAbility():IsCooldownReady() then
		self.armor = 0
		self.evasion = 0
	elseif self:GetAbility():IsCooldownReady() then
		self.armor = 30
		self.evasion = 30
	end
end

function item_black_crest:OnRefresh(  )
	self.mp_hp = 666
	self.int = 80
	self.stats = 50
	self.regen = 100
	self.armor = 30

	if not self:GetAbility():IsCooldownReady() then
		self.armor = 0
	elseif self:GetAbility():IsCooldownReady() then
		self.armor = 30
	end
end

function item_black_crest:GetModifierManaBonus(  )
	return self.mp_hp
end

function item_black_crest:GetModifierHealthBonus(  )
	return self.mp_hp
end

function item_black_crest:GetModifierBonusStats_Intellect(  )
	return self.int
end

function item_black_crest:GetModifierBonusStats_Strength(  )
	return self.stats
end

function item_black_crest:GetModifierBonusStats_Agility(  )
	return self.stats
end

function item_black_crest:GetModifierPercentageManaRegen(  )
	return self.regen
end

function item_black_crest:GetModifierPhysicalArmorBonus(  )
	return self.armor
end

function item_black_crest:GetModifierEvasion_Constant(  )
	return self.evasion
end

---------------------------------------------------------------------------------------------------------

if modifier_black_crest_aura_emmiter_t == nil then
	modifier_black_crest_aura_emmiter_t = class({})
end

function modifier_black_crest_aura_emmiter_t:IsAura()
	return true
end

function modifier_black_crest_aura_emmiter_t:IsPurgable()
    return false
end

function modifier_black_crest_aura_emmiter_t:IsHidden()
	return true
end

function modifier_black_crest_aura_emmiter_t:GetAuraRadius()
    return 900
end

function modifier_black_crest_aura_emmiter_t:GetModifierAura()
    return "modifier_black_crest_aura_team"
end
   
function modifier_black_crest_aura_emmiter_t:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_black_crest_aura_emmiter_t:GetAuraSearchType()
	types = { DOTA_UNIT_TARGET_CREEP,DOTA_UNIT_TARGET_HERO }
    return types
end

function modifier_black_crest_aura_emmiter_t:GetAuraDuration()
    return 0.1
end

---------------------------------------------------------------------------------------------------------

if modifier_black_crest_aura_emmiter == nil then
	modifier_black_crest_aura_emmiter = class({})
end

function modifier_black_crest_aura_emmiter:IsAura()
	return true
end

function modifier_black_crest_aura_emmiter:IsPurgable()
    return false
end

function modifier_black_crest_aura_emmiter:IsHidden()
	return true
end

function modifier_black_crest_aura_emmiter:GetAuraRadius()
    return 900
end

function modifier_black_crest_aura_emmiter:GetModifierAura()
    return "modifier_black_crest_aura_enemy"
end
   
function modifier_black_crest_aura_emmiter_t:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_black_crest_aura_emmiter:GetAuraSearchType()
    types = { DOTA_UNIT_TARGET_CREEP,DOTA_UNIT_TARGET_HERO }
    return types
end

function modifier_black_crest_aura_emmiter:GetAuraDuration()
    return 0.1
end

----------------------------------------------------------------------------------------------------------

if modifier_black_crest_freeze == nil then
	modifier_black_crest_freeze = class({})
end

function modifier_black_crest_freeze:CheckState()
	local states = { [MODIFIER_STATE_HEXED] = true, [MODIFIER_STATE_STUNNED] = true }
	return states
end

function modifier_black_crest_freeze:OnCreated(  )
	local target = self:GetParent()
	local caster = self:GetAbility():GetCaster()
	target:AddNewModifier(caster,self:GetAbility(),"modifier_black_crest_disarmor",{duration = 5})
end

function modifier_black_crest_freeze:OnRefresh(  )
	local target = self:GetParent()
	local caster = self:GetAbility():GetCaster()
	target:AddNewModifier(caster,self:GetAbility(),"modifier_black_crest_disarmor",{duration = 5})
end

-----------------------------------------------------------------------------------------------------

if modifier_black_crest_aura_team == nil then
	modifier_black_crest_aura_team = class({})
end

function modifier_black_crest_aura_team:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_EVASION_CONSTANT }
	return funcs
end

function modifier_black_crest_aura_team:GetModifierEvasion_Constant(  )
	return self:GetAbility():GetSpecialValueFor("special_aura")
end

if modifier_black_crest_aura_enemy == nil then
	modifier_black_crest_aura_enemy = class({})
end

function modifier_black_crest_aura_enemy:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_MISS_PERCENTAGE }
	return funcs
end

function modifier_black_crest_aura_enemy:GetModifierMiss_Percentage(  )
	return self:GetAbility():GetSpecialValueFor("special_aura")
end

-----------------------------------------------------------------------------------------------------

if modifier_black_crest_disarmor == nil then
	modifier_black_crest_disarmor = class({})
end

function modifier_black_crest_disarmor:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,MODIFIER_PROPERTY_MISS_PERCENTAGE }
	return funcs
end

function modifier_black_crest_disarmor:GetModifierPhysicalArmorBonus(  )
	return self:GetAbility():GetSpecialValueFor("disarmor")
end

function modifier_black_crest_disarmor:GetModifierMiss_Percentage(  )
	return self:GetAbility():GetSpecialValueFor("miss")
end

--------------------------------------------------------------------------------------------------------

if modifier_black_crest_armor == nil then
	modifier_black_crest_armor = class({})
end

function modifier_black_crest_armor:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,MODIFIER_PROPERTY_EVASION_CONSTANT }
	return funcs
end

function modifier_black_crest_armor:GetModifierPhysicalArmorBonus(  )
	return self:GetAbility():GetSpecialValueFor("armor")
end

function modifier_black_crest_armor:GetModifierEvasion_Constant(  )
	return self:GetAbility():GetSpecialValueFor("miss")
end