local name, RUI = ...

function RUI.Util.CreateUnitFrame (unitID, powerBarHeight)
    local UnitFrame = CreateFrame("Button", nil, UIParent, "SecureUnitButtonTemplate")
	--UnitFrame:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])
	UnitFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	UnitFrame:SetAttribute("type1", "target")
	UnitFrame:SetAttribute("unit", unitID)
	UnitFrame:SetAttribute("type2", "togglemenu")
	RegisterUnitWatch(UnitFrame)

	UnitFrame.Background = CreateFrame("Frame", nil, UnitFrame, BackdropTemplateMixin and "BackdropTemplate")
	UnitFrame.Background:SetAllPoints(UnitFrame)
	UnitFrame.Background:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])

	UnitFrame.Border = CreateFrame("Frame", nil, UnitFrame, BackdropTemplateMixin and "BackdropTemplate")
	UnitFrame.Border:SetAllPoints(UnitFrame)
	UnitFrame.Border:SetBackdrop(RUI.EdgeTable["UI-Tooltip-Border"])
	UnitFrame.Border:SetFrameLevel(UnitFrame:GetFrameLevel() + 2)

	UnitFrame.HealthBar = CreateFrame("StatusBar", nil, UnitFrame)
	UnitFrame.HealthBar:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
	UnitFrame.HealthBar:GetStatusBarTexture():SetHorizTile(false)
	UnitFrame.HealthBar:SetMinMaxValues(0, 100)
	UnitFrame.HealthBar:SetValue(50)
	UnitFrame.HealthBar:SetPoint("TOPLEFT", UnitFrame, "TOPLEFT", 4, -4)
	UnitFrame.HealthBar:SetPoint("BOTTOMRIGHT", UnitFrame, "BOTTOMRIGHT", -4, 4)

	if powerBarHeight > 0 then
		UnitFrame.HealthBar:SetPoint("BOTTOMRIGHT", UnitFrame, "BOTTOMRIGHT", -4, 4 + powerBarHeight)
		UnitFrame.PowerBar = CreateFrame("StatusBar", nil, UnitFrame)
		UnitFrame.PowerBar:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
		UnitFrame.PowerBar:GetStatusBarTexture():SetHorizTile(false)
		UnitFrame.PowerBar:SetMinMaxValues(0, 100)
		UnitFrame.PowerBar:SetValue(70)
		UnitFrame.PowerBar:SetPoint("TOPLEFT", UnitFrame, "BOTTOMLEFT", 4, 4 + powerBarHeight)
		UnitFrame.PowerBar:SetPoint("BOTTOMRIGHT", UnitFrame, "BOTTOMRIGHT", -4, 4)

		UnitFrame.Seperator = UnitFrame.Border:CreateTexture()
		UnitFrame.Seperator:SetTexture("Interface\\RAIDFRAME\\Raid-HSeparator")
		UnitFrame.Seperator:SetHeight(8)
		UnitFrame.Seperator:SetPoint("TOPLEFT", UnitFrame.HealthBar, "BOTTOMLEFT", 0, 1)
		UnitFrame.Seperator:SetPoint("TOPRIGHT", UnitFrame.HealthBar, "BOTTOMRIGHT", 0, 1)
	end

	UnitFrame.HealthBar.TextLeft = UnitFrame.HealthBar:CreateFontString()
	UnitFrame.HealthBar.TextLeft:SetFont("Fonts\\ARIALN.TTF", 18, "OUTLINE")
	UnitFrame.HealthBar.TextLeft:SetPoint("BOTTOMLEFT", UnitFrame.HealthBar, "BOTTOMLEFT", 2, 2)

	UnitFrame.HealthBar.TextRight = UnitFrame.HealthBar:CreateFontString()
	UnitFrame.HealthBar.TextRight:SetFont("Fonts\\ARIALN.TTF", 18, "OUTLINE")
	UnitFrame.HealthBar.TextRight:SetPoint("BOTTOMRIGHT", UnitFrame.HealthBar, "BOTTOMRIGHT", -2, 2)

	UnitFrame.PowerBar.TextLeft = UnitFrame.PowerBar:CreateFontString()
	UnitFrame.PowerBar.TextLeft:SetFont("Fonts\\ARIALN.TTF", 12, "OUTLINE")
	UnitFrame.PowerBar.TextLeft:SetPoint("BOTTOMLEFT", UnitFrame.PowerBar, "BOTTOMLEFT", 2, 0)

	UnitFrame.PowerBar.TextRight = UnitFrame.PowerBar:CreateFontString()
	UnitFrame.PowerBar.TextRight:SetFont("Fonts\\ARIALN.TTF", 12, "OUTLINE")
	UnitFrame.PowerBar.TextRight:SetPoint("BOTTOMRIGHT", UnitFrame.PowerBar, "BOTTOMRIGHT", -2, 0)

	UnitFrame.HealthBar.TextCenter = UnitFrame.HealthBar:CreateFontString()
	UnitFrame.HealthBar.TextCenter:SetFont("Fonts\\ARIALN.TTF", 18, "OUTLINE")
	UnitFrame.HealthBar.TextCenter:SetPoint("TOP", UnitFrame.HealthBar, "TOP", 0, -2)
	UnitFrame.HealthBar.TextCenter:SetPoint("LEFT", UnitFrame.HealthBar, "LEFT", 20, -2)
	UnitFrame.HealthBar.TextCenter:SetPoint("RIGHT", UnitFrame.HealthBar, "RIGHT", -20, -2)
	UnitFrame.HealthBar.TextCenter:SetWordWrap(false)

	function UnitFrame.HealthBar:Update()
		local hpValue = UnitHealth(unitID)
		local hpValueMax = UnitHealthMax(unitID);
		if (hpValueMax > 0) then
			local hpValueNormalized = (hpValue / hpValueMax);
			local hpValuePercent = hpValueNormalized * 100;
			self:SetValue(hpValuePercent)
			self.TextLeft:SetText(string.format("%.1f%%", hpValuePercent))
			self.TextRight:SetText(AbbreviateLargeNumbers(hpValue))
			self:SetStatusBarColor(RUI.Math.Lerp3({1.0, 0.0, 0.0}, {1.0, 1.0, 0.0}, {0.5, 0.5, 0.5}, hpValueNormalized));
		else
			self:SetValue(0)
			self.TextLeft:SetText("")
			self.TextRight:SetText("")
		end
	end

	function UnitFrame.PowerBar:Update()
		local powerValue = UnitPower(unitID)
		local powerValueMax = UnitPowerMax(unitID)
		if (powerValueMax > 0) then 
			local powerValuePercent = math.ceil((powerValue / powerValueMax) * 100);
			self:SetValue(powerValuePercent)
			self.TextLeft:SetText(powerValuePercent .. "%")
			self.TextRight:SetText(AbbreviateLargeNumbers(powerValue))
			local l,powerToken, r, g, b = UnitPowerType(unitID);
			local l,powerToken, r, g, b = UnitPowerType(unitID);
				if r == nil then
					local info = PowerBarColor[powerToken];
					self:SetStatusBarColor(info.r, info.g, info.b)
				else
					self:SetStatusBarColor(r, b, g)
				end
		else
			self:SetValue(0)
			self.TextLeft:SetText("")
			self.TextRight:SetText("")
		end
	end

	function UnitFrame:Update()
		self.HealthBar:Update()
		self.PowerBar:Update()
		self.HealthBar.TextCenter:SetText(UnitName(unitID))
	end

	UnitFrame.Events = {}

	function UnitFrame.Events:UNIT_HEALTH(...)
		if ... ~= unitID then return end
		UnitFrame.HealthBar:Update()
	end	

	function UnitFrame.Events:UNIT_POWER_FREQUENT(...)
		if ... ~= unitID then return end
		UnitFrame.PowerBar:Update()
	end

	function UnitFrame.Events:PLAYER_ENTERING_WORLD()
		UnitFrame:Update()
	end

	function UnitFrame.Events:UNIT_NAME_UPDATE(...)
		if ... ~= unitID then return end
		self.HealthBar.TextCenter:SetText(UnitName(unitID))
	end

	UnitFrame:SetScript("OnEvent", function(self, event, ...)
		self.Events[event](self, ...);
	end);

	for k, v in pairs(UnitFrame.Events) do
		UnitFrame:RegisterEvent(k);
	end

    return UnitFrame
end

function RUI.Util.CreatePlayerUnitFrame(powerBarHeight)
	local PlayerUnitFrame = RUI.Util.CreateUnitFrame("player", powerBarHeight)

	PlayerUnitFrame.HealthBar.CombatIcon = PlayerUnitFrame.HealthBar:CreateTexture()
	PlayerUnitFrame.HealthBar.CombatIcon:SetWidth(32)
	PlayerUnitFrame.HealthBar.CombatIcon:SetHeight(32)
	PlayerUnitFrame.HealthBar.CombatIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
	PlayerUnitFrame.HealthBar.CombatIcon:SetTexCoord(0.5, 1, 0, 0.5)
	PlayerUnitFrame.HealthBar.CombatIcon:SetPoint("BOTTOM", PlayerUnitFrame.HealthBar, "BOTTOM", 0, 0)
	PlayerUnitFrame.HealthBar.CombatIcon:Hide()
	

	function PlayerUnitFrame.Events:PLAYER_REGEN_DISABLED(...)
		PlayerUnitFrame.HealthBar.CombatIcon:Show()
	end
	function PlayerUnitFrame.Events:PLAYER_REGEN_ENABLED(...)
		PlayerUnitFrame.HealthBar.CombatIcon:Hide()
	end

	PlayerUnitFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	PlayerUnitFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

	return PlayerUnitFrame
end

function RUI.Util.CreateTargetUnitFrame(powerBarHeight)
	local TargetUnitFrame = RUI.Util.CreateUnitFrame("target", powerBarHeight)

	TargetUnitFrame.BaseUpdate = TargetUnitFrame.Update

	function TargetUnitFrame:Update()
		if(not UnitExists("target")) then
			self:Hide()
		end
		self:Show()
		self:BaseUpdate()
	end

	function TargetUnitFrame.Events:PLAYER_TARGET_CHANGED(...)
		TargetUnitFrame:Update()
	end

	TargetUnitFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

	return TargetUnitFrame
end

function RUI.Util.CreatePetUnitFrame(powerBarHeight)
	local PetUnitFrame = RUI.Util.CreateUnitFrame("pet", powerBarHeight)

	PetUnitFrame.BaseUpdate = PetUnitFrame.Update

	function PetUnitFrame:Update()
		if(not UnitExists("pet")) then
			self:Hide()
		end
		self:BaseUpdate()
		self:Show()
	end

	function PetUnitFrame.Events:UNIT_PET(...)
		if ... ~= "player" then return end
		PetUnitFrame:Update()
	end

	PetUnitFrame:RegisterEvent("UNIT_PET")

	return PetUnitFrame
end

function RUI.Util.CreateTargetTargetUnitFrame(powerBarHeight)
	local TargetTargetUnitFrame = RUI.Util.CreateUnitFrame("targettarget", powerBarHeight)

	TargetTargetUnitFrame.BaseUpdate = TargetTargetUnitFrame.Update

	function TargetTargetUnitFrame:Update()
		if(not UnitExists("targettarget")) then
			self:Hide()
		end
		self:BaseUpdate()
		self:Show()
	end

	function TargetTargetUnitFrame.Events:UNIT_TARGET(...)
		if ... ~= "target" then return end
		TargetTargetUnitFrame:Update()
	end

	function TargetTargetUnitFrame.Events:PLAYER_TARGET_CHANGED(...)
		TargetTargetUnitFrame:Update()
	end

	TargetTargetUnitFrame:RegisterEvent("UNIT_TARGET")

	TargetTargetUnitFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

	return TargetTargetUnitFrame
end

function RUI.Util.CreateBossUnitFrame(bossN, powerBarHeight)
	local BossUnitFrame = RUI.Util.CreateUnitFrame(bossN, powerBarHeight)

	BossUnitFrame.BaseUpdate = BossUnitFrame.Update
	
	function BossUnitFrame:Update()
		if(not UnitExists(bossN)) then
			self:Hide()
		end
		self:BaseUpdate()
		self:Show()
	end

	function BossUnitFrame.Events:INSTANCE_ENCOUNTER_ENGAGE_UNIT(...)
		BossUnitFrame:Update()
	end

	BossUnitFrame:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")

	return BossUnitFrame
end 