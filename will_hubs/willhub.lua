-- ==========================================
-- WillHub - Cyberpunk Edition (Full Custom Farm)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
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
    Green = Color3.fromRGB(50, 200, 50)
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

-- MAIN WINDOW
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = C.BgMain
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = C.NeonPurple
MainStroke.Thickness = 2

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
local function createPage(name)
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = Content
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

local function createToggle(parent, text, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.Position = UDim2.new(0, 0, 0, yPos)
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
    lbl.TextSize = 12
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

local function createInput(parent, placeholder, yPos, default)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.45, 0, 0, 30)
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
-- PENGATURAN AREA & KECEPATAN
-- ==========================================
local lblTarget = Instance.new("TextLabel")
lblTarget.Size = UDim2.new(1, -100, 0, 20)
lblTarget.Position = UDim2.new(0, 0, 0, 0)
lblTarget.BackgroundTransparency = 1
lblTarget.Text = "Target: (Semua)"
lblTarget.TextColor3 = C.NeonCyan
lblTarget.Font = Enum.Font.GothamBold
lblTarget.TextSize = 12
lblTarget.TextXAlignment = Enum.TextXAlignment.Left
lblTarget.Parent = pFarm

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 90, 0, 25)
refreshBtn.Position = UDim2.new(1, -90, 0, 0)
refreshBtn.BackgroundColor3 = C.BgElement
refreshBtn.Text = "REFRESH TAS"
refreshBtn.TextColor3 = C.TextW
refreshBtn.Font = Enum.Font.Code
refreshBtn.TextSize = 11
refreshBtn.Parent = pFarm
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 4)

local blockScroll = Instance.new("ScrollingFrame")
blockScroll.Size = UDim2.new(1, 0, 0, 80)
blockScroll.Position = UDim2.new(0, 0, 0, 30)
blockScroll.BackgroundTransparency = 1
blockScroll.ScrollBarThickness = 3
blockScroll.Parent = pFarm
local blockList = Instance.new("UIListLayout", blockScroll)
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
                btn.Size = UDim2.new(0, 120, 0, 25)
                btn.BackgroundColor3 = C.BgElement
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
                        if b:IsA("TextButton") then b.BackgroundColor3 = C.BgElement end
                    end
                    btn.BackgroundColor3 = C.NeonPurple
                end)
            end
        end
    end
end
refreshBtn.MouseButton1Click:Connect(function()
    refreshBlocks()
    notify("WillHub", "Tas di-refresh!")
end)
task.spawn(refreshBlocks)

-- INPUT SETTINGS
local areaInput = createInput(pFarm, "Radius Area (Studs)", 120, "30")
local breakInput = createInput(pFarm, "Break Delay (s)", 120, "0.2")
breakInput.Position = UDim2.new(0.5, 5, 0, 120)

local placeInput = createInput(pFarm, "Place Delay (s)", 160, "0.5")
local fastPunchToggle = createToggle(pFarm, "Fast Punch (Spam Klik)", 160, function(state)
    if state then notify("WillHub", "Fast Punch Aktif (Gunakan dengan hati-hati)") end
end)

-- ==========================================
-- 1. AUTO BREAK (RADIUS + TARGET)
-- ==========================================
local farmThread = nil
createToggle(pFarm, "Auto Break (Raycaster)", 200, function(state)
    if state then
        notify("WillHub", "Auto Break Aktif!")
        farmThread = task.spawn(function()
            while state do
                pcall(function()
                    local char = player.Character
                    if not char then return end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local cam = workspace.CurrentCamera
                    if not hrp or not hum or not cam then return end

                    -- Baca Radius dari input
                    local maxRadius = tonumber(areaInput.Text) or 30
                    
                    local rayOrigin = cam.CFrame.Position
                    local rayDirection = cam.CFrame.LookVector * maxRadius
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {char}
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude
                    
                    local result = workspace:Raycast(rayOrigin, rayDirection, rayParams)
                    
                    if result and result.Instance then
                        local targetPart = result.Instance
                        local dist = (targetPart.Position - hrp.Position).Magnitude
                        
                        -- Cek apakah objek di depan cocok dengan target
                        local isTargetMatch = false
                        if selectedBlock == "" then isTargetMatch = true
                        elseif string.find(string.lower(targetPart.Name), string.lower(selectedBlock)) then isTargetMatch = true end

                        -- Pastikan objek bukan lantai, ukurannya masuk akal, dan dalam radius
                        if targetPart.Name ~= "Baseplate" and targetPart.Size.Y > 0.2 and isTargetMatch and dist <= maxRadius then
                            hum:MoveTo(targetPart.Position)
                            
                            -- Kecepatan Break
                            local bDelay = tonumber(breakInput.Text) or 0.2
                            if fastPunchToggle and fastPunchToggle() then bDelay = 0.01 end
                            
                            task.wait(bDelay + math.random(-5,5)/100) -- Randomize biar aman
                            
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            task.wait(0.02)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        else
                            cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(45), 0)
                        end
                    else
                        cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(45), 0)
                        task.wait(0.1)
                    end
                end)
            end
        end)
    else
        notify("WillHub", "Auto Break Mati")
        if farmThread then task.cancel(farmThread) end
    end
end)

-- ==========================================
-- 2. AUTO COLLECT (PICKUP)
-- ==========================================
local collectThread = nil
createToggle(pFarm, "Auto Collect (Ambil Jatuhan)", 250, function(state)
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

                    for _, part in pairs(workspace:GetChildren()) do
                        if part:IsA("BasePart") and not part:IsDescendantOf(char) then
                            if part.Size.X <= 5 and part.Size.Y <= 5 and part.Size.Z <= 5 then
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

-- ================= TELEPORT & SETTINGS =================
local tpX = createInput(pTeleport, "Coord X", 0)
local tpY = createInput(pTeleport, "Coord Y", 40)
local tpZ = createInput(pTeleport, "Coord Z", 80)
local btnTp = Instance.new("TextButton")
btnTp.Size = UDim2.new(1, 0, 0, 40)
btnTp.Position = UDim2.new(0, 0, 0, 125)
btnTp.BackgroundColor3 = C.BgElement
btnTp.Text = "TELEPORT!"
btnTp.TextColor3 = C.NeonCyan
btnTp.Font = Enum.Font.Code
btnTp.TextSize = 13
btnTp.Parent = pTeleport
Instance.new("UICorner", btnTp).CornerRadius = UDim.new(0, 4)
btnTp.MouseButton1Click:Connect(function()
    local x, y, z = tonumber(tpX.Text), tonumber(tpY.Text), tonumber(tpZ.Text)
    if x and y and z then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
            notify("Teleport", "Berhasil!")
        end
    end
end)

local speedBox = createInput(pSettings, "WalkSpeed (16)", 0)
local btnSpd = Instance.new("TextButton")
btnSpd.Size = UDim2.new(1, 0, 0, 40)
btnSpd.Position = UDim2.new(0, 0, 0, 45)
btnSpd.BackgroundColor3 = C.BgElement
btnSpd.Text = "SET SPEED"
btnSpd.TextColor3 = C.NeonCyan
btnSpd.Font = Enum.Font.Code
btnSpd.TextSize = 13
btnSpd.Parent = pSettings
Instance.new("UICorner", btnSpd).CornerRadius = UDim.new(0, 4)
btnSpd.MouseButton1Click:Connect(function()
    local spd = tonumber(speedBox.Text)
    if spd then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = spd
            notify("Settings", "Speed diubah ke " .. spd)
        end
    end
end)

switchTab("Farm", TabBar:GetChildren()[1])
