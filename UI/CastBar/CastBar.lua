local name, RUI = ...

PlayerCastingBarFrame:SetScript("OnEvent", nil);
PlayerCastingBarFrame:Hide()

local CastBarFrame = CreateFrame("Frame", nil, UIParent)
CastBarFrame:SetWidth(216)
CastBarFrame:SetHeight(25)
CastBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -322)
CastBarFrame:Hide()

local CastBarFrameBackground = CreateFrame("Frame", nil, CastBarFrame, BackdropTemplateMixin and "BackdropTemplate")
CastBarFrameBackground:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])
CastBarFrameBackground:SetWidth(488)
CastBarFrameBackground:SetHeight(34)
CastBarFrameBackground:SetPoint("CENTER")
CastBarFrameBackground:SetFrameLevel(0)

local CastBar = CreateFrame("StatusBar", nil, CastBarFrame)
CastBar:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
CastBar:GetStatusBarTexture():SetHorizTile(false)
CastBar:SetMinMaxValues(0, 100)
CastBar:SetValue(100)
CastBar:SetWidth(480)
CastBar:SetHeight(26)
CastBar:SetPoint("CENTER")
CastBar:SetStatusBarColor(1,1,0)
CastBar:SetFrameLevel(1)

local CastBarTextLeft = CastBar:CreateFontString(nil, OVERLAY)
CastBarTextLeft:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
CastBarTextLeft:SetPoint("CENTER", CastBar, "CENTER", 0, -1)

local CastBarFrameBorder = CreateFrame("Frame", nil, CastBarFrame, BackdropTemplateMixin and "BackdropTemplate")
CastBarFrameBorder:SetBackdrop(RUI.EdgeTable["UI-Tooltip-Border"])
CastBarFrameBorder:SetWidth(488)
CastBarFrameBorder:SetHeight(34)
CastBarFrameBorder:SetPoint("CENTER")
CastBarFrameBorder:SetFrameLevel(3)

local Spark = CastBar:CreateTexture(nil, 'OVERLAY')
Spark:SetSize(15, 50)
Spark:SetBlendMode('ADD')
Spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])

local fadeout = nil

local function onUpdateCast(self,elapsed)
    Spark:SetPoint("CENTER", CastBar, "LEFT", (CastBar:GetValue() / select(2, CastBar:GetMinMaxValues())) * CastBar:GetWidth(), 0)
    if( fadeout ~= nil) then
        fadeout = fadeout - elapsed
        if (fadeout < 0) then
            CastBarFrame:Hide()
            fadeout = nil
        end
    end

    a, b, c, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo("player")
    if a == nil then return end
    CastBar:SetMinMaxValues(0, endTime-startTime)
    CastBar:SetValue(GetTime() * 1000 - startTime)
end
 
local function onUpdateChannel(self,elapsed)
    Spark:SetPoint("CENTER", CastBar, "LEFT", (CastBar:GetValue() / select(2, CastBar:GetMinMaxValues())) * CastBar:GetWidth(), 0)
    if( fadeout ~= nil) then
        fadeout = fadeout - elapsed
        if (fadeout < 0) then
            CastBarFrame:Hide()
            fadeout = nil
        end
    end

    a, b, c, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitChannelInfo("player")
    if a == nil then return end
    CastBar:SetMinMaxValues(0, endTime-startTime)
    CastBar:SetValue(endTime - GetTime() * 1000)

end

local events = {}

function events:UNIT_SPELLCAST_START(...)
    a, b, c = ...
    if a ~= "player" then return end
    local spell = Spell:CreateFromSpellID(c);
    CastBarTextLeft:SetText(spell:GetSpellName())
    CastBar:SetValue(0)
    CastBar:SetStatusBarColor(1,1,0)
    fadeout = nil

    CastBarFrame:SetScript("OnUpdate", onUpdateCast)

    CastBarFrame:Show()
end
function events:UNIT_SPELLCAST_STOP(...)
    a, b, c = ...
    if a ~= "player" then return end
    fadeout = 0.25
end
function events:UNIT_SPELLCAST_INTERRUPTED(...)
    a, b, c = ...
    if a ~= "player" then return end
    CastBar:SetStatusBarColor(1,0,0)
end
function events:UNIT_SPELLCAST_SUCCEEDED(...)
    a, b, c = ...
    if a ~= "player" then return end
    CastBar:SetValue(select(2, CastBar:GetMinMaxValues()))
    CastBar:SetStatusBarColor(0,1,0)
end

function events:UNIT_SPELLCAST_CHANNEL_START(...)
    a, b, c = ...
    if a ~= "player" then return end
    local spell = Spell:CreateFromSpellID(c);
    CastBarTextLeft:SetText(spell:GetSpellName())
    CastBar:SetValue(0)
    CastBar:SetStatusBarColor(1,1,0)
    fadeout = nil

    CastBarFrame:SetScript("OnUpdate", onUpdateChannel)

    CastBarFrame:Show()
end
function events:UNIT_SPELLCAST_CHANNEL_STOP(...)
    a, b, c = ...
    if a ~= "player" then return end
    fadeout = 0.25
end


CastBarFrame:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...);
end);
for k, v in pairs(events) do
    CastBarFrame:RegisterEvent(k);
end