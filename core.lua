------
--Definitions
------

--Setup keybinding strings for bindings.xml
_G["BINDING_HEADER_STRUDELSTORE"] = "StrudelStore"
_G["BINDING_NAME_STRUDELSTORE_OPEN_SHOW"] = "Open/close StrudelStore window"

--Load addon and libraries
local addonName = ...
_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0","AceConsole-3.0");

local addon = _G[addonName];
local _, _, _, interfaceVersion = GetBuildInfo()
interfaceVersion = tonumber(interfaceVersion) or 0

local projectId = WOW_PROJECT_ID
addon.isRunningMainline = (projectId and projectId == WOW_PROJECT_MAINLINE) or (not projectId and interfaceVersion >= 100000)
addon.isRunningClassicEra = (projectId and projectId == WOW_PROJECT_CLASSIC) or (not projectId and interfaceVersion > 0 and interfaceVersion < 20000)
addon.isRunningTbc = (projectId and projectId == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) or (not projectId and interfaceVersion >= 20000 and interfaceVersion < 30000)
addon.isRunningWrath = (projectId and projectId == WOW_PROJECT_WRATH_CLASSIC) or (not projectId and interfaceVersion >= 30000 and interfaceVersion < 40000)
addon.isRunningCata = (projectId and projectId == WOW_PROJECT_CATACLYSM_CLASSIC) or (not projectId and interfaceVersion >= 40000 and interfaceVersion < 50000)
addon.isRunningMoP = (projectId and projectId == WOW_PROJECT_MISTS_CLASSIC) or (not projectId and interfaceVersion >= 50000 and interfaceVersion < 60000)

addon.conjuringRanksExist = addon.isRunningWrath or addon.isRunningTbc or addon.isRunningClassicEra

addon.config = LibStub("AceConfig-3.0");
addon.helpers = {}
addon.gui = {}
addon.spells = {}

--Default database values
local AddonDB_Defaults = {
  char = {
	startupshow = true,
	minimap = {
		hide = false,
	},
	display = {
		spellOffsetX = 2,
		spellOffsetY = 2,
		maxInRow = 5,
		collapseAnchor = "TOPRIGHT",
		hiddenSpells = {}
	}
  },
}

if addon.conjuringRanksExist then
	AddonDB_Defaults.char.display.selectedTab = 1;
else
	AddonDB_Defaults.char.display.selectedTab = 2;
end

--------
--Initialization
--------

--Initializing the Addon
function addon:OnInitialize()
	self = self or addon
	local function refreshPlayerSpells(eventName, unitTarget)
		if unitTarget == nil or unitTarget == "player" then
			self:HandleSpellEvents(eventName)
		end
	end

	if AddonCompartmentFrame then
		--Register addon in addon compartment
		AddonCompartmentFrame:RegisterAddon({
			text = addonName,
			icon = "Interface\\Icons\\INV_Misc_Food_73CinnamonRoll",
			notCheckable = true,
			func = function(button, menuInputData, menu)
				if Settings and Settings.OpenToCategory then
					Settings.OpenToCategory(addon.config.optionsPaneCategoryId);
				elseif InterfaceOptionsFrame_OpenToCategory then
					InterfaceOptionsFrame_OpenToCategory(addon.config.optionsPaneCategoryId);
					InterfaceOptionsFrame_OpenToCategory(addon.config.optionsPaneCategoryId);
				end
			end,
		});
	end

	--Register post initialize events
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("BAG_UPDATE", function(eventName) self:HandleSpellEvents(eventName) end);
	self:RegisterEvent("SPELLS_CHANGED", function(eventName)
		self:HandleSpellEvents(eventName)
	end);
	self:RegisterEvent("UNIT_POWER_UPDATE", refreshPlayerSpells);
	self:RegisterEvent("UNIT_MANA", refreshPlayerSpells);
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", refreshPlayerSpells);

	--Setup db and config
	self.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	self.config:SetupConfig();

	--Print welcome message
	local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true);
	self:Print("|cFF99CCFF [StrudelStore] |r" .. L["WelcomeMessage"]);

	self:IntializeFrames();
end

--Intialize the frames of the addon
function addon:IntializeFrames()
	--Create gui
	self.gui:BuildGui();

	if self.db.char.startupshow then
		self.gui.mainframe:Show();
		self.gui.mainCollapsedBtn:Hide();
	else
		self.gui.mainframe:Hide();
		self.gui.mainCollapsedBtn:Show();
	end
end

function addon:PLAYER_ENTERING_WORLD()
	--These parts need to be called here to make sure faction and spell data is available

	--Initialize the spell tables based on faction
	self.spells.InitializeSpellTables();
	--Populate the tabs with spells
	self.gui:PopulateTabs();

	--This only needs to be called and set up once per addon load, so unregister this event here.
	self:UnregisterEvent("PLAYER_ENTERING_WORLD");
end

function addon:HandleSpellEvents(eventName)
	self.gui:UpdateAllTabs();
end
