-- DIOXI HUB - versión raw para Delta Executor
-- Archivo: dioxi.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DIOXI_HUB"
screenGui.Parent = game.CoreGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,280,0,400)
mainFrame.Position = UDim2.new(0,20,0,80)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "DIOXI HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = mainFrame

local listFrame = Instance.new("ScrollingFrame")
listFrame.Size = UDim2.new(1,-10,1,-60)
listFrame.Position = UDim2.new(0,5,0,45)
listFrame.BackgroundTransparency = 1
listFrame.ScrollBarThickness = 6
listFrame.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = listFrame
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0,6)

-- función que crea botones
local function makePlayerButton(targetPlayer)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-10,0,32)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = targetPlayer.Name
    btn.Parent = listFrame

    btn.MouseButton1Click:Connect(function()
        if targetPlayer ~= LocalPlayer then
            targetPlayer:Kick("Lost connection due to error code: 277")
        else
            LocalPlayer:Kick("Lost connection due to error code: 277")
        end
    end)
end

-- refrescar lista
local function refreshList()
    for _,c in pairs(listFrame:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _,p in pairs(Players:GetPlayers()) do
        makePlayerButton(p)
    end
end

Players.PlayerAdded:Connect(refreshList)
Players.PlayerRemoving:Connect(refreshList)

refreshList()
