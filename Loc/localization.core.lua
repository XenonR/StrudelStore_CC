local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true);
if L then
--Messages
L["WelcomeMessage"]= "Thank you for using StrudelStore |cFFFFFF00" .. GetAddOnMetadata(addonName,"Version"); --Do not change the text after the |
L["SlashCommandMessage1"]= "|cFF99CCFFStrudelstore " .. GetAddOnMetadata(addonName, "Version");
L["SlashCommandMessage2"]= "The following commands are available:";
L["SlashCommandMessage3"]= "|cFF99CCFF Syntax: |r  /Strudelstore [command] or /Strudel [command]";
L["SlashCommandMessage4"]= "|cFF99CCFF Settings/Options |r  --Shows the option pane"; --Do not change text before --
L["SlashCommandMessage5"]= "|cFF99CCFF Show |r  --Shows the main pane"; --Do not change text before --
L["SlashCommandMessage6"]= "|cFF99CCFF Hide |r --Hides the main pane"; --Do not change text before --
L["CombatError"]= "|cFF99CCFF[StrudelStore]|r You can't do that in combat.";
L["NeutralMessage"]= "You must choose a faction first";
--Titles
L["ConjureFrameTitle"] = "Conjuring";
L["TeleportFrameTitle"] = "Teleports";
L["PortalFrameTitle"] = "Portals";
L["OptionFrameTitle"] = "STRUDELSTORE SETTINGS";
--Buttons -> Main
L["SettingsButton"]= "Settings";
L["CloseButton"]="Close";
L["ConjureTabButton"] = "Conjuring";
L["PortalTabButton"] = "Portals";
L["TeleportTabButton"] = "Teleports";

--Buttons/Labels -> 
 L["GeneralGroup"] = "General";
 L["DisplayGroup"] = "Display";
 L["SizeGroup"] = "Sizing";

 L["InstructionsMinimap"] = "Left click for StrudelStore window. \nRight click for settings";
 L["LayoutLabel"] = "Layout";
 L["ShowPortalTab"] = "Show Portal Tab";
 L["ShowTeleportTab"] = "Show Teleport Tab";
 L["Opacity"] = "Opacity";
 L["ResetPosition"] = "Reset Position";
 L["ShowOnLogon"] = "Show on login";
 L["ShowMinimap"] = "Show minimap button";
 L["MaxInRow"] = "Spells per row";
 L["CollapseAnchor"] = "Collapse anchor";
 L["SpellOffsetX"] = "Spell offset (Horizontal)";
 L["SpellOffsetY"] = "Spell offset (Vertical)";
 L["HideReagentCount"] = "Hide reagent counter";
 L["HideSpell"] = "Hide spell (Experimental)";
 L["RestoreHiddenSpells"] = "Restore hidden spells (Experimental)";
 L["CheckMinimap_ToolTip"] = "Show or hide the minimap button";
 L["CheckLogon_ToolTip"] = "StrudelStore window opens on login";
 L["ResetPos_ToolTip"] = "Resets the position of the StrudelStore window back to the center";
 L["SetLayout_ToolTip"] = "Set the current layout for the StrudelStore window";
 L["SlideLayout_ToolTip"] = "Set the opacity of the StrudelStore window";
 L["CheckTab2_ToolTip"] = "Show or hide the portal tab";
 L["CheckTab3_ToolTip"] = "Show or hide the teleport tab";
 L["MaxInRow_ToolTip"] = "Sets the amount of spells to show per row";
 L["CollapseAnchor_ToolTip"] = "Sets the anchor for the window";
 L["HideReagentCount_ToolTip"] = "Show or hide the reagent counter on the spell buttons";
 L["HideSpell_ToolTip"] = "Hide a spell from the UI (by spell id)";
 L["RestoreHiddenSpells_ToolTip"] = "Restore any hidden spells";
 end
