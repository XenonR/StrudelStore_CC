local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES", false);
if L then
--Messages
L["WelcomeMessage"]= "Gracias por usar StrudelStore |cFFFFFF00" .. GetAddOnMetadata(addonName,"Version"); --Do not change the text after the |
L["SlashCommandMessage1"]= "|cFF99CCFFStrudelstore " .. GetAddOnMetadata(addonName, "Version");
L["SlashCommandMessage2"]= "Los siguientes comandos están disponibles:";
L["SlashCommandMessage3"]= "|cFF99CCFF Syntax: |r  /Strudelstore [command] or /Strudel [command]";
L["SlashCommandMessage4"]= "|cFF99CCFF Settings/Options |r  *Shows the option pane"; --Do not change text before *
L["SlashCommandMessage5"]= "|cFF99CCFF Show |r  *Shows the main pane"; --Do not change text before *
L["SlashCommandMessage6"]= "|cFF99CCFF Hide |r *Hides the main pane"; --Do not change text before *
L["CombatError"]= "|cFF99CCFF[StrudelStore]|r *You can't do that in combat."; --Do not change text before *
L["NeutralMessage"]= "Usted debe elegir una facción";
--Labels
L["ConjureFrameTitle"] = "MAGIA";
L["ConjureFrameSubTitle"] = "Elige tu refrigerio";
L["TeleportFrameTitle"] = "TELETRANSPORTES";
L["PortalFrameTitle"] = "PORTALES";
L["OptionFrameTitle"] = "AJUSTES DE STRUDELSTORE";
--Buttons -> Main
L["SettingsButton"]= "Ajustes";
L["CloseButton"]="Cerrar";
L["ConjureTabButton"] = "Magia";
L["PortalTabButton"] = "Portales";
L["TeleportTabButton"] = "Teletrans";
--Buttons/Labels -> Optionpane
 L["InstructionsMinimap"] = "Pulse el botón izquierdo para ventana StrudelStore. \nHaga clic para ajustes";
 L["LayoutLabel"] = "Diseño";
 L["ShowPortalTab"] = "Mostrar pestaña de portal";
 L["ShowTeleportTab"] = "Mostrar pestaña de teletransporte";
 L["Opacity"] = "Opacidad";
 L["ResetPosition"] = "Restaurar posición";
 L["ShowOnLogon"] = "Mostrar al conectar";
 L["ShowMinimap"] = "Mostrar botón en el minimapa";
  L["CheckMinimap_ToolTip"] = "Show or hide the minimap button";
 L["CheckLogon_ToolTip"] = "Checking this will make StrudelStore appear after you have logged on to World of Warcraft";
 L["ResetPos_ToolTip"] = "Resets the position of the StrudelStore window back to the center";
 L["SetLayout_ToolTip"] = "Set the current layout for the StrudelStore window";
 L["SlideLayout_ToolTip"] = "Set the opacity of the StrudelStore window";
 L["CheckTab2_ToolTip"] = "Show or hide the portal tab";
 L["CheckTab3_ToolTip"] = "Show or hide the teleport tab";
 end
