-- ==========================================
-- WillHub - The Real World Hooker (Fix)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubCyber") then CoreGui.WillHubCyber:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "WillHubCyber"
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
title.Text = "🕵️ WillHub - World Hooker"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.Parent = top

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -40)
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

-- Hook Namecall
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
        local rName = tostring(self.Name)
        -- Cek apakah ini remote dari WorldRemotes
        if self.Parent and self.Parent.Name == "WorldRemotes" then
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

task.spawn(function()
    log("Menyiapkan Hook...")
    task.wait(1)
    log("Hook Aktif! Silakan pukul 1 block.")
    log("Tunggu tulisan hijau muncul.")
end)
