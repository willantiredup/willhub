-- ==========================================
-- WillHub - Farm UI (Accordion + Live Detector)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
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
Main.Size = UDim2.new(0, 600, 0, 420)
Main.Position = UDim2.new(0.5, -300, 0.5, -210)
Main.BackgroundColor3 = C.BgMain
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(40, 45, 60)

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- RESIZE HANDLE
local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
ResizeHandle.BackgroundColor3 = C.Accent
ResizeHandle.Text = "◢"
ResizeHandle.TextColor3 = C.TextW
ResizeHandle.Font = Enum.Font.GothamBold
ResizeHandle.TextSize = 12
ResizeHandle.ZIndex = 10
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
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local deltaX = UserInputService:GetMouseLocation().X - startMousePos.X
        local deltaY = UserInputService:GetMouseLocation().Y - startMousePos.Y
        Main.Size = UDim2.new(0, math.clamp(startSize.X + deltaX, 350, 900), 0, math.clamp(startSize.Y + deltaY, 250, 700))
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

-- TOP BAR
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

-- CONTENT SCROLL
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -70)
Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.Parent = Main
local ScrollList = Instance.new("UIListLayout", Scroll)
ScrollList.Padding = UDim.new(0, 10)

-- ==========================================
-- LIVE STATUS DATA
-- ==========================================
local LiveData = {
    IsRunning = false,
    SelectedBlock = "",
    CurrentTarget = "-",
    Distance = "0",
    PosX = 0,
    PosZ = 0,
    BreakCount = 0,
    CollectCount = 0,
    Action = "Idle",
    FarmStatus = "Mencari area farm..."
}

local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(1, -10, 0, 140)
StatusFrame.BackgroundColor3 = C.BgElement
StatusFrame.Parent = Scroll
Instance.new("UICorner", StatusFrame).CornerRadius = UDim.new(0, 6)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 1, -10)
StatusText.Position = UDim2.new(0, 10, 0, 5)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Memuat data..."
StatusText.TextColor3 = C.TextG
StatusText.Font = Enum.Font.Code
StatusText.TextSize = 12
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.TextYAlignment = Enum.TextYAlignment.Top
StatusText.Parent = StatusFrame

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
    local function updateSize()
        if open then
            inner.Size = UDim2.new(1, -20, 0, innerList.AbsoluteContentSize.Y)
            frame.Size = UDim2.new(1, -10, 0, 45 + innerList.AbsoluteContentSize.Y + 10)
        else
            frame.Size = UDim2.new(1, -10, 0, 45)
        end
    end

    header.MouseButton1Click:Connect(function()
        open = not open
        header.Text = "  |  " .. title .. (open and "  v" or "  >")
        updateSize()
    end)
    innerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
    return inner
end

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
    local bg = Instance.new("TextButton")
    bg.Size = UDim2.new(0, 40, 0, 20)
    bg.Position = UDim2.new(1, -50, 0.5, -10)
    bg.BackgroundColor3 = C.BgElement
    bg.Text = ""
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
end

-- ISI MENU ACCORDION
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

local BlockInner = createAccordion("Block")
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
    LiveData.SelectedBlock = ""
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
                    LiveData.SelectedBlock = tool.Name
                    for _, b in pairs(blockScroll:GetChildren()) do
                        if b:IsA("TextButton") then b.BackgroundColor3 = C.BgMain end
                    end
                    btn.BackgroundColor3 = C.Accent
                end)
            end
        end
    end
end
task.spawn(refreshBlocks)
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, 0, 0, 30)
refreshBtn.BackgroundColor3 = C.BgMain
refreshBtn.Text = "REFRESH TAS"
refreshBtn.TextColor3 = C.TextW
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextSize = 11
refreshBtn.Parent = BlockInner
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 4)
refreshBtn.MouseButton1Click:Connect(refreshBlocks)

local OtomatisInner = createAccordion("Otomatis")
local isFastPunch = false
createToggle(OtomatisInner, "Fast Punch", function(state) isFastPunch = state end)
local isAutoCollect = false
createToggle(OtomatisInner, "Auto Collect", function(state) isAutoCollect = state end)

local LanjutanInner = createAccordion("Lanjutan")
local areaInput = Instance.new("TextBox")
areaInput.Size = UDim2.new(1, 0, 0, 30)
areaInput.BackgroundColor3 = C.BgMain
areaInput.PlaceholderText = "Radius (30)"
areaInput.Text = "30"
areaInput.TextColor3 = C.TextW
areaInput.Font = Enum.Font.Code
areaInput.TextSize = 11
areaInput.Parent = LanjutanInner
Instance.new("UICorner", areaInput).CornerRadius = UDim.new(0, 4)

-- ==========================================
-- LOGIKA FARM (LIVE UPDATE DATA)
-- ==========================================
local farmThread = nil
playBtn.MouseButton1Click:Connect(function()
    LiveData.IsRunning = not LiveData.IsRunning
    if LiveData.IsRunning then
        playBtn.Text = "BERHENTI FARM"
        playBtn.BackgroundColor3 = C.Red
        farmThread = task.spawn(function()
            while LiveData.IsRunning do
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

                    for _, part in pairs(parts) do
                        if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name ~= "Baseplate" and part.Size.Y > 0.2 then
                            local isMatch = false
                            if LiveData.SelectedBlock == "" then isMatch = true
                            elseif string.find(string.lower(part.Name), string.lower(LiveData.SelectedBlock)) then isMatch = true end
                            if isMatch then
                                local dist = (part.Position - hrp.Position).Magnitude
                                if dist < shortestDist then
                                    shortestDist = dist
                                    targetPart = part
                                end
                            end
                        end
                    end

                    if targetPart then
                        LiveData.CurrentTarget = targetPart.Name
                        LiveData.Distance = math.floor(shortestDist)
                        LiveData.Action = "Memukul block..."
                        
                        hum:MoveTo(targetPart.Position)
                        local bDelay = isFastPunch and 0.01 or 0.2
                        task.wait(bDelay + math.random(-2,2)/100)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.02)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        LiveData.BreakCount = LiveData.BreakCount + 1
                    else
                        LiveData.CurrentTarget = "-"
                        LiveData.Distance = "0"
                        LiveData.Action = "Mencari block..."
                        hum:MoveTo(hrp.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
                        task.wait(0.5)
                    end

                    -- Auto Collect
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
                            LiveData.Action = "Mengambil item..."
                            hum:MoveTo(closestItem.Position)
                            LiveData.CollectCount = LiveData.CollectCount + 1
                            task.wait(0.3)
                        end
                    end
                end)
            end
        end)
    else
        playBtn.Text = "MULAI FARM"
        playBtn.BackgroundColor3 = C.Accent
        LiveData.Action = "Idle"
        if farmThread then task.cancel(farmThread) end
    end
end)

-- ==========================================
-- LIVE DETECTOR (UPDATE UI SETIAP FRAME)
-- ==========================================
RunService.RenderStepped:Connect(function()
    if not Main.Visible then return end
    
    -- 1. Deteksi Posisi Karakter
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local p = char.HumanoidRootPart.Position
        LiveData.PosX = math.floor(p.X)
        LiveData.PosZ = math.floor(p.Z)
    end

    -- 2. Deteksi Area Farm Sendiri
    local farmName = "Tidak ada"
    for i = 1, 8 do
        local f = workspace:FindFirstChild("Farm" .. i)
        if f and f:FindFirstChild("Owner") and f.Owner.Value == player then
            farmName = f.Name
            break
        end
    end
    LiveData.FarmStatus = farmName

    -- 3. Format Teks Status
    local colorStatus = LiveData.IsRunning and "🟢 JALAN" or "🔴 BERHENTI"
    local colorAksi = LiveData.IsRunning and C.TextW or C.TextG
    
    StatusText.Text = string.format(
        "Status : %s\nBlock : %s\nKarakter : (%d, %d)\nTile : %s\nPlace/Break/Collect : 0 / %d / %d\nCollect : Remote via ?\nPosisi farm: %s | refill on | return on | drop seed off\nAksi : %s",
        colorStatus, 
        LiveData.SelectedBlock == "" and "Semua" or LiveData.SelectedBlock, 
        LiveData.PosX, LiveData.PosZ, 
        LiveData.CurrentTarget, 
        LiveData.BreakCount, LiveData.CollectCount,
        LiveData.FarmStatus, 
        LiveData.Action
    )
end)
