local GITHUB_USER = "willantiredup"
local REPO        = "willhub"
local BRANCH      = "main"
local FILE        = "will_hubs/willhub.lua"

local URL = ("https://raw.githubusercontent.com/%s/%s/%s/%s")
    :format(GITHUB_USER, REPO, BRANCH, FILE) -- Perhatikan: pakai GITHUB_USER, bukan teks mentah

local ok, err = pcall(function()
    local src = game:HttpGet(URL, true)
    if not src or #src < 100 then
        error("Fetch gagal / file kosong: " .. URL)
    end
    loadstring(src)()
end)

if not ok then
    warn("[WillHub Loader] " .. tostring(err))
end
