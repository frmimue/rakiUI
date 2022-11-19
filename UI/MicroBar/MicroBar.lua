local name, RUI = ...

RUI.MicroButtonBar = CreateFrame("Frame", nil, UIParent)
RUI.MicroButtonBar:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 10, -10)
RUI.MicroButtonBar:SetWidth(100)
RUI.MicroButtonBar:SetHeight(CharacterMicroButton:GetHeight())
RUI.MicroButtonBar:SetScale(MicroButtonAndBagsBar:GetScale())
RUI.MicroButtonBar:Show()

CharacterMicroButton:SetParent(RUI.MicroButtonBar)
CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:SetPoint("BOTTOMLEFT", RUI.MicroButtonBar, "BOTTOMLEFT")

SpellbookMicroButton:SetParent(RUI.MicroButtonBar)
SpellbookMicroButton:ClearAllPoints()
SpellbookMicroButton:SetPoint("BOTTOMLEFT", CharacterMicroButton, "BOTTOMRIGHT", 1, 0)

TalentMicroButton:SetParent(RUI.MicroButtonBar)
TalentMicroButton:ClearAllPoints()
TalentMicroButton:SetPoint("BOTTOMLEFT", SpellbookMicroButton, "BOTTOMRIGHT", 1, 0)

AchievementMicroButton:SetParent(RUI.MicroButtonBar)
AchievementMicroButton:ClearAllPoints()
AchievementMicroButton:SetPoint("BOTTOMLEFT", TalentMicroButton, "BOTTOMRIGHT", 1, 0)

QuestLogMicroButton:SetParent(RUI.MicroButtonBar)
QuestLogMicroButton:ClearAllPoints()
QuestLogMicroButton:SetPoint("BOTTOMLEFT", AchievementMicroButton, "BOTTOMRIGHT", 1, 0)

GuildMicroButton:SetParent(RUI.MicroButtonBar)
GuildMicroButton:ClearAllPoints()
GuildMicroButton:SetPoint("BOTTOMLEFT", QuestLogMicroButton, "BOTTOMRIGHT", 1, 0)

LFDMicroButton:SetParent(RUI.MicroButtonBar)
LFDMicroButton:ClearAllPoints()
LFDMicroButton:SetPoint("BOTTOMLEFT", GuildMicroButton, "BOTTOMRIGHT", 1, 0)

CollectionsMicroButton:SetParent(RUI.MicroButtonBar)
CollectionsMicroButton:ClearAllPoints()
CollectionsMicroButton:SetPoint("BOTTOMLEFT", LFDMicroButton, "BOTTOMRIGHT", 1, 0)

EJMicroButton:SetParent(RUI.MicroButtonBar)
EJMicroButton:ClearAllPoints()
EJMicroButton:SetPoint("BOTTOMLEFT", CollectionsMicroButton, "BOTTOMRIGHT", 1, 0)

MainMenuMicroButton:SetParent(RUI.MicroButtonBar)
MainMenuMicroButton:ClearAllPoints()
MainMenuMicroButton:SetPoint("BOTTOMLEFT", EJMicroButton, "BOTTOMRIGHT", 1, 0)

MicroButtonAndBagsBar:Hide()

-- RUI.MicroButtonBar.Background = CreateFrame("Frame", nil, RUI.MicroButtonBar, BackdropTemplateMixin and "BackdropTemplate")
-- RUI.MicroButtonBar.Background:SetPoint("RIGHT", "MainMenuMicroButton", "RIGHT", 8, 0)
-- RUI.MicroButtonBar.Background:SetPoint("LEFT", "CharacterMicroButton", "LEFT", -8, 0)
-- RUI.MicroButtonBar.Background:SetPoint("TOP", "MainMenuMicroButton", "TOP", 0, 8)
-- RUI.MicroButtonBar.Background:SetPoint("BOTTOM", "MainMenuMicroButton", "BOTTOM", 0, -8)
-- RUI.MicroButtonBar.Background:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])
-- RUI.MicroButtonBar.Background:SetFrameStrata("BACKGROUND")

-- RUI.MicroButtonBar.Edge = CreateFrame("Frame", nil, RUI.MicroButtonBar, BackdropTemplateMixin and "BackdropTemplate")
-- RUI.MicroButtonBar.Edge:SetPoint("RIGHT", "MainMenuMicroButton", "RIGHT", 8, 0)
-- RUI.MicroButtonBar.Edge:SetPoint("LEFT", "CharacterMicroButton", "LEFT", -8, 0)
-- RUI.MicroButtonBar.Edge:SetPoint("TOP", "MainMenuMicroButton", "TOP", 0, 8)
-- RUI.MicroButtonBar.Edge:SetPoint("BOTTOM", "MainMenuMicroButton", "BOTTOM", 0, -8)
-- RUI.MicroButtonBar.Edge:SetBackdrop(RUI.EdgeTable["UI-DialogBox-Border"])