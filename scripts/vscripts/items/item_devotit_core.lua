LinkLuaModifier("modifier_item_devotit_core", "items/modifier_item_devotit_core.lua", LUA_MODIFIER_MOTION_NONE)

function OnEquip(keys)
	keys.caster:AddNewModifier(keys.caster, nil, "modifier_item_devotit_core", {duration = -1})
end