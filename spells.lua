local addonName = ...
local addon = _G[addonName]
local spells = {}
addon.spells = spells

--Alliance
local portalSpellsAlliance = {10059, 11416, 11419, 32266,
33691, 53142, 49360, 88345, 132620, 176246, 120146, 224871, 281400, 344597, 395289, 446534, 1259194 };

local teleportSpellsAlliance = {3561, 3562, 3565, 32271,
33690, 53140, 49359, 88342, 132621, 176248, 120145, 224869, 281403, 193759, 344587, 395277, 446540, 1259190 };

--Horde
local portalSpellsHorde = {11417, 11420, 11418, 32267,
35717, 53142, 49361, 88346, 132626, 176244, 120146, 224871, 281402, 344597, 395289, 446534, 1259194 };

local teleportSpellsHorde = {3567, 3566, 3563, 32272,
35715, 53140, 49358, 88344, 132627, 176242, 120145, 224869, 281404, 193759, 344587, 395277, 446540, 1259190 };

--Conjuring
local conjuringSpells = {
	--Food
	587, 597, 990, 6129, 10144, 10145, 28612, 33717,
	--Water
	5504, 5505, 5506, 6127, 10138, 10139, 10140, 37420, 27090,
	--Mana gem
	759, 3552, 10053, 10054, 27101, 42985
};


function spells.InitializeSpellTables()
	if UnitFactionGroup("player") == "Alliance" then
		spells.conjuringSpells = conjuringSpells;
		spells.portalSpells = portalSpellsAlliance;
		spells.teleportSpells = teleportSpellsAlliance;
	elseif UnitFactionGroup("player") == "Horde" then
		spells.conjuringSpells = conjuringSpells;
		spells.portalSpells = portalSpellsHorde;
		spells.teleportSpells = teleportSpellsHorde;
	else
		addon:Print("Please choose a faction first")
	end
end



function spells.GetSpellRank(spellId)
	--Manual rank assignment due to nil value in GetSpellInfo
	local ranksForSpell = {
		[587] = 1, --Food Rank 1
		[597] = 2, --Food Rank 2
		[990] = 3, --Food Rank 3
		[6129] = 4, --Food Rank 4
		[10144] = 5, --Food Rank 5
		[10145] =  6, --Food Rank 6
		[28612] =  7, --Food Rank 7
		[33717] =  8, --Food Rank 8

		[5504] = 1, --Water Rank 1
		[5505] = 2, --Water Rank 2
		[5506] = 3, --Water Rank 3
		[6127] = 4, --Water Rank 4
		[10138] = 5, --Water Rank 5
		[10139] =  6, --Water Rank 6
		[10140] =  7, --Water Rank 7
		[37420] =  8, --Water Rank 8
		[27090] =  9, --Water Rank 9
	}
	return ranksForSpell[spellId]
end