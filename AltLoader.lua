if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(math.random())

local REPO = "https://raw.githubusercontent.com/gilgameshfate59/hobfooskated/main/"

local routes = {
	[10563114921] = { "Steal a Egg", REPO .. "StealEgg.lua" },
	[10539411000] = { "Clean All The Leaves", REPO .. "Leaves.lua" },
	[10338952197] = { "Grow a Chicken Fighter", REPO .. "Chicken.lua" },
}

local route = routes[game.GameId]
if not route then return end

local genv = getgenv and getgenv()
local state = (genv and genv.SupraLoaderState) or { loaded = {} }
if genv then genv.SupraLoaderState = state end
if state.loaded[route[1]] then return end
state.loaded[route[1]] = true

local ok, src = pcall(game.HttpGet, game, route[2])
if ok and type(src) == "string" and #src >= 32 then
	local chunk = loadstring((src:gsub("^\239\187\191", "")))
	if chunk and pcall(chunk) then return end
end

state.loaded[route[1]] = nil
