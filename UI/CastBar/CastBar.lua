local name, RUI = ...

-- PlayerCastingBarFrame:SetScript("OnEvent", nil);
-- PlayerCastingBarFrame:Hide()

PlayerCastingBarFrame:SetWidth(488)
PlayerCastingBarFrame:SetHeight(34)

RUI.CastBarFrame = CreateFrame("Frame", nil, UIParent)
RUI.CastBarFrame:SetWidth(216)
RUI.CastBarFrame:SetHeight(25)
RUI.CastBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -322)
RUI.CastBarFrame:Hide()

RUI.CastBarFrame.Background = CreateFrame("Frame", nil, RUI.CastBarFrame, BackdropTemplateMixin and "BackdropTemplate")
RUI.CastBarFrame.Background:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])
RUI.CastBarFrame.Background:SetWidth(488)
RUI.CastBarFrame.Background:SetHeight(34)
RUI.CastBarFrame.Background:SetPoint("CENTER")
RUI.CastBarFrame.Background:SetFrameLevel(0)

RUI.CastBarFrame.Border = CreateFrame("Frame", nil, RUI.CastBarFrame, BackdropTemplateMixin and "BackdropTemplate")
RUI.CastBarFrame.Border:SetBackdrop(RUI.EdgeTable["UI-Tooltip-Border"])
RUI.CastBarFrame.Border:SetWidth(488)
RUI.CastBarFrame.Border:SetHeight(34)
RUI.CastBarFrame.Border:SetPoint("CENTER")
RUI.CastBarFrame.Border:SetFrameLevel(3)

RUI.CastBarFrame.CastBar = CreateFrame("StatusBar", nil, RUI.CastBarFrame)
RUI.CastBarFrame.CastBar:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
RUI.CastBarFrame.CastBar:GetStatusBarTexture():SetHorizTile(false)
RUI.CastBarFrame.CastBar:SetMinMaxValues(0, 100)
RUI.CastBarFrame.CastBar:SetValue(100)
RUI.CastBarFrame.CastBar:SetWidth(480)
RUI.CastBarFrame.CastBar:SetHeight(26)
RUI.CastBarFrame.CastBar:SetPoint("CENTER")
RUI.CastBarFrame.CastBar:SetStatusBarColor(1,1,0)
RUI.CastBarFrame.CastBar:SetFrameLevel(1)

RUI.CastBarFrame.CastBar.TextLeft = RUI.CastBarFrame.CastBar:CreateFontString(nil, OVERLAY)
RUI.CastBarFrame.CastBar.TextLeft:SetFont("Fonts\\ARIALN.TTF", 18, "OUTLINE")
RUI.CastBarFrame.CastBar.TextLeft:SetPoint("CENTER", RUI.CastBarFrame.CastBar, "CENTER", 0, -1)

RUI.CastBarFrame.CastBar.Spark = RUI.CastBarFrame.CastBar:CreateTexture(nil, 'OVERLAY')
RUI.CastBarFrame.CastBar.Spark:SetSize(15, 50)
RUI.CastBarFrame.CastBar.Spark:SetBlendMode('ADD')
RUI.CastBarFrame.CastBar.Spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])

RUI.CastBarFrame.CastBar.fadeout = nil
RUI.CastBarFrame.CastBar.selfStartTime = nil
RUI.CastBarFrame.CastBar.selfEndTime = nil
RUI.CastBarFrame.CastBar.selfNumStages = nil
RUI.CastBarFrame.CastBar.selfChannel = false

RUI.CastBarFrame.CastBar.EmpowerMark = {}

for i=1, 4 do
    RUI.CastBarFrame.CastBar.EmpowerMark[i] = RUI.CastBarFrame.CastBar:CreateTexture(nil, "OVERLAY")
    RUI.CastBarFrame.CastBar.EmpowerMark[i]:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    RUI.CastBarFrame.CastBar.EmpowerMark[i]:SetBlendMode("ADD")
    RUI.CastBarFrame.CastBar.EmpowerMark[i]:SetWidth(8)
    RUI.CastBarFrame.CastBar.EmpowerMark[i]:SetHeight(40)
    RUI.CastBarFrame.CastBar.EmpowerMark[i]:SetPoint("CENTER", RUI.CastBarFrame.CastBar, "LEFT", i*(RUI.CastBarFrame.CastBar:GetWidth() / 5), 0)
    RUI.CastBarFrame.CastBar.EmpowerMark[i]:Hide()
end

local function onUpdateCast(self,elapsed)
    RUI.CastBarFrame.CastBar.Spark:SetPoint("CENTER", RUI.CastBarFrame.CastBar, "LEFT", (RUI.CastBarFrame.CastBar:GetValue() / select(2, RUI.CastBarFrame.CastBar:GetMinMaxValues())) * RUI.CastBarFrame.CastBar:GetWidth(), 0)
    if( RUI.CastBarFrame.CastBar.fadeout ~= nil) then
        RUI.CastBarFrame.CastBar.fadeout = RUI.CastBarFrame.CastBar.fadeout - elapsed
        if (RUI.CastBarFrame.CastBar.fadeout < 0) then
            RUI.CastBarFrame:Hide()
            RUI.CastBarFrame.CastBar.fadeout = nil
        end
        return
    end

    local a, b, c, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo("player")
    RUI.CastBarFrame.CastBar:SetValue(GetTime() * 1000 - RUI.CastBarFrame.CastBar.selfStartTime)
end
 
local function onUpdateChannel(self,elapsed)
    if( RUI.CastBarFrame.CastBar.fadeout ~= nil) then
        RUI.CastBarFrame.CastBar.fadeout = RUI.CastBarFrame.CastBar.fadeout - elapsed
        if (RUI.CastBarFrame.CastBar.fadeout < 0) then
            RUI.CastBarFrame:Hide()
            RUI.CastBarFrame.CastBar.fadeout = nil
        end
        return
    end

    --if a == nil then return end
    RUI.CastBarFrame.CastBar:SetValue(RUI.CastBarFrame.CastBar.selfEndTime - GetTime() * 1000)
    RUI.CastBarFrame.CastBar.Spark:SetPoint("CENTER", RUI.CastBarFrame.CastBar, "LEFT", (RUI.CastBarFrame.CastBar:GetValue() / select(2, RUI.CastBarFrame.CastBar:GetMinMaxValues())) * RUI.CastBarFrame.CastBar:GetWidth(), 0)
end

local function onUpdateEmpower(self,elapsed)
    if( RUI.CastBarFrame.CastBar.fadeout ~= nil) then
        RUI.CastBarFrame.CastBar.fadeout = RUI.CastBarFrame.CastBar.fadeout - elapsed
        if (RUI.CastBarFrame.CastBar.fadeout < 0) then
            RUI.CastBarFrame:Hide()
            RUI.CastBarFrame.CastBar.fadeout = nil
        end
        return
    end

    --if a == nil then return end
    RUI.CastBarFrame.CastBar:SetValue(GetTime() * 1000 - RUI.CastBarFrame.CastBar.selfStartTime)
    RUI.CastBarFrame.CastBar.Spark:SetPoint("CENTER", RUI.CastBarFrame.CastBar, "LEFT", (RUI.CastBarFrame.CastBar:GetValue() / select(2, RUI.CastBarFrame.CastBar:GetMinMaxValues())) * RUI.CastBarFrame.CastBar:GetWidth(), 0)
end

local events = {}

function events:UNIT_SPELLCAST_START(...)
    a, b, c = ...
    if a ~= "player" then return end
    local spell = Spell:CreateFromSpellID(c);
    RUI.CastBarFrame.CastBar.TextLeft:SetText(spell:GetSpellName())
    RUI.CastBarFrame.CastBar:SetValue(0)
    RUI.CastBarFrame.CastBar:SetStatusBarColor(1,1,0)
    RUI.CastBarFrame.CastBar.fadeout = nil
    RUI.CastBarFrame.CastBar.selfChannel = false

    local a, b, c, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo("player")

    for i=1, 4 do
        RUI.CastBarFrame.CastBar.EmpowerMark[i]:Hide()
    end

    RUI.CastBarFrame.CastBar.selfStartTime = startTime
    RUI.CastBarFrame.CastBar.selfEndTime = endTime
    RUI.CastBarFrame.CastBar.selfNumStages = nil
    RUI.CastBarFrame.CastBar:SetMinMaxValues(0, endTime - startTime)

    RUI.CastBarFrame:SetScript("OnUpdate", onUpdateCast)

    RUI.CastBarFrame:Show()
end

function events:UNIT_SPELLCAST_CHANNEL_START(...)
    a, b, c = ...
    if a ~= "player" then return end
    local spell = Spell:CreateFromSpellID(c);
    RUI.CastBarFrame.CastBar.TextLeft:SetText(spell:GetSpellName())
    RUI.CastBarFrame.CastBar:SetValue(0)
    RUI.CastBarFrame.CastBar:SetStatusBarColor(0,1,0)
    RUI.CastBarFrame.CastBar.fadeout = nil
    RUI.CastBarFrame.CastBar.selfChannel = true

    for i=1, 4 do
        RUI.CastBarFrame.CastBar.EmpowerMark[i]:Hide()
    end

    local a, b, c, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID, numStages = UnitChannelInfo("player")
    RUI.CastBarFrame.CastBar.selfStartTime = startTime
    RUI.CastBarFrame.CastBar.selfEndTime = endTime
    RUI.CastBarFrame.CastBar.selfNumStages = numStages
    RUI.CastBarFrame.CastBar:SetMinMaxValues(0, RUI.CastBarFrame.CastBar.selfEndTime - RUI.CastBarFrame.CastBar.selfStartTime)

    RUI.CastBarFrame:SetScript("OnUpdate", onUpdateChannel)

    RUI.CastBarFrame:Show()
end

function events:UNIT_SPELLCAST_EMPOWER_START(...)
    a, b, c = ...
    if a ~= "player" then return end
    local spell = Spell:CreateFromSpellID(c);
    RUI.CastBarFrame.CastBar.TextLeft:SetText(spell:GetSpellName())
    RUI.CastBarFrame.CastBar:SetValue(0)
    RUI.CastBarFrame.CastBar:SetStatusBarColor(0,1,0)
    RUI.CastBarFrame.CastBar.fadeout = nil
    RUI.CastBarFrame.CastBar.selfChannel = true

    for i=1, 4 do
        RUI.CastBarFrame.CastBar.EmpowerMark[i]:Show()
    end

    local a, b, c, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID, numStages = UnitChannelInfo("player")
    local endHoldTime = GetUnitEmpowerHoldAtMaxTime("player")

    RUI.CastBarFrame.CastBar.selfStartTime = startTime
    RUI.CastBarFrame.CastBar.selfEndTime = endTime + GetUnitEmpowerHoldAtMaxTime("player")
    RUI.CastBarFrame.CastBar.selfNumStages = numStages

    local stageDuration = GetUnitEmpowerStageDuration("player", 0)
    RUI.CastBarFrame.CastBar.EmpowerMark[1]:ClearAllPoints()
    RUI.CastBarFrame.CastBar.EmpowerMark[1]:SetPoint("CENTER", RUI.CastBarFrame.CastBar, "LEFT", stageDuration / (RUI.CastBarFrame.CastBar.selfEndTime - RUI.CastBarFrame.CastBar.selfStartTime) * RUI.CastBarFrame.CastBar:GetWidth(), 0)

    for i=2,3 do
        local stageDuration = GetUnitEmpowerStageDuration("player", i)
        RUI.CastBarFrame.CastBar.EmpowerMark[i]:ClearAllPoints()
        RUI.CastBarFrame.CastBar.EmpowerMark[i]:SetPoint("CENTER", RUI.CastBarFrame.CastBar.EmpowerMark[i-1], "CENTER", stageDuration / (RUI.CastBarFrame.CastBar.selfEndTime - RUI.CastBarFrame.CastBar.selfStartTime) * RUI.CastBarFrame.CastBar:GetWidth(), 0)
    end

    RUI.CastBarFrame.CastBar.EmpowerMark[4]:ClearAllPoints()
    RUI.CastBarFrame.CastBar.EmpowerMark[4]:SetPoint("CENTER", RUI.CastBarFrame.CastBar, "LEFT", (RUI.CastBarFrame.CastBar.selfEndTime - RUI.CastBarFrame.CastBar.selfStartTime - endHoldTime) / (RUI.CastBarFrame.CastBar.selfEndTime - RUI.CastBarFrame.CastBar.selfStartTime) * RUI.CastBarFrame.CastBar:GetWidth(), 0)

    RUI.CastBarFrame.CastBar:SetMinMaxValues(0, RUI.CastBarFrame.CastBar.selfEndTime - RUI.CastBarFrame.CastBar.selfStartTime)

    RUI.CastBarFrame:SetScript("OnUpdate", onUpdateEmpower)
    RUI.CastBarFrame:Show()
end

function events:UNIT_SPELLCAST_STOP(...)
    a, b, c = ...
    if a ~= "player" then return end
    RUI.CastBarFrame.CastBar.fadeout = 0.25
end

function events:UNIT_SPELLCAST_CHANNEL_STOP(...)
    a, b, c = ...
    if a ~= "player" then return end
    RUI.CastBarFrame.CastBar.fadeout = 0.25
end

function events:UNIT_SPELLCAST_EMPOWER_STOP(...)
    a, b, c = ...
    if a ~= "player" then return end
    -- RUI.CastBarFrame.CastBar:SetStatusBarColor(1,0,0)
    RUI.CastBarFrame.CastBar.fadeout = 0.25
end

function events:UNIT_SPELLCAST_INTERRUPTED(...)
    a, b, c = ...
    if a ~= "player" then return end
    RUI.CastBarFrame.CastBar.fadeout = 0.25
    RUI.CastBarFrame.CastBar:SetStatusBarColor(1,0,0)
    -- RUI.CastBarFrame.CastBar:SetValue(select(2, RUI.CastBarFrame.CastBar:GetMinMaxValues()))
end
function events:UNIT_SPELLCAST_SUCCEEDED(...)
    a, b, c = ...
    if a ~= "player" then return end
    -- CastBar:SetValue(select(2, CastBar:GetMinMaxValues()))
    if RUI.CastBarFrame.CastBar.selfChannel == false then
        RUI.CastBarFrame.CastBar:SetStatusBarColor(0,1,0)
    end
end

function events:UNIT_SPELLCAST_EMPOWER_UPDATE(...)
end

function events:UNIT_SPELLCAST_FAILED(...)
end

function events:UNIT_SPELLCAST_FAILED_QUIET(...)
end

RUI.CastBarFrame:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...);
end);
for k, v in pairs(events) do
    RUI.CastBarFrame:RegisterEvent(k);
end