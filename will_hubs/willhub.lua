-- ==========================================
-- WillHub - Growblox (Modern UI + Floating Toggle)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubModern") then CoreGui.WillHubModern:Destroy() end

local COLORS = {
    BgMain = Color3.fromRGB(15, 17, 24),
    BgSidebar = Color3.fromRGB(20, 23, 32),
    BgElement = Color3.fromRGB(25, 28, 38),
    Accent = Color3.fromRGB(45, 100, 245),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextGray = Color3.fromRGB(150, 155, 165),
    Green = Color3.fromRGB(50, 200, 50),
    Red = Color3.fromRGB(200, 50, 50)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubModern"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- ==========================================
-- 1. FLOATING TOGGLE BUTTON (Buka/Tutup UI)
-- ==========================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "FloatingToggle"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = COLORS.Accent
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = COLORS.TextWhite
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
ToggleBtn.Active = true
ToggleBtn.Draggable = true -- Biar bisa digeser
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 650, 0, 420)
Main.Position = UDim2.new(0.5, -325, 0.5, -210)
Main.BackgroundColor3 = COLORS.BgMain
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- Logika klik (bedain antara klik buat buka UI vs digeser)
local clickTime = 0
local startPos = Vector2.new(0,0)
ToggleBtn.MouseButton1Down:Connect(function()
    clickTime = tick()
    startPos = ToggleBtn.AbsolutePosition
end)
ToggleBtn.MouseButton1Up:Connect(function()
    local timePassed = tick() - clickTime
    local distance = (ToggleBtn.AbsolutePosition - startPos).Magnitude
    if timePassed < 0.2 and distance < 5 then
        Main.Visible = not Main.Visible
    end
end)

-- ==========================================
-- 2. SIDEBAR
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = COLORS.BgSidebar
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 10, 1, 0)
SidebarFix.Position = UDim2.new(1, -10, 0, 0)
SidebarFix.BackgroundColor3 = COLORS.BgSidebar
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "  WillHub 🥀"
Title.TextColor3 = COLORS.TextWhite
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Sidebar

local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(0.9, 0, 0, 30)
SearchFrame.Position = UDim2.new(0.05, 0, 0, 60)
SearchFrame.BackgroundColor3 = COLORS.BgElement
SearchFrame.Parent = Sidebar
Instance.new("UICorner", SearchFrame).CornerRadius = UDim.new(0, 4)

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -10, 1, 0)
SearchBox.Position = UDim2.new(0, 5, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = "Cari fitur..."
SearchBox.TextColor3 = COLORS.TextGray
SearchBox.PlaceholderColor3 = COLORS.TextGray
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchFrame

-- ==========================================
-- 3. KONTEN AREA (TAB SYSTEM)
-- ==========================================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -160, 1, 0)
Content.Position = UDim2.new(0, 160, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function createTab(name, layoutOrder)
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(1, -30, 1, -30)
    tab.Position = UDim2.new(0, 15, 0, 15)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    tab.LayoutOrder = layoutOrder
    tab.Parent = Content
    return tab
end

local TabFarm = createTab("Farm", 1)
local TabAutoClear = createTab("Auto Clear", 2)
local TabAutoDF = createTab("Auto DF", 3)
local TabSetting = createTab("Setting", 4)

-- SIDEBAR BUTTONS (Menu)
local function createSidebarButton(text, layoutOrder)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 100 + (layoutOrder * 40))
    btn.BackgroundColor3 = COLORS.BgElement
    btn.Text = "  " .. text
    btn.TextColor3 = COLORS.TextGray
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    return btn
end

local btnFarm = createSidebarButton("Farm", 0)
local btnAutoClear = createSidebarButton("Auto Clear", 1)
local btnAutoDF = createSidebarButton("Auto DF", 2)
local btnSetting = createSidebarButton("Setting", 3)

local activeBtn = btnFarm
local function switchTab(tabFrame, btn)
    TabFarm.Visible = false
    TabAutoClear.Visible = false
    TabAutoDF.Visible = false
    TabSetting.Visible = false
    
    tabFrame.Visible = true
    
    activeBtn.BackgroundColor3 = COLORS.BgElement
    activeBtn.TextColor3 = COLORS.TextGray
    
    btn.BackgroundColor3 = COLORS.Accent
    btn.TextColor3 = COLORS.TextWhite
    activeBtn = btn
end

btnFarm.MouseButton1Click:Connect(function() switchTab(TabFarm, btnFarm) end)
btnAutoClear.MouseButton1Click:Connect(function() switchTab(TabAutoClear, btnAutoClear) end)
btnAutoDF.MouseButton1Click:Connect(function() switchTab(TabAutoDF, btnAutoDF) end)
btnSetting.MouseButton1Click:Connect(function() switchTab(TabSetting, btnSetting) end)

-- Set Default Tab
switchTab(TabFarm, btnFarm)

-- ==========================================
-- 4. ISI MASING-MASING TAB
-- ==========================================

-- [TAB FARM]
local function createToggle(parent, text, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.Position = UDim2.new(0, 0, 0, yPos)
    frame.BackgroundColor3 = COLORS.BgElement
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TextWhite
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 45, 0, 25)
    btn.Position = UDim2.new(1, -60, 0.5, -12.5)
    btn.BackgroundColor3 = COLORS.Red
    btn.Text = "OFF"
    btn.TextColor3 = COLORS.TextWhite
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    return btn
end

local FarmToggle = createToggle(TabFarm, "Auto Farm Growblox", 0)
local ClearToggle = createToggle(TabFarm, "Auto Clear (Nanti)", 55)
local DfToggle = createToggle(TabFarm, "Auto DF (Nanti)", 110)

-- [TAB AUTO CLEAR]
local ClearInfo = Instance.new("TextLabel")
ClearInfo.Size = UDim2.new(1, 0, 0, 50)
ClearInfo.BackgroundColor3 = COLORS.BgElement
ClearInfo.Text = "Fitur Auto Clear akan segera hadir!"
ClearInfo.TextColor3 = COLORS.TextWhite
ClearInfo.Font = Enum.Font.Gotham
ClearInfo.TextSize = 14
ClearInfo.Parent = TabAutoClear
Instance.new("UICorner", ClearInfo).CornerRadius = UDim.new(0, 6)

-- [TAB AUTO DF]
local DFInfo = Instance.new("TextLabel")
DFInfo.Size = UDim2.new(1, 0, 0, 50)
DFInfo.BackgroundColor3 = COLORS.BgElement
DFInfo.Text = "Fitur Auto DF akan segera hadir!"
DFInfo.TextColor3 = COLORS.TextWhite
DFInfo.Font = Enum.Font.Gotham
DFInfo.TextSize = 14
DFInfo.Parent = TabAutoDF
Instance.new("UICorner", DFInfo).CornerRadius = UDim.new(0, 6)

-- [TAB SETTING]
local SettingInfo = Instance.new("TextLabel")
SettingInfo.Size = UDim2.new(1, 0, 0, 50)
SettingInfo.BackgroundColor3 = COLORS.BgElement
SettingInfo.Text = "Setting (Save/Load Config) akan segera hadir!"
SettingInfo.TextColor3 = COLORS.TextWhite
SettingInfo.Font = Enum.Font.Gotham
SettingInfo.TextSize = 14
SettingInfo.Parent = TabSetting
Instance.new("UICorner", SettingInfo).CornerRadius = UDim.new(0, 6)


-- ==========================================
-- 5. LOGIKA AUTO FARM
-- ==========================================
local CONFIG = { SEED_NAME = "Hay", FARM_DELAY = 1.5 }
local Remotes, PlayerData = {}, nil
local farm, plots, running = nil, {}, false

task.spawn(function()
    pcall(function()
        Remotes.ManipulateCrop = ReplicatedStorage:WaitForChild("ManipulateCrop", 5)
        Remotes.UseMarket      = ReplicatedStorage:WaitForChild("UseMarket", 5)
        local pd = ReplicatedStorage:FindFirstChild("PlayerData", true)
        if pd then PlayerData = require(pd) end
    end)
end)

local function findFarm()
    for i = 1, 8 do
        local f = workspace:FindFirstChild("Farm" .. i)
        if f and f:FindFirstChild("Owner") and f.Owner.Value == player then farm = f; break end
    end
    if not farm then return end
    plots = {}
    for i = 1, 6 do
        local plot = farm:FindFirstChild("Plot" .. i)
        if plot then table.insert(plots, plot) end
    end
end

local function processPlot(plot)
    for _, crop in pairs(plot:GetChildren()) do
        if crop:FindFirstChild("CropType") then
            local cropType = crop.CropType.Value
            if cropType ~= "none" and crop:FindFirstChild("CropStage") and Remotes.ManipulateCrop then
                local stage = crop.CropStage.Value
                local reqStage = (PlayerData and PlayerData.get().crops[cropType]) or 3
                if stage >= reqStage then
                    pcall(function() Remotes.ManipulateCrop:FireServer(crop, "Harvest") end)
                    task.wait(0.1)
                end
            end
            if cropType == "none" and Remotes.ManipulateCrop then
                pcall(function() Remotes.ManipulateCrop:FireServer(crop, "PlantSeed", CONFIG.SEED_NAME) end)
                task.wait(0.1)
            end
        end
    end
end

FarmToggle.MouseButton1Click:Connect(function()
    running = not running
    if running then
        FarmToggle.Text = "ON"
        FarmToggle.BackgroundColor3 = COLORS.Green
        task.spawn(function()
            while running do
                pcall(function()
                    if #plots == 0 then findFarm() end
                    for _, plot in pairs(plots) do
                        if not running then break end
                        processPlot(plot)
                        task.wait(0.1)
                    end
                end)
                task.wait(CONFIG.FARM_DELAY)
            end
        end)
    else
        FarmToggle.Text = "OFF"
        FarmToggle.BackgroundColor3 = COLORS.Red
    end
end)

print("[WillHub] UI dengan Floating Toggle berhasil dimuat! 🥀")
