local addonName = ...
local addon = _G[addonName]
local gui = addon.gui

local defaultHighlightTexture = "Interface\\Buttons\\ButtonHilight-Square";
local collapsedButtonTexture = "Interface\\Icons\\INV_Misc_Food_73CinnamonRoll"
local configButtonTexture = "Interface\\Icons\\INV_Misc_Gear_01"
local spellBookType = BOOKTYPE_SPELL or "spell"

local function OpenConfigCategory()
	if Settings and Settings.OpenToCategory then
		Settings.OpenToCategory(addon.config.optionsPaneCategoryId);
	elseif InterfaceOptionsFrame_OpenToCategory then
		InterfaceOptionsFrame_OpenToCategory(addon.config.optionsPaneCategoryId);
		InterfaceOptionsFrame_OpenToCategory(addon.config.optionsPaneCategoryId);
	end
end

local function GetSpellBookSlot(spellId)
	if not (GetNumSpellTabs and GetSpellTabInfo and GetSpellBookItemInfo) then
		return nil
	end

	for tabIndex = 1, GetNumSpellTabs() do
		local _, _, offset, numSlots = GetSpellTabInfo(tabIndex)
		for slot = offset + 1, offset + numSlots do
			local spellType, spellBookSpellId = GetSpellBookItemInfo(slot, spellBookType)
			if spellType == "SPELL" and spellBookSpellId == spellId then
				return slot
			end
		end
	end
end

local function GetSpellCastName(spellInfo)
	if not spellInfo then
		return nil
	end

	if spellInfo.rank and spellInfo.rank ~= "" then
		return spellInfo.name .. "(" .. spellInfo.rank .. ")"
	end

	local normalizedSpellId = spellInfo.spellID or spellInfo.spellId
	local rankNumber = normalizedSpellId and addon.spells.GetSpellRank(normalizedSpellId)
	if rankNumber then
		return string.format("%s(%s %d)", spellInfo.name, RANK or "Rank", rankNumber)
	end

	return spellInfo.name
end

function gui:BuildGui()
	local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true);

	local backdrop = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
		tile = false,
		tileSize = 0,
		edgeSize = 1
	};

	--Create the StrudelStore container frame
	local containerFrame = CreateFrame("Frame", "StrudelStoreContainerFrame", UIParent)
	containerFrame:SetFrameStrata("BACKGROUND");
	containerFrame:SetPoint("CENTER");
	containerFrame:SetClampedToScreen(true);
	containerFrame:SetMovable(true)
	-- Keep the container click-through; the visible child frames handle interaction.
	containerFrame:EnableMouse(false)
	--If there are no store region points, center the frame
	if containerFrame:GetNumPoints() == 0 then
		containerFrame:SetPoint("CENTER");
	end
	containerFrame:Show();

	self.containerFrame = containerFrame;

	--Create the main frame and assign it to the main variable
	local frame = CreateFrame("Frame", "StrudelStoreFrame", containerFrame, BackdropTemplateMixin and "BackdropTemplate")
	self.mainframe = frame;

	--Create the collapsed button
	local collapsedBtn = self:CreateCollapsedButton();
	self.mainCollapsedBtn = collapsedBtn;

	--Setup main frame
	frame:SetFrameStrata("MEDIUM")
	frame:SetBackdrop(backdrop);
	frame:SetBackdropColor(0.1, 0.1, 0.1, 0.6);
	frame:EnableMouse(true);

	--Drag code
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self)
		gui.containerFrame:StartMoving();
		gui.containerFrame.isMoving = true;
	end);

	frame:SetScript("OnDragStop", function(self)
		gui.containerFrame:StopMovingOrSizing();
		gui.containerFrame.isMoving = false;
	end);

	--Header
	frame.titleFrame = CreateFrame("Frame", "$parentTitle", frame);
	frame.titleFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5);
	frame.titleFrame.Text = frame.titleFrame:CreateFontString("$parentText", "OVERLAY", "GameToolTipText");
	frame.titleFrame.Text:SetAllPoints(frame.titleFrame);
	frame.titleFrame.Text:SetText(addonName);

	frame.titleFrame:SetSize(frame.titleFrame.Text:GetStringWidth() + 4,frame.titleFrame.Text:GetStringHeight()); --Resize titleFrame to fit text


	--Create the close button
	frame.closeStrudelButton = CreateFrame("Button", "$parentCloseBtn", frame, "SecureHandlerClickTemplate");
	frame.closeStrudelButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5);
	frame.closeStrudelButton:SetWidth(10);
	frame.closeStrudelButton:SetHeight(10);
	frame.closeStrudelButton:SetNormalTexture("Interface\\BUTTONS\\UI-MinusButton-Up");
	frame.closeStrudelButton:SetPushedTexture("Interface\\BUTTONS\\UI-MinusButton-Down");
	frame.closeStrudelButton:SetHighlightTexture(defaultHighlightTexture);
	frame.closeStrudelButton:SetAttribute("_onclick", [=[
		local frameRef = self:GetFrameRef("strudelFrame");
		frameRef:Hide();

		local btnRef = self:GetFrameRef("collapsedStrudelBtn");
		if not btnRef:IsShown() then
			btnRef:Show();
		end
	]=]);
	frame.closeStrudelButton:SetFrameRef("collapsedStrudelBtn", collapsedBtn);
	frame.closeStrudelButton:SetFrameRef("strudelFrame", frame);

	--Create the config button
	frame.configButton = CreateFrame("Button", "$parentConfigBtn", frame);
	frame.configButton:SetPoint("TOPRIGHT", frame.closeStrudelButton, "TOPLEFT", -5, 0);
	frame.configButton:SetWidth(12);
	frame.configButton:SetHeight(12);
	frame.configButton:SetNormalTexture(configButtonTexture);
	frame.configButton:SetPushedTexture(configButtonTexture);
	frame.configButton:SetHighlightTexture(defaultHighlightTexture);
	frame.configButton:GetPushedTexture():SetVertexColor(0.75, 0.75, 0.75);
	frame.configButton:SetScript("OnClick", function()
		OpenConfigCategory();
	end);

	--Create the tabbar
	frame.tabBar = CreateFrame("Frame", "$parentTabBar", frame);
	frame.tabBar.SetActiveTabIndex = function(tabIndex)
		frame.tabBar.activetabindex = tabIndex;
		addon.db.char.display.selectedTab = tabIndex;
		for i, tab in ipairs(frame.tabs) do
			if i == tabIndex then
				tab:Show();
			else
				tab:Hide();
			end
		end
		self:SizeMainFrame();
	end;
	--frame.tabBar:SetBackdrop(backdrop);
	--frame.tabBar:SetBackdropColor(0.3, 1, 0, 0.6);
	frame.tabBar:SetSize(100,30)
	frame.tabBar:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0,0);

	if addon.conjuringRanksExist then
		frame.tabBar.conjureTabButton = CreateFrame("Button", "$parentConjure", frame.tabBar);
		frame.tabBar.conjureTabButton:SetWidth(30);
		frame.tabBar.conjureTabButton:SetHeight(30);
		frame.tabBar.conjureTabButton:SetPoint("TOPRIGHT", frame.tabBar, "TOPRIGHT", 0,0);
		frame.tabBar.conjureTabButton:SetNormalTexture("Interface\\Icons\\INV_Drink_06");
		frame.tabBar.conjureTabButton:SetHighlightTexture(defaultHighlightTexture);
		frame.tabBar.conjureTabButton:SetScript("OnClick", function()
			frame.tabBar.SetActiveTabIndex(1);
		end);
		frame.tabBar.conjureTabButton:SetScript("OnEnter", function() 
			GameTooltip:SetOwner(frame.tabBar.conjureTabButton, "ANCHOR_BOTTOMRIGHT");
			GameTooltip:SetText(L["ConjureFrameTitle"], nil, nil, nil, 0.5, 1); 
		end);
		frame.tabBar.conjureTabButton:SetScript("OnLeave", function() 
			GameTooltip:Hide();
		end);
	end

	frame.tabBar.portalTabButton = CreateFrame("Button", "$parentPortal", frame.tabBar);
	frame.tabBar.portalTabButton:SetWidth(30);
	frame.tabBar.portalTabButton:SetHeight(30);
	frame.tabBar.portalTabButton:SetNormalTexture("Interface\\Icons\\Spell_Arcane_PortalStormWind");
	frame.tabBar.portalTabButton:SetHighlightTexture(defaultHighlightTexture);
	frame.tabBar.portalTabButton:SetScript("OnClick", function()
		frame.tabBar.SetActiveTabIndex(2);
	end);
	frame.tabBar.portalTabButton:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(frame.tabBar.portalTabButton, "ANCHOR_BOTTOMRIGHT");
		GameTooltip:SetText(L["PortalFrameTitle"], nil, nil, nil, 0.5, 1); 
	end);
	frame.tabBar.portalTabButton:SetScript("OnLeave", function() 
		GameTooltip:Hide();
	end);

	--If addon is running in version where conjuring ranks exist align the button to the existing conjure button.
	--Otherwise align it to the right (since conjure button isn't created when no ranks available)
	if addon.conjuringRanksExist then
		frame.tabBar.portalTabButton:SetPoint("TOPRIGHT", frame.tabBar.conjureTabButton, "TOPLEFT", -5,0);
	else
		frame.tabBar.portalTabButton:SetPoint("TOPRIGHT", frame.tabBar, "TOPRIGHT", 0,0);
	end

	frame.tabBar.teleportTabButton = CreateFrame("Button", "$parentTeleport", frame.tabBar);
	frame.tabBar.teleportTabButton:SetWidth(30);
	frame.tabBar.teleportTabButton:SetHeight(30);
	frame.tabBar.teleportTabButton:SetPoint("TOPRIGHT", frame.tabBar.portalTabButton, "TOPLEFT", -5,0);
	frame.tabBar.teleportTabButton:SetNormalTexture("Interface\\Icons\\Spell_Arcane_TeleportStormWind");
	frame.tabBar.teleportTabButton:SetHighlightTexture(defaultHighlightTexture);
	frame.tabBar.teleportTabButton:SetScript("OnClick", function()
		frame.tabBar.SetActiveTabIndex(3);
	end);
	frame.tabBar.teleportTabButton:SetScript("OnEnter", function() 
		GameTooltip:SetOwner(frame.tabBar.teleportTabButton, "ANCHOR_BOTTOMRIGHT");
		GameTooltip:SetText(L["TeleportFrameTitle"], nil, nil, nil, 0.5, 1); 
	end);
	frame.tabBar.teleportTabButton:SetScript("OnLeave", function() 
		GameTooltip:Hide();
	end);

	--Set all layout points
	frame:SetPoint("TOPLEFT", containerFrame, "TOPLEFT");
	frame:SetPoint("BOTTOMRIGHT", containerFrame, "BOTTOMRIGHT", 0, frame.tabBar:GetHeight());
end

function gui:CreateCollapsedButton()
	--Create the collapsed frame
	local anchorPoint = addon.db.char.display.collapseAnchor;
	local collapsedBtn = CreateFrame("Button", "StrudelStoreCollapsedBtn", self.containerFrame, "SecureHandlerClickTemplate");
	collapsedBtn:SetPoint(anchorPoint);
	collapsedBtn:SetWidth(20);
	collapsedBtn:SetHeight(20);
	collapsedBtn:SetFrameStrata("MEDIUM")
	collapsedBtn:EnableMouse(true)
	collapsedBtn:RegisterForDrag("LeftButton")

	local btnTexture = collapsedBtn:CreateTexture(nil,"OVERLAY",nil,-6)
	btnTexture:SetTexture(collapsedButtonTexture)
	btnTexture:SetAllPoints(collapsedBtn) --make texture same size as button

	collapsedBtn:SetNormalTexture(btnTexture);
	collapsedBtn:SetHighlightTexture(defaultHighlightTexture)
	collapsedBtn:SetAttribute("_onclick", [=[
		mainFrame = self:GetFrameRef("mainFrame");
		if not mainFrame:IsShown() then
			mainFrame:Show();
		end
		self:Hide();
	]=]);
	collapsedBtn:SetFrameRef("mainFrame", self.mainframe);

	--Header Drag code
	collapsedBtn:SetScript("OnDragStart", function(self)
		gui.containerFrame:StartMoving();
		gui.containerFrame.isMoving = true;
	end);

	collapsedBtn:SetScript("OnDragStop", function(self)
		gui.containerFrame:StopMovingOrSizing();
		gui.containerFrame.isMoving = false;
	end);

	collapsedBtn:Show();
	return collapsedBtn;
end

function gui:UpdateCollapseAnchor()
	--Set anchor point
	local anchorPoint = addon.db.char.display.collapseAnchor;
	self.mainCollapsedBtn:ClearAllPoints();
	self.mainCollapsedBtn:SetPoint(anchorPoint, self.containerFrame, anchorPoint, 0, 0);
end

function gui:PopulateTabs()
	local frame = self.mainframe;

	--Create the buttons for the spells
	frame.tabs = {};
	frame.tabs[1] = self:DrawButtonFrame(frame, "$parentButtonFrameConjure", addon.spells.conjuringSpells);
	frame.tabs[2] = self:DrawButtonFrame(frame, "$parentButtonFramePortal", addon.spells.portalSpells);
	frame.tabs[3] = self:DrawButtonFrame(frame, "$parentButtonFrameTeleport", addon.spells.teleportSpells);

	--Make tabs fill parent space
	for _, tab in ipairs(frame.tabs) do
		tab:SetPoint("TOPLEFT", frame.titleFrame, "BOTTOMLEFT", 0,0);
		tab:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5);
	end

	--Set frame to first tab
	frame.tabBar.SetActiveTabIndex(addon.db.char.display.selectedTab);
end

function gui:SizeMainFrame()
	local containerFrame = self.containerFrame;
	local frame = self.mainframe;
	--Sizing vars
	local frameMargin = 5;
	local iconoffsetX = addon.db.char.display.spellOffsetX;
	local iconoffsetY = addon.db.char.display.spellOffsetY;
	local maxPerRow = addon.db.char.display.maxInRow;

	local activeTab = frame.tabs[frame.tabBar.activetabindex];
	local buttons = activeTab.spellButtons;
	if #buttons > 0 then
		for i, btn in ipairs(buttons) do
			btn:ClearAllPoints();
			--Grab previous button and button on previous row
			local prevButton = buttons [i - 1];
			local prevRowButton = buttons [i - maxPerRow];
			if prevButton == nil then
				--If no buttons exist yet, set initial alignment
				btn:SetPoint("TOPLEFT",0,0);
			else
				if prevRowButton == nil then
					--Align this button to the initial row
					btn:SetPoint("TOPLEFT", prevButton, "TOPRIGHT", iconoffsetX, 0);
					btn:SetPoint("BOTTOMLEFT", prevButton, "BOTTOMRIGHT", iconoffsetX, 0);
				else
					--Align this button to the bottom of the button on the previous row
					btn:SetPoint("TOPLEFT", prevRowButton, "BOTTOMLEFT", 0, -iconoffsetY);
					btn:SetPoint("TOPRIGHT", prevRowButton, "BOTTOMRIGHT", 0, -iconoffsetY);
				end
			end
		end
		local totalButtonCount = #buttons;
		local totalRowCount = math.ceil(totalButtonCount / maxPerRow);
		local totalColumnCount = maxPerRow < totalButtonCount and maxPerRow or totalButtonCount;

		local titleMargin = frame.titleFrame:GetHeight();
		local totalWidth = (totalColumnCount * (buttons[1]:GetWidth() + iconoffsetX)) + (frameMargin * 2);
		local totalHeight = (totalRowCount * (buttons[1]:GetHeight() + iconoffsetY)) + frameMargin + titleMargin + frame.tabBar:GetHeight() + 5;

		containerFrame:SetSize(totalWidth, totalHeight);

	else
		--If there are no buttons, just give the mainframe a standard size
		containerFrame:SetSize(100, 100);
	end
end

function gui:DrawButtonFrame(frame, frameId, spellTable)
	local buttonFrame = CreateFrame("Frame", frameId, frame);
	--buttonFrame:SetBackdrop(backdrop);
	--buttonFrame:SetBackdropColor(1, 1, 0.1, 0.6);
	buttonFrame.spellButtons = {};
	local hiddenSpells = addon.db.char.display.hiddenSpells
	for _, spellId in ipairs(spellTable) do
		local spellInfo = GetSpellInfoCompat(spellId);
		--If spell does exist, create a button for it
		if spellInfo and not TableExtras:Contains(hiddenSpells, spellId) then
			local spellCastName = GetSpellCastName(spellInfo)
			local normalizedSpellId = spellInfo.spellID or spellId
			local btn = CreateFrame("Button", "StrudelSpellButton" .. normalizedSpellId, buttonFrame, "SecureActionButtonTemplate");
			btn.buttonSpell = normalizedSpellId --assign spell id to button (for later reference)
			btn:RegisterForClicks("LeftButtonUp", "LeftButtonDown");
			btn:SetAttribute("type", "spell");
			btn:SetAttribute("spell", spellCastName);
			btn:SetWidth(35);
			btn:SetHeight(35);

			btn:SetScript("OnEnter", function() 
				GameTooltip:SetOwner(btn, "ANCHOR_TOPRIGHT");
				GameTooltip:SetText(spellInfo.name, nil, nil, nil, 0.5, 1); 
			end);
			btn:SetScript("OnLeave", function() 
				GameTooltip:Hide();
			end);

			local btnTexture = btn:CreateTexture(nil,"OVERLAY",nil,-6)
			btnTexture:SetTexture(spellInfo.iconID)
			btnTexture:SetAllPoints(btn) --make texture same size as button
			local btnDisabledTexture = btn:CreateTexture(nil,"OVERLAY",nil,-6)
			btnDisabledTexture:SetTexture(spellInfo.iconID)
			btnDisabledTexture:SetAlpha(0.3)
			btnDisabledTexture:SetAllPoints(btn) --make texture same size as button

			btn:SetNormalTexture(btnTexture);
			btn:SetDisabledTexture(btnDisabledTexture);
			btn:SetHighlightTexture(defaultHighlightTexture)

			--Reagent counter
			btn.reagentCounterFrame = CreateFrame("Frame", "$parentReagentCount", btn);
			btn.reagentCounterFrame:SetPoint("BOTTOMRIGHT", btn, -1, 1);
			btn.reagentCounterFrame:SetSize(30,14);

			btn.reagentCounterFrame.Text = btn.reagentCounterFrame:CreateFontString("$parentText", "OVERLAY", "NumberFontNormal");
			btn.reagentCounterFrame.Text:SetJustifyH("RIGHT");
			btn.reagentCounterFrame.Text:SetAllPoints(btn.reagentCounterFrame);

			self:UpdateButton(btn);

			table.insert(buttonFrame.spellButtons, btn);
		end
	end
	return buttonFrame;
end

function gui:UpdateButton(btn)
	local spellId = btn.buttonSpell
	if IsConsumableSpellCompat(spellId) and not addon.db.char.display.hideReagentCount then
		local spellCount = GetSpellCastCountCompat(spellId)
		btn.reagentCounterFrame.Text:SetText(spellCount)
	else 
		btn.reagentCounterFrame.Text:SetText("")
	end
	
	local isPlayerSpell = IsSpellKnownCompat(spellId)
	local isUsable, insufficientPower = IsSpellUsableCompat(spellId)
	if not InCombatLockdown() then
		if isPlayerSpell and isUsable and not insufficientPower then
			btn:Enable()
		else
			btn:Disable()
		end
	end
end

function gui:UpdateAllTabs()
	local frame = self.mainframe
	if (frame.tabs ~= nil) then
		for _, tab in ipairs(frame.tabs) do
			for _, btn in ipairs(tab.spellButtons) do
				self:UpdateButton(btn)
			end
		end
	end
end

--Helper method for 12.0.0 and 5.5.0/1.15.8 C_Spell differences
function GetSpellInfoCompat(spellId)
	local legacyName, legacyRank, legacyIcon = GetSpellInfo(spellId)
	if C_Spell and C_Spell.GetSpellInfo then
		local cSpellInfo, cRank, cIcon = C_Spell.GetSpellInfo(spellId)
		if type(cSpellInfo) == "table" then
			cSpellInfo.name = cSpellInfo.name or cSpellInfo.spellName or legacyName
			cSpellInfo.rank = cSpellInfo.rank or cSpellInfo.subText or cSpellInfo.subtext or legacyRank
			cSpellInfo.iconID = cSpellInfo.iconID or cSpellInfo.originalIconID or cSpellInfo.iconFileID or legacyIcon
			cSpellInfo.spellID = cSpellInfo.spellID or cSpellInfo.spellId or spellId
			if cSpellInfo.name then
				return cSpellInfo
			end
		elseif cSpellInfo then
			return {
				name = cSpellInfo or legacyName,
				rank = cRank or legacyRank,
				iconID = cIcon or legacyIcon,
				spellID = spellId,
			}
		end
	end

	if not legacyName then
		return nil
	end

	return {
		name = legacyName,
		rank = legacyRank,
		iconID = legacyIcon,
		spellID = spellId,
	}
end

function GetSpellCastCountCompat(spellId)
	if C_Spell and C_Spell.GetSpellCastCount then
		return C_Spell.GetSpellCastCount(spellId)
	end

	local spellBookSlot = GetSpellBookSlot(spellId)
	if spellBookSlot then
		return GetSpellCount(spellBookSlot, spellBookType) or 0
	end

	return GetSpellCount(spellId) or 0
end

function IsSpellKnownCompat(spellId)
	if C_SpellBook and C_SpellBook.IsSpellKnown then
		return C_SpellBook.IsSpellKnown(spellId)
	end

	if IsSpellKnownOrOverridesKnown then
		return IsSpellKnownOrOverridesKnown(spellId)
	end

	if IsSpellKnown then
		return IsSpellKnown(spellId)
	end

	return GetSpellBookSlot(spellId) ~= nil
end

function IsSpellUsableCompat(spellId)
	if C_Spell and C_Spell.IsSpellUsable then
		return C_Spell.IsSpellUsable(spellId)
	end

	local spellBookSlot = GetSpellBookSlot(spellId)
	if spellBookSlot then
		return IsUsableSpell(spellBookSlot, spellBookType)
	end

	local spellInfo = GetSpellInfoCompat(spellId)
	if not spellInfo then
		return false, false
	end

	return IsUsableSpell(GetSpellCastName(spellInfo))
end

function IsConsumableSpellCompat(spellId)
	if C_Spell and C_Spell.IsConsumableSpell ~= nil then
		return C_Spell.IsConsumableSpell(spellId)
	end

	local spellBookSlot = GetSpellBookSlot(spellId)
	if spellBookSlot then
		return IsConsumableSpell(spellBookSlot, spellBookType)
	end

	local spellInfo = GetSpellInfoCompat(spellId)
	if not spellInfo then
		return false
	end

	return IsConsumableSpell(GetSpellCastName(spellInfo))
end
