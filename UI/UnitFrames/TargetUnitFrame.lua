local name, RUI = ...

TargetFrame:SetScript("OnEvent", nil);
TargetFrame:Hide();

RUI.UI.TargetUnitFrame = RUI.Util.CreateTargetUnitFrame(11)
RUI.UI.TargetUnitFrame:SetWidth(200)
RUI.UI.TargetUnitFrame:SetHeight(80)
RUI.UI.TargetUnitFrame:SetPoint("CENTER",UIParent,"CENTER", 350, -300)


function UpdateUIElementsForClientScene(sceneType)
	if sceneType == Enum.ClientSceneType.MinigameSceneType then
		RUI.UI.PlayerUnitFrame:Hide();
		RUI.UI.TargetUnitFrame:Hide();
	else
		RUI.UI.PlayerUnitFrame:Show();
		RUI.UI.TargetUnitFrame:Update();
	end
end