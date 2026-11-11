-- ==========================================
-- WillHub - WorldRemotes Brute Forcer
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubBrute") then CoreGui.WillHubBrute:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "WillHubBrute"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 250)
main.Position = UDim2.new(0.5, -175, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 30)
top.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "💣 WillHub Brute Forcer"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.Parent = top

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -50)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 3
scroll.Parent = main
local list = Instance.new("UIListLayout", scroll)

local function log(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(50, 200, 50)
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = scroll
    task.defer(function() scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y) end)
end

-- Tombol Mulai
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -10, 0, 30)
btn.Position = UDim2.new(0, 5, 1, -35)
btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btn.Text = "MULAI BRUTE FORCE"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.Parent = main
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

-- Logika Brute Force
btn.MouseButton1Click:Connect(function()
    btn.Text = "SEDANG MENEMBAK..."
    btn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
    
    task.spawn(function()
        local worldFolder = ReplicatedStorage:FindFirstChild("WorldRemotes")
        if not worldFolder then
            log("WorldRemotes tidak ditemukan!")
            return
        end
        
        for _, remote in pairs(worldFolder:GetChildren()) do
            log("Mencoba: " .. remote.Name)
            
            pcall(function()
                -- Tembak pakai tebakan (Harvest, Break, Block)
                if remote:IsA("RemoteEvent") then
                    remote:FireServer()
                    remote:FireServer("Harvest")
                    remote:FireServer("Break")
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer()
                end
            end)
            
            task.wait(0.5) -- Jeda 0.5 detik biar ga langsung kena ban
        end
        
        log("=== SELESAI ===")
        btn.Text = "SELESAI"
        btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end)
end)
