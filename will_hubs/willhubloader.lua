-- WillHub Anti-Cache Loader
-- Gunakan math.random biar setiap execute, URL-nya dianggap BARU oleh GitHub
local antiCache = math.random(1, 9999999)
local url = "https://raw.githubusercontent.com/willantiredup/willhub/refs/heads/main/will_hubs/willhub.lua?nocache=" .. antiCache

local success, err = pcall(function()
    loadstring(game:HttpGet(url, true))()
end)

if not success then
    warn("[WillHub] Gagal memuat GUI: " .. tostring(err))
end
