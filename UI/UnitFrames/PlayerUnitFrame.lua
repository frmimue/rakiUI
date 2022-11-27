local name, RUI = ...

ComboPointPlayerFrame:SetScript("OnEvent", nil);
ComboPointPlayerFrame:Hide();

PlayerFrame:SetScript("OnEvent", nil);
PlayerFrame:Hide();

RUI.UI.PlayerUnitFrame = RUI.Util.CreatePlayerUnitFrame(11)
RUI.UI.PlayerUnitFrame:SetWidth(200)
RUI.UI.PlayerUnitFrame:SetHeight(80)
RUI.UI.PlayerUnitFrame:SetPoint("TOP",UIParent,"CENTER", -350, -260)