-- ==========================================
-- 1. UI MODERN (Langsung di sini, tanpa file luar)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("WillHubModern") then CoreGui.WillHubModern:Destroy() end

local COLORS = {
    BgMain = Color3.fromRGB(15, 17, 24),
    BgSidebar = Color3.fromRGB(20, 23, 32),
    BgElement = Color3.fromRGB(25, 28, 38),
    Accent = Color3.fromRGB(45, 100, 245),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextGray = Color3.fromRGB(150, 155, 165),
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubModern"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 650, 0, 420)
Main.Position = UDim2.new(0.5, -325, 0.5, -210)
Main.BackgroundColor3 = COLORS.BgMain
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

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

local btnPabrik = Instance.new("TextButton")
btnPabrik.Size = UDim2.new(0.9, 0, 0, 30)
btnPabrik.Position = UDim2.new(0.05, 0, 0, 100)
btnPabrik.BackgroundTransparency = 1
btnPabrik.Text = "  Pabrik"
btnPabrik.TextColor3 = COLORS.TextGray
btnPabrik.Font = Enum.Font.Gotham
btnPabrik.TextSize = 13
btnPabrik.TextXAlignment = Enum.TextXAlignment.Left
btnPabrik.Parent = Sidebar

local btnKoneksi = Instance.new("TextButton")
btnKoneksi.Size = UDim2.new(0.9, 0, 0, 30)
btnKoneksi.Position = UDim2.new(0.05, 0, 0, 140)
btnKoneksi.BackgroundColor3 = COLORS.Accent
btnKoneksi.Text = "  Koneksi"
btnKoneksi.TextColor3 = COLORS.TextWhite
btnKoneksi.Font = Enum.Font.Gotham
btnKoneksi.TextSize = 13
btnKoneksi.TextXAlignment = Enum.TextXAlignment.Left
btnKoneksi.Parent = Sidebar
Instance.new("UICorner", btnKoneksi).CornerRadius = UDim.new(0, 4)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -160, 1, 0)
Content.Position = UDim2.new(0, 160, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Banner = Instance.new("Frame")
Banner.Size = UDim2.new(1, -30, 0, 45)
Banner.Position = UDim2.new(0, 15, 0, 15)
Banner.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
Banner.Parent = Content
Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 6)

local BannerText = Instance.new("TextLabel")
BannerText.Size = UDim2.new(1, -20, 1, 0)
BannerText.Position = UDim2.new(0, 10, 0, 0)
BannerText.BackgroundTransparency = 1
BannerText.Text = "Referensi game:\nWorld: TIDAK | Inventory: TIDAK | setTile cd/cangan | Panen: TIDAK | Drop: TIDAK"
BannerText.TextColor3 = COLORS.TextGray
BannerText.Font = Enum.Font.Gotham
BannerText.TextSize = 11
BannerText.TextXAlignment = Enum.TextXAlignment.Left
BannerText.TextYAlignment = Enum.TextYAlignment.Center
BannerText.Parent = Banner

-- Toggle Auto Farm
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, -30, 0, 60)
ToggleFrame.Position = UDim2.new(0, 15, 0, 70)
ToggleFrame.BackgroundColor3 = COLORS.BgElement
ToggleFrame.Parent = Content
Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

local ToggleText = Instance.new("TextLabel")
ToggleText.Size = UDim2.new(1, -70, 1, 0)
ToggleText.Position = UDim2.new(0, 15, 0, 0)
ToggleText.BackgroundTransparency = 1
ToggleText.Text = "Auto Farm Growblox"
ToggleText.TextColor3 = COLORS.TextWhite
ToggleText.Font = Enum.Font.GothamBold
ToggleText.TextSize = 14
ToggleText.TextXAlignment = Enum.TextXAlignment.Left
ToggleText.Parent = ToggleFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 25)
ToggleBtn.Position = UDim2.new(1, -60, 0.5, -12.5)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "OFF"
ToggleBtn.TextColor3 = COLORS.TextWhite
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
ToggleBtn.Parent = ToggleFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 4)

-- ==========================================
-- 2. LOGIKA AUTO FARM (Berjalan di belakang)
-- ==========================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local CONFIG = { SEED_NAME = "Hay", WALK_SPEED = 60, FARM_DELAY = 1.5, OUTBOX = false }
local Remotes, PlayerData = {}, nil
local farm, plots, isSelling, running = nil, {}, false, false

-- Load Remote & Data secara aman (Anti-Crash)
task.spawn(function()
    pcall(function()
        Remotes.ManipulateCrop = ReplicatedStorage:WaitForChild("ManipulateCrop", 5)
        Remotes.UseMarket      = ReplicatedStorage:WaitForChild("UseMarket", 5)
        local pd = ReplicatedStorage:FindFirstChild("PlayerData", true)
        if pd then PlayerData = require(pd) end
        print("[WillHub] Sistem Auto Farm siap.")
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
            -- Panen
            if cropType ~= "none" and crop:FindFirstChild("CropStage") and Remotes.ManipulateCrop then
                local stage = crop.CropStage.Value
                local reqStage = (PlayerData and PlayerData.get().crops[cropType]) or 3
                if stage >= reqStage then
                    pcall(function() Remotes.ManipulateCrop:FireServer(crop, "Harvest") end)
                    task.wait(0.1)
                end
            end
            -- Tanam
            if cropType == "none" and Remotes.ManipulateCrop then
                pcall(function() Remotes.ManipulateCrop:FireServer(crop, "PlantSeed", CONFIG.SEED_NAME) end)
                task.wait(0.1)
            end
        end
    end
end

-- Fungsi Tombol Toggle
ToggleBtn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        ToggleBtn.Text = "ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        -- Mulai Loop
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
        ToggleBtn.Text = "OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

print("[WillHub] UI Modern berhasil dimuat! 🥀")
