local name, RUI = ...

Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")
MinimapBorderTop:Hide()
MinimapBackdrop:Hide()
MinimapZoneText:SetPoint("TOP", Minimap, "TOP", 0, -6)
MinimapZoneText:SetFont("Fonts\\ARIALN.TTF", 16, "OUTLINE")
MinimapZoneText:Hide()
GarrisonLandingPageMinimapButton:Show()
GarrisonLandingPageMinimapButton:ClearAllPoints()
GarrisonLandingPageMinimapButton:SetPoint("CENTER", Minimap, "BOTTOMLEFT", 8, 8)
GarrisonLandingPageMinimapButton:SetParent(Minimap)
GarrisonLandingPageMinimapButton:SetFrameLevel(4)
GameTimeFrame:ClearAllPoints()
GameTimeFrame:SetPoint("CENTER", Minimap, "TOPRIGHT", -8, -8)
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
MiniMapChallengeMode:ClearAllPoints()
MiniMapChallengeMode:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT")
QueueStatusMinimapButton:Show();
QueueStatusMinimapButton:SetParent(Minimap)
QueueStatusMinimapButton:SetFrameLevel(4)
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("CENTER", Minimap, "BOTTOMRIGHT", -8, 8)

Minimap:SetWidth(200)
Minimap:SetHeight(200)
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -8, -8)
MinimapCluster:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 6, -35)

local MinimapFrameBorder = CreateFrame("Frame", nil, Minimap)
MinimapFrameBorder:SetBackdrop(RUI.EdgeTable["UI-DialogBox-Gold-Border"])
MinimapFrameBorder:SetWidth(Minimap:GetWidth() + 8)
MinimapFrameBorder:SetHeight(Minimap:GetHeight() + 8)
MinimapFrameBorder:SetPoint("CENTER")

BuffFrame:ClearAllPoints()
BuffFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -16, 0)
local hookFuncRecurseCancel = false
hooksecurefunc(BuffFrame, "SetPoint", function(frame)
    if(hookFuncRecurseCancel == true) then hookFuncRecurseCancel = false return end
    hookFuncRecurseCancel = true
	frame:ClearAllPoints()
	BuffFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -16, 0)
end)



function onEnter(self, motion)
    MinimapZoneText:Show()
end

function onLeave(self, motion)
    MinimapZoneText:Hide()
end

function onMouseWheel(self, delta)
    Minimap:SetZoom(math.min(math.max(0, Minimap:GetZoom() + delta)), Minimap:GetZoomLevels()- 1)
end

Minimap:SetScript("OnEnter", onEnter)
Minimap:SetScript("OnLeave", onLeave)
Minimap:SetScript("OnMouseWheel", onMouseWheel)

local function OnMouseUp(self,button)
	if button == "RightButton" then
		ToggleDropDownMenu(1,nil,MiniMapTrackingDropDown,"cursor")
	elseif button == "MiddleButton" then
		if(not CalendarFrame) then
			LoadAddOn("Blizzard_Calendar")
		end
		Calendar_Toggle()
    elseif button == "LeftButton" then
        local x, y = GetCursorPosition();
	    x = x / self:GetEffectiveScale();
	    y = y / self:GetEffectiveScale();

	    local cx, cy = self:GetCenter();
	    x = x - cx;
	    y = y - cy;
	    if ( sqrt(x * x + y * y) < (self:GetWidth() / 2) ) then
		    Minimap:PingLocation(x, y);
	    end
	end
end

Minimap:SetScript("OnMouseUp",OnMouseUp)

local events = {}

function events:ADDON_LOADED(...)
    local name = ...
    if name == "Blizzard_TimeManager" then
        TimeManagerClockButton:SetPoint("CENTER", Minimap, "BOTTOM")
    end
end

MinimapFrameBorder:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...);
end);
for k, v in pairs(events) do
 MinimapFrameBorder:RegisterEvent(k);
end