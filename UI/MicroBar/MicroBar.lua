local name, RUI = ...

MicroButtonAndBagsBar:Hide()
CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:SetPoint("TOPLEFT", "UIParent", "TOPLEFT")
MainMenuBarPerformanceBar:ClearAllPoints()
MainMenuBarPerformanceBar:SetPoint("BOTTOM", "MainMenuMicroButton", "BOTTOM")
MoveMicroButtons = function() end

local MicroBarBackground = CreateFrame("Frame", nil, MainMenuBarArtFrame)
MicroBarBackground:SetPoint("RIGHT", "MainMenuMicroButton", "RIGHT", 8, 0)
MicroBarBackground:SetPoint("LEFT", "CharacterMicroButton", "LEFT", -8, 0)
MicroBarBackground:SetPoint("TOP", "MainMenuMicroButton", "TOP", 0, 8)
MicroBarBackground:SetPoint("BOTTOM", "MainMenuMicroButton", "BOTTOM", 0, -8)
MicroBarBackground:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])
MicroBarBackground:SetFrameStrata("BACKGROUND")

local MicroBarEdge = CreateFrame("Frame", nil, MainMenuBarArtFrame)
MicroBarEdge:SetPoint("RIGHT", "MainMenuMicroButton", "RIGHT", 8, 0)
MicroBarEdge:SetPoint("LEFT", "CharacterMicroButton", "LEFT", -8, 0)
MicroBarEdge:SetPoint("TOP", "MainMenuMicroButton", "TOP", 0, 8)
MicroBarEdge:SetPoint("BOTTOM", "MainMenuMicroButton", "BOTTOM", 0, -8)
MicroBarEdge:SetBackdrop(RUI.EdgeTable["UI-DialogBox-Border"])