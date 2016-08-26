require('libraries/timers')

if item_black_crest == nil then
	item_black_crest = class({})
end

LinkLuaModifier("item_black_crest_passive","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_aura_emmiter_t","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_aura_emmiter","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_aura_team","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_aura_enemy","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_freeze","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_armor","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_black_crest_disarmor","items/item_black_crest.lua",LUA_MODIFIER_MOTION_NONE)

function item_black_crest:GetIntrinsicModifierName()
	return "item_black_crest_passive"
end

function item_black_crest:OnSpellStart(  )
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()
	local duration = 5
	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		target:AddNewModifier(caster,self,"modifier_black_crest_freeze",{duration = 1})
		target:AddNewModifier(caster,self,"modifier_black_crest_disarmor",{duration = 5})
	elseif target:GetTeamNumber() == caster:GetTeamNumber() then
		if target == caster then
			caster:SetMana(caster:GetMana()+self:GetManaCost(self:GetLevel()))
			duration = 0
			self:EndCooldown()
		end
		target:AddNewModifier(caster,self,"modifier_black_crest_armor",{duration = duration})
	end
end

---------------------------------------------------------------------------------------------------------

if item_black_crest_passive == nil then
	item_black_crest_passive = class({})
end

function item_black_crest_passive:IsHidden(  )
	return true
end

function item_black_crest_passive:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_EVASION_CONSTANT,
					MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, 
					MODIFIER_PROPERTY_HEALTH_BONUS, 
					MODIFIER_PROPERTY_MANA_BONUS, 
					MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
					MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, 
					MODIFIER_PROPERTY_STATS_AGILITY_BONUS, 
					MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE }
	return funcs
end

function item_black_crest_passive:OnCreated(  )
	self.mp_hp = 666
	self.int = 80
	self.stats = 50
	self.regen = 100


	self:GetParent():AddNewModifier(self:GetParent(),self:GetAbility(),"modifier_black_crest_aura_emmiter",{duration = -1})
	self:GetParent():AddNewModifier(self:GetParent(),self:GetAbility(),"modifier_black_crest_aura_emmiter_t",{duration = -1})

	Timers:CreateTimer(0,function()
		if self:GetAbility():IsCooldownReady() then
			self:GetParent():AddNewModifier(self:GetParent(),self:GetAbility(),"modifier_black_crest_armor",{duration = -1})
		else
			self:GetParent():RemoveModifierByName("modifier_black_crest_armor")
		end
		return 0.2
	end)
end

function item_black_crest_passive:OnDestroy(  )
	self:GetParent():RemoveModifierByName("modifier_black_crest_aura_emmiter")
	self:GetParent():RemoveModifierByName("modifier_black_crest_aura_emmiter_t")
	self:GetParent():RemoveModifierByName("modifier_black_crest_armor")
end

function item_black_crest_passive:GetModifierManaBonus(  )
	return self.mp_hp
end

function item_black_crest_passive:GetModifierHealthBonus(  )
	return self.mp_hp
end

function item_black_crest_passive:GetModifierBonusStats_Intellect(  )
	return self.int
end

function item_black_crest_passive:GetModifierBonusStats_Strength(  )
	return self.stats
end

function item_black_crest_passive:GetModifierBonusStats_Agility(  )
	return self.stats
end

function item_black_crest_passive:GetModifierPercentageManaRegen(  )
	return self.regen
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
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_black_crest_aura_emmiter_t:GetAuraSearchType()
	types = { DOTA_UNIT_TARGET_CREEP,DOTA_UNIT_TARGET_HERO }
    return types
end

function modifier_black_crest_aura_emmiter_t:GetAuraDuration()
    return 0.5
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
   
function modifier_black_crest_aura_emmiter:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_black_crest_aura_emmiter:GetAuraSearchType()
    types = { DOTA_UNIT_TARGET_CREEP,DOTA_UNIT_TARGET_HERO }
    return types
end

function modifier_black_crest_aura_emmiter:GetAuraDuration()
    return 0.5
end

----------------------------------------------------------------------------------------------------------

if modifier_black_crest_freeze == nil then
	modifier_black_crest_freeze = class({})
end

function modifier_black_crest_freeze:GetEffectAttachType(  )
	return PATTACH_ABSORIGIN
end

function modifier_black_crest_freeze:GetEffectName(  )
	return "particles/econ/events/league_teleport_2014/teleport_end_ground_drop_league.vpcf"
end

function modifier_black_crest_freeze:CheckState()
	local states = { [MODIFIER_STATE_HEXED] = true, [MODIFIER_STATE_STUNNED] = true }
	return states
end

function modifier_black_crest_freeze:GetTexture(  )
	return "item_black_crest"
end

-----------------------------------------------------------------------------------------------------

if modifier_black_crest_aura_team == nil then
	modifier_black_crest_aura_team = class({})
end

function modifier_black_crest_aura_team:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_EVASION_CONSTANT,MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
	return funcs
end

function modifier_black_crest_aura_team:GetModifierEvasion_Constant(  )
	return 5
end

function modifier_black_crest_aura_team:GetModifierAttackSpeedBonus_Constant(  )
	return 75
end

function modifier_black_crest_aura_team:GetTexture(  )
	return "item_black_crest"
end

if modifier_black_crest_aura_enemy == nil then
	modifier_black_crest_aura_enemy = class({})
end

function modifier_black_crest_aura_enemy:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_MISS_PERCENTAGE }
	return funcs
end

function modifier_black_crest_aura_enemy:GetTexture(  )
	return "item_black_crest"
end

function modifier_black_crest_aura_enemy:IsDebuff(  )
	return true
end

function modifier_black_crest_aura_enemy:GetModifierMiss_Percentage(  )
	return 5
end

function modifier_black_crest_aura_enemy:GetModifierAttackSpeedBonus_Constant(  )
	return -75
end

-----------------------------------------------------------------------------------------------------

if modifier_black_crest_disarmor == nil then
	modifier_black_crest_disarmor = class({})
end

function modifier_black_crest_disarmor:GetEffectAttachType(  )
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_black_crest_disarmor:GetEffectName(  )
	return "particles/items2_fx/medallion_of_courage_b.vpcf"
end

function modifier_black_crest_disarmor:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,MODIFIER_PROPERTY_MISS_PERCENTAGE }
	return funcs
end

function modifier_black_crest_disarmor:IsDebuff(  )
	return true
end

function modifier_black_crest_disarmor:IsPurgable(  )
	return true
end

function modifier_black_crest_disarmor:GetTexture(  )
	return "item_black_crest"
end

function modifier_black_crest_disarmor:GetModifierPhysicalArmorBonus(  )
	return -30
end

function modifier_black_crest_disarmor:GetModifierMiss_Percentage(  )
	return 30
end

--------------------------------------------------------------------------------------------------------

if modifier_black_crest_armor == nil then
	modifier_black_crest_armor = class({})
end

function modifier_black_crest_armor:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,MODIFIER_PROPERTY_EVASION_CONSTANT }
	return funcs
end

function modifier_black_crest_armor:GetEffectName(  )
	return "particles/items2_fx/medallion_of_courage_friend.vpcf"
end

function modifier_black_crest_armor:GetEffectAttachType(  )
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_black_crest_armor:GetModifierPhysicalArmorBonus(  )
	return 30
end

function modifier_black_crest_armor:GetModifierEvasion_Constant(  )
	return 30
end

function modifier_black_crest_armor:IsPurgable(  )
	return true
end

function modifier_black_crest_armor:GetTexture(  )
	return "item_black_crest"
end