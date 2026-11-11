--[[
    WillHub - Growblox Auto Farm (GUI Version)
    Game : https://www.roblox.com/games/112863874972771/Growblox
]]

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui           = game:GetService("CoreGui")
local player            = Players.LocalPlayer

local CONFIG = {
    AUTO_PLANT   = true,
    AUTO_HARVEST = true,
    AUTO_WATER   = true,
    AUTO_SELL    = true,
    SEED_NAME    = "Hay",
    WALK_SPEED   = 60,
    FARM_DELAY   = 1.5,
    OUTBOX       = false,
}

local Remotes = {
    ManipulateCrop = ReplicatedStorage:WaitForChild("ManipulateCrop"),
    UseMarket      = ReplicatedStorage:WaitForChild("UseMarket"),
    CropSold       = ReplicatedStorage:WaitForChild("CropSold"),
    UseItem        = ReplicatedStorage:WaitForChild("UseItem"),
}
local PlayerData = require(ReplicatedStorage:WaitForChild("PlayerData"))

local farm, plots, isSelling, running = nil, {}, false, false

-- ==========================================
-- UI CREATION
-- ==========================================
local gui = Instance.new("ScreenGui")
gui.Name = "WillHubUI"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 220, 0, 150)
main.Position = UDim2.new(0.5, -110, 0.5, -75)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
title.BorderSizePixel = 0
title.Text = "WillHub | Growblox 🥀"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = main

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0.8, 0, 0, 40)
toggle.Position = UDim2.new(0.1, 0, 0.4, 0)
toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggle.BorderSizePixel = 0
toggle.Text = "AUTO FARM: OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
toggle.Parent = main

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 20)
status.Position = UDim2.new(0, 0, 0.8, 0)
status.BackgroundTransparency = 1
status.Text = "Status: Idle"
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Parent = main
-- ==========================================

-- ==========================================
-- LOGIC FUNCTIONS
-- ==========================================
local function findFarm()
    for i = 1, 8 do
        local f = workspace:FindFirstChild("Farm" .. i)
        if f and f:FindFirstChild("Owner") and f.Owner.Value == player then
            farm = f; break
        end
    end
    if not farm then return end
    plots = {}
    for i = 1, 6 do
        local plot = farm:FindFirstChild("Plot" .. i)
        if plot then table.insert(plots, plot) end
    end
end

local function setSpeed()
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = CONFIG.WALK_SPEED end
    end
end

local function sellCrops()
    if not CONFIG.AUTO_SELL or isSelling then return end
    local data = PlayerData.get()
    if not data or data.weight <= 0 then return end
    isSelling = true
    if not CONFIG.OUTBOX and player.Character then
        player.Character:MoveTo(Vector3.new(52, 5, -453))
        task.wait(2)
    end
    for cropType in pairs(data.crops) do
        local qty = data.crops[cropType] or 0
        if qty > 0 then
            pcall(function()
                Remotes.UseMarket:FireServer("SellCrop", cropType, qty, CONFIG.OUTBOX)
                Remotes.CropSold:Fire(cropType, qty, CONFIG.OUTBOX)
            end)
        end
    end
    isSelling = false
end

local function processPlot(plot)
    for _, crop in pairs(plot:GetChildren()) do
        if crop:FindFirstChild("CropType") then
            local cropType = crop.CropType.Value

            -- HARVEST
            if CONFIG.AUTO_HARVEST and cropType ~= "none" then
                local stage = crop.CropStage and crop.CropStage.Value or 0
                local reqStage = PlayerData.get().crops[cropType] or 99
                if stage >= reqStage then
                    pcall(function() Remotes.ManipulateCrop:FireServer(crop, "Harvest") end)
                    task.wait(0.1)
                end
            end
            -- PLANT
            if CONFIG.AUTO_PLANT and cropType == "none" then
                local data = PlayerData.get()
                if data.seeds[CONFIG.SEED_NAME] and data.seeds[CONFIG.SEED_NAME] > 0 then
                    pcall(function() Remotes.ManipulateCrop:FireServer(crop, "PlantSeed", CONFIG.SEED_NAME) end)
                    task.wait(0.1)
                end
            end
            -- WATER
            if CONFIG.AUTO_WATER and crop:FindFirstChild("WaterContent") and crop.WaterContent.Value <= 2 then
                Remotes.ManipulateCrop:FireServer(crop, "Water")
                if farm and farm:FindFirstChild("Well") then
                    Remotes.UseItem:FireServer(farm.Well)
                end
            end
        end
    end
end

local function startFarm()
    running = true
    toggle.Text = "AUTO FARM: ON"
    toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    status.Text = "Status: Farming... 🥀"
    
    task.spawn(function()
        findFarm()
        while running do
            pcall(function()
                setSpeed()
                if #plots == 0 then findFarm() end
                for _, plot in pairs(plots) do
                    if not running then break end
                    processPlot(plot)
                    task.wait(0.05)
                end
                sellCrops()
            end)
            task.wait(CONFIG.FARM_DELAY)
        end
    end)
end
-- ==========================================

-- ==========================================
-- UI EVENTS
-- ==========================================
toggle.MouseButton1Click:Connect(function()
    if running then
        running = false
        toggle.Text = "AUTO FARM: OFF"
        toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        status.Text = "Status: Idle"
    else
        startFarm()
    end
end)
