local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubSpy") then CoreGui.WillHubSpy:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "WillHubSpy"
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 250)
main.Position = UDim2.new(0, 10, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
title.Text = "🔎 TBOD2 Remote Spy"
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
        if not string.find(string.lower(rName), "chat") then
            local str = ""
            for i, v in pairs(args) do
                if type(v) == "table" then str = str .. "[Tabel] "
                else str = str .. tostring(v) .. " " end
            end
            log("[" .. method .. "] " .. rName .. " -> " .. str)
        end
    end
    return oldNamecall(self, ...)
end)

-- Hook Index (Buat nangkep remote yang lewat wrapper)
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if not checkcaller() then
        if type(key) == "string" and (key == "FireServer" or key == "InvokeServer") then
            log("Akses: " .. tostring(self) .. " | " .. key)
        end
    end
    return oldIndex(self, key)
end)

log("Spy Aktif! Klik tombol Buy manual.")
