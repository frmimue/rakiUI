local name, RUI = ...

for i=1, 10  do 
    _G["ChatFrame"..i]:SetClampedToScreen(false);
end

ChatBorderFrame = CreateFrame("Frame", nil, UIParent)
ChatBorderFrame:SetPoint("TOP", GeneralDockManager, "TOP", 0, 0)
ChatBorderFrame:SetPoint("BOTTOMLEFT", ChatFrame1EditBox, "BOTTOMLEFT", 0, 0)
ChatBorderFrame:SetPoint("BOTTOMRIGHT", ChatFrame1EditBox, "BOTTOMRIGHT", 0, 0)
ChatBorderFrame:SetBackdrop(RUI.BackgroundTable["UI-DialogBox-Background"])
ChatBorderFrame:SetFrameStrata("BACKGROUND")

ChatBorderFrame.Container = CreateFrame("Frame", nil, ChatBorderFrame)
ChatBorderFrame.Container:SetAllPoints(ChatBorderFrame)
ChatBorderFrame.Container:SetFrameStrata("DIALOG")
ChatBorderFrame.Container:SetFrameLevel(ChatBorderFrame:GetFrameLevel() + 2)

ChatBorderFrame.Container.Border = CreateFrame("Frame", nil, ChatBorderFrame.Container)
ChatBorderFrame.Container.Border:SetAllPoints(ChatBorderFrame.Container)
ChatBorderFrame.Container.Border:SetBackdrop(RUI.EdgeTable["UI-Tooltip-Border"])

ChatBorderFrame.Seperator = ChatBorderFrame.Container:CreateTexture()
ChatBorderFrame.Seperator:SetTexture("Interface\\RAIDFRAME\\Raid-HSeparator")
ChatBorderFrame.Seperator:SetHeight(8)
ChatBorderFrame.Seperator:SetPoint("TOPLEFT", ChatFrame1EditBox, "TOPLEFT", 2, -2)
ChatBorderFrame.Seperator:SetPoint("TOPRIGHT", ChatFrame1EditBox, "TOPRIGHT", -2, -2)

ChatFrame1EditBoxLeft:Hide()
ChatFrame1EditBoxMid:Hide()
ChatFrame1EditBoxRight:Hide()

local origChatEdit_ActivateChat = ChatEdit_ActivateChat
ChatEdit_ActivateChat = function(...)
    origChatEdit_ActivateChat(...)
    ChatFrame1EditBoxFocusLeft:Hide()
    ChatFrame1EditBoxFocusMid:Hide()
    ChatFrame1EditBoxFocusRight:Hide()
end