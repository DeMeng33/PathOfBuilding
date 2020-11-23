if not loadStatFile then
	dofile("statdesc.lua")
end
loadStatFile("stat_descriptions.txt")

local itemClassMap = {
	["LifeFlask"] = "Flask",
	["ManaFlask"] = "Flask",
	["HybridFlask"] = "Flask",
	["Amulet"] = "Amulet",
	["Ring"] = "Ring",
	["Claw"] = "Claw",
	["Dagger"] = "Dagger",
	["Wand"] = "Wand",
	["One Hand Sword"] = "One Handed Sword",
	["Thrusting One Hand Sword"] = "Thrusting One Handed Sword",
	["One Hand Axe"] = "One Handed Axe",
	["One Hand Mace"] = "One Handed Mace",
	["Bow"] = "Bow",
	["Staff"] = "Staff",
	["Two Hand Sword"] = "Two Handed Sword",
	["Two Hand Axe"] = "Two Handed Axe",
	["Two Hand Mace"] = "Two Handed Mace",
	["Quiver"] = "Quiver",
	["Belt"] = "Belt",
	["Gloves"] = "Gloves",
	["Boots"] = "Boots",
	["Body Armour"] = "Body Armour",
	["Helmet"] = "Helmet",
	["Shield"] = "Shield",
	["Sceptre"] = "Sceptre",
	["UtilityFlask"] = "Flask",
	["UtilityFlaskCritical"] = "Flask",
	["Map"] = "Map",
	["Jewel"] = "Jewel",
	["Rune Dagger"] = "Dagger",
	["Warstaff"] = "Staff",
}
local out = io.open("../Data/ModMaster.lua", "w")
out:write('-- This file is automatically generated, do not edit!\n')
out:write('-- Item data (c) Grinding Gear Games\n\nreturn {\n')
for _, craft in ipairs(dat("CraftingBenchOptions"):GetRowList("IsDisabled", false)) do
	if craft.Mod then
		out:write('\t{ ')
		if craft.Mod.GenerationType == 1 then
			out:write('type = "Prefix", ')
		elseif craft.Mod.GenerationType == 2 then
			out:write('type = "Suffix", ')
		end
		out:write('affix = "', craft.Mod.Name, '", ')
		local stats, orders = describeMod(craft.Mod)
		out:write('modTags = { ', stats.modTags, ' }, ')
		out:write('"', table.concat(stats, '", "'), '", ')
		out:write('statOrder = { ', table.concat(orders, ', '), ' }, ')
		out:write('level = ', craft.Mod.Level, ', group = "', craft.Mod.Family, '", ')
		out:write('types = { ')
		for _, category in ipairs(craft.ItemCategories) do
			for _, itemClass in ipairs(category.ItemClasses) do
				out:write('["', itemClassMap[itemClass.Id], '"] = true, ')
			end
		end
		out:write('}, ')
		out:write('},\n')
	end
end
out:write('}')
out:close()

print("Master mods exported.")