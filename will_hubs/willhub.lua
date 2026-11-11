-- 1. Load Modern UI
local uiUrl = "https://raw.githubusercontent.com/willantiredup/willhub/refs/heads/main/will_hubs/ui.lua"
pcall(function()
    loadstring(game:HttpGet(uiUrl, true))()
end)

-- 2. Logika Auto Farm (di belakang layar)
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player            = Players.LocalPlayer

local Remotes, PlayerData = {}, nil
task.spawn(function()
    pcall(function()
        Remotes.ManipulateCrop = ReplicatedStorage:WaitForChild("ManipulateCrop", 10)
        Remotes.UseMarket      = ReplicatedStorage:WaitForChild("UseMarket", 10)
        Remotes.CropSold       = ReplicatedStorage:WaitForChild("CropSold", 10)
        Remotes.UseItem        = ReplicatedStorage:WaitForChild("UseItem", 10)
        PlayerData             = require(ReplicatedStorage:WaitForChild("PlayerData", 10))
    end)
end)

local CONFIG = { AUTO_PLANT = true, AUTO_HARVEST = true, AUTO_WATER = true, AUTO_SELL = true, SEED_NAME = "Hay", WALK_SPEED = 60, FARM_DELAY = 1.5, OUTBOX = false }
local farm, plots, isSelling, running = nil, {}, false, true -- running = true biar langsung jalan

local function findFarm()
    for i = 1, 8 do
        local f = workspace:FindFirstChild("Farm" .. i)
        if f and f:FindFirstChild("Owner") and f.Owner.Value == player then farm = f; break end
    end
    if not farm then return end
    plots = {}
    for i = 1, 6 do
        local plot = farm:FindFirstChild("Plot" .. i)
        if plot then table.insert(plots, plot) end
    end
end

-- (Masukkan fungsi setSpeed, sellCrops, processPlot persis kayak kode sebelumnya)

-- Loop farm
task.spawn(function()
    while true do
        if running then
            pcall(function()
                if #plots == 0 then findFarm() end
                for _, plot in pairs(plots) do processPlot(plot); task.wait(0.05) end
                sellCrops()
            end)
        end
        task.wait(CONFIG.FARM_DELAY)
    end
end)
