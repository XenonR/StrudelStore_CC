local addonName = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN", false);
if L then
--Messages
L["WelcomeMessage"]= "感谢你使用StrudelStore |cFFFFFF00" .. GetAddOnMetadata(addonName,"Version"); --Do not change the text after the |
L["SlashCommandMessage1"]= "|cFF99CCFFStrudelstore " .. GetAddOnMetadata(addonName, "Version");
L["SlashCommandMessage2"]= "可用以下命令：";
L["SlashCommandMessage3"]= "|cFF99CCFF Syntax: |r  /Strudelstore [command] 或者 /Strudel [command]";
L["SlashCommandMessage4"]= "|cFF99CCFF Settings/Options |r  --Shows the option pane"; --Do not change text before --
L["SlashCommandMessage5"]= "|cFF99CCFF Show |r  --Shows the main pane"; --Do not change text before --
L["SlashCommandMessage6"]= "|cFF99CCFF Hide |r --Hides the main pane"; --Do not change text before --
L["CombatError"]= "|cFF99CCFF[StrudelStore]|r 你不能在战斗中这么做";
L["NeutralMessage"]= "You must choose a faction first";
--Labels
L["ConjureFrameTitle"] = "消耗品";
L["ConjureFrameSubTitle"] = "消耗品";
L["TeleportFrameTitle"] = "传送";
L["PortalFrameTitle"] = "传送门";
L["OptionFrameTitle"] = "Strudelstore设置";
--Buttons -> Main
L["SettingsButton"]= "设置";
L["CloseButton"]="关闭";
L["ConjureTabButton"] = "消耗品";
L["PortalTabButton"] = "传送";
L["TeleportTabButton"] = "传送门";
--Buttons/Labels -> Optionpane
 L["InstructionsMinimap"] = "L点击鼠标左键StrudelStore窗口 \n 右键单击设置";
 L["LayoutLabel"] = "布局";
 L["ShowPortalTab"] = "显示门户选项卡";
 L["ShowTeleportTab"] = "显示瞬移“选项卡";
 L["Opacity"] = "不透明度";
 L["ResetPosition"] = "复位位置";
 L["ShowOnLogon"] = "显示在登录";
 L["ShowMinimap"] = "显示小地图按钮";
 L["CheckMinimap_ToolTip"] = "Show or hide the minimap button";
 L["CheckLogon_ToolTip"] = "Checking this will make StrudelStore appear after you have logged on to World of Warcraft";
 L["ResetPos_ToolTip"] = "Resets the position of the StrudelStore window back to the center";
 L["SetLayout_ToolTip"] = "Set the current layout for the StrudelStore window";
 L["SlideLayout_ToolTip"] = "Set the opacity of the StrudelStore window";
 L["CheckTab2_ToolTip"] = "Show or hide the portal tab";
 L["CheckTab3_ToolTip"] = "Show or hide the teleport tab";
 end
