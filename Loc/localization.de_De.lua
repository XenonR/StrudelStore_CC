local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "deDE", false);
if L then
--Messages
L["WelcomeMessage"]= "Danke das du StrudelStore |cFFFFFF00" .. C_AddOns(addonName,"Version") .." benutzt"; --Do not change the text after the |
L["SlashCommandMessage1"]= "|cFF99CCFFStrudelstore " .. C_AddOns(addonName, "Version");
L["SlashCommandMessage2"]= "Die folgenden Befehle stehen zur Verfügung:";
L["SlashCommandMessage3"]= "|cFF99CCFF Syntax: |r  /Strudelstore [command] oder /Strudel [command]";
L["SlashCommandMessage4"]= "|cFF99CCFF Settings/Options |r  *Shows the option pane"; --Do not change text before *
L["SlashCommandMessage5"]= "|cFF99CCFF Show |r  *Shows the main pane"; --Do not change text before *
L["SlashCommandMessage6"]= "|cFF99CCFF Hide |r *Hides the main pane"; --Do not change text before *
L["CombatError"]= "|cFF99CCFF[StrudelStore]|r *Sie können das nicht im Kampf."; --Do not change text before *
L["NeutralMessage"]= "Usted debe elegir una facción";
--Labels
L["ConjureFrameTitle"] = "Herbeizaubern";
L["ConjureFrameSubTitle"] = "Wähle deine Erfrischung";
L["TeleportFrameTitle"] = "Teleporter";
L["PortalFrameTitle"] = "Portale";
L["OptionFrameTitle"] = "Strudelstore Einstellungen";
--Buttons -> Main
L["SettingsButton"]= "Einstellungen";
L["CloseButton"]="Schließen";
L["ConjureTabButton"] = "Herbeizaubern";
L["PortalTabButton"] = "Portale";
L["TeleportTabButton"] = "Teleporter";

--Buttons/Labels -> Optionpane
L["InstructionsMinimap"] = "Linksklick für Fenster.\n Recht für Einstellungen klicken";
L["LayoutLabel"] = "Layout";
L["ShowPortalTab"] = "Zeig Portale Tab";
L["ShowTeleportTab"] = "Zeig Teleporter Tab";
L["Opacity"] = "Undurchsichtigkeit";
L["ResetPosition"] = "Position Rücksetzen";
L["ShowOnLogon"] = "Zeigen bei der Anmeldung";
L["ShowMinimap"] = "Zeig minimap Knopf";
L["CheckMinimap_ToolTip"] = "Show or hide the minimap button";
L["CheckLogon_ToolTip"] = "Checking this will make StrudelStore appear after you have logged on to World of Warcraft";
L["ResetPos_ToolTip"] = "Resets the position of the StrudelStore window back to the center";
L["SetLayout_ToolTip"] = "Set the current layout for the StrudelStore window";
L["SlideLayout_ToolTip"] = "Set the opacity of the StrudelStore window";
L["CheckTab2_ToolTip"] = "Show or hide the portal tab";
L["CheckTab3_ToolTip"] = "Show or hide the teleport tab";
 end
