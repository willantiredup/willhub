-- ==========================================
-- WillHub - Cyberpunk Edition (Ultimate Fix)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubCyber") then CoreGui.WillHubCyber:Destroy() end

local C = {
    BgMain = Color3.fromRGB(10, 10, 15),
    BgTop = Color3.fromRGB(15, 15, 22),
    BgElement = Color3.fromRGB(22, 22, 32),
    NeonPurple = Color3.fromRGB(180, 50, 255),
    NeonCyan = Color3.fromRGB(0, 255, 200),
    TextW = Color3.fromRGB(255, 255, 255),
    TextG = Color3.fromRGB(150, 150, 170),
    Red = Color3.fromRGB(255, 80, 80),
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubCyber"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function notify(title, text)
    pcall(function() 
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3}) 
    end)
end

-- ==========================================
-- 1. FLOATING TOGGLE BUTTON (BUKA/TUTUP)
-- ==========================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "FloatingToggle"
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = C.NeonPurple
ToggleBtn.Text = "W"
ToggleBtn.TextColor3 = C.TextW
ToggleBtn.Font = Enum.Font.Code
ToggleBtn.TextSize = 18
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- ==========================================
-- 2. MAIN WINDOW & RESIZE
-- ==========================================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = C.BgMain
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = C.NeonPurple
MainStroke.Thickness = 2

-- Logika Buka/Tutup (Klik vs Geser)
local clickTime = 0
local startPos = Vector2.new(0,0)
ToggleBtn.MouseButton1Down:Connect(function() clickTime = tick(); startPos = ToggleBtn.AbsolutePosition end)
ToggleBtn.MouseButton1Up:Connect(function()
    if tick() - clickTime < 0.2 and (ToggleBtn.AbsolutePosition - startPos).Magnitude < 5 then 
        Main.Visible = not Main.Visible 
    end
end)

-- Resize Handle (Tarik Pojok Kanan Bawah)
local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
ResizeHandle.BackgroundColor3 = C.NeonPurple
ResizeHandle.Text = "◢"
ResizeHandle.TextColor3 = C.TextW
ResizeHandle.TextSize = 12
ResizeHandle.ZIndex = 10
ResizeHandle.Parent = Main
Instance.new("UICorner", ResizeHandle).CornerRadius = UDim.new(0, 4)

local resizing = false
local startSize, startMousePos
ResizeHandle.MouseButton1Down:Connect(function() 
    resizing = true; startSize = Main.AbsoluteSize; startMousePos = UserInputService:GetMouseLocation() 
end)
UserInputService.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local deltaX = UserInputService:GetMouseLocation().X - startMousePos.X
        local deltaY = UserInputService:GetMouseLocation().Y - startMousePos.Y
        Main.Size = UDim2.new(0, math.clamp(startSize.X + deltaX, 400, 800), 0, math.clamp(startSize.Y + deltaY, 300, 600))
    end
end)
UserInputService.InputEnded:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end 
end)

-- ==========================================
-- 3. TOP BAR & TABS
-- ==========================================
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = C.BgTop
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "WILLHUB // SYSTEM"
Title.TextColor3 = C.NeonCyan
Title.Font = Enum.Font.Code
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = C.Red
CloseBtn.Font = Enum.Font.Code
CloseBtn.TextSize = 18
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 30)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main
local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 10)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -100)
Content.Position = UDim2.new(0, 10, 0, 90)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Pages = {}
local activeBtn = nil

-- Fungsi Bikin Halaman
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
    if activeBtn then TweenService:Create(activeBtn, TweenInfo.new(0.2), {BackgroundColor3 = C.BgElement, TextColor3 = C.TextG}):Play() end
    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = C.NeonPurple, TextColor3 = C.TextW}):Play()
    activeBtn = btn
end

local function addTabButton(text, pageName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 1, 0)
    btn.BackgroundColor3 = C.BgElement
    btn.Text = text
    btn.TextColor3 = C.TextG
    btn.Font = Enum.Font.Code
    btn.TextSize = 13
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function() switchTab(pageName, btn) end)
    return btn
end

local pFarm = createPage("Farm")
local pTeleport = createPage("Teleport")
local pSettings = createPage("Settings")
addTabButton("FARM", "Farm")
addTabButton("TELEPORT", "Teleport")
addTabButton("SETTINGS", "Settings")

-- ==========================================
-- 4. KOMPONEN UI (SUDAH RAPI)
-- ==========================================
local function createToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = C.BgElement
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 15, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = C.TextW
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 40, 0, 20)
    bg.Position = UDim2.new(1, -55, 0.5, -10)
    bg.BackgroundColor3 = C.BgMain
    bg.Parent = frame
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local stroke = Instance.new("UIStroke", bg)
    stroke.Color = C.TextG
    
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
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = C.NeonPurple}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = C.TextW}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.2), {Color = C.NeonPurple}):Play()
        else
            TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = C.BgMain}):Play()
            TweenService:Create(dot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = C.TextG}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.2), {Color = C.TextG}):Play()
        end
        if callback then callback(isActive) end
    end)
end

local function createInput(parent, placeholder, default)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -10, 0, 35)
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

local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = C.BgElement
    btn.Text = text
    btn.TextColor3 = C.NeonCyan
    btn.Font = Enum.Font.Code
    btn.TextSize = 13
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = C.NeonCyan
    stroke.Transparency = 0.5
    btn.MouseButton1Click:Connect(function() if callback then callback() end end)
    return btn
end

-- ==========================================
-- 5. ISI TAB FARM (TARGET BLOCK & SETTINGS)
-- ==========================================
-- Frame Khusus Target Block
local blockFrame = Instance.new("Frame")
blockFrame.Size = UDim2.new(1, -10, 0, 80)
blockFrame.BackgroundColor3 = C.BgElement
blockFrame.Parent = pFarm
Instance.new("UICorner", blockFrame).CornerRadius = UDim.new(0, 4)

local lblTarget = Instance.new("TextLabel")
lblTarget.Size = UDim2.new(1, -80, 0, 25)
lblTarget.Position = UDim2.new(0, 10, 0, 0)
lblTarget.BackgroundTransparency = 1
lblTarget.Text = "Target: (Semua Block)"
lblTarget.TextColor3 = C.NeonCyan
lblTarget.Font = Enum.Font.GothamBold
lblTarget.TextSize = 12
lblTarget.TextXAlignment = Enum.TextXAlignment.Left
lblTarget.Parent = blockFrame

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 65, 0, 20)
refreshBtn.Position = UDim2.new(1, -75, 0, 3)
refreshBtn.BackgroundColor3 = C.NeonPurple
refreshBtn.Text = "REFRESH"
refreshBtn.TextColor3 = C.TextW
refreshBtn.Font = Enum.Font.Code
refreshBtn.TextSize = 10
refreshBtn.Parent = blockFrame
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 4)

local blockScroll = Instance.new("ScrollingFrame")
blockScroll.Size = UDim2.new(1, -10, 1, -30)
blockScroll.Position = UDim2.new(0, 5, 0, 25)
blockScroll.BackgroundTransparency = 1
blockScroll.ScrollBarThickness = 3
blockScroll.Parent = blockFrame
local blockList = Instance.new("UIListLayout", blockScroll)
blockList.FillDirection = Enum.FillDirection.Horizontal
blockList.Padding = UDim.new(0, 5)

local selectedBlock = ""
local function refreshBlocks()
    for _, child in pairs(blockScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    selectedBlock = ""
    lblTarget.Text = "Target: (Semua Block)"
    
    local bp = player:FindFirstChild("Backpack")
    if bp then
        for _, tool in pairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0, 85, 0, 25)
                btn.BackgroundColor3 = C.BgMain
                btn.Text = tool.Name
                btn.TextColor3 = C.TextW
                btn.Font = Enum.Font.Code
                btn.TextSize = 11
                btn.Parent = blockScroll
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
                btn.MouseButton1Click:Connect(function()
                    selectedBlock = tool.Name
                    lblTarget.Text = "Target: " .. selectedBlock
                    for _, b in pairs(blockScroll:GetChildren()) do
                        if b:IsA("TextButton") then b.BackgroundColor3 = C.BgMain end
                    end
                    btn.BackgroundColor3 = C.NeonPurple
                end)
            end
        end
    end
end
refreshBtn.MouseButton1Click:Connect(function() refreshBlocks(); notify("WillHub", "Tas di-refresh!") end)
task.spawn(refreshBlocks)

local areaInput = createInput(pFarm, "Radius Area (Studs)", "30")
local breakInput = createInput(pFarm, "Break Delay (Detik)", "0.2")
local placeInput = createInput(pFarm, "Place Delay (Detik)", "0.5")

local isFastPunch = false
createToggle(pFarm, "Fast Punch (Spam Klik)", function(state) isFastPunch = state end)

-- AUTO BREAK LOOP
local farmThread = nil
createToggle(pFarm, "Auto Break (Radius)", function(state)
    if state then
        notify("WillHub", "Auto Break Aktif!")
        farmThread = task.spawn(function()
            while state do
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

                    if targetPart then
                        hum:MoveTo(targetPart.Position)
                        local bDelay = tonumber(breakInput.Text) or 0.2
                        if isFastPunch then bDelay = 0.01 end
                        task.wait(bDelay + math.random(-2,2)/100)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.02)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    else
                        hum:MoveTo(hrp.Position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
                        task.wait(0.5)
                    end
                end)
            end
        end)
    else
        notify("WillHub", "Auto Break Mati")
        if farmThread then task.cancel(farmThread) end
    end
end)

-- AUTO COLLECT LOOP
local collectThread = nil
createToggle(pFarm, "Auto Collect (Ambil Jatuhan)", function(state)
    if state then
        notify("WillHub", "Auto Collect Aktif!")
        collectThread = task.spawn(function()
            while state do
                pcall(function()
                    local char = player.Character
                    if not char then return end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if not hrp or not hum then return end

                    local closestItem = nil
                    local shortestDist = 40
                    
                    -- Pakai radius biar ga lag (scan 40 studs sekitar)
                    local parts = workspace:GetPartBoundsInRadius(hrp.Position, 40)
                    for _, part in pairs(parts) do
                        if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name ~= "Baseplate" then
                            if part.Size.Magnitude <= 15 then -- Filter ukuran item drop
                                local dist = (part.Position - hrp.Position).Magnitude
                                if dist < shortestDist then
                                    shortestDist = dist
                                    closestItem = part
                                end
                            end
                        end
                    end

                    if closestItem then
                        hum:MoveTo(closestItem.Position)
                        task.wait(0.2) 
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        notify("WillHub", "Auto Collect Mati")
        if collectThread then task.cancel(collectThread) end
    end
end)

-- ==========================================
-- 6. TAB TELEPORT & SETTINGS
-- ==========================================
local tpX = createInput(pTeleport, "Coord X", "0")
local tpY = createInput(pTeleport, "Coord Y", "50")
local tpZ = createInput(pTeleport, "Coord Z", "0")
createButton(pTeleport, "TELEPORT!", function()
    local x, y, z = tonumber(tpX.Text), tonumber(tpY.Text), tonumber(tpZ.Text)
    if x and y and z then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
            notify("Teleport", "Berhasil!")
        end
    end
end)

local speedBox = createInput(pSettings, "WalkSpeed (16)", "50")
createButton(pSettings, "SET SPEED", function()
    local spd = tonumber(speedBox.Text)
    if spd then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = spd
            notify("Settings", "Speed diubah ke " .. spd)
        end
    end
end)

createButton(pSettings, "REJOIN SERVER", function()
    notify("Settings", "Sedang Rejoin...")
    task.wait(1)
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- Set Default Tab
switchTab("Farm", TabBar:GetChildren()[1])
