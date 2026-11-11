-- WillHub Auto-Update Loader (Bypass Cache)
local GITHUB_USER = "willantiredup"
local REPO        = "willhub"
local BRANCH      = "main"
local FILE_PATH   = "will_hubs/willhub.lua"

-- 1. Ambil ID Commit paling baru dari GitHub
local apiUrl = ("https://api.github.com/repos/%s/%s/commits/%s"):format(GITHUB_USER, REPO, BRANCH)
local success, response = pcall(function() return game:HttpGet(apiUrl, true) end)

local commitHash = BRANCH
if success and response then
    local match = string.match(response, '"sha"%s*:%s*"([a-f0-9]+)"')
    if match then commitHash = match end
end

-- 2. Tarik file pakai ID Commit (Cache-Proof)
local rawUrl = ("https://raw.githubusercontent.com/%s/%s/%s/%s"):format(GITHUB_USER, REPO, commitHash, FILE_PATH)

local ok, err = pcall(function()
    local src = game:HttpGet(rawUrl, true)
    if not src or #src < 50 then error("Fetch gagal / file kosong") end
    loadstring(src)()
end)

if not ok then
    warn("[WillHub Auto-Updater] " .. tostring(err))
end
