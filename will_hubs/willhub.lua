-- WillHub Modern UI (Pure Instance)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Hapus UI lama kalau ada
if CoreGui:FindFirstChild("WillHubModern") then
    CoreGui.WillHubModern:Destroy()
end

-- PALET WARNA (Sesuai Screenshot)
local COLORS = {
    BgMain = Color3.fromRGB(15, 17, 24),
    BgSidebar = Color3.fromRGB(20, 23, 32),
    BgElement = Color3.fromRGB(25, 28, 38),
    Accent = Color3.fromRGB(45, 100, 245),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextGray = Color3.fromRGB(150, 155, 165),
}

-- MAIN FRAME
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

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(40, 45, 60)
MainStroke.Thickness = 1
MainStroke.Parent = Main

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = COLORS.BgSidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Fix corner for sidebar (so it doesn't round on the right side)
local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 10, 1, 0)
SidebarFix.Position = UDim2.new(1, -10, 0, 0)
SidebarFix.BackgroundColor3 = COLORS.BgSidebar
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

-- Judul Sidebar
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

-- Search Bar
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

-- Sidebar Buttons
local function createSidebarButton(text, isHeader, isActive)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.BackgroundTransparency = 1
    btn.Text = "  " .. text
    btn.TextColor3 = isActive and COLORS.TextWhite or COLORS.TextGray
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    
    if isActive then
        btn.BackgroundTransparency = 0
        btn.BackgroundColor3 = COLORS.Accent
        local cor = Instance.new("UICorner", btn)
        cor.CornerRadius = UDim.new(0, 4)
    end
    
    if isHeader then
        btn.Font = Enum.Font.GothamBold
        btn.TextColor3 = Color3.fromRGB(80, 90, 110)
        btn.TextSize = 11
    end
    
    return btn
end

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 4)
UIList.Parent = Sidebar
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- Spacer for list layout
local spacer = Instance.new("Frame", Sidebar)
spacer.Size = UDim2.new(1, 0, 0, 100)
spacer.BackgroundTransparency = 1
spacer.LayoutOrder = 1

local btnPabrik = createSidebarButton("Pabrik", false, false)
btnPabrik.LayoutOrder = 2
local btnTitikDrop = createSidebarButton("Titik Drop", false, false)
btnTitikDrop.LayoutOrder = 3
local btnDirtFarm = createSidebarButton("Dirt Farm", false, false)
btnDirtFarm.LayoutOrder = 4

local spacer2 = Instance.new("Frame", Sidebar)
spacer2.Size = UDim2.new(1, 0, 0, 10)
spacer2.BackgroundTransparency = 1
spacer2.LayoutOrder = 5

local btnFitur = createSidebarButton("FITUR", true, false)
btnFitur.LayoutOrder = 6
local btnKeamanan = createSidebarButton("KEAMANAN", true, false)
btnKeamanan.LayoutOrder = 7
local btnSetelan = createSidebarButton("SETELAN", true, false)
btnSetelan.LayoutOrder = 8

local btnPengaturan = createSidebarButton("Pengaturan", false, false)
btnPengaturan.LayoutOrder = 9
local btnKoneksi = createSidebarButton("Koneksi", false, true) -- Active
btnKoneksi.LayoutOrder = 10
local btnDiscord = createSidebarButton("Discord", false, false)
btnDiscord.LayoutOrder = 11
local btnObservasi = createSidebarButton("Observasi", false, false)
btnObservasi.LayoutOrder = 12

-- CONTENT AREA
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -160, 1, 0)
Content.Position = UDim2.new(0, 160, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = Main

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 10)
ContentList.Parent = Content
ContentList.SortOrder = Enum.SortOrder.LayoutOrder

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 15)
ContentPadding.PaddingLeft = UDim.new(0, 15)
ContentPadding.PaddingRight = UDim.new(0, 15)
ContentPadding.Parent = Content

-- Top Banner
local Banner = Instance.new("Frame")
Banner.Size = UDim2.new(1, 0, 0, 45)
Banner.BackgroundColor3 = Color3.fromRGB(20, 24, 35)
Banner.LayoutOrder = 1
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

-- Fungsi Bikin Accordion (Buka-Tutup)
local function createAccordion(titleText, layoutOrder)
    local accFrame = Instance.new("Frame")
    accFrame.Size = UDim2.new(1, 0, 0, 40)
    accFrame.BackgroundColor3 = COLORS.BgElement
    accFrame.LayoutOrder = layoutOrder
    accFrame.ClipsDescendants = true
    accFrame.Parent = Content
    Instance.new("UICorner", accFrame).CornerRadius = UDim.new(0, 6)

    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, 0, 0, 40)
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
    
    local function updateSize()
        if open then
            accFrame.Size = UDim2.new(1, 0, 0, 45 + inner.Size.Y.Offset)
        else
            accFrame.Size = UDim2.new(1, 0, 0, 40)
        end
    end

    header.MouseButton1Click:Connect(function()
        open = not open
        updateSize()
    end)
    
    -- Auto update size when inner content changes
    inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        inner.Size = UDim2.new(1, -20, 0, inner.AbsoluteSize.Y)
        updateSize()
    end)

    return inner
end

-- Accordion 1: Koneksi
local KoneksiInner = createAccordion("Koneksi", 2)

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

-- Accordion 2: Config
local ConfigInner = createAccordion("Config", 3)

-- Status Text
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

-- Toggle Switch (Auto Save Config)
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
    if isToggled then
        TweenService:Create(ToggleBg, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Accent}):Play()
        TweenService:Create(ToggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
    else
        TweenService:Create(ToggleBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        TweenService:Create(ToggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
    end
end)

-- Button Simpan Config
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
