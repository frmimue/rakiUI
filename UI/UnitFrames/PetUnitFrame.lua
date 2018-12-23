local name, RUI = ...

RUI.UI.PetUnitFrame = RUI.Util.CreatePetUnitFrame(11)
RUI.UI.PetUnitFrame:SetWidth(150)
RUI.UI.PetUnitFrame:SetHeight(60)
RUI.UI.PetUnitFrame:SetPoint("TOPLEFT",RUI.UI.PlayerUnitFrame,"BOTTOMLEFT", 0, 0)