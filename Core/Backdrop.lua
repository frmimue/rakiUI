local name, RUI = ...

RUI.BackgroundTable = {}
RUI.EdgeTable = {}

local function AddToBackgroundTable(name, filePath)
    RUI.BackgroundTable[name] = {
        bgFile = filePath,
        insets = {
            left = 4,
            right = 4,
            top = 4,
            bottom = 4
        }
    }
end

local function AddToEdgeTable(name, filePath)
    RUI.EdgeTable[name] = {
        edgeFile = filePath,
        tile = true,
        edgeSize = 16,
        insets = {
            left = 4,
            right = 4,
            top = 4,
            bottom = 4
        }
    }
end

AddToEdgeTable("UI-Tooltip-Border", "Interface\\Tooltips\\UI-Tooltip-Border")
AddToEdgeTable("UI-DialogBox-Border", "Interface\\DialogFrame\\UI-DialogBox-Border")
AddToEdgeTable("UI-DialogBox-Gold-Border", "Interface\\DialogFrame\\UI-DialogBox-Gold-Border")

AddToBackgroundTable("UI-DialogBox-Background", "Interface\\DialogFrame\\UI-DialogBox-Background")