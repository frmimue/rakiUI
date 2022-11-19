local name, RUI = ...

local PowerBarFrame = CreateFrame("Frame", nil, UIParent)
PowerBarFrame:SetWidth(488)
PowerBarFrame:SetHeight(34)
PowerBarFrame:SetPoint("TOP",UIParent,"CENTER", 0, -260)

PowerBarFrame.Background = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
PowerBarFrame.Background:SetAllPoints(PowerBarFrame)
PowerBarFrame.Background:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])


local PowerBar = CreateFrame("StatusBar", nil, PowerBarFrame)
PowerBar:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
PowerBar:GetStatusBarTexture():SetHorizTile(false)
PowerBar:SetMinMaxValues(0, 100)
PowerBar:SetValue(100)
PowerBar:SetWidth(480)
PowerBar:SetHeight(26)
PowerBar:SetPoint("CENTER")
PowerBar:SetStatusBarColor(1,1,0)
PowerBar:SetFrameLevel(1)

local PowerBarFrameBorder = CreateFrame("Frame", nil, PowerBarFrame, BackdropTemplateMixin and "BackdropTemplate")
PowerBarFrameBorder:SetBackdrop(RUI.EdgeTable["UI-DialogBox-Border"])
PowerBarFrameBorder:SetWidth(488)
PowerBarFrameBorder:SetHeight(34)
PowerBarFrameBorder:SetPoint("CENTER")
PowerBarFrameBorder:SetFrameLevel(3)

local events = {}

local powerTypeIndex = 0
local highPrecision = true

local function OnSpecChange()

  local _, _, playerClass = UnitClass("player");
  if(playerClass == 9) then
    powerTypeIndex = 7

    if(GetSpecialization() == 3) then
      highPrecision = true
    else
      highPrecision = false
    end

    local MyPlayerFrameSeperator0 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator0:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator0:SetWidth(8)
    MyPlayerFrameSeperator0:SetHeight(26)
    MyPlayerFrameSeperator0:SetPoint("CENTER", PowerBar, "LEFT", 1 *(PowerBar:GetWidth() / 5) + 3, 0)
    
    local MyPlayerFrameSeperator1 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator1:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator1:SetWidth(8)
    MyPlayerFrameSeperator1:SetHeight(26)
    MyPlayerFrameSeperator1:SetPoint("CENTER", PowerBar, "LEFT", 2 *(PowerBar:GetWidth() / 5) + 3, 0)
    
    local MyPlayerFrameSeperator2 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator2:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator2:SetWidth(8)
    MyPlayerFrameSeperator2:SetHeight(26)
    MyPlayerFrameSeperator2:SetPoint("CENTER", PowerBar, "LEFT", 3 *(PowerBar:GetWidth() / 5) + 3, 0)
    
    local MyPlayerFrameSeperator3 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator3:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator3:SetWidth(8)
    MyPlayerFrameSeperator3:SetHeight(26)
    MyPlayerFrameSeperator3:SetPoint("CENTER", PowerBar, "LEFT", 4 *(PowerBar:GetWidth() / 5) + 3, 0)

    PowerBarFrame:Show()
elseif (playerClass == 7) then
    powerTypeIndex = 11
    highPrecision = true

    local MyPlayerFrameSeperator2 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator2:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    MyPlayerFrameSeperator2:SetBlendMode("ADD")
    MyPlayerFrameSeperator2:SetWidth(8)
    MyPlayerFrameSeperator2:SetHeight(40)
    MyPlayerFrameSeperator2:SetPoint("CENTER", PowerBar, "LEFT", 3 *(PowerBar:GetWidth() / 5) + 3, 0)

    PowerBarFrame:Show()

elseif (playerClass == 5) then
    powerTypeIndex = 13
    highPrecision = true

    local MyPlayerFrameSeperator2 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator2:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    MyPlayerFrameSeperator2:SetBlendMode("ADD")
    MyPlayerFrameSeperator2:SetWidth(8)
    MyPlayerFrameSeperator2:SetHeight(40)
    MyPlayerFrameSeperator2:SetPoint("CENTER", PowerBar, "LEFT", 2 *(PowerBar:GetWidth() / 4) + 3, 0)

    PowerBarFrame:Show()

  elseif (playerClass == 4) then
    powerTypeIndex = 4
    highPrecision = false

    local MyPlayerFrameSeperator0 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator0:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator0:SetWidth(8)
    MyPlayerFrameSeperator0:SetHeight(26)
    MyPlayerFrameSeperator0:SetPoint("CENTER", PowerBar, "LEFT", 1 *(PowerBar:GetWidth() / 5) + 3, 0)
    
    local MyPlayerFrameSeperator1 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator1:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator1:SetWidth(8)
    MyPlayerFrameSeperator1:SetHeight(26)
    MyPlayerFrameSeperator1:SetPoint("CENTER", PowerBar, "LEFT", 2 *(PowerBar:GetWidth() / 5) + 3, 0)
    
    local MyPlayerFrameSeperator2 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator2:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator2:SetWidth(8)
    MyPlayerFrameSeperator2:SetHeight(26)
    MyPlayerFrameSeperator2:SetPoint("CENTER", PowerBar, "LEFT", 3 *(PowerBar:GetWidth() / 5) + 3, 0)
    
    local MyPlayerFrameSeperator3 =  PowerBar:CreateTexture(nil, "OVERLAY")
    MyPlayerFrameSeperator3:SetTexture("Interface\\RAIDFRAME\\Raid-VSeparator")
    MyPlayerFrameSeperator3:SetWidth(8)
    MyPlayerFrameSeperator3:SetHeight(26)
    MyPlayerFrameSeperator3:SetPoint("CENTER", PowerBar, "LEFT", 4 *(PowerBar:GetWidth() / 5) + 3, 0)

  else
    PowerBarFrame:Hide()
  end

  local info = PowerBarColor[powerTypeIndex];

  if(info) then
      PowerBar:SetStatusBarColor(info.r, info.g, info.b, 1.0)
  else
      info = PowerBarColor["MANA"];
      PowerBar:SetStatusBarColor(info.r, info.g, info.b, 1.0)
  end

  if(powerTypeIndex == 4) then
    PowerBar:SetStatusBarColor(1, 0, 0, 1.0)
  end

  PowerBar:SetMinMaxValues(0, UnitPowerMax("player", powerTypeIndex, highPrecision))

  PowerBar:SetMinMaxValues(0, UnitPowerMax("player", powerTypeIndex, highPrecision))
  PowerBar:SetValue(UnitPower("player", powerTypeIndex, highPrecision))

  function events:UNIT_POWER_FREQUENT(...)
    if ... ~= "player" then return end
    PowerBar:SetValue(UnitPower("player", powerTypeIndex, highPrecision))
  end

end

function events:PLAYER_ENTERING_WORLD(...)
  OnSpecChange()
end

function events:PLAYER_SPECIALIZATION_CHANGED(...)
  OnSpecChange()
end 

function events:UNIT_POWER_FREQUENT(...)
end


PowerBarFrame:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...);
    end);
    for k, v in pairs(events) do
    PowerBarFrame:RegisterEvent(k);
end
