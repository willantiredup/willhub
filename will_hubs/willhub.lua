-- ==========================================
-- WillHub - Growblox (Clean, Resizable & Fixed)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("WillHubModern") then CoreGui.WillHubModern:Destroy() end

-- GANTI URL DI BAWAH INI DENGAN ID GAMBAR LOGO KAMU
local LOGO_URL = "rbxassetid://1234567890" 

local COLORS = {
    BgMain = Color3.fromRGB(15, 17, 24),
    BgSidebar = Color3.fromRGB(20, 23, 32),
    BgElement = Color3.fromRGB(25, 28, 38),
    Accent = Color3.fromRGB(45, 100, 245),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextGray = Color3.fromRGB(150, 155, 165),
    Red = Color3.fromRGB(200, 50, 50)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubModern"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- ==========================================
-- 1. FLOATING TOGGLE BUTTON
-- ==========================================
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "FloatingToggle"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = COLORS.BgMain
ToggleBtn.Image = LOGO_URL
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = COLORS.Accent
BtnStroke.Thickness = 2

-- ==========================================
-- 2. MAIN WINDOW
-- ==========================================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 480, 0, 320)
Main.Position = UDim2.new(0.5, -240, 0.5, -160)
Main.BackgroundColor3 = COLORS.BgMain
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Visible = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(40, 45, 60)
MainStroke.Thickness = 1

-- Tombol Buka/Tutup (Klik vs Geser)
local clickTime = 0
local startPos = Vector2.new(0,0)
ToggleBtn.MouseButton1Down:Connect(function()
    clickTime = tick()
    startPos = ToggleBtn.AbsolutePosition
end)
ToggleBtn.MouseButton1Up:Connect(function()
    if tick() - clickTime < 0.2 and (ToggleBtn.AbsolutePosition - startPos).Magnitude < 5 then
        Main.Visible = not Main.Visible
    end
end)

-- Tombol Close (X) di Pojok Kanan Atas
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = COLORS.TextWhite
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = Main
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- ==========================================
-- 3. FITUR RESIZE (Tarik Ujung Kanan Bawah)
-- ==========================================
local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
ResizeHandle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
ResizeHandle.Text = "◢"
ResizeHandle.TextColor3 = COLORS.TextWhite
ResizeHandle.TextSize = 12
ResizeHandle.ZIndex = 5
ResizeHandle.Parent = Main
Instance.new("UICorner", ResizeHandle).CornerRadius = UDim.new(0, 4)

local resizing = false
local startSize, startMousePos

ResizeHandle.MouseButton1Down:Connect(function()
    resizing = true
    startSize = Main.AbsoluteSize
    startMousePos = UserInputService:GetMouseLocation()
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local currentMousePos = UserInputService:GetMouseLocation()
        local deltaX = currentMousePos.X - startMousePos.X
        local deltaY = currentMousePos.Y - startMousePos.Y
        
        -- Batas minimal dan maksimal ukuran UI
        local newX = math.clamp(startSize.X + deltaX, 400, 800)
        local newY = math.clamp(startSize.Y + deltaY, 250, 600)
        
        Main.Size = UDim2.new(0, newX, 0, newY)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

-- ==========================================
-- 4. SIDEBAR & LOGO
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = COLORS.BgSidebar
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 10, 1, 0)
SidebarFix.Position = UDim2.new(1, -10, 0, 0)
SidebarFix.BackgroundColor3 = COLORS.BgSidebar
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

local SmallLogo = Instance.new("ImageLabel")
SmallLogo.Size = UDim2.new(0, 24, 0, 24)
SmallLogo.Position = UDim2.new(0, 10, 0, 13)
SmallLogo.BackgroundTransparency = 1
SmallLogo.Image = LOGO_URL
SmallLogo.Parent = Sidebar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 50)
Title.Position = UDim2.new(0, 40, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "WillHub"
Title.TextColor3 = COLORS.TextWhite
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Sidebar

local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(0.9, 0, 0, 25)
SearchFrame.Position = UDim2.new(0.05, 0, 0, 50)
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
SearchBox.TextSize = 11
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchFrame

-- ==========================================
-- 5. KONTEN AREA & TAB KOSONG
-- ==========================================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -140, 1, 0)
Content.Position = UDim2.new(0, 140, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function createTab()
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(1, -20, 1, -20)
    tab.Position = UDim2.new(0, 10, 0, 10)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    tab.Parent = Content
    return tab
end

local TabStatus = createTab()
local TabFarm = createTab()
local TabAutoClear = createTab()
local TabAutoDF = createTab()
local TabSetting = createTab()

-- SIDEBAR BUTTONS (Status ditambahin di atas Farm)
local function createSidebarButton(text, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = COLORS.BgElement
    btn.Text = "  " .. text
    btn.TextColor3 = COLORS.TextGray
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    return btn
end

local btnStatus = createSidebarButton("Status", 90)
local btnFarm = createSidebarButton("Farm", 130)
local btnAutoClear = createSidebarButton("Auto Clear", 170)
local btnAutoDF = createSidebarButton("Auto DF", 210)
local btnSetting = createSidebarButton("Setting", 250)

local activeBtn = btnStatus
local function switchTab(tabFrame, btn)
    TabStatus.Visible = false
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

btnStatus.MouseButton1Click:Connect(function() switchTab(TabStatus, btnStatus) end)
btnFarm.MouseButton1Click:Connect(function() switchTab(TabFarm, btnFarm) end)
btnAutoClear.MouseButton1Click:Connect(function() switchTab(TabAutoClear, btnAutoClear) end)
btnAutoDF.MouseButton1Click:Connect(function() switchTab(TabAutoDF, btnAutoDF) end)
btnSetting.MouseButton1Click:Connect(function() switchTab(TabSetting, btnSetting) end)

-- Set Default Tab
switchTab(TabStatus, btnStatus)

print("[WillHub] UI Updated: Status Menu, Fixed Resize, and Close Button!")
