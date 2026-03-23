local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU", false);
if L then
--Messages
L["WelcomeMessage"]= "Благодарим вас за использование StrudelStore |cFFFFFF00" .. GetAddOnMetadata(addonName,"Version"); --Do not change the text after the |
L["SlashCommandMessage1"]= "|cFF99CCFFStrudelstore " .. GetAddOnMetadata(addonName, "Version");
L["SlashCommandMessage2"]= "Доступны следующие команды:";
L["SlashCommandMessage3"]= "|cFF99CCFF Syntax: |r  /Strudelstore [command] или /Strudel [command]";
L["SlashCommandMessage4"]= "|cFF99CCFF Settings/Options |r  --Shows the option pane"; --Do not change text before --
L["SlashCommandMessage5"]= "|cFF99CCFF Show |r  --Shows the main pane"; --Do not change text before --
L["SlashCommandMessage6"]= "|cFF99CCFF Hide |r --Hides the main pane"; --Do not change text before --
L["CombatError"]= "|cFF99CCFF[StrudelStore]|r Вы не можете сделать это в бою.";
L["NeutralMessage"]= "Вы должны выбрать фракцию";
--Labels
L["ConjureFrameTitle"] = "Сотворение";
L["ConjureFrameSubTitle"] = "Выберете ваш напиток/еду";
L["TeleportFrameTitle"] = "Телепорты";
L["PortalFrameTitle"] = "Порталы";
L["OptionFrameTitle"] = "Настройки Strudelstore";
--Buttons -> Main
L["SettingsButton"]= "Настройки";
L["CloseButton"]="Закрыть";
L["ConjureTabButton"] = "Сотворение";
L["PortalTabButton"] = "Порталы";
L["TeleportTabButton"] = "Телепорты";
--Buttons/Labels -> Optionpane
 L["InstructionsMinimap"] = "Щелкните левой кнопкой мыши для StrudelStore окна. \nщелкните правой кнопкой мыши для настройки";
 L["LayoutLabel"] = "Layout";
 L["ShowPortalTab"] = "показать портала вкладке";
 L["ShowTeleportTab"] = "показать телепорт вкладке";
 L["Opacity"] = "непрозрачность";
 L["ResetPosition"] = "сброс позиции";
 L["ShowOnLogon"] = "показать на Войти";
 L["ShowMinimap"] = "показать мини кнопку";
 L["CheckMinimap_ToolTip"] = "Show or hide the minimap button";
 L["CheckLogon_ToolTip"] = "Checking this will make StrudelStore appear after you have logged on to World of Warcraft";
 L["ResetPos_ToolTip"] = "Resets the position of the StrudelStore window back to the center";
 L["SetLayout_ToolTip"] = "Set the current layout for the StrudelStore window";
 L["SlideLayout_ToolTip"] = "Set the opacity of the StrudelStore window";
 L["CheckTab2_ToolTip"] = "Show or hide the portal tab";
 L["CheckTab3_ToolTip"] = "Show or hide the teleport tab";
 end
