local name, RUI = ...

local PowerBarFrame = CreateFrame("Frame", nil, UIParent)
PowerBarFrame:SetWidth(200)
PowerBarFrame:SetHeight(25)
PowerBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -280)

local PowerBarFrameBackground = CreateFrame("Frame", nil, PowerBarFrame)
PowerBarFrameBackground:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])
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

local PowerBarFrameBorder = CreateFrame("Frame", nil, PowerBarFrame)
PowerBarFrameBorder:SetBackdrop(RUI.EdgeTable["UI-DialogBox-Border"])
PowerBarFrameBorder:SetWidth(488)
PowerBarFrameBorder:SetHeight(34)
PowerBarFrameBorder:SetPoint("CENTER")
PowerBarFrameBorder:SetFrameLevel(3)

local powerTypeIndex = 0
local highPrecision = true

function PowerBar:Update()
    PowerBar:SetValue(UnitPower("player", powerTypeIndex, highPrecision))
end

function PowerBar:Init()
    local info = PowerBarColor[powerTypeIndex];

    if(info) then
        PowerBar:SetStatusBarColor(info.r, info.g, info.b, 1.0)
    else
        info = PowerBarColor["MANA"];
        PowerBar:SetStatusBarColor(info.r, info.g, info.b, 1.0)
    end


    PowerBar:SetMinMaxValues(0, UnitPowerMax("player", powerTypeIndex, highPrecision))
    PowerBar:Update()
end

local events = {}

function events:PLAYER_ENTERING_WORLD(...)
    PowerBar:Init()
end

function events:PLAYER_SPECIALIZATION_CHANGED(...)
    PowerBar:Init()
end 

function events:UNIT_POWER_FREQUENT(...)
    if ... ~= "player" then return end
    PowerBar:Update()
end


PowerBarFrame:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...);
    end);
    for k, v in pairs(events) do
    PowerBarFrame:RegisterEvent(k);
end