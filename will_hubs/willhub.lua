-- ==========================================
-- WillHub - V4 (Complete Farm Edition)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Hapus semua UI lama
for _, v in pairs(CoreGui:GetChildren()) do
    if string.find(v.Name, "WillHub") then v:Destroy() end
end

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
ScreenGui.Name = "WillHubV4"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function notify(title, text)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3}) end)
end

-- FLOATING TOGGLE BUTTON
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
Main.Size = UDim2.new(0, 520, 0, 350)
Main.Position = UDim2.new(0.5, -260, 0.5, -175)
Main.BackgroundColor3 = C.BgMain
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = C.BgTop
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ WILLHUB // V4"
Title.TextColor3 = C.Accent
Title.Font = Enum.Font.Code
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = C.BgElement
CloseBtn.Text = "X"
CloseBtn.TextColor3 = C.Red
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 15)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- TABS SETUP
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 55)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main
local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 10)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -100)
Content.Position = UDim2.new(0, 10, 0, 95)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Pages = {}
local activeBtn = nil

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = Content
    Pages[name] = page
    return page
end

local function switchTab(pageName, btn)
    for _, p in pairs(Pages) do p.Visible = false end
    if Pages[pageName] then Pages[pageName].Visible = true end
    if activeBtn then TweenService:Create(activeBtn, TweenInfo.new(0.2), {BackgroundColor3 = C.BgElement, TextColor3 = C.TextG}):Play() end
    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = C.Accent, TextColor3 = C.TextW}):Play()
    activeBtn = btn
end

local function addTabButton(text, pageName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 1, 0)
    btn.BackgroundColor3 = C.BgElement
    btn.Text = text
    btn.TextColor3 = C.TextG
    btn.Font = Enum.Font.Code
    btn.TextSize = 12
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function() switchTab(pageName, btn) end)
    return btn
end

local pFarm = createPage("Farm")
local pStatus = createPage("Status")
local pSetting = createPage("Setting")

addTabButton("FARM", "Farm")
addTabButton("STATUS", "Status")
addTabButton("SETTING", "Setting")

-- COMPONENT: TOGGLE
local function createToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
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
    
    local bg = Instance.new("TextButton")
    bg.Size = UDim2.new(0, 40, 0, 20)
    bg.Position = UDim2.new(1, -50, 0.5, -10)
    bg.BackgroundColor3 = C.BgMain
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
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = C.BgMain}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = C.TextG}):Play()
        end
        if callback then callback(isActive) end
    end)
end

-- COMPONENT: INPUT
local function createInput(parent, placeholder, default, yPos)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -10, 0, 35)
    box.Position = UDim2.new(0, 0, 0, yPos)
    box.BackgroundColor3 = C.BgElement
    box.PlaceholderText = placeholder
    box.Text = default or ""
    box.TextColor3 = C.TextW
    box.Font = Enum.Font.Code
    box.TextSize = 12
    box.Parent = parent
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    return box
end

-- ==========================================
-- TAB FARM
-- ==========================================
local radiusBox = createInput(pFarm, "Radius Area (Studs)", "30", 0)
local breakDelayBox = createInput(pFarm, "Break Delay (Detik)", "0.2", 40)
local placeDelayBox = createInput(pFarm, "Place Delay (Detik)", "0.5", 80)

-- Variabel Thread
local breakThread, placeThread, collectThread, walkThread = nil, nil, nil, nil
local isBreaking, isPlacing, isCollecting, isWalking = false, false, false, false

-- Auto Break
createToggle(pFarm, "Auto Break (Mecahin Block)", function(state)
    isBreaking = state
    if state then
        breakThread = task.spawn(function()
            while isBreaking do
                pcall(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hrp and hum then
                        local maxRadius = tonumber(radiusBox.Text) or 30
                        local parts = workspace:GetPartBoundsInRadius(hrp.Position, maxRadius)
                        local targetPart = nil
                        local shortestDist = maxRadius
                        
                        for _, part in pairs(parts) do
                            if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name ~= "Baseplate" and part.Size.Y > 0.2 then
                                local dist = (part.Position - hrp.Position).Magnitude
                                if dist < shortestDist then
                                    shortestDist = dist
                                    targetPart = part
                                end
                            end
                        end

                        if targetPart then
                            hum:MoveTo(targetPart.Position)
                            local bDelay = tonumber(breakDelayBox.Text) or 0.2
                            task.wait(bDelay + math.random(-2,2)/100)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            task.wait(0.02)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        else
                            hum:MoveTo(hrp.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
                            task.wait(0.5)
                        end
                    end
                end)
            end
        end)
        notify("WillHub", "Auto Break ON")
    else
        if breakThread then task.cancel(breakThread) end
        notify("WillHub", "Auto Break OFF")
    end
end)

-- Auto Place
createToggle(pFarm, "Auto Place (Tanam Block)", function(state)
    isPlacing = state
    if state then
        placeThread = task.spawn(function()
            while isPlacing do
                pcall(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hrp and hum then
                        -- Cari tool seed di backpack
                        local bp = player:FindFirstChild("Backpack")
                        local seed = nil
                        if bp then
                            for _, tool in pairs(bp:GetChildren()) do
                                if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "seed") or string.find(string.lower(tool.Name), "block")) then
                                    seed = tool
                                    break
                                end
                            end
                        end
                        
                        if seed then
                            hum:EquipTool(seed)
                            task.wait(0.2)
                            -- Klik kanan buat nanem
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                            task.wait(0.05)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                            local pDelay = tonumber(placeDelayBox.Text) or 0.5
                            task.wait(pDelay)
                        end
                    end
                end)
            end
        end)
        notify("WillHub", "Auto Place ON")
    else
        if placeThread then task.cancel(placeThread) end
        notify("WillHub", "Auto Place OFF")
    end
end)

-- Auto Collect
createToggle(pFarm, "Auto Collect (Ambil Drop)", function(state)
    isCollecting = state
    if state then
        collectThread = task.spawn(function()
            while isCollecting do
                pcall(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hrp and hum then
                        local closest, dist = nil, 30
                        for _, part in pairs(workspace:GetPartBoundsInRadius(hrp.Position, 30)) do
                            if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name ~= "Baseplate" and part.Size.Magnitude <= 15 then
                                local d = (part.Position - hrp.Position).Magnitude
                                if d < dist then dist, closest = d, part end
                            end
                        end
                        if closest then hum:MoveTo(closest.Position) end
                    end
                end)
                task.wait(0.5)
            end
        end)
        notify("WillHub", "Auto Collect ON")
    else
        if collectThread then task.cancel(collectThread) end
        notify("WillHub", "Auto Collect OFF")
    end
end)

-- Auto Walk
createToggle(pFarm, "Auto Walk (Jalan Muter)", function(state)
    isWalking = state
    if state then
        walkThread = task.spawn(function()
            while isWalking do
                pcall(function()
                    local char = player.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum:MoveTo(char.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20)))
                    end
                end)
                task.wait(1.5)
            end
        end)
        notify("WillHub", "Auto Walk ON")
    else
        if walkThread then task.cancel(walkThread) end
        notify("WillHub", "Auto Walk OFF")
    end
end)

-- ==========================================
-- TAB STATUS
-- ==========================================
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 0, 150)
StatusLabel.BackgroundColor3 = C.BgElement
StatusLabel.TextColor3 = C.TextW
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextYAlignment = Enum.TextYAlignment.Top
StatusLabel.Text = "Memuat data..."
StatusLabel.Parent = pStatus
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 6)

RunService.RenderStepped:Connect(function()
    if not Main.Visible or not pStatus.Visible then return end
    local pos = "-"
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local p = char.HumanoidRootPart.Position
        pos = string.format("(%d, %d)", p.X, p.Z)
    end
    StatusLabel.Text = string.format(
        "=== LIVE STATUS ===\nPosisi : %s\n\nAuto Break : %s\nAuto Place : %s\nAuto Collect : %s\nAuto Walk : %s",
        pos, isBreaking and "ON" or "OFF", isPlacing and "ON" or "OFF", isCollecting and "ON" or "OFF", isWalking and "ON" or "OFF"
    )
end)

-- ==========================================
-- TAB SETTING
-- ==========================================
local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(1, -10, 0, 45)
RejoinBtn.BackgroundColor3 = C.Accent
RejoinBtn.Text = "REJOIN SERVER"
RejoinBtn.TextColor3 = C.TextW
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.TextSize = 13
RejoinBtn.Parent = pSetting
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 4)
RejoinBtn.MouseButton1Click:Connect(function()
    notify("WillHub", "Sedang Rejoin...")
    task.wait(1)
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

switchTab("Farm", TabBar:GetChildren()[1])
