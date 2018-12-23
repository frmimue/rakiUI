local name, RUI = ...

PlayerFrame:SetScript("OnEvent", nil);
PlayerFrame:Hide();

RUI.UI.PlayerUnitFrame = RUI.Util.CreatePlayerUnitFrame(11)
RUI.UI.PlayerUnitFrame:SetWidth(200)
RUI.UI.PlayerUnitFrame:SetHeight(80)
RUI.UI.PlayerUnitFrame:SetPoint("CENTER",UIParent,"CENTER", -350, -300)