-- ==========================================
-- WillHub - V6 (Block Selector)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

for _, v in pairs(CoreGui:GetChildren()) do
    if string.find(v.Name, "WillHub") then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function notify(title, text)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3}) end)
end

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(43, 104, 227)
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 18
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 400)
Main.Position = UDim2.new(0.5, -250, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(13, 15, 23)
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(17, 20, 28)
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ WILLHUB // V6"
Title.TextColor3 = Color3.fromRGB(43, 104, 227)
Title.Font = Enum.Font.Code
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(23, 27, 38)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 15)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- TAB BAR
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
    local list = Instance.new("UIListLayout", page)
    list.Padding = UDim.new(0, 8)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    Pages[name] = page
    return page
end

local function switchTab(pageName, btn)
    for _, p in pairs(Pages) do p.Visible = false end
    if Pages[pageName] then Pages[pageName].Visible = true end
    if activeBtn then TweenService:Create(activeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(23, 27, 38), TextColor3 = Color3.fromRGB(150, 155, 165)}):Play() end
    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(43, 104, 227), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    activeBtn = btn
end

local function addTabButton(text, pageName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(23, 27, 38)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(150, 155, 165)
    btn.Font = Enum.Font.Code
    btn.TextSize = 12
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function() switchTab(pageName, btn) end)
    return btn
end

local pBlocks = createPage("Blocks")
local pFarm = createPage("Farm")
local pStatus = createPage("Status")

addTabButton("BLOCKS", "Blocks")
addTabButton("FARM", "Farm")
addTabButton("STATUS", "Status")

-- SELECTED BLOCK
local selectedBlock = nil
local selectedBlockLabel = Instance.new("TextLabel")
selectedBlockLabel.Size = UDim2.new(1, 0, 0, 30)
selectedBlockLabel.BackgroundColor3 = Color3.fromRGB(23, 27, 38)
selectedBlockLabel.Text = "Selected: (None)"
selectedBlockLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
selectedBlockLabel.Font = Enum.Font.GothamBold
selectedBlockLabel.TextSize = 13
selectedBlockLabel.Parent = pBlocks
Instance.new("UICorner", selectedBlockLabel).CornerRadius = UDim.new(0, 4)

-- SCAN BUTTON
local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(1, 0, 0, 35)
ScanBtn.BackgroundColor3 = Color3.fromRGB(43, 104, 227)
ScanBtn.Text = "SCAN BLOCKS AROUND ME"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.TextSize = 13
ScanBtn.Parent = pBlocks
Instance.new("UICorner", ScanBtn).CornerRadius = UDim.new(0, 4)

local blockListFrame = Instance.new("Frame")
blockListFrame.Size = UDim2.new(1, 0, 0, 200)
blockListFrame.BackgroundTransparency = 1
blockListFrame.Parent = pBlocks
local blockList = Instance.new("UIListLayout", blockListFrame)
blockList.Padding = UDim.new(0, 5)
blockList.SortOrder = Enum.SortOrder.LayoutOrder

ScanBtn.MouseButton1Click:Connect(function()
    for _, c in pairs(blockListFrame:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end

    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then notify("WillHub", "Karakter belum spawn!") return end

    local uniqueNames = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "Baseplate" and v.Name ~= "Terrain" then
            if v.Size.Y > 0.2 and not v:IsDescendantOf(char) then
                local dist = (v.Position - hrp.Position).Magnitude
                if dist <= 100 then
                    uniqueNames[v.Name] = true
                end
            end
        end
    end

    local count = 0
    for name, _ in pairs(uniqueNames) do
        count = count + 1
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(23, 27, 38)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Code
        btn.TextSize = 12
        btn.Parent = blockListFrame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(function()
            selectedBlock = name
            selectedBlockLabel.Text = "Selected: " .. name
            selectedBlockLabel.TextColor3 = Color3.fromRGB(50, 200, 50)
            notify("WillHub", "Target block: " .. name)
        end)
    end

    notify("WillHub", "Ketemu " .. count .. " jenis block.")
end)

-- ==========================================
-- TAB FARM
-- ==========================================
local function createToggle(parent, text, layoutOrder, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(23, 27, 38)
    frame.LayoutOrder = layoutOrder
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 15, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    local bg = Instance.new("TextButton")
    bg.Size = UDim2.new(0, 40, 0, 20)
    bg.Position = UDim2.new(1, -55, 0.5, -10)
    bg.BackgroundColor3 = Color3.fromRGB(13, 15, 23)
    bg.Text = ""
    bg.Parent = frame
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new(0, 3, 0.5, -7)
    dot.BackgroundColor3 = Color3.fromRGB(150, 155, 165)
    dot.Parent = bg
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    local isActive = false
    bg.MouseButton1Click:Connect(function()
        isActive = not isActive
        if isActive then
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(43, 104, 227)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(13, 15, 23)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Color3.fromRGB(150, 155, 165)}):Play()
        end
        if callback then callback(isActive) end
    end)
end

local breakThread = nil
local isBreaking = false

createToggle(pFarm, "Auto Break (Target Selected)", 1, function(state)
    isBreaking = state
    if state then
        if not selectedBlock then
            notify("WillHub", "Pilih block dulu di tab BLOCKS!")
            return
        end
        breakThread = task.spawn(function()
            while isBreaking do
                pcall(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hrp and hum then
                        local parts = workspace:GetPartBoundsInRadius(hrp.Position, 50)
                        local targetPart, shortest = nil, 50
                        for _, part in pairs(parts) do
                            if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name == selectedBlock then
                                local d = (part.Position - hrp.Position).Magnitude
                                if d < shortest then shortest, targetPart = d, part end
                            end
                        end
                        if targetPart then
                            hum:MoveTo(targetPart.Position)
                            task.wait(0.5)
                            VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
                            task.wait(0.05)
                            VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0)
                            task.wait(0.2)
                        else
                            hum:MoveTo(hrp.Position + Vector3.new(math.random(-10,10),0,math.random(-10,10)))
                            task.wait(1)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
        notify("WillHub", "Auto Break ON (Target: " .. selectedBlock .. ")")
    else
        if breakThread then task.cancel(breakThread) end
        notify("WillHub", "Auto Break OFF")
    end
end)

-- STATUS TAB
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 100)
StatusLabel.BackgroundColor3 = Color3.fromRGB(23, 27, 38)
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextYAlignment = Enum.TextYAlignment.Top
StatusLabel.Text = "Menunggu data..."
StatusLabel.Parent = pStatus
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 6)

task.spawn(function()
    while true do
        if pStatus.Visible then
            local pos = "-"
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local p = char.HumanoidRootPart.Position
                pos = string.format("(%d, %d)", p.X, p.Z)
            end
            StatusLabel.Text = string.format(
                "=== STATUS ===\nPosisi : %s\nTarget : %s\nAuto Break : %s",
                pos, selectedBlock or "None", isBreaking and "ON" or "OFF"
            )
        end
        task.wait(0.5)
    end
end)

switchTab("Blocks", TabBar:GetChildren()[1])
