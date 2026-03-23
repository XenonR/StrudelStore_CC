local addonName = ...
local addon = _G[addonName]
local config = addon.config

--Configuration setup
function config:SetupConfig()
	--Locale loading
	local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true);
	local options = {
		name = L["OptionFrameTitle"],
		handler = config,
		type = 'group',
		args = {
			generalgroup = {
				name = L["GeneralGroup"],
				type = "group",
				order = 0,
				args = {
					onlogin = {
						type = 'toggle',
						name = L["ShowOnLogon"],
						desc = L["CheckLogon_ToolTip"],
						set = 'SetLogonShow',
						get = 'GetLogonShow',
					},
				},
				inline = true,
			},
			displaygroup = {
				name = L["DisplayGroup"],
				type = "group",
				args = {
					collapseAnchor = {
						type = 'select',
						values = {
							["TOPLEFT"] = "Top left",
							["TOPRIGHT"] = "Top right",
							["BOTTOMLEFT"] = "Bottom left",
							["BOTTOMRIGHT"] = "Bottom right",
							["CENTER"] = "Center"
						},
						name = L["CollapseAnchor"],
						desc = L["CollapseAnchor_ToolTip"],
						set = 'SetCollapseAnchor',
						get = 'GetCollapseAnchor',
						order = 0,
					},
					sizegroup = {
						name = L["SizeGroup"],
						type = "group",
						width = "full",
						order = 2,
						args = {
							maxInRow = {
								type = 'range',
								min = 2,
								softMax = 20,
								step = 1,
								name = L["MaxInRow"],
								desc = L["MaxInRow_ToolTip"],
								set = 'SetMaxInRow',
								get = 'GetMaxInRow',
								order = 0,
							},
							spellOffsetX = {
								type = 'range',
								min = 2,
								softMax = 150,
								step = 1,
								name = L["SpellOffsetX"],
								set = 'SetSpellOffsetX',
								get = 'GetSpellOffsetX',
								order = 1,
							},
							spellOffsetY = {
								type = 'range',
								min = 2,
								softMax = 150,
								step = 1,
								name = L["SpellOffsetY"],
								set = 'SetSpellOffsetY',
								get = 'GetSpellOffsetY',
								order = 2,
							}
						},
						inline = true,
					},
					hidereagentcount = {
						type = 'toggle',
						name = L["HideReagentCount"],
						desc = L["HideReagentCount_ToolTip"],
						set = 'SetHideReagentCount',
						get = 'GetHideReagentCount',
						order = 1,
					}
				},
				inline = true,
			},
			experimentalgroup = {
				name = "Experimental",
				type = "group",
				guiHidden = true,
				cmdHidden = false,
				args = {
					hidespell = {
						type = 'execute',
						name = L["HideSpell"],
						desc = L["HideSpell_ToolTip"],
						func = 'HideSpell',
						order = 0
					},
					restorespells = {
						type = 'execute',
						name = L["RestoreHiddenSpells"],
						desc = L["RestoreHiddenSpells_ToolTip"],
						func = 'RestoreHiddenSpells',
						order = 1
					}
				},
				inline = true
			}
		},
	};
	self:RegisterOptionsTable(addonName, options, {"strudel", "strudelstore"});
	local registeredFrame, categoryId = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName,addonName);
	addon.config.optionsPaneCategoryId = categoryId;
end

--Getters and Setters
--Startup
function config:GetLogonShow(info)
    return addon.db.char.startupshow;
end

function config:SetLogonShow(info, input)
    addon.db.char.startupshow = input;
end

--Collapse anchor
function config:GetCollapseAnchor(info)
    return addon.db.char.display.collapseAnchor;
end

function config:SetCollapseAnchor(info, input)
    addon.db.char.display.collapseAnchor = input;
	addon.gui:UpdateCollapseAnchor();
end

--MaxInRow
function config:GetMaxInRow(info)
    return addon.db.char.display.maxInRow;
end

function config:SetMaxInRow(info, input)
    addon.db.char.display.maxInRow = input;
	addon.gui:SizeMainFrame();
end

--SpellOffsetX
function config:GetSpellOffsetX(info)
    return addon.db.char.display.spellOffsetX;
end

function config:SetSpellOffsetX(info, input)
    addon.db.char.display.spellOffsetX = input;
	addon.gui:SizeMainFrame();
end

--SpellOffsetY
function config:GetSpellOffsetY(info)
    return addon.db.char.display.spellOffsetY;
end

function config:SetSpellOffsetY(info, input)
    addon.db.char.display.spellOffsetY = input;
	addon.gui:SizeMainFrame();
end

--HideReagentCount
function config:GetHideReagentCount(info)
    return addon.db.char.display.hideReagentCount;
end

function config:SetHideReagentCount(info, input)
    addon.db.char.display.hideReagentCount = input;
	addon.gui:UpdateAllTabs();
end

--HideSpell
function config:HideSpell(info)
	for spellIdParameter in string.gmatch(info.input, "%S+") do
		local spellId = tonumber(spellIdParameter)
		if spellId ~= nil then
			local spellInfo = GetSpellInfoCompat(spellId);
			if spellInfo then
				table.insert(addon.db.char.display.hiddenSpells, spellId)
				addon:Print("(Experimental)  Hidden spell: ".. spellInfo.name.." (use /reload to see changes)");
			else
				addon:Print("Spell id "..spellId.." not valid");
			end
		end
	end
	addon.gui:UpdateAllTabs();
end

--RestoreHiddenSpells
function config:RestoreHiddenSpells(info)
	addon.db.char.display.hiddenSpells = {}
	addon.gui:UpdateAllTabs();
	addon:Print("(Experimental) Hidden spells are restored (use /reload to see changes)");
end
