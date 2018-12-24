local edge = {
  --edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  tile = true,
  edgeSize = 16,
  insets = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4
  }
}

local background = {
  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
  insets = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4
  }
}

local PowerBarFrame = CreateFrame("Frame", nil, UIParent)
PowerBarFrame:SetWidth(200)
PowerBarFrame:SetHeight(25)
PowerBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -280)

local PowerBarFrameBackground = CreateFrame("Frame", nil, PowerBarFrame)
PowerBarFrameBackground:SetBackdrop(background)
PowerBarFrameBackground:SetWidth(488)
PowerBarFrameBackground:SetHeight(34)
PowerBarFrameBackground:SetPoint("CENTER")
PowerBarFrameBackground:SetFrameLevel(0)

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
PowerBar:SetStatusBarColor(0.50, 0.32, 0.55, 1.0)

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

local PowerBarFrameBorder = CreateFrame("Frame", nil, PowerBarFrame)
PowerBarFrameBorder:SetBackdrop(edge)
PowerBarFrameBorder:SetWidth(488)
PowerBarFrameBorder:SetHeight(34)
PowerBarFrameBorder:SetPoint("CENTER")
PowerBarFrameBorder:SetFrameLevel(3)

local events = {}

local function OnSpecChange()
  local powerTypeIndex = 7
  if(GetSpecialization() == 3) then
      PowerBar:SetMinMaxValues(0, UnitPowerMax("player", powerTypeIndex, true))
      PowerBar:SetValue(UnitPower("player", powerTypeIndex, true))

      function events:UNIT_POWER_FREQUENT(...)
        if ... ~= "player" then return end
        PowerBar:SetValue(UnitPower("player", powerTypeIndex, true))
      end

    else
      PowerBar:SetMinMaxValues(0, UnitPowerMax("player", powerTypeIndex))
      PowerBar:SetValue(UnitPower("player", powerTypeIndex))

      function events:UNIT_POWER_FREQUENT(...)
        if ... ~= "player" then return end
        PowerBar:SetValue(UnitPower("player", powerTypeIndex))
      end

    end
end

function events:PLAYER_ENTERING_WORLD(...)
    local _, _, playerClass = UnitClass("player");
    if(playerClass == 9) then
      PowerBarFrame:Show()
    else
      PowerBarFrame:Hide()
    end
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
