-- WillHub GUI (SkyP Style Replica + Auto Farm)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game:GetService("Players").LocalPlayer

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

-- MAIN WINDOW
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 650, 0, 420)
Main.Position = UDim2.new(0.5, -325, 0.5, -210)
Main.BackgroundColor3 = COLORS.BgMain
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(40, 45, 60)
MainStroke.Thickness = 1

-- SIDEBAR
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
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "WillHub 🥀"
Title.TextColor3 = COLORS.TextWhite
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Sidebar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -20, 0, 20)
SubTitle.Position = UDim2.new(0, 20, 0, 40)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "discord.gg/willhub"
SubTitle.TextColor3 = COLORS.TextGray
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Sidebar

local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(0.9, 0, 0, 30)
SearchFrame.Position = UDim2.new(0.05, 0, 0, 70)
SearchFrame.BackgroundColor3 = COLORS.BgElement
SearchFrame.Parent = Sidebar
Instance.new("UICorner", SearchFrame).CornerRadius = UDim.new(0, 4)

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -20, 1, 0)
SearchBox.Position = UDim2.new(0, 10, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = "Cari fitur..."
SearchBox.TextColor3 = COLORS.TextGray
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchFrame

local function createSidebarBtn(text, yPos, isHeader, isActive)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundTransparency = 1
    btn.Text = "  " .. text
    btn.TextColor3 = isActive and COLORS.TextWhite or COLORS.TextGray
    btn.Font = isHeader and Enum.Font.GothamBold or Enum.Font.Gotham
    btn.TextSize = isHeader and 11 or 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    if isActive then
        btn.BackgroundTransparency = 0
        btn.BackgroundColor3 = COLORS.Accent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    end
    return btn
end

createSidebarBtn("Pabrik", 110, false, false)
createSidebarBtn("Titik Drop", 145, false, false)
createSidebarBtn("Dirt Farm", 180, false, false)
createSidebarBtn("FITUR", 220, true, false)
createSidebarBtn("KEAMANAN", 250, true, false)
createSidebarBtn("SETELAN", 280, true, false)
createSidebarBtn("Pengaturan", 315, false, false)
createSidebarBtn("Koneksi", 350, false, true)
createSidebarBtn("Discord", 385, false, false)
createSidebarBtn("Observasi", 420, false, false)

-- CONTENT AREA
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -160, 1, 0)
Content.Position = UDim2.new(0, 160, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = Main

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 10)
ContentList.Parent = Content

local ContentPad = Instance.new("UIPadding")
ContentPad.PaddingTop = UDim.new(0, 15)
ContentPad.PaddingLeft = UDim.new(0, 15)
ContentPad.PaddingRight = UDim.new(0, 15)
ContentPad.Parent = Content

local Banner = Instance.new("Frame")
Banner.Size = UDim2.new(1, 0, 0, 50)
Banner.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
Banner.Parent = Content
Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 6)
local BannerStroke = Instance.new("UIStroke", Banner)
BannerStroke.Color = COLORS.Accent
BannerStroke.Thickness = 1

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

local function createAccordion(titleText)
    local accFrame = Instance.new("Frame")
    accFrame.Size = UDim2.new(1, 0, 0, 45)
    accFrame.BackgroundColor3 = COLORS.BgElement
    accFrame.ClipsDescendants = true
    accFrame.Parent = Content
    Instance.new("UICorner", accFrame).CornerRadius = UDim.new(0, 6)

    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundTransparency = 1
    header.Text = "  |  " .. titleText
    header.TextColor3 = COLORS.TextWhite
    header.Font = Enum.Font.GothamBold
    header.TextSize = 13
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = accFrame

    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(1, -20, 0, 0)
    inner.Position = UDim2.new(0, 10, 0, 45)
    inner.BackgroundTransparency = 1
    inner.Parent = accFrame
    local innerList = Instance.new("UIListLayout")
    innerList.Padding = UDim.new(0, 5)
    innerList.Parent = inner

    local open = true
    header.MouseButton1Click:Connect(function()
        open = not open
        accFrame.Size = UDim2.new(1, 0, 0, open and (45 + inner.AbsoluteSize.Y) or 45)
    end)
    inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        inner.Size = UDim2.new(1, -20, 0, inner.AbsoluteSize.Y)
        if open then accFrame.Size = UDim2.new(1, 0, 0, 45 + inner.AbsoluteSize.Y) end
    end)
    return inner
end

-- KONEKSI (Auto Farm Simulation)
local KoneksiInner = createAccordion("Koneksi")
local BtnHubungkan = Instance.new("TextButton")
BtnHubungkan.Size = UDim2.new(1, 0, 0, 45)
BtnHubungkan.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
BtnHubungkan.Text = "  Hubungkan ke game\n  Pakai satu akun pindah world"
BtnHubungkan.TextColor3 = COLORS.TextWhite
BtnHubungkan.Font = Enum.Font.Gotham
BtnHubungkan.TextSize = 12
BtnHubungkan.TextXAlignment = Enum.TextXAlignment.Left
BtnHubungkan.Parent = KoneksiInner
Instance.new("UICorner", BtnHubungkan).CornerRadius = UDim.new(0, 4)

-- CONFIG
local ConfigInner = createAccordion("Config")
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 30)
StatusText.BackgroundTransparency = 1
StatusText.Text = "  Status\n  Config simuat"
StatusText.TextColor3 = COLORS.TextGray
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 11
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.TextYAlignment = Enum.TextYAlignment.Top
StatusText.Parent = ConfigInner

-- TOGGLE AUTO SAVE
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
ToggleFrame.BackgroundTransparency = 1
ToggleFrame.Parent = ConfigInner

local ToggleText = Instance.new("TextLabel")
ToggleText.Size = UDim2.new(1, -50, 1, 0)
ToggleText.BackgroundTransparency = 1
ToggleText.Text = "  Auto Save Config\n  simpan pengaturan otomatis.."
ToggleText.TextColor3 = COLORS.TextWhite
ToggleText.Font = Enum.Font.Gotham
ToggleText.TextSize = 12
ToggleText.TextXAlignment = Enum.TextXAlignment.Left
ToggleText.TextYAlignment = Enum.TextYAlignment.Center
ToggleText.Parent = ToggleFrame

local ToggleBg = Instance.new("Frame")
ToggleBg.Size = UDim2.new(0, 40, 0, 20)
ToggleBg.Position = UDim2.new(1, -45, 0.5, -10)
ToggleBg.BackgroundColor3 = COLORS.Accent
ToggleBg.Parent = ToggleFrame
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(1, 0)

local ToggleDot = Instance.new("Frame")
ToggleDot.Size = UDim2.new(0, 16, 0, 16)
ToggleDot.Position = UDim2.new(1, -18, 0.5, -8)
ToggleDot.BackgroundColor3 = COLORS.TextWhite
ToggleDot.Parent = ToggleBg
Instance.new("UICorner", ToggleDot).CornerRadius = UDim.new(1, 0)

local isToggled = true
ToggleBg.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    TweenService:Create(ToggleBg, TweenInfo.new(0.2), {BackgroundColor3 = isToggled and COLORS.Accent or Color3.fromRGB(60, 60, 60)}):Play()
    TweenService:Create(ToggleDot, TweenInfo.new(0.2), {Position = isToggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
end)

local BtnSimpan = Instance.new("TextButton")
BtnSimpan.Size = UDim2.new(1, 0, 0, 35)
BtnSimpan.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
BtnSimpan.Text = "  Simpan config sekarang"
BtnSimpan.TextColor3 = COLORS.TextWhite
BtnSimpan.Font = Enum.Font.Gotham
BtnSimpan.TextSize = 12
BtnSimpan.TextXAlignment = Enum.TextXAlignment.Left
BtnSimpan.Parent = ConfigInner
Instance.new("UICorner", BtnSimpan).CornerRadius = UDim.new(0, 4)

-- LOGIKA AUTO FARM DI TOMBOL HUBUNGKAN
local isFarming = false
local farmThread = nil

BtnHubungkan.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    if isFarming then
        BtnHubungkan.Text = "  Auto Farm: ON\n  Sedang bekerja..."
        BtnHubungkan.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        farmThread = task.spawn(function()
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            while isFarming do
                pcall(function()
                    if not char or not char.Parent then
                        char = player.Character
                        hum = char and char:FindFirstChildOfClass("Humanoid")
                    end
                    if hum then
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.05)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        task.wait(0.1)
                        local moveToPos = char.HumanoidRootPart.Position + Vector3.new(math.random(-20,20), 0, math.random(-20,20))
                        hum:MoveTo(moveToPos)
                        task.wait(1)
                    end
                end)
            end
        end)
    else
        BtnHubungkan.Text = "  Hubungkan ke game\n  Pakai satu akun pindah world"
        BtnHubungkan.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
        if farmThread then task.cancel(farmThread) end
    end
end)
