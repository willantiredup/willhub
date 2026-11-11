-- ==========================================
-- WillHub - Ultimate Data Extractor
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if CoreGui:FindFirstChild("WillHubDump") then CoreGui.WillHubDump:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "WillHubDump"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 300)
main.Position = UDim2.new(0.5, -200, 0.5, -150)
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
title.Text = "🕵️ WillHub Data Extractor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.Parent = top

local tb = Instance.new("TextBox")
tb.Size = UDim2.new(1, -20, 1, -40)
tb.Position = UDim2.new(0, 10, 0, 35)
tb.BackgroundTransparency = 1
tb.TextColor3 = Color3.fromRGB(50, 200, 50)
tb.Font = Enum.Font.Code
tb.TextSize = 10
tb.MultiLine = true
tb.TextWrapped = true
tb.TextXAlignment = Enum.TextXAlignment.Left
tb.TextYAlignment = Enum.TextYAlignment.Top
tb.Text = "Mulai memindai...\n"
tb.Parent = main

local text = ""
local function log(msg)
    text = text .. msg .. "\n"
    tb.Text = text
    tb.CursorPosition = #text
end

task.spawn(function()
    log("=== 1. REPLICATEDSTORAGE ===")
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        log("[" .. v.ClassName .. "] " .. v:GetFullName())
    end
    
    log("\n=== 2. PLAYERSCRIPTS ===")
    for _, v in pairs(player.PlayerScripts:GetDescendants()) do
        log("[" .. v.ClassName .. "] " .. v:GetFullName())
    end
    
    log("\n=== 3. HOOK ACTIVE ===")
    log("Silakan pukul 1 block manual di game...")
end)

-- Hook Namecall
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if not checkcaller() then
        if method == "FireServer" or method == "InvokeServer" then
            local rName = self.Name
            if not string.find(string.lower(rName), "chat") then
                local argStr = ""
                for i, arg in ipairs(args) do
                    if type(arg) == "table" then argStr = argStr .. "[Table] "
                    else argStr = argStr .. tostring(arg) .. " " end
                end
                log(">> " .. method .. ": " .. rName .. " (" .. argStr .. ")")
            end
        end
    end
    return oldNamecall(self, ...)
end)

-- Hook Index (Buat nangkep ByteNet / Custom Network)
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if not checkcaller() then
        if type(key) == "string" and (key == "Fire" or key == "Invoke" or key == "FireServer" or key == "InvokeServer") then
            log(">> Akses Network: " .. tostring(self) .. " -> " .. key)
        end
    end
    return oldIndex(self, key)
end)
