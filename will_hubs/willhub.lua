-- ==========================================
-- WillHub - WorldRemotes Specific Hooker
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if CoreGui:FindFirstChild("WillHubHooker") then CoreGui.WillHubHooker:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "WillHubHooker"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 200)
main.Position = UDim2.new(0, 10, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
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

local function hookRemote(remote)
    if remote:IsA("RemoteEvent") then
        local old = remote.FireServer
        remote.FireServer = function(self, ...)
            local args = {...}
            local str = ""
            for i, v in pairs(args) do str = str .. tostring(v) .. " " end
            log("[EVENT] " .. remote.Name .. " (" .. str .. ")")
            return old(self, ...)
        end
    elseif remote:IsA("RemoteFunction") then
        local old = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            local args = {...}
            local str = ""
            for i, v in pairs(args) do str = str .. tostring(v) .. " " end
            log("[FUNC] " .. remote.Name .. " (" .. str .. ")")
            return old(self, ...)
        end
    end
end

task.spawn(function()
    log("Mencari WorldRemotes...")
    local worldFolder = ReplicatedStorage:WaitForChild("WorldRemotes", 10)
    if not worldFolder then
        log("WorldRemotes tidak ditemukan!")
        return
    end
    
    log("Menghubungkan ke semua remote...")
    for _, remote in pairs(worldFolder:GetChildren()) do
        hookRemote(remote)
    end
    log("Selesai! Silakan pukul block manual.")
end)
