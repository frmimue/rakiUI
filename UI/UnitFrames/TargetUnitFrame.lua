local name, RUI = ...

TargetFrame:SetScript("OnEvent", nil);
TargetFrame:Hide();

RUI.UI.TargetUnitFrame = RUI.Util.CreateTargetUnitFrame(11)
RUI.UI.TargetUnitFrame:SetWidth(200)
RUI.UI.TargetUnitFrame:SetHeight(80)
RUI.UI.TargetUnitFrame:SetPoint("CENTER",UIParent,"CENTER", 350, -300)