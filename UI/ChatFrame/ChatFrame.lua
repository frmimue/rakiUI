local name, RUI = ...

for i=1, 10  do 
    _G["ChatFrame"..i]:SetClampedToScreen(false);
end

local ChatBorderFrame = CreateFrame("Frame", nil, UIParent)
ChatBorderFrame:SetPoint("TOPLEFT", ChatFrame1Background, "TOPLEFT", -4, 4)
ChatBorderFrame:SetPoint("BOTTOMRIGHT", ChatFrame1Background, "BOTTOMRIGHT", 4, -4)
ChatBorderFrame:SetBackdrop(RUI.EdgeTable["UI-DialogBox-Border"])