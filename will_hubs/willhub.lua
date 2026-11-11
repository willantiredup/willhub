-- ==========================================
-- WillHub - TBOD2 Data Extractor
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubExtractor") then CoreGui.WillHubExtractor:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "WillHubExtractor"
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

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
title.Text = "🔎 TBOD2 Data Extractor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.Parent = main

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -40)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 3
scroll.Parent = main
local list = Instance.new("UIListLayout", scroll)

local function log(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(50, 200, 50)
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.Parent = scroll
    task.defer(function() scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y) end)
end

-- 1. Hook Namecall (Buat nangkep remote)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
        local rName = tostring(self.Name)
        -- Filter chat
        if not string.find(string.lower(rName), "chat") then
            local argsStr = ""
            for i, v in pairs(args) do
                if type(v) == "table" then argsStr = argsStr .. "[Table] "
                else argsStr = argsStr .. tostring(v) .. " " end
            end
            log("[" .. method .. "] " .. rName .. " -> " .. argsStr)
        end
    end
    return oldNamecall(self, ...)
end)

-- 2. Dump ReplicatedStorage
task.spawn(function()
    log("=== MEMINDAI REPLICATEDSTORAGE ===")
    task.wait(0.5)
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("ModuleScript") then
            log("[" .. v.ClassName .. "] " .. v.Name)
        end
    end
    
    log("\n=== HOOK AKTIF ===")
    log("Silakan main manual (beli, klik, drop)")
    log("Pantau log di atas...")
end)
