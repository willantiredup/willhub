-- ==========================================
-- WillHub - TBOD2 Ultimate Tycoon Farm
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubTBOD") then CoreGui.WillHubTBOD:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WillHubTBOD"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local C = {
    BgMain = Color3.fromRGB(13, 15, 23),
    BgTop = Color3.fromRGB(17, 20, 28),
    BgElement = Color3.fromRGB(23, 27, 38),
    Accent = Color3.fromRGB(43, 104, 227),
    TextW = Color3.fromRGB(255, 255, 255),
    TextG = Color3.fromRGB(150, 155, 165),
    Red = Color3.fromRGB(255, 80, 80)
}

local function notify(title, text)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3}) end)
end

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

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 450, 0, 320)
Main.Position = UDim2.new(0.5, -225, 0.5, -160)
Main.BackgroundColor3 = C.BgMain
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = C.BgTop
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🍔 TBOD2 Ultimate Farm"
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

local function createToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 45)
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
    lbl.TextSize = 13
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

-- FITUR 1: AUTO BUY & UPGRADE
local buyThread = nil
createToggle(Scroll, "Auto Buy & Upgrade (Klik Semua)", function(state)
    if state then
        notify("TBOD2", "Auto Buy ON")
        buyThread = task.spawn(function()
            while state do
                pcall(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    
                    if hrp then
                        local parts = workspace:GetPartBoundsInRadius(hrp.Position, 30)
                        for _, part in pairs(parts) do
                            for _, child in pairs(part:GetChildren()) do
                                if child:IsA("ProximityPrompt") then
                                    pcall(function() fireproximityprompt(child) end)
                                elseif child:IsA("ClickDetector") then
                                    pcall(function() fireclickdetector(child) end)
                                end
                            end
                        end
                    end
                end)
                task.wait(0.5) -- Cepet tapi aman
            end
        end)
    else
        notify("TBOD2", "Auto Buy OFF")
        if buyThread then task.cancel(buyThread) end
    end
end)

-- FITUR 2: AUTO WALK TO CASH
local walkThread = nil
createToggle(Scroll, "Auto Walk to Cash (Ambil Duit)", function(state)
    if state then
        notify("TBOD2", "Auto Walk ON")
        walkThread = task.spawn(function()
            while state do
                pcall(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    
                    if hrp and hum then
                        local closest, dist = nil, 40
                        
                        local parts = workspace:GetPartBoundsInRadius(hrp.Position, 40)
                        for _, part in pairs(parts) do
                            if part:IsA("BasePart") and not part:IsDescendantOf(char) and part.Name ~= "Baseplate" then
                                local name = string.lower(part.Name)
                                -- Cari objek duit (nama biasanya cash, money, coin, atau Part kecil)
                                if (string.find(name, "cash") or string.find(name, "money") or string.find(name, "coin")) and part.Size.Magnitude <= 15 then
                                    local d = (part.Position - hrp.Position).Magnitude
                                    if d < dist then dist, closest = d, part end
                                end
                            end
                        end
                        
                        if closest then
                            hum:MoveTo(closest.Position)
                            task.wait(0.1)
                            -- Paksa sentuh pas udah deket
                            if firetouchinterest then
                                pcall(function()
                                    firetouchinterest(hrp, closest, 0)
                                    firetouchinterest(hrp, closest, 1)
                                end)
                            end
                        end
                    end
                end)
                task.wait(0.5) -- Jeda aman
            end
        end)
    else
        notify("TBOD2", "Auto Walk OFF")
        if walkThread then task.cancel(walkThread) end
    end
end)
