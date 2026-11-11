-- WillHub Loader
local url = "https://raw.githubusercontent.com/willantiredup/willhub/refs/heads/main/will_hubs/gui.lua?v=9999"
local success, err = pcall(function()
    loadstring(game:HttpGet(url, true))()
end)

if not success then
    warn("[WillHub] Gagal memuat GUI: " .. tostring(err))
end
