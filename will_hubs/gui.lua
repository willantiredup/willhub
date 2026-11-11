-- ==========================================
-- WillHub GUI (SkyP Replica - 100% Functional)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubModern") then CoreGui.WillHubModern:Destroy() end

local C = {
    BgMain = Color3.fromRGB(13, 15, 23),
    BgSidebar = Color3.fromRGB(17, 20, 28),
    BgElement = Color3.fromRGB(23, 27, 38),
    Accent = Color3.fromRGB(43, 104, 227),
    TextW = Color3.fromRGB(255, 255, 255),
    TextG = Color3.fromRGB(130, 140, 160),
    TextD = Color3.fromRGB(80, 90, 110),
    Green = Color3.fromRGB(50, 200, 50),
    Red = Color3.fromRGB(200, 50, 50)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubModern"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- UI NOTIFICATION FUNCTION
local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title, Text = text, Duration = 3
        })
    end)
end

-- MAIN WINDOW
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

local Banner = Instance.new("Frame")
Banner.Size = UDim2.new(1, 0, 0, 45)
Banner.BackgroundColor3 = C.BgElement
Banner.LayoutOrder = 1
Banner.Parent = Content
Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 4)

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

-- TAB CONTAINER
local Pages = {}
local function createPage(name)
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 0, 300)
    page.BackgroundTransparency = 1
    page.LayoutOrder = 2
    page.Visible = false
    page.Parent = Content
    Pages[name] = page
    return page
end

local PagePabrik = createPage("Pabrik")
local PageTitikDrop = createPage("TitikDrop")
local PageDirtFarm = createPage("DirtFarm")
local PagePengaturan = createPage("Pengaturan")
local PageKoneksi = createPage("Koneksi")
local PageDiscord = createPage("Discord")
local PageObservasi = createPage("Observasi")

-- FUNGSI SWITCH TAB
local activeBtn = nil
local function switchTab(pageName, btn)
    for _, p in pairs(Pages) do p.Visible = false end
    if Pages[pageName] then Pages[pageName].Visible = true end
    
    if activeBtn then
        activeBtn.BackgroundTransparency = 1
        activeBtn.TextColor3 = C.TextG
    end
    btn.BackgroundTransparency = 0
    btn.BackgroundColor3 = C.Accent
    btn.TextColor3 = C.TextW
    activeBtn = btn
end

-- SIDEBAR MENU BUTTONS
local function addMenu(text, y, isHeader, pageName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 26)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundTransparency = 1
    btn.Text = "  " .. text
    btn.TextColor3 = isHeader and C.TextD or C.TextG
    btn.Font = isHeader and Enum.Font.GothamBold or Enum.Font.Gotham
    btn.TextSize = isHeader and 11 or 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    
    if not isHeader and pageName then
        btn.MouseButton1Click:Connect(function() switchTab(pageName, btn) end)
    end
    return btn
end

addMenu("Pabrik", 110, false, "Pabrik")
addMenu("Titik Drop", 140, false, "TitikDrop")
addMenu("Dirt Farm", 170, false, "DirtFarm")
addMenu("FITUR", 210, true, nil)
addMenu("KEAMANAN", 235, true, nil)
addMenu("SETELAN", 260, true, nil)
addMenu("Pengaturan", 290, false, "Pengaturan")
addMenu("Koneksi", 320, false, "Koneksi")
addMenu("Discord", 350, false, "Discord")
addMenu("Observasi", 380, false, "Observasi")

-- ================= FUNGSI UI ELEMENTS =================
local function createToggle(parent, text, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = C.BgElement
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = C.TextW
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 36, 0, 18)
    bg.Position = UDim2.new(1, -45, 0.5, -9)
    bg.BackgroundColor3 = C.TextG
    bg.Parent = frame
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new(0, 2, 0.5, -7)
    dot.BackgroundColor3 = C.TextW
    dot.Parent = bg
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local isActive = false
    bg.MouseButton1Click:Connect(function()
        isActive = not isActive
        TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = isActive and C.Accent or C.TextG}):Play()
        TweenService:Create(dot, TweenInfo.new(0.2), {Position = isActive and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
        if callback then callback(isActive) end
    end)
end

local function createButton(parent, text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = C.BgElement
    btn.Text = "  " .. text
    btn.TextColor3 = C.TextW
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function() if callback then callback() end end)
    return btn
end

-- ================= ISI MENU: PABRIK =================
local clickThread = nil
createToggle(PagePabrik, "Auto Clicker (Pabrik)", 10, function(state)
    if state then
        notify("Pabrik", "Auto Clicker AKTIF")
        clickThread = task.spawn(function()
            while state do
                pcall(function()
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.05)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    task.wait(0.1)
                end)
            end
        end)
    else
        notify("Pabrik", "Auto Clicker MATI")
        if clickThread then task.cancel(clickThread) end
    end
end)

-- ================= ISI MENU: TITIK DROP =================
local dropY = 10
local function createTextBox(parent, placeholder, yPos, callback)
    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(1, -20, 0, 35)
    tb.Position = UDim2.new(0, 10, 0, yPos)
    tb.BackgroundColor3 = C.BgElement
    tb.PlaceholderText = placeholder
    tb.Text = ""
    tb.TextColor3 = C.TextW
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 12
    tb.Parent = parent
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 4)
    return tb
end

local tpX = createTextBox(PageTitikDrop, "X Coordinate (Contoh: 0)", 10)
local tpY = createTextBox(PageTitikDrop, "Y Coordinate (Contoh: 50)", 50)
local tpZ = createTextBox(PageTitikDrop, "Z Coordinate (Contoh: 0)", 90)

createButton(PageTitikDrop, "TELEPORT SEKARANG", 135, function()
    if tpX.Text and tpY.Text and tpZ.Text then
        local x, y, z = tonumber(tpX.Text), tonumber(tpY.Text), tonumber(tpZ.Text)
        if x and y and z then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
                notify("Teleport", "Berhasil ke " .. x .. ", " .. y .. ", " .. z)
            end
        else
            notify("Error", "Koordinat harus berupa angka!")
        end
    end
end)

-- ================= ISI MENU: DIRT FARM =================
local farmThread = nil
createToggle(PageDirtFarm, "Auto Farm (Jalan & Pukul)", 10, function(state)
    if state then
        notify("Dirt Farm", "Auto Farm AKTIF")
        farmThread = task.spawn(function()
            while state do
                pcall(function()
                    local char = player.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.05)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        task.wait(0.1)
                        hum:MoveTo(char.HumanoidRootPart.Position + Vector3.new(math.random(-15,15), 0, math.random(-15,15)))
                        task.wait(1)
                    end
                end)
            end
        end)
    else
        notify("Dirt Farm", "Auto Farm MATI")
        if farmThread then task.cancel(farmThread) end
    end
end)

-- ================= ISI MENU: PENGATURAN =================
local speedBox = createTextBox(PagePengaturan, "WalkSpeed (Contoh: 50)", 10)
createButton(PagePengaturan, "TERAPKAN SPEED", 55, function()
    local speed = tonumber(speedBox.Text)
    if speed then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
            notify("Speed", "WalkSpeed diubah ke " .. speed)
        end
    else
        notify("Error", "Masukkan angka yang valid!")
    end
end)

-- ================= ISI MENU: KONEKSI =================
createButton(PageKoneksi, "HUBUNGKAN ULANG (REJOIN)", 10, function()
    notify("Koneksi", "Sedang melakukan Rejoin...")
    task.wait(1)
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- ================= ISI MENU: DISCORD =================
createButton(PageDiscord, "COPY LINK DISCORD", 10, function()
    pcall(function()
        setclipboard("https://discord.gg/willhub")
        notify("Discord", "Link berhasil di-copy ke clipboard!")
    end)
end)

-- ================= ISI MENU: OBSERVASI (ESP) =================
local espThread = nil
createToggle(PageObservasi, "Player ESP (Highlight)", 10, function(state)
    if state then
        notify("Observasi", "ESP AKTIF")
        local espFolder = Instance.new("Folder", workspace)
        espFolder.Name = "WillHubESP"
        
        espThread = task.spawn(function()
            while state do
                pcall(function()
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= player and p.Character and not espFolder:FindFirstChild(p.Name) then
                            local hl = Instance.new("Highlight", espFolder)
                            hl.Name = p.Name
                            hl.Adornee = p.Character
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.FillTransparency = 0.5
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    else
        notify("Observasi", "ESP MATI")
        if espThread then task.cancel(espThread) end
        if workspace:FindFirstChild("WillHubESP") then
            workspace.WillHubESP:Destroy()
        end
    end
end)

-- START DEFAULT
switchTab("Pabrik", Sidebar:GetChildren()[4]) -- Otomatis buka Pabrik
