local name, RUI = ...

Boss1TargetFrame:SetScript("OnEvent", nil);
Boss1TargetFrame:Hide();
Boss2TargetFrame:SetScript("OnEvent", nil);
Boss2TargetFrame:Hide();
Boss3TargetFrame:SetScript("OnEvent", nil);
Boss3TargetFrame:Hide();
Boss4TargetFrame:SetScript("OnEvent", nil);
Boss4TargetFrame:Hide();
Boss5TargetFrame:SetScript("OnEvent", nil);
Boss5TargetFrame:Hide();

RUI.UI.Boss1UnitFrame = RUI.Util.CreateBossUnitFrame("boss1", 11)
RUI.UI.Boss1UnitFrame:SetWidth(200)
RUI.UI.Boss1UnitFrame:SetHeight(60)
RUI.UI.Boss1UnitFrame:SetPoint("CENTER",UIParent,"CENTER", 800  , 250)

RUI.UI.Boss2UnitFrame = RUI.Util.CreateBossUnitFrame("boss2", 11)
RUI.UI.Boss2UnitFrame:SetWidth(200)
RUI.UI.Boss2UnitFrame:SetHeight(60)
RUI.UI.Boss2UnitFrame:SetPoint("TOPLEFT",RUI.UI.Boss1UnitFrame,"BOTTOMLEFT", 0, -30)

RUI.UI.Boss3UnitFrame = RUI.Util.CreateBossUnitFrame("boss3", 11)
RUI.UI.Boss3UnitFrame:SetWidth(200)
RUI.UI.Boss3UnitFrame:SetHeight(60)
RUI.UI.Boss3UnitFrame:SetPoint("TOPLEFT",RUI.UI.Boss2UnitFrame,"BOTTOMLEFT", 0, -30)

RUI.UI.Boss4UnitFrame = RUI.Util.CreateBossUnitFrame("boss4", 11)
RUI.UI.Boss4UnitFrame:SetWidth(200)
RUI.UI.Boss4UnitFrame:SetHeight(60)
RUI.UI.Boss4UnitFrame:SetPoint("TOPLEFT",RUI.UI.Boss3UnitFrame,"BOTTOMLEFT", 0, -30)

RUI.UI.Boss5UnitFrame = RUI.Util.CreateBossUnitFrame("boss5", 11)
RUI.UI.Boss5UnitFrame:SetWidth(200)
RUI.UI.Boss5UnitFrame:SetHeight(60)
RUI.UI.Boss5UnitFrame:SetPoint("TOPLEFT",RUI.UI.Boss4UnitFrame,"BOTTOMLEFT", 0, -30)