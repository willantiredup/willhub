-- ==========================================
-- WillHub - Cyberpunk Edition (Accordion Farm)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubCyber") then CoreGui.WillHubCyber:Destroy() end

local C = {
    BgMain = Color3.fromRGB(13, 15, 23),
    BgTop = Color3.fromRGB(17, 20, 28),
    BgElement = Color3.fromRGB(23, 27, 38),
    Accent = Color3.fromRGB(43, 104, 227),
    TextW = Color3.fromRGB(255, 255, 255),
    TextG = Color3.fromRGB(150, 155, 165),
    Red = Color3.fromRGB(255, 80, 80),
    Green = Color3.fromRGB(50, 200, 50)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubCyber"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function notify(title, text)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3}) end)
end

-- FLOATING TOGGLE
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "FloatingToggle"
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = C.Accent
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = C.TextW
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 18
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- MAIN WINDOW
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 650, 0, 420)
Main.Position = UDim2.new(0.5, -325, 0.5, -210)
Main.BackgroundColor3 = C.BgMain
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(40, 45, 60)

local clickTime = 0
local startPos = Vector2.new(0,0)
ToggleBtn.MouseButton1Down:Connect(function() clickTime = tick(); startPos = ToggleBtn.AbsolutePosition end)
ToggleBtn.MouseButton1Up:Connect(function()
    if tick() - clickTime < 0.2 and (ToggleBtn.AbsolutePosition - startPos).Magnitude < 5 then Main.Visible = not Main.Visible end
end)

-- TOP BAR (Kaya Screenshot)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = C.BgTop
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🍔 Farm"
Title.TextColor3 = C.TextW
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 150, 0, 15)
SubTitle.Position = UDim2.new(0, 15, 0, 25)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Farm"
SubTitle.TextColor3 = C.TextG
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TopBar

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0, 200, 0, 30)
SearchBox.Position = UDim2.new(0.5, -100, 0, 10)
SearchBox.BackgroundColor3 = C.BgElement
SearchBox.PlaceholderText = "Cari fitur..."
SearchBox.Text = ""
SearchBox.TextColor3 = C.TextW
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.Parent = TopBar
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 15)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = C.BgElement
CloseBtn.Text = "X"
CloseBtn.TextColor3 = C.TextW
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 15)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- CONTENT AREA
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Position = UDim2.new(0, 10, 0, 55)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- TAB BUTTONS (Farm & Dirt Farm)
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 30)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = Content

local btnFarm = Instance.new("TextButton")
btnFarm.Size = UDim2.new(0, 80, 1, 0)
btnFarm.BackgroundColor3 = C.Accent
btnFarm.Text = "Farm"
btnFarm.TextColor3 = C.TextW
btnFarm.Font = Enum.Font.GothamBold
btnFarm.TextSize = 12
btnFarm.Parent = TabFrame
Instance.new("UICorner", btnFarm).CornerRadius = UDim.new(1, 0)

local btnDirt = Instance.new("TextButton")
btnDirt.Size = UDim2.new(0, 100, 1, 0)
btnDirt.Position = UDim2.new(0, 90, 0, 0)
btnDirt.BackgroundColor3 = C.BgElement
btnDirt.Text = "Dirt Farm"
btnDirt.TextColor3 = C.TextG
btnDirt.Font = Enum.Font.GothamBold
btnDirt.TextSize = 12
btnDirt.Parent = TabFrame
Instance.new("UICorner", btnDirt).CornerRadius = UDim.new(1, 0)

-- SCROLLING FRAME UNTUK KONTEN
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, 0, 1, -40)
Scroll.Position = UDim2.new(0, 0, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.Parent = Content
local ScrollList = Instance.new("UIListLayout", Scroll)
ScrollList.Padding = UDim.new(0, 10)

-- STATUS BOX
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(1, -10, 0, 120)
StatusFrame.BackgroundColor3 = C.BgElement
StatusFrame.Parent = Scroll
Instance.new("UICorner", StatusFrame).CornerRadius = UDim.new(0, 6)

local StatusLine = Instance.new("Frame")
StatusLine.Size = UDim2.new(0, 3, 0.9, 0)
StatusLine.Position = UDim2.new(0, 0, 0.05, 0)
StatusLine.BackgroundColor3 = C.Accent
StatusLine.Parent = StatusFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 1, -10)
StatusText.Position = UDim2.new(0, 10, 0, 5)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Status : BERHENTI\n..."
StatusText.TextColor3 = C.TextG
StatusText.Font = Enum.Font.Code
StatusText.TextSize = 12
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.TextYAlignment = Enum.TextYAlignment.Top
StatusText.Parent = StatusFrame

-- VARIABEL STATUS
local isFarmRunning = false
local selectedBlock = ""
local breakCount, placeCount, collectCount = 0, 0, 0

-- FUNGSI ACCORDION
local function createAccordion(title)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 45)
    frame.BackgroundColor3 = C.BgElement
    frame.ClipsDescendants = true
    frame.Parent = Scroll
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundTransparency = 1
    header.Text = "  |  " .. title .. "  >"
    header.TextColor3 = C.TextW
    header.Font = Enum.Font.GothamBold
    header.TextSize = 13
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = frame

    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(1, -20, 0, 0)
    inner.Position = UDim2.new(0, 10, 0, 45)
    inner.BackgroundTransparency = 1
    inner.Parent = frame
    local innerList = Instance.new("UIListLayout", inner)
    innerList.Padding = UDim.new(0, 8)

    local open = false
    header.MouseButton1Click:Connect(function()
        open = not open
        frame.Size = UDim2.new(1, -10, 0, open and (45 + inner.AbsoluteSize.Y) or 45)
        header.Text = "  |  " .. title .. (open and "  v" or "  >")
    end)
    
    -- Auto resize frame kalau isi inner berubah
    inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        inner.Size = UDim2.new(1, -20, 0, inner.AbsoluteSize.Y)
        if open then frame.Size = UDim2.new(1, -10, 0, 45 + inner.AbsoluteSize.Y) end
    end)

    return inner
end

-- FUNGSI TOGGLE
local function createToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = C.BgMain
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
    bg.Size = UDim2.new(0, 40, 0, 20)
    bg.Position = UDim2.new(1, -50, 0.5, -10)
    bg.BackgroundColor3 = C.BgElement
    bg.Parent = frame
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new(0, 3, 0.5, -7)
    dot.BackgroundColor3 = C.TextG
    dot.Parent = bg
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    local isActive = false
    bg.MouseButton1Click:Connect(function()
        isActive = not isActive
        if isActive then
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = C.Accent}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = C.TextW}):Play()
        else
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = C.BgElement}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = C.TextG}):Play()
        end
        if callback then callback(isActive) end
    end)
    return isActive
end

-- ==========================================
-- ACCORDION 1: KONTROL
-- ==========================================
local KontrolInner = createAccordion("Kontrol")
local playBtn = Instance.new("TextButton")
playBtn.Size = UDim2.new(1, 0, 0, 35)
playBtn.BackgroundColor3 = C.Accent
playBtn.Text = "MULAI FARM"
playBtn.TextColor3 = C.TextW
playBtn.Font = Enum.Font.GothamBold
playBtn.TextSize = 12
playBtn.Parent = KontrolInner
Instance.new("UICorner", playBtn).CornerRadius = UDim.new(0, 4)

-- ==========================================
-- ACCORDION 2: BLOCK
-- ==========================================
local BlockInner = createAccordion("Block")

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 0, 30)
refreshBtn.BackgroundColor3 = C.BgMain
refreshBtn.Text = "REFRESH TAS"
refreshBtn.TextColor3 = C.TextW
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextSize = 11
refreshBtn.Parent = BlockInner
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 4)

local blockScroll = Instance.new("ScrollingFrame")
blockScroll.Size = UDim2.new(1, 0, 0, 80)
blockScroll.BackgroundTransparency = 1
blockScroll.ScrollBarThickness = 3
blockScroll.Parent = BlockInner
local blockList = Instance.new("UIListLayout", blockScroll)
blockList.FillDirection = Enum.FillDirection.Horizontal
blockList.Padding = UDim.new(0, 5)

local function refreshBlocks()
    for _, child in pairs(blockScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    selectedBlock = ""
    local bp = player:FindFirstChild("Backpack")
    if bp then
        for _, tool in pairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0, 80, 0, 25)
                btn.BackgroundColor3 = C.BgMain
                btn.Text = tool.Name
                btn.TextColor3 = C.TextW
                btn.Font = Enum.Font.Code
                btn.TextSize = 11
                btn.Parent = blockScroll
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
                btn.MouseButton1Click:Connect(function()
                    selectedBlock = tool.Name
                    for _, b in pairs(blockScroll:GetChildren()) do
                        if b:IsA("TextButton") then b.BackgroundColor3 = C.BgMain end
                    end
                    btn.BackgroundColor3 = C.Accent
                end)
            end
        end
    end
end
refreshBtn.MouseButton1Click:Connect(refreshBlocks)
task.spawn(refreshBlocks)

-- ==========================================
-- ACCORDION 3: OTOMATIS
-- ==========================================
local OtomatisInner = createAccordion("Otomatis")
local isFastPunch = false
createToggle(OtomatisInner, "Fast Punch (Spam Klik)", function(state) isFastPunch = state end)
local isAutoCollect = false
createToggle(OtomatisInner, "Auto Collect (Ambil Drop)", function(state) isAutoCollect = state end)

-- ==========================================
-- ACCORDION 4: LANJUTAN
-- ==========================================
local LanjutanInner = createAccordion("Lanjutan")
local function createInput(parent, placeholder, default)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, 0, 0, 30)
    box.BackgroundColor3 = C.BgMain
    box.PlaceholderText = placeholder
    box.Text = default or ""
    box.TextColor3 = C.TextW
    box.Font = Enum.Font.Code
    box.TextSize = 11
    box.Parent = parent
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    return box
end
local areaInput = createInput(LanjutanInner, "Radius Area (Studs)", "30")
local breakInput = createInput(LanjutanInner, "Break Delay (Detik)", "0.2")

-- ==========================================
-- LOGIKA UTAMA (JALAN DI BELAKANG LAYAR)
-- ==========================================
local farmThread = nil
playBtn.MouseButton1Click:Connect(function()
    isFarmRunning = not isFarmRunning
    if isFarmRunning then
        playBtn.Text = "BERHENTI FARM"
        playBtn.BackgroundColor3 = C.Red
        notify("WillHub", "Auto Farm Berjalan!")
        
        farmThread = task.spawn(function()
            while isFarmRunning do
                pcall(function()
                    local char = player.Character
                    if not char then return end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if not hrp or not hum then return end

                    local maxRadius = tonumber(areaInput.Text) or 30
                    local parts = workspace:GetPartBoundsInRadius(hrp.Position, maxRadius)
                    local targetPart = nil
                    local shortestDist = maxRadius

                    -- 1. Cari Block Terdekat
                    for _, part in pairs(parts) do
                        if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name ~= "Baseplate" and part.Size.Y > 0.2 then
                            local isMatch = false
                            if selectedBlock == "" then isMatch = true
                            elseif string.find(string.lower(part.Name), string.lower(selectedBlock)) then isMatch = true end

                            if isMatch then
                                local dist = (part.Position - hrp.Position).Magnitude
                                if dist < shortestDist then
                                    shortestDist = dist
                                    targetPart = part
                                end
                            end
                        end
                    end

                    -- 2. Eksekusi Pukul
                    if targetPart then
                        hum:MoveTo(targetPart.Position)
                        local bDelay = tonumber(breakInput.Text) or 0.2
                        if isFastPunch then bDelay = 0.01 end
                        task.wait(bDelay + math.random(-2,2)/100)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.02)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        breakCount = breakCount + 1
                    else
                        hum:MoveTo(hrp.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
                        task.wait(0.5)
                    end

                    -- 3. Eksekusi Auto Collect
                    if isAutoCollect then
                        local closestItem = nil
                        local shortestItemDist = 40
                        for _, part in pairs(parts) do
                            if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name ~= "Baseplate" then
                                if part.Size.Magnitude <= 15 then
                                    local dist = (part.Position - hrp.Position).Magnitude
                                    if dist < shortestItemDist then
                                        shortestItemDist = dist
                                        closestItem = part
                                    end
                                end
                            end
                        end
                        if closestItem then
                            hum:MoveTo(closestItem.Position)
                            collectCount = collectCount + 1
                            task.wait(0.3)
                        end
                    end
                end)
            end
        end)
    else
        playBtn.Text = "MULAI FARM"
        playBtn.BackgroundColor3 = C.Accent
        notify("WillHub", "Auto Farm Berhenti")
        if farmThread then task.cancel(farmThread) end
    end
end)

-- ==========================================
-- LIVE STATUS UPDATE (Kaya di Screenshot)
-- ==========================================
RunService.RenderStepped:Connect(function()
    if not Main.Visible then return end
    local char = player.Character
    local posStr = "-"
    if char and char:FindFirstChild("HumanoidRootPart") then
        local p = char.HumanoidRootPart.Position
        posStr = string.format("(%d,%d)", p.X, p.Z)
    end
    
    local statusStr = isFarmRunning and "JALAN" or "BERHENTI"
    local blockStr = selectedBlock == "" and "-" or selectedBlock
    
    StatusText.Text = string.format(
        "Status : %s\nBlock : %s\nKarakter : %s\nTile : -\nPlace/Break/Collect : %d / %d / %d\nCollect : Remote via ?\nPosisi farm: - | refill on | return on | drop seed off\nAksi : -",
        statusStr, blockStr, posStr, placeCount, breakCount, collectCount
    )
end)
