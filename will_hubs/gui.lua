-- WillHub GUI (100% SkyP Replica)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game:GetService("Players").LocalPlayer

if CoreGui:FindFirstChild("WillHubModern") then CoreGui.WillHubModern:Destroy() end

local C = {
    BgMain = Color3.fromRGB(13, 15, 23),
    BgSidebar = Color3.fromRGB(17, 20, 28),
    BgElement = Color3.fromRGB(23, 27, 38),
    Accent = Color3.fromRGB(43, 104, 227),
    TextW = Color3.fromRGB(255, 255, 255),
    TextG = Color3.fromRGB(130, 140, 160),
    TextD = Color3.fromRGB(80, 90, 110)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubModern"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main Window (Lebih lebar sesuai screenshot)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 680, 0, 400)
Main.Position = UDim2.new(0.5, -340, 0.5, -200)
Main.BackgroundColor3 = C.BgMain
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(30, 35, 50)

-- ================= SIDEBAR =================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 170, 1, 0)
Sidebar.BackgroundColor3 = C.BgSidebar
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)
-- Fix ujung kanan sidebar biar ga melengkung
local SideFix = Instance.new("Frame", Sidebar)
SideFix.Size = UDim2.new(0, 10, 1, 0)
SideFix.Position = UDim2.new(1, -10, 0, 0)
SideFix.BackgroundColor3 = C.BgSidebar
SideFix.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 15, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "WillHub 🥀"
Title.TextColor3 = C.TextW
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Sidebar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -20, 0, 15)
SubTitle.Position = UDim2.new(0, 15, 0, 40)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "discord.gg/willhub"
SubTitle.TextColor3 = C.TextG
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Sidebar

local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -20, 0, 30)
SearchFrame.Position = UDim2.new(0, 10, 0, 65)
SearchFrame.BackgroundColor3 = C.BgElement
SearchFrame.Parent = Sidebar
Instance.new("UICorner", SearchFrame).CornerRadius = UDim.new(0, 4)

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -20, 1, 0)
SearchBox.Position = UDim2.new(0, 10, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = "Cari fitur..."
SearchBox.TextColor3 = C.TextG
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 11
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchFrame

-- Sidebar Menu Items (Posisi Y disesuaikan persis)
local function addMenu(text, y, isHeader, isActive)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 26)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundTransparency = 1
    btn.Text = "  " .. text
    btn.TextColor3 = isHeader and C.TextD or (isActive and C.TextW or C.TextG)
    btn.Font = isHeader and Enum.Font.GothamBold or Enum.Font.Gotham
    btn.TextSize = isHeader and 11 or 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    
    if isActive then
        btn.BackgroundTransparency = 0
        btn.BackgroundColor3 = C.Accent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    end
    return btn
end

addMenu("Pabrik", 110, false, false)
addMenu("Titik Drop", 140, false, false)
addMenu("Dirt Farm", 170, false, false)
addMenu("FITUR", 210, true, false)
addMenu("KEAMANAN", 235, true, false)
addMenu("SETELAN", 260, true, false)
addMenu("Pengaturan", 290, false, false)
addMenu("Koneksi", 320, false, true) -- Active
addMenu("Discord", 350, false, false)
addMenu("Observasi", 380, false, false)

-- ================= CONTENT AREA =================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -170, 1, 0)
Content.Position = UDim2.new(0, 170, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = Main

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 10)
ContentList.Parent = Content
ContentList.SortOrder = Enum.SortOrder.LayoutOrder

local ContentPad = Instance.new("UIPadding")
ContentPad.PaddingTop = UDim.new(0, 15)
ContentPad.PaddingLeft = UDim.new(0, 15)
ContentPad.PaddingRight = UDim.new(0, 15)
ContentPad.Parent = Content

-- Banner Referensi Game
local Banner = Instance.new("Frame")
Banner.Size = UDim2.new(1, 0, 0, 45)
Banner.BackgroundColor3 = C.BgElement
Banner.LayoutOrder = 1
Banner.Parent = Content
Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 4)

-- Garis biru kecil di kiri banner
local BannerLine = Instance.new("Frame")
BannerLine.Size = UDim2.new(0, 3, 0.8, 0)
BannerLine.Position = UDim2.new(0, 0, 0.1, 0)
BannerLine.BackgroundColor3 = C.Accent
BannerLine.Parent = Banner

local BannerText = Instance.new("TextLabel")
BannerText.Size = UDim2.new(1, -20, 1, 0)
BannerText.Position = UDim2.new(0, 10, 0, 0)
BannerText.BackgroundTransparency = 1
BannerText.Text = "Referensi game:\nWorld: TIDAK | Inventory: TIDAK | setTile cd/cangan | Panen: TIDAK | Drop:\nTIDAK | Pohon: TIDAK | Pemain: TIDAK | Animasi: OK | Dropdown: OK"
BannerText.TextColor3 = C.TextG
BannerText.Font = Enum.Font.Gotham
BannerText.TextSize = 10
BannerText.TextXAlignment = Enum.TextXAlignment.Left
BannerText.TextYAlignment = Enum.TextYAlignment.Center
BannerText.Parent = Banner

-- Fungsi Accordion
local function createAcc(title, layoutOrder)
    local acc = Instance.new("Frame")
    acc.Size = UDim2.new(1, 0, 0, 40)
    acc.BackgroundColor3 = C.BgElement
    acc.LayoutOrder = layoutOrder
    acc.ClipsDescendants = true
    acc.Parent = Content
    Instance.new("UICorner", acc).CornerRadius = UDim.new(0, 4)

    local line = Instance.new("Frame", acc)
    line.Size = UDim2.new(0, 3, 0, 15)
    line.Position = UDim2.new(0, 10, 0.5, -7.5)
    line.BackgroundColor3 = C.Accent

    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundTransparency = 1
    header.Text = "    " .. title
    header.TextColor3 = C.TextW
    header.Font = Enum.Font.GothamBold
    header.TextSize = 12
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = acc

    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(1, -20, 0, 0)
    inner.Position = UDim2.new(0, 10, 0, 40)
    inner.BackgroundTransparency = 1
    inner.Parent = acc
    local innerList = Instance.new("UIListLayout", inner)
    innerList.Padding = UDim.new(0, 5)

    local open = true
    header.MouseButton1Click:Connect(function()
        open = not open
        acc.Size = UDim2.new(1, 0, 0, open and (40 + inner.AbsoluteSize.Y) or 40)
    end)
    inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        inner.Size = UDim2.new(1, -20, 0, inner.AbsoluteSize.Y)
        if open then acc.Size = UDim2.new(1, 0, 0, 40 + inner.AbsoluteSize.Y) end
    end)
    return inner
end

-- Accordion 1: Koneksi
local KoneksiInner = createAcc("Koneksi", 2)
local BtnHubungkan = Instance.new("TextButton")
BtnHubungkan.Size = UDim2.new(1, 0, 0, 45)
BtnHubungkan.BackgroundColor3 = Color3.fromRGB(30, 36, 48)
BtnHubungkan.Text = "  Hubungkan ke game\n  Pakai satu akun pindah world"
BtnHubungkan.TextColor3 = C.TextG
BtnHubungkan.Font = Enum.Font.Gotham
BtnHubungkan.TextSize = 11
BtnHubungkan.TextXAlignment = Enum.TextXAlignment.Left
BtnHubungkan.Parent = KoneksiInner
Instance.new("UICorner", BtnHubungkan).CornerRadius = UDim.new(0, 4)
local Arrow1 = Instance.new("TextLabel", BtnHubungkan)
Arrow1.Size = UDim2.new(0, 20, 1, 0)
Arrow1.Position = UDim2.new(1, -25, 0, 0)
Arrow1.BackgroundTransparency = 1
Arrow1.Text = ">"
Arrow1.TextColor3 = C.Accent
Arrow1.TextSize = 14

-- Accordion 2: Config
local ConfigInner = createAcc("Config", 3)
local StatusTxt = Instance.new("TextLabel")
StatusTxt.Size = UDim2.new(1, 0, 0, 30)
StatusTxt.BackgroundTransparency = 1
StatusTxt.Text = "  Status\n  Config simuat"
StatusTxt.TextColor3 = C.TextG
StatusTxt.Font = Enum.Font.Gotham
StatusTxt.TextSize = 11
StatusTxt.TextXAlignment = Enum.TextXAlignment.Left
StatusTxt.TextYAlignment = Enum.TextYAlignment.Top
StatusTxt.Parent = ConfigInner

-- Toggle
local TFrame = Instance.new("Frame")
TFrame.Size = UDim2.new(1, 0, 0, 45)
TFrame.BackgroundColor3 = Color3.fromRGB(30, 36, 48)
TFrame.Parent = ConfigInner
Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 4)

local TText = Instance.new("TextLabel")
TText.Size = UDim2.new(1, -50, 1, 0)
TText.Position = UDim2.new(0, 10, 0, 0)
TText.BackgroundTransparency = 1
TText.Text = "  Auto Save Config\n  simpan pengaturan otomatis.."
TText.TextColor3 = C.TextW
TText.Font = Enum.Font.Gotham
TText.TextSize = 11
TText.TextXAlignment = Enum.TextXAlignment.Left
TText.Parent = TFrame

local TBg = Instance.new("Frame")
TBg.Size = UDim2.new(0, 36, 0, 18)
TBg.Position = UDim2.new(1, -45, 0.5, -9)
TBg.BackgroundColor3 = C.Accent
TBg.Parent = TFrame
Instance.new("UICorner", TBg).CornerRadius = UDim.new(1, 0)
local TDot = Instance.new("Frame")
TDot.Size = UDim2.new(0, 14, 0, 14)
TDot.Position = UDim2.new(1, -16, 0.5, -7)
TDot.BackgroundColor3 = C.TextW
TDot.Parent = TBg
Instance.new("UICorner", TDot).CornerRadius = UDim.new(1, 0)

local isTog = true
TBg.MouseButton1Click:Connect(function()
    isTog = not isTog
    TweenService:Create(TBg, TweenInfo.new(0.2), {BackgroundColor3 = isTog and C.Accent or Color3.fromRGB(60, 60, 60)}):Play()
    TweenService:Create(TDot, TweenInfo.new(0.2), {Position = isTog and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
end)

-- Tombol Simpan
local BtnSimpan = Instance.new("TextButton")
BtnSimpan.Size = UDim2.new(1, 0, 0, 40)
BtnSimpan.BackgroundColor3 = Color3.fromRGB(30, 36, 48)
BtnSimpan.Text = "  Simpan config sekarang"
BtnSimpan.TextColor3 = C.TextW
BtnSimpan.Font = Enum.Font.Gotham
BtnSimpan.TextSize = 11
BtnSimpan.TextXAlignment = Enum.TextXAlignment.Left
BtnSimpan.Parent = ConfigInner
Instance.new("UICorner", BtnSimpan).CornerRadius = UDim.new(0, 4)
local Arrow2 = Instance.new("TextLabel", BtnSimpan)
Arrow2.Size = UDim2.new(0, 20, 1, 0)
Arrow2.Position = UDim2.new(1, -25, 0, 0)
Arrow2.BackgroundTransparency = 1
Arrow2.Text = ">"
Arrow2.TextColor3 = C.Accent
Arrow2.TextSize = 14

-- ================= LOGIKA AUTO FARM =================
local isFarming = false
local farmThread = nil

BtnHubungkan.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    if isFarming then
        BtnHubungkan.Text = "  Auto Farm: ON\n  Sedang bekerja..."
        BtnHubungkan.TextColor3 = Color3.fromRGB(50, 200, 50)
        
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
        BtnHubungkan.TextColor3 = C.TextG
        if farmThread then task.cancel(farmThread) end
    end
end)
