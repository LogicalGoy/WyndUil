--[[
	SUPRA | STEAL A EGG
	Full script built from MCP research against place 107778070777162.

	Farm   — auto steal area eggs, auto place, auto treadmill, guard safety
	Progress — auto base/treadmill upgrades, auto claim offline + index
	ESP    — eggs, rare eggs, guards
	Pets   — auto favorite by rarity/mutation, auto sell by rarity/income/blacklist

	Game bridges everything through the client Network module
	(ReplicatedStorage.Library.Client.Network). Every call also has a raw
	RemoteFunction/RemoteEvent fallback so the script keeps working even if
	the module require is blocked.

	Every endpoint was verified live via MCP on 2026-08-16, including the two
	that used to be guesses: selling goes through ActiveAssets: RequestSell
	(RemoteFunction, plain uid string) and Index: RequestClaimAll is a
	RemoteFunction answering (ok, reason).

	UI:   WindUI (Footagesus) - MIT
	ESP:  MSESP (mstudio45)   - MIT
	Core: supra-repo/core.lua
--]]

local HUB_NAME = "Steal a Egg"
local HUB_FOLDER = "SupraHub"
local REPO = "https://raw.githubusercontent.com/LogicalGoy/WyndUil/main/"
local DISCORD = "https://discord.gg/WfYDzQfE8y"
local LOGO_ID = 87181760775636

-- Set if you ever host the finished script. Auto-rejoin re-runs it after a kick.
local SCRIPT_URL = nil

local ACCENT = Color3.fromHex("#4C8DFF")
local ACCENT2 = Color3.fromHex("#7C5CFF")
local DANGER = Color3.fromHex("#E5484D")

-- ============================================================ CORE

local function Fetch(name)
	local ok, body = pcall(game.HttpGet, game, REPO .. name)
	if not ok then
		error(("[%s] failed to download %s: %s"):format(HUB_NAME, name, tostring(body)), 0)
	end
	local chunk, err = loadstring(body)
	if not chunk then
		error(("[%s] failed to compile %s: %s"):format(HUB_NAME, name, tostring(err)), 0)
	end
	return chunk()
end

local WindUI = Fetch("ui.lua")
local ESPLib = Fetch("esp.lua")

local Core = Fetch("core.lua").Init({
	HubName = HUB_NAME,
	Folder = HUB_FOLDER,
	Discord = DISCORD,
	LogoId = LOGO_ID,
	Accent = ACCENT,
	Island = { LogoSize = 26 },
})

local Cleanup, Scheduler, Island, Util = Core.Cleanup, Core.Scheduler, Core.Island, Core.Util

local WINDOW_SIZE = Core.IsMobile and Vector2.new(560, 380) or Vector2.new(700, 500)

local SafeCall = Util.SafeCall
local GetCharacter = Util.GetCharacter
local ReadJSON = Util.ReadJSON
local WriteJSON = Util.WriteJSON

local IS_MOBILE = Core.IsMobile
local setclipboard = Core.setclipboard

-- ============================================================ SERVICES

local cloneref = cloneref or function(o) return o end

local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Workspace = cloneref(game:GetService("Workspace"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local HttpService = cloneref(game:GetService("HttpService"))
local GuiService = cloneref(game:GetService("GuiService"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function Notify(title, content, duration, icon)
	SafeCall(function()
		WindUI:Notify({
			Title = title,
			Content = content,
			Duration = duration or 3,
			Icon = icon or "info",
		})
	end)
end

-- ============================================================ WINDOW

local Window = WindUI:CreateWindow({
	Title = HUB_NAME,
	Icon = "rbxassetid://" .. LOGO_ID,
	IconSize = 30,
	Author = "Supra",
	Folder = HUB_FOLDER,
	Size = UDim2.fromOffset(WINDOW_SIZE.X, WINDOW_SIZE.Y),
	Theme = "Dark",
	Resizable = true,
	MinSize = Vector2.new(520, 380),
	SideBarWidth = IS_MOBILE and 150 or 190,
	HideSearchBar = false,
	Transparent = false,
	Radius = 16,
	ShadowTransparency = 0.35,
	ToggleKey = Enum.KeyCode.RightShift,
	Topbar = { Height = 46, ButtonsType = "Mac" },
	OpenButton = { Enabled = false },
})

Window:Tag({ Title = "v1.0", Color = ACCENT })

local MainGroup = Window:Section({ Title = "Cheats" })
local SystemGroup = Window:Section({ Title = "System" })

local Tabs = {
	Home = MainGroup:Tab({ Title = "Home", Icon = "layout-dashboard" }),
	Farm = MainGroup:Tab({ Title = "Farm", Icon = "egg-fried" }),
	Progress = MainGroup:Tab({ Title = "Progress", Icon = "trending-up" }),
	ESP = MainGroup:Tab({ Title = "ESP", Icon = "eye" }),
	Pets = MainGroup:Tab({ Title = "Pets", Icon = "paw-print" }),
	Settings = SystemGroup:Tab({ Title = "Settings", Icon = "settings" }),
	Info = SystemGroup:Tab({ Title = "Info", Icon = "scroll-text" }),
}

Island:AttachWindow(Window, WINDOW_SIZE)

-- ============================================================ GAME BRIDGE
-- Every endpoint below was read from the game's NETWORK_MAP registry. Calls
-- go through the client Network module when it exists, with a raw remote
-- fallback so a blocked require can't break the script.

local E = {
	AreaEggSnapshot = "Eggs: RequestAreaEggSnapshot",
	AreaEggCarry = "Eggs: RequestAreaEggCarry",
	AreaEggDrop = "Eggs: RequestAreaEggDrop",
	PlaceEgg = "Eggs: RequestPlaceEgg",
	EquipTool = "Eggs: RequestEquipTool",
	UnequipTool = "Eggs: RequestUnequipTool",
	HatchEgg = "Eggs: RequestHatchEgg",
	CompleteHatchEgg = "Eggs: RequestCompleteHatchEgg",

	AreaEggUpdated = "Eggs: AreaEggUpdated",
	AreaEggRemoved = "Eggs: AreaEggRemoved",
	AreaEggBatchUpdated = "Eggs: AreaEggBatchUpdated",
	AreaEggCarryState = "Eggs: AreaEggCarryState",
	AreaEggClaimFeedback = "Eggs: AreaEggClaimFeedback",

	BaseUpgrade = "Plots: RequestBaseUpgrade",
	OnBaseUpgraded = "Plots: OnBaseUpgraded",
	PlotState = "Plots: RequestState",

	TreadmillEquipStatic = "Treadmills: RequestEquipStatic",
	TreadmillUnequip = "Treadmills: RequestUnequip",
	TreadmillUpgrade = "Treadmills: RequestUpgrade",
	TreadmillActiveChanged = "Treadmills: ActiveTreadmillChanged",
	TreadmillSpeedGain = "Treadmills: SpeedGain",

	OfflineGetSummary = "OfflineAssets: GetSummary",
	OfflineRedeem = "OfflineAssets: Redeem",
	IndexClaimAll = "Index: RequestClaimAll",

	AssetRuntimeSnapshot = "ActiveAssets: RequestRuntimeSnapshot",
	AssetEquip = "ActiveAssets: RequestEquip",
	AssetUnequip = "ActiveAssets: RequestUnequip",
	MoneyUpdated = "ActiveAssets: MoneyUpdated",
	ItemUpdated = "ActiveAssets: ItemUpdated",

	SetFavorite = "AssetInventory: SetFavorite",
	SellAsset = "AssetInventory: SellAsset", -- RemoteEvent, fire-and-forget fallback
	RequestSell = "ActiveAssets: RequestSell", -- RemoteFunction(uid) -> ok
	GetAutoSell = "Backpack: GetAutoSellState",
	SetAutoSell = "Backpack: SetAutoSellState",

	GuardSpeedHitWarning = "Guards: SpeedHitWarning",
	GuardWakeUp = "Guards: WakeUp",
}

local Network, MAP
do
	local ok, mod = pcall(require, ReplicatedStorage.Library.Client.Network)
	if ok and mod then Network = mod end
	if Network then
		pcall(function() MAP = Network.NET_MAP end)
	end
end

local function FindRemote(name, class)
	for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
		if obj.Name == name and obj:IsA(class) then return obj end
	end
end

-- Network.Invoke / .Fire / .Fired are plain functions on the module, not
-- methods. Calling them with the module as the first argument (colon style)
-- makes the endpoint name land in the wrong slot and the module errors with
-- "Unable to assign property Name". Every call has to be dot style.
-- Passes every return through, not just the first. Several endpoints answer
-- (ok, reason) and the reason is the only way to tell "nothing to do" from
-- "call is wrong".
local function Invoke(name, ...)
	if Network then
		local r = table.pack(pcall(Network.Invoke, name, ...))
		if r[1] then return table.unpack(r, 2, r.n) end
	end
	local rf = FindRemote(name, "RemoteFunction")
	if rf then
		local r = table.pack(pcall(rf.InvokeServer, rf, ...))
		if r[1] then return table.unpack(r, 2, r.n) end
	end
	return nil
end

local function Fire(name, ...)
	if Network then
		-- Return on success, otherwise the raw fallback fires a second time.
		local ok = pcall(Network.Fire, name, ...)
		if ok then return end
	end
	local re = FindRemote(name, "RemoteEvent")
	if re then pcall(re.FireServer, re, ...) end
end

local function Fired(name, cb)
	if Network then
		local ev = Network.Fired(name)
		if ev and ev.Connect then
			local c = ev:Connect(cb)
			if c then return c end
		end
	end
	local re = FindRemote(name, "RemoteEvent")
	if re then return re.OnClientEvent:Connect(cb) end
end

local function BindEvent(name, cb)
	local c = Fired(name, cb)
	if c then Cleanup:Connection(c) end
end

local function TryRequire(path)
	local ok, mod = pcall(require, path)
	return ok and mod or nil
end

local SaveMod = TryRequire(ReplicatedStorage.Library.Client.Save)
local PlotCmds = TryRequire(ReplicatedStorage.Library.Client.PlotCmds)
local EggCmds = TryRequire(ReplicatedStorage.Library.Client.EggCmds)
local AssetCmds = TryRequire(ReplicatedStorage.Library.Client.AssetCmds)
local Bases = TryRequire(ReplicatedStorage.Directory.Bases)
local TreadmillsDir = TryRequire(ReplicatedStorage.Directory.Treadmills)

local AssetsDir
do
	local ok, mod = pcall(require, ReplicatedStorage.Directory.Assets)
	if ok and mod then AssetsDir = mod.Directory end
end

-- ============================================================ GAME HELPERS

local function GetSave()
	if not SaveMod then return nil end
	local ok, s = pcall(function() return SaveMod.Get(LocalPlayer, false) end)
	return ok and s or nil
end

local function GetMoney()
	local s = GetSave()
	return (s and s.Money) or 0
end

local function EggConfig(cat)
	return AssetsDir and AssetsDir[cat]
end

local function EggRarityNum(cat)
	local c = EggConfig(cat)
	local r = c and c.Rarity
	return (r and r.RarityNumber) or 1
end

local function EggRarityId(cat)
	local c = EggConfig(cat)
	local r = c and c.Rarity
	return (r and (r._id or r.DisplayName)) or "Unknown"
end

local function EggName(cat)
	local c = EggConfig(cat)
	return (c and c.DisplayName) or cat or "?"
end

local function EggIncome(cat)
	local c = EggConfig(cat)
	return (c and c.EarningRate) or 0
end

-- Ordered rarity ladder, discovered from the asset directory at runtime.
local RarityLadder = {}
do
	local byNum = {}
	if AssetsDir then
		for _, c in pairs(AssetsDir) do
			local r = c and c.Rarity
			if r and r.RarityNumber then
				local n = r.RarityNumber
				if not byNum[n] then
					byNum[n] = r._id or r.DisplayName or ("Rarity " .. n)
				end
			end
		end
	end
	local nums = {}
	for n in pairs(byNum) do nums[#nums + 1] = n end
	table.sort(nums)
	for _, n in ipairs(nums) do RarityLadder[#RarityLadder + 1] = { n = n, name = byNum[n] } end
	if #RarityLadder == 0 then
		for _, n in ipairs({ "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Cosmic", "Secret", "Eternal", "Divine" }) do
			RarityLadder[#RarityLadder + 1] = { n = #RarityLadder + 1, name = n }
		end
	end
end

local function RarityColor(num)
	local C = {
		[1] = Color3.fromRGB(170, 170, 170),
		[2] = Color3.fromRGB(83, 170, 98),
		[3] = Color3.fromRGB(7, 119, 255),
		[4] = Color3.fromRGB(255, 190, 60),
		[5] = Color3.fromRGB(255, 120, 60),
		[6] = Color3.fromRGB(170, 85, 255),
		[7] = Color3.fromRGB(255, 60, 255),
		[8] = Color3.fromRGB(120, 190, 255),
	}
	return C[num] or Color3.fromRGB(255, 255, 255)
end

local function FormatMoney(n)
	if type(n) ~= "number" then return "0" end
	local abs = math.abs(n)
	if abs >= 1e15 then return ("%.2fQ"):format(n / 1e15) end
	if abs >= 1e12 then return ("%.2fT"):format(n / 1e12) end
	if abs >= 1e9 then return ("%.2fB"):format(n / 1e9) end
	if abs >= 1e6 then return ("%.2fM"):format(n / 1e6) end
	if abs >= 1e3 then return ("%.1fK"):format(n / 1e3) end
	return ("%d"):format(math.floor(n))
end

-- Parses "10M", "100K", "1B" or a plain number. Returns nil when unparseable.
local function ParseMoney(s)
	if not s then return nil end
	local str = s:gsub(",", ""):gsub("%s+", ""):upper()
	if str == "" or str == "0" then return 0 end
	local mult = 1
	local num = str:match("^([%d%.]+)([KMBQ]?)$")
	if not num then return nil end
	local prefix = str:match("[KMBQ]$")
	if prefix == "K" then mult = 1e3 elseif prefix == "M" then mult = 1e6
	elseif prefix == "B" then mult = 1e9 elseif prefix == "Q" then mult = 1e12 end
	local v = tonumber(num)
	if not v then return nil end
	return v * mult
end

-- ============================================================ CHARACTER / PLOT

local function MyHRP()
	local _, _, hrp = GetCharacter()
	return hrp
end

local function MySlot()
	if PlotCmds then
		local ok, slot = pcall(function() return PlotCmds.GetMySlot() end)
		if ok and slot then return slot end
	end
	-- fallback: ask the server for the owner map and find ourselves
	local res = Invoke(E.PlotState)
	if type(res) == "table" and type(res.OwnersBySlot) == "table" then
		for slot, uid in pairs(res.OwnersBySlot) do
			if tonumber(uid) == LocalPlayer.UserId then return tonumber(slot) end
		end
	end
	return nil
end

local function MyPlot()
	local slot = MySlot()
	if not slot then return nil end
	return Workspace.Plots:FindFirstChild(tostring(slot))
end

local function MyPlotPoint()
	local plot = MyPlot()
	if plot then
		local cp = plot:FindFirstChild("CenterPoint")
		if cp and cp:IsA("BasePart") then return cp.Position end
		local sp = plot:FindFirstChild("SpawnPoint")
		if sp and sp:IsA("BasePart") then return sp.Position end
	end
	return nil
end

local function InMyPlot(pos)
	if not pos then return false end
	if PlotCmds then
		local ok, inside = pcall(function()
			return PlotCmds.IsWorldPositionWithinLocalPlotBounds(pos)
		end)
		if ok and inside then return true end
	end
	local point = MyPlotPoint()
	return point ~= nil and (pos - point).Magnitude <= 22
end

local function IsTrapped()
	local _, _, hrp = GetCharacter()
	if not hrp then return false end
	local char = hrp.Parent
	return char and char:GetAttribute("IsTrapped") == true
end

-- ============================================================ MOVEMENT
-- Hop mode is the default and is driven by its own fast loop (the farm tick
-- is too slow to hop smoothly). If the game's integrity check keeps undoing
-- the hops (no net movement), it auto-falls back to walking for a few seconds
-- then tries hopping again.

local MoveCfg = { Mode = "Hop", HopSize = 30, HopRate = 10 }

local Movement = {
	Active = false,
	Target = nil,
	Within = 3,
	Arrived = false,
	Clock = 0,
	ProgressCheck = 0,
	LastPos = nil,
	FallbackWalk = false,
}

function Movement:Go(point, within)
	if not point then return end
	if self.Active and self.Target and (self.Target - point).Magnitude < 5 then
		self.Within = within or self.Within
		return
	end
	self.Target = point
	self.Within = within or 3
	self.Arrived = false
	self.Active = true
	self.Clock = 0
	self.ProgressCheck = os.clock()
	self.LastPos = nil
end

function Movement:Stop()
	self.Active = false
	self.Target = nil
end

-- Ask the world, not the mover. Callers re-issue Go every tick, and Go clears
-- Arrived when it is not already running, so the flag was being wiped one line
-- before it was read and the farm could never leave MovingToEgg.
local function AtPoint(point, within)
	local hrp = MyHRP()
	if not (hrp and point) then return false end
	return (point - hrp.Position).Magnitude <= (within or 4)
end

local function MoverTick(dt)
	if not Movement.Active then return end
	local _, hum, hrp = GetCharacter()
	if not hum or not hrp or hum.Health <= 0 then
		Movement:Stop()
		return
	end
	if IsTrapped() then return end

	local target = Movement.Target
	local delta = target - hrp.Position
	local dist = delta.Magnitude
	if dist <= Movement.Within then
		Movement.Arrived = true
		Movement:Stop()
		return
	end

	local effMode = MoveCfg.Mode
	if Movement.FallbackWalk then effMode = "Walk" end

	if effMode == "Hop" then
		local interval = 1 / math.max(MoveCfg.HopRate, 1)
		Movement.Clock = Movement.Clock + dt
		while Movement.Clock >= interval do
			Movement.Clock = Movement.Clock - interval
			local step = math.min(dist, MoveCfg.HopSize)
			hrp.CFrame = hrp.CFrame + delta.Unit * step + Vector3.new(0, 1, 0)
			dist = (target - hrp.Position).Magnitude
			if dist <= Movement.Within then
				Movement.Arrived = true
				Movement:Stop()
				return
			end
		end

		if os.clock() - Movement.ProgressCheck > 1.5 then
			local moved = hrp.Position
			if Movement.LastPos then
				local net = (moved - Movement.LastPos).Magnitude
				if net < 5 then
					Movement.FallbackWalk = true
					task.delay(3, function() Movement.FallbackWalk = false end)
				end
			end
			Movement.LastPos = moved
			Movement.ProgressCheck = os.clock()
		end
	else
		hum:MoveTo(target)
		hum.AutoRotate = true
	end
end

-- ============================================================ EGG STORE
-- Refreshes the area egg snapshot on demand and follows the update events so
-- the farm and the ESP always see live records.

local EggStore = { ByUid = {}, List = {}, LastRefresh = 0, Ready = false }

local function ApplyAreaRecords(records)
	EggStore.ByUid = {}
	for _, rec in ipairs(records) do
		EggStore.ByUid[rec.Uid] = rec
	end
	EggStore.List = records
	EggStore.Ready = true
end

function EggStore:Refresh(force)
	local now = os.clock()
	if not force and (now - self.LastRefresh) < 1.2 then return self.Ready end
	self.LastRefresh = now
	local res = Invoke(E.AreaEggSnapshot)
	if type(res) ~= "table" then return self.Ready end
	local records = res.Records or res
	if type(records) ~= "table" then return self.Ready end
	ApplyAreaRecords(records)
	return true
end

function EggStore:Get(uid)
	return self.ByUid[uid]
end

BindEvent(E.AreaEggUpdated, function(rec)
	if rec and rec.Uid then
		EggStore.ByUid[rec.Uid] = rec
		EggStore.List = {}
		for _, r in pairs(EggStore.ByUid) do EggStore.List[#EggStore.List + 1] = r end
	end
end)

BindEvent(E.AreaEggRemoved, function(uid)
	if uid then
		EggStore.ByUid[uid] = nil
		EggStore.List = {}
		for _, r in pairs(EggStore.ByUid) do EggStore.List[#EggStore.List + 1] = r end
	end
end)

-- ============================================================ CARRY STATE

local Carry = {
	IsCarrying = false,
	Uid = nil,
	AreaId = nil,
	Category = nil,
	Since = 0,
}

BindEvent(E.AreaEggCarryState, function(state)
	if type(state) ~= "table" then return end
	Carry.IsCarrying = state.IsCarrying == true
	Carry.Uid = state.Uid
	Carry.AreaId = state.AreaId
	Carry.Category = state.AssetCategory
	Carry.Since = os.clock()
end)

local function IsCarrying()
	return Carry.IsCarrying
end

-- ============================================================ GUARD MONITOR

local GuardState = {
	Chasing = false,
	Guard = nil,
	Distance = math.huge,
	LastWarnAt = 0,
	LastDropAt = 0,
}

local GuardCfg = {
	Warning = false,
	AutoDrop = false,
	Distance = 25,
}

local function GuardModels()
	local folder = Workspace:FindFirstChild("__OBJECTS")
		and Workspace.__OBJECTS:FindFirstChild("Areas")
		and Workspace.__OBJECTS.Areas:FindFirstChild("GuardAreas")
	if not folder then return {} end
	local out = {}
	for _, area in ipairs(folder:GetChildren()) do
		local g = area:FindFirstChild("Guard")
		if g and g:IsA("Model") then out[#out + 1] = g end
	end
	return out
end

local function ScanGuards()
	local uidStr = tostring(LocalPlayer.UserId)
	local hrp = MyHRP()
	local chasing, bestG, bestD = false, nil, math.huge

	for _, g in ipairs(GuardModels()) do
		local root = g:FindFirstChild("HumanoidRootPart")
		if root and root:IsA("BasePart") then
			local dist = hrp and (root.Position - hrp.Position).Magnitude or math.huge
			local state = g:GetAttribute("GuardState")
			local target = g:GetAttribute("TargetPlayer")
			local wakeTarget = g:GetAttribute("WakeTargetPlayer")
			local hum = g:FindFirstChildOfClass("Humanoid")
			local moving = hum and hum.WalkSpeed > 1 or false

			local attrChase = (state == "Chase" or state == "Waking" or state == "EggRetrieval")
				and (target == uidStr or wakeTarget == uidStr)
			local proxChase = dist < GuardCfg.Distance and moving

			if attrChase or proxChase then
				chasing = true
				if dist < bestD then bestD, bestG = dist, g end
			end
		end
	end

	GuardState.Chasing = chasing
	GuardState.Guard = bestG
	GuardState.Distance = bestD
end

BindEvent(E.GuardSpeedHitWarning, function()
	if not GuardCfg.Warning then return end
	Notify("Guard", "Speed hit incoming! Move!", 2, "triangle-alert")
	Island:Push("Guard hit incoming!", 2)
end)

BindEvent(E.GuardWakeUp, function()
	if GuardCfg.Warning and not GuardState.Chasing then
		Notify("Guard", "A guard woke up.", 2, "eye")
	end
end)

-- ============================================================ FARM

local FarmCfg = {
	On = false,
	MinRarity = 0, -- 0 = disabled
	Priority = "Rarity", -- Rarity | Closest | Income
	Areas = {}, -- set of area ids; empty = all
	Eggs = {}, -- set of egg categories; empty = all
	AutoPlace = true,
	PlaceRule = "Always", -- Always | Full
	AutoHatch = true,
}

local Farm = {
	State = "Idle",
	Target = nil,
	StateChangedAt = 0,
	ActionAt = 0,
	FailCount = 0,
	ClaimedThisRun = false,
}

local function FarmTargetOk(rec)
	if not rec then return false end
	if rec.State ~= "Slot" then return false end
	if FarmCfg.Areas[rec.AreaId] == false then return false end
	if FarmCfg.Eggs[rec.AssetCategory] == false then return false end
	if FarmCfg.MinRarity > 0 and EggRarityNum(rec.AssetCategory) < FarmCfg.MinRarity then return false end
	return true
end

local function FindStealTarget()
	EggStore:Refresh()
	local hrp = MyHRP()
	local best, bestScore = nil, math.huge
	for _, rec in pairs(EggStore.ByUid) do
		if FarmTargetOk(rec) and rec.BottomCFrame then
			local dist = hrp and (rec.BottomCFrame.Position - hrp.Position).Magnitude or math.huge
			local score
			if FarmCfg.Priority == "Closest" then
				score = dist
			elseif FarmCfg.Priority == "Income" then
				score = -EggIncome(rec.AssetCategory)
			else
				score = -EggRarityNum(rec.AssetCategory) * 1000 + dist
			end
			if score < bestScore then best, bestScore = rec, score end
		end
	end
	return best
end

local function PenFull()
	local s = GetSave()
	if not s then return false end
	local capacity = Bases and Bases.GetAssetEquipCapacity and Bases.GetAssetEquipCapacity(s.BaseUpgradeLevel) or 10
	local placed = 0
	if s.EggInventory then
		for _, v in pairs(s.EggInventory) do
			if v.Placement ~= nil then placed = placed + 1 end
		end
	end
	return placed >= capacity
end

local function ShouldPlaceNow()
	if not FarmCfg.AutoPlace then return false end
	if FarmCfg.PlaceRule == "Always" then return true end
	return PenFull()
end

local function DropHeldEgg(reason)
	if not IsCarrying() then return true end
	local ok = Invoke(E.AreaEggDrop, { Reason = reason or "PlayerRequest" })
	return ok == true
end

-- The game funnels every area-egg steal through one shared prompt,
-- Workspace.SmartPromptPart.CarryAreaEgg, which it repositions onto whichever
-- egg you are standing next to. ActionText "Steal", 1.2s hold, 8 stud range.
-- Firing it is what the real client does, so the server sees a legitimate
-- interaction rather than a bare remote call.
local function CarryPrompt()
	local part = Workspace:FindFirstChild("SmartPromptPart")
	if not part then return nil end
	local prompt = part:FindFirstChild("CarryAreaEgg")
	if prompt and prompt:IsA("ProximityPrompt") then return prompt end
	return nil
end

local function FireCarryPrompt()
	local prompt = CarryPrompt()
	if not prompt or not prompt.Enabled then return false end

	-- Enabled means "somebody can use this", not "we can". The part is shared
	-- and gets parked on whichever egg is being interacted with, so it can sit
	-- a thousand studs away while still enabled. Only fire it when the part is
	-- actually within its own activation range of us.
	local part = prompt.Parent
	local hrp = MyHRP()
	if not (part and hrp) then return false end
	if (part.Position - hrp.Position).Magnitude > (prompt.MaxActivationDistance or 8) then
		return false
	end

	-- The prompt ships with a 1.2s hold. Guards are standing right on top of
	-- these eggs, so waiting it out is a free hit. HoldDuration is client-side
	-- only; zeroing it makes the trigger fire the instant we ask.
	pcall(function() prompt.HoldDuration = 0 end)

	-- fireproximityprompt handles the hold for us. Without it we would need
	-- InputHoldBegin, which needs an identity a game-fired callback does not
	-- have, so the manual path is deliberately not attempted.
	if typeof(fireproximityprompt) == "function" then
		local ok = pcall(fireproximityprompt, prompt, 1)
		if not ok then pcall(fireproximityprompt, prompt) end
		return true
	end
	return false
end

local function TryCarry(rec)
	local uid = rec.Uid
	-- FirstArea eggs (Forest tutorial) require the slot key, otherwise the
	-- server answers "Egg not found". Matches the game's own client exactly.
	local key
	if string.find(uid, "FirstAreaEgg_", 1, true) == 1 then
		key = rec.AreaId .. ":" .. (rec.NestId or "")
	end
	local ok, err = Invoke(E.AreaEggCarry, { Uid = uid, FirstAreaSlotKey = key })
	if ok == true then return true end

	if type(err) == "string" then
		-- Positional rejections mean we simply have not walked in far enough
		-- yet. Keep the target and let the mover carry on instead of spending
		-- a retry and giving up on a perfectly good egg.
		if err:find("gameplay area") or err:find("too far") then
			Island:Detail("moving closer")
			return false, true
		end
		Notify("Farm", err, 2, "triangle-alert")
	end
	return false
end

local function TryPlace(uid)
	local plot = MyPlot()
	if not plot then return false end
	local cp = plot:FindFirstChild("CenterPoint")
	if not cp then return false end
	local base = cp.CFrame
	local offset = CFrame.new(0, 0, -4)
	local ok = Invoke(E.PlaceEgg, { Uid = uid, LocalCFrame = base:ToObjectSpace(base * offset) })
	return ok == true
end

local HatchCooldown = {}

local function AutoHatchTick()
	if not FarmCfg.AutoHatch then return end
	local s = GetSave()
	if not s or not s.EggInventory then return end
	local now = workspace:GetServerTimeNow()
	local uidList = {}
	for uid, egg in pairs(s.EggInventory) do
		if type(egg) == "table" and egg.Placement ~= nil then
			local ready = false
			if EggCmds and EggCmds.IsLocalEggReady then
				pcall(function() ready = EggCmds.IsLocalEggReady(uid) end)
			end
			if not ready and egg.HatchEndTime and egg.HatchEndTime <= now then
				ready = true
			end
			if ready then uidList[#uidList + 1] = uid end
		end
	end
	for _, uid in ipairs(uidList) do
		if not HatchCooldown[uid] or os.clock() - HatchCooldown[uid] > 8 then
			HatchCooldown[uid] = os.clock()
			if Invoke(E.HatchEgg, uid) == true then
				task.delay(0.4, function() Invoke(E.CompleteHatchEgg, uid) end)
			end
		end
	end
end

-- State machine. Cheap enough to run on a fast tick; never per-frame.
local function FarmSetState(name)
	if Farm.State ~= name then
		Farm.StateChangedAt = os.clock()
	end
	Farm.State = name
end

-- Its own function so arriving at an egg can grab in the same tick instead of
-- waiting for the next one. A guard is usually standing on the thing.
local function DoCarry(now)
	local target = Farm.Target
	if not target then FarmSetState("Idle") return end

	local function Grabbed()
		Farm.ActionAt = now
		FarmSetState("RunningHome")
		Island:Status("Farm: run home")
		Island:Detail(EggName(target.AssetCategory))
		-- Start hopping out immediately rather than idling here for a tick.
		local point = MyPlotPoint()
		if point then Movement:Go(point, 6) end
	end

	-- Prompt first, remote second. The prompt is the path the real client
	-- takes; the remote stays as the fallback for when we are in range but
	-- the prompt has not enabled yet.
	FireCarryPrompt()

	if IsCarrying() then
		Grabbed()
		return
	end

	local carried, positional = TryCarry(target)
	if carried then
		Grabbed()
	elseif positional then
		-- Walk in further and try again; this is not a failure.
		FarmSetState("MovingToEgg")
	else
		Farm.FailCount = Farm.FailCount + 1
		Farm.ActionAt = now
		Farm.State = Farm.FailCount >= 3 and "Idle" or "MovingToEgg"
	end
end

local function FarmTick()
	if not FarmCfg.On then
		FarmSetState("Idle")
		return
	end

	local now = os.clock()

	if IsCarrying() then
		-- Guard safety first: if a guard is chasing, drop the egg.
		if GuardCfg.AutoDrop and GuardState.Chasing and now - GuardState.LastDropAt > 1.5 then
			GuardState.LastDropAt = now
			DropHeldEgg("PlayerRequest")
			FarmSetState("Idle")
			return
		end
		if now - Carry.Since < 0.15 then return end -- one beat for the carry to settle

		-- Run home and place.
		if FarmCfg.AutoPlace then
			local point = MyPlotPoint()
			if point then
				if InMyPlot(MyHRP() and MyHRP().Position) then
					FarmSetState("Placing")
				else
					FarmSetState("RunningHome")
				end
			end
		else
			FarmSetState("Idle") -- carrying but not auto-placing: hold
			return
		end
	end

	local state = Farm.State

	-- A dropped/lost egg can leave run-home/place states behind; recover.
	if not IsCarrying() and (state == "RunningHome" or state == "Placing" or state == "Holding") then
		FarmSetState("Idle")
		Farm.ActionAt = now
		return
	end

	if state == "Idle" then
		if now - Farm.ActionAt < 1.2 then return end
		local target = FindStealTarget()
		if not target then
			Island:Status("Farm: no eggs")
			AutoHatchTick()
			return
		end
		Farm.Target = target
		FarmSetState("MovingToEgg")
		Farm.FailCount = 0
		Island:Status("Farm: steal")
		Island:Detail(EggName(target.AssetCategory))
		return
	end

	if state == "MovingToEgg" then
		local target = Farm.Target
		if not target then FarmSetState("Idle") return end
		-- target vanished or got taken
		local rec = EggStore:Get(target.Uid)
		if not rec or rec.State ~= "Slot" then
			FarmSetState("Idle")
			Farm.ActionAt = now
			return
		end
		local pos = target.BottomCFrame and target.BottomCFrame.Position
		if not pos then FarmSetState("Idle") return end
		if AtPoint(pos, 5) then
			Movement:Stop()
			FarmSetState("Carrying")
			DoCarry(now)
			return
		end
		Movement:Go(pos, 3.5)
		if now - Farm.StateChangedAt > 25 then
			Farm.FailCount = Farm.FailCount + 1
			Farm.ActionAt = now
			Movement:Stop()
			FarmSetState(Farm.FailCount >= 3 and "Idle" or "MovingToEgg")
			if Farm.FailCount >= 3 then Notify("Farm", "Could not reach egg.", 2, "triangle-alert") end
		end
		return
	end

	if state == "Carrying" then
		DoCarry(now)
		return
	end

	if state == "RunningHome" then
		local point = MyPlotPoint()
		if point then
			local hrp = MyHRP()
			if hrp and InMyPlot(hrp.Position) then
				if ShouldPlaceNow() then
					FarmSetState("Placing")
				else
					FarmSetState("Holding")
				end
				return
			end
			Movement:Go(point, 6)
			if now - Farm.StateChangedAt > 30 then
				Movement:Stop()
				DropHeldEgg("PlayerRequest")
				FarmSetState("Idle")
				Farm.ActionAt = now
			end
		end
		return
	end

	if state == "Placing" then
		local uid = Farm.Target and Farm.Target.Uid or Carry.Uid
		if uid and TryPlace(uid) then
			Farm.ClaimedThisRun = true
			FarmSetState("Idle")
			Farm.ActionAt = now
			Island:Push("Placed " .. EggName(Farm.Target and Farm.Target.AssetCategory or Carry.Category), 2)
		else
			Farm.FailCount = Farm.FailCount + 1
			if Farm.FailCount >= 3 then
				DropHeldEgg("PlayerRequest")
				FarmSetState("Idle")
				Farm.ActionAt = now
			end
		end
		return
	end

	if state == "Holding" then
		-- carry but rule says only place when full; wait at the pen.
		if ShouldPlaceNow() then FarmSetState("Placing") end
		return
	end
end

-- ============================================================ TREADMILL

local TreadmillCfg = { On = false }
local Treadmill = { Active = false, EquipAt = 0 }

BindEvent(E.TreadmillActiveChanged, function(player, active)
	if player == LocalPlayer then
		Treadmill.Active = active == true
	end
end)

local function MyTreadmillBottom()
	local plot = MyPlot()
	if not plot then return nil end
	local bottom = plot:FindFirstChild("TreadmillBottom")
	return bottom and bottom:IsA("BasePart") and bottom or nil
end

local function ExitTreadmill()
	if not Treadmill.Active then return true end
	Invoke(E.TreadmillUnequip)
	Treadmill.Active = false
	return true
end

local function TreadmillTick()
	if not TreadmillCfg.On then return end
	-- Don't train while the farm is mid-run or while carrying.
	if IsCarrying() or (FarmCfg.On and Farm.State ~= "Idle") then
		if Treadmill.Active then ExitTreadmill() end
		return
	end

	local bottom = MyTreadmillBottom()
	if not bottom then return end
	local hrp = MyHRP()
	if not hrp then return end

	if Treadmill.Active then
		Island:Status("Treadmill")
		Island:Detail("SpeedPower " .. tostring(GetSave() and GetSave().SpeedPower or 0))
		return
	end

	if (hrp.Position - bottom.Position).Magnitude <= 7 and os.clock() - Treadmill.EquipAt > 2 then
		Treadmill.EquipAt = os.clock()
		if Invoke(E.TreadmillEquipStatic) == true then
			Treadmill.Active = true
			Island:Status("Treadmill")
		end
		return
	end

	if AtPoint(bottom.Position, 7) then
		Movement:Stop()
		Treadmill.EquipAt = 0
		return
	end
	Movement:Go(bottom.Position, 6)
end

-- ============================================================ PROGRESS

local ProgressCfg = {
	Base = false,
	Treadmill = false,
	Offline = false,
	Index = false,
}

local function BaseUpgradeTick()
	if not ProgressCfg.Base then return end
	local s = GetSave()
	if not s then return end
	local level = s.BaseUpgradeLevel
	local nextCfg = Bases and Bases.BASES and Bases.BASES[level + 1]
	if not nextCfg then return end
	if s.Money >= nextCfg.Cost then
		Fire(E.BaseUpgrade)
		Island:Push("Base -> Lv " .. tostring(level + 1), 2)
	end
end

local function TreadmillUpgradeTick()
	if not ProgressCfg.Treadmill then return end
	local s = GetSave()
	if not s then return end
	local nextCfg = TreadmillsDir and TreadmillsDir.GetByUpgradeLevel
		and TreadmillsDir.GetByUpgradeLevel(s.TreadmillUpgradeLevel + 1)
	if not nextCfg then return end
	if s.Money >= (nextCfg.Price or math.huge) then
		if Invoke(E.TreadmillUpgrade, nextCfg._id) == true then
			Island:Push("Treadmill -> " .. tostring(nextCfg._id), 2)
		end
	end
end

local function OfflineClaimTick()
	if not ProgressCfg.Offline then return end
	local summary = Invoke(E.OfflineGetSummary)
	if type(summary) ~= "table" then return end
	if (summary.ClaimableAmount or 0) > 0 then
		Invoke(E.OfflineRedeem)
		Island:Push("Claimed " .. FormatMoney(summary.ClaimableAmount) .. " offline", 2)
	end
end

-- Verified live: a RemoteFunction returning (ok, reason). The old Fire fallback
-- was chasing a RemoteEvent that does not exist, so a "nothing to claim" answer
-- looked like a failed call.
local function IndexClaimTick()
	if not ProgressCfg.Index then return end
	local ok, reason = Invoke(E.IndexClaimAll)
	if ok == true then
		Island:Push("Claimed index rewards", 2)
	elseif type(reason) == "string" and not reason:find("No index rewards") then
		Notify("Progress", reason, 2, "triangle-alert")
	end
end

-- ============================================================ PETS

local PetCfg = {
	AutoFavorite = false,
	FavMinRarity = 0,
	FavMutation = "", -- empty = any

	AutoSell = false,
	SellRule = "Both", -- Rarity | Income | Both
	MaxRarity = 0, -- 0 = disabled
	IncomeThreshold = 0, -- 0 = disabled
	Blacklist = {}, -- uid -> display name

	EquipBest = false,
}

local EquipBestLast = 0

local function OwnedPets()
	local out = {}
	local me = LocalPlayer.UserId
	local function Add(uid, itemData)
		if not uid or not itemData or out[uid] then return end
		out[uid] = { UID = uid, ItemData = itemData }
	end
	-- Direct runtime snapshot is the reliable source in an executor context.
	local res = Invoke(E.AssetRuntimeSnapshot)
	if type(res) == "table" then
		for _, owner in ipairs(res) do
			if owner and owner.OwnerUserId == me and type(owner.Records) == "table" then
				for uid, rec in pairs(owner.Records) do
					if rec and rec.ItemData then Add(uid, rec.ItemData) end
				end
			end
		end
	end
	if AssetCmds then
		local ok, recs = pcall(function() return AssetCmds.GetOwnerRuntimeRecords(me) end)
		if ok and recs then
			for uid, rec in pairs(recs) do
				Add(uid, rec.ItemData)
			end
		end
	end
	local s = GetSave()
	if s and type(s.Inventory) == "table" then
		for uid, item in pairs(s.Inventory) do
			if type(item) == "table" then
				Add(uid, item.ItemData or item)
			end
		end
	end
	return out
end

local function PetRarity(ItemData)
	return EggRarityNum(ItemData.Category)
end

local function PetIncome(ItemData)
	return ItemData.GeneratedMoney or EggIncome(ItemData.Category)
end

local function PetMutations(ItemData)
	return ItemData.Mutations or {}
end

local function PetMatchesFavorite(ItemData)
	if PetCfg.FavMinRarity > 0 and PetRarity(ItemData) < PetCfg.FavMinRarity then return false end
	if PetCfg.FavMutation ~= "" then
		local found = false
		for _, m in ipairs(PetMutations(ItemData)) do
			if m == PetCfg.FavMutation then found = true break end
		end
		if not found then return false end
	end
	return true
end

local function PetMatchesSell(ItemData, uid)
	if PetCfg.Blacklist[uid] then return false end
	if ItemData.IsFavorite == true then return false end
	if PetCfg.MaxRarity > 0 and PetRarity(ItemData) > PetCfg.MaxRarity then return false end
	if PetCfg.IncomeThreshold > 0 and PetIncome(ItemData) >= PetCfg.IncomeThreshold then return false end
	if PetCfg.SellRule == "Rarity" then
		return PetCfg.MaxRarity > 0
	elseif PetCfg.SellRule == "Income" then
		return PetCfg.IncomeThreshold > 0
	end
	return (PetCfg.MaxRarity > 0 or PetCfg.IncomeThreshold > 0)
end

local function FavoritePet(uid)
	Fire(E.SetFavorite, uid, true)
end

-- Verified live: ActiveAssets: RequestSell is a RemoteFunction taking a plain
-- uid string and answering with a success bool. Passing a table trips the
-- server's assert, which is how the old guessed shape was silently doing
-- nothing. AssetInventory: SellAsset is a RemoteEvent covering backpack items
-- the runtime snapshot does not own, so it stays as a fire-and-forget fallback.
local function SellPet(uid)
	if Invoke(E.RequestSell, uid) == true then return true end
	Fire(E.SellAsset, uid)
	return false
end

-- The game ships its own server-side auto-sell, keyed by rarity id. Verified
-- live: SetAutoSellState takes a { [RarityId] = true } map and answers
-- (ok, payload). It keeps selling while you are offline, which no client loop
-- can do, so it is the better tool whenever plain rarity filtering is enough.
local function PushNativeAutoSell(set)
	local ok = Invoke(E.SetAutoSell, set or {})
	return ok == true
end

local function FavoriteTick()
	if not PetCfg.AutoFavorite then return end
	for uid, pet in pairs(OwnedPets()) do
		if pet.ItemData.IsFavorite ~= true and PetMatchesFavorite(pet.ItemData) then
			FavoritePet(uid)
		end
	end
end

local function SellTick()
	if not PetCfg.AutoSell then return end
	for uid, pet in pairs(OwnedPets()) do
		if PetMatchesSell(pet.ItemData, uid) then
			SellPet(uid)
		end
	end
end

local function FavoriteNow()
	local n = 0
	for uid, pet in pairs(OwnedPets()) do
		if pet.ItemData.IsFavorite ~= true and PetMatchesFavorite(pet.ItemData) then
			FavoritePet(uid)
			n = n + 1
		end
	end
	Notify("Pets", ("Favorited %d pet%s."):format(n, n == 1 and "" or "s"), 2, "star")
end

local function SellNow()
	local n = 0
	for uid, pet in pairs(OwnedPets()) do
		if PetMatchesSell(pet.ItemData, uid) then
			SellPet(uid)
			n = n + 1
		end
	end
	Notify("Pets", ("Selling %d pet%s..."):format(n, n == 1 and "" or "s"), 2, "coins")
end

-- Native game endpoint: equips the best pets up to pen capacity. The game
-- enforces a 5s cooldown, so we only ask every 8s.
local function EquipBestTick()
	if not PetCfg.EquipBest then return end
	if os.clock() - EquipBestLast < 8 then return end
	EquipBestLast = os.clock()
	Invoke("Backpack: EquipBest")
end

-- ============================================================ ESP

local EspCfg = {
	Eggs = false,
	RareEggs = false,
	RareThreshold = 0,
	Guards = false,
	MaxDistance = 3000,
}

local EspFolder
do
	EspFolder = Cleanup:Instance(Instance.new("Folder"))
	EspFolder.Name = "StealEggESP"
	EspFolder.Parent = Workspace
end

local EggMarkers = {} -- uid -> { part, billboard, label, sub }
local GuardMarkers = {} -- areaName -> marker

local function NewMarker(text, color)
	local part = Instance.new("Part")
	part.Size = Vector3.new(0.2, 0.2, 0.2)
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Parent = EspFolder

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.fromOffset(220, 60)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 9000
	billboard.Parent = part

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 0.6, 0)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 13
	label.TextColor3 = color
	label.TextStrokeTransparency = 0.3
	label.Text = text
	label.Parent = billboard

	local sub = label:Clone()
	sub.Position = UDim2.new(0, 0, 0.5, 0)
	sub.Size = UDim2.new(1, 0, 0.5, 0)
	sub.Font = Enum.Font.Gotham
	sub.TextSize = 11
	sub.TextColor3 = Color3.fromRGB(220, 220, 220)
	sub.Parent = billboard

	return part, billboard, label, sub
end

local function ClearMarkers(map)
	for _, m in pairs(map) do
		pcall(function() m.Part:Destroy() end)
	end
	table.clear(map)
end

local function EspTick()
	local hrp = MyHRP()
	local basePos = hrp and hrp.Position

	if EspCfg.Eggs or EspCfg.RareEggs then
		if EggStore:Refresh() then
			local wanted = {}
			for uid, rec in pairs(EggStore.ByUid) do
				local rar = EggRarityNum(rec.AssetCategory)
				local show = EspCfg.Eggs
					or (EspCfg.RareEggs and rar >= EspCfg.RareThreshold)
				if show and rec.BottomCFrame then
					wanted[uid] = true
					local marker = EggMarkers[uid]
					if not marker then
						local part, bb, label, sub = NewMarker(EggName(rec.AssetCategory), RarityColor(rar))
						marker = { Part = part, Billboard = bb, Label = label, Sub = sub }
						EggMarkers[uid] = marker
					end
					marker.Part.CFrame = rec.BottomCFrame + Vector3.new(0, 2, 0)
					local dist = basePos and (rec.BottomCFrame.Position - basePos).Magnitude or 0
					marker.Label.Text = ("%s [%s]"):format(EggName(rec.AssetCategory), EggRarityId(rec.AssetCategory))
					marker.Sub.Text = string.format("%.0f studs", dist)
					marker.Label.TextColor3 = RarityColor(rar)
				end
			end
			for uid in pairs(EggMarkers) do
				if not wanted[uid] then
					pcall(function() EggMarkers[uid].Part:Destroy() end)
					EggMarkers[uid] = nil
				end
			end
		end
	elseif next(EggMarkers) then
		ClearMarkers(EggMarkers)
	end

	if EspCfg.Guards then
		for _, g in ipairs(GuardModels()) do
			local root = g:FindFirstChild("HumanoidRootPart")
			if root and root:IsA("BasePart") then
				local area = g.Parent and g.Parent.Name or "?"
				local marker = GuardMarkers[area]
				if not marker then
					local part, bb, label, sub = NewMarker("Guard", DANGER)
					marker = { Part = part, Billboard = bb, Label = label, Sub = sub }
					GuardMarkers[area] = marker
				end
				marker.Part.CFrame = root.CFrame
				local state = g:GetAttribute("GuardState") or "Sleep"
				local dist = basePos and (root.Position - basePos).Magnitude or 0
				marker.Label.Text = ("Guard [%s]"):format(state)
				marker.Sub.Text = string.format("%s | %.0f studs", area, dist)
				marker.Label.TextColor3 = state == "Sleep" and Color3.fromRGB(150, 150, 150) or DANGER
			end
		end
	elseif next(GuardMarkers) then
		ClearMarkers(GuardMarkers)
	end
end

-- ============================================================ HOME STATS

local StatsParagraph

local function UpdateStats()
	local s = GetSave()
	local money = s and s.Money or 0
	local speed = s and s.SpeedPower or 0
	local base = s and s.BaseUpgradeLevel or 0
	local tread = s and s.TreadmillUpgradeLevel or 0
	local state = IsCarrying() and "Carrying" or (Farm.State or "Idle")
	SafeCall(function()
		StatsParagraph:SetDesc(("Money %s  |  Speed %s  |  Base %d  |  TM %d  |  %s")
			:format(FormatMoney(money), speed, base, tread, state))
	end)
end

-- ============================================================ TASKS

Scheduler:Every("Mover", 0.04, MoverTick)
Scheduler:Every("EggStore", 2, function()
	EggStore:Refresh(true)
end)

Scheduler:Every("Farm", 0.15, FarmTick)
Scheduler:Every("Treadmill", 0.8, TreadmillTick)
Scheduler:Every("Guards", 0.4, ScanGuards)
Scheduler:Every("BaseUpgrade", 1.2, BaseUpgradeTick)
Scheduler:Every("TreadmillUpgrade", 1.4, TreadmillUpgradeTick)
Scheduler:Every("OfflineClaim", 3, OfflineClaimTick)
Scheduler:Every("IndexClaim", 3, IndexClaimTick)
Scheduler:Every("Favorite", 2.5, FavoriteTick)
Scheduler:Every("Sell", 3, SellTick)
Scheduler:Every("EquipBest", 8, EquipBestTick)
Scheduler:Every("EggEsp", 1, EspTick)
Scheduler:Every("HomeStats", 2, UpdateStats)

Cleanup:Callback(function()
	ClearMarkers(EggMarkers)
	ClearMarkers(GuardMarkers)
	if IsCarrying() then DropHeldEgg("PlayerRequest") end
	if Treadmill.Active then Invoke(E.TreadmillUnequip) end
end)

-- ============================================================ HOME

do
	Tabs.Home:Paragraph({
		Title = HUB_NAME .. " loaded",
		Desc = "Built from live MCP research. RightShift toggles the menu.",
	})

	local Session = Tabs.Home:Section({ Title = "Session", Icon = "activity", Opened = true })

	StatsParagraph = Session:Paragraph({
		Title = "Live",
		Desc = "Money --  |  Speed --  |  Base --  |  TM --",
	})

	local Quick = Tabs.Home:Section({ Title = "Quick Actions", Icon = "zap", Opened = true })

	Quick:Button({
		Title = "Exit Treadmill",
		Icon = "log-out",
		Callback = function()
			if ExitTreadmill() then Notify("Farm", "Treadmill exited.", 2, "check") end
		end,
	})

	Quick:Button({
		Title = "Drop Held Egg",
		Icon = "droplet-off",
		Color = DANGER,
		Callback = function()
			if DropHeldEgg("PlayerRequest") then Notify("Farm", "Egg dropped.", 2, "check") end
		end,
	})

	Quick:Button({
		Title = "Rejoin",
		Icon = "rotate-cw",
		Callback = function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end,
	})
end

-- ============================================================ FARM TAB

do
	local FarmSection = Tabs.Farm:Section({ Title = "Steal", Opened = true })

	FarmSection:Toggle({
		Title = "Auto Steal",
		Desc = "Steal eggs from areas, run them home and place them.",
		Flag = "SAEAutoSteal",
		Value = false,
		Callback = function(v)
			FarmCfg.On = v
			if v then
				Island:Status("Farm")
			else
				FarmSetState("Idle")
				Island:Clear()
			end
		end,
	})

	-- Area names discovered from the live GuardAreas folder.
	local function AreaNames()
		local names = {}
		local folder = Workspace:FindFirstChild("__OBJECTS")
			and Workspace.__OBJECTS:FindFirstChild("Areas")
			and Workspace.__OBJECTS.Areas:FindFirstChild("GuardAreas")
		if folder then
			for _, area in ipairs(folder:GetChildren()) do
				if area:IsA("Model") then names[#names + 1] = area.Name end
			end
			table.sort(names)
		end
		return names
	end

	local AreaDropdown = FarmSection:Dropdown({
		Title = "Target Areas",
		Desc = "Empty = all areas",
		Values = AreaNames(),
		Value = nil,
		Multi = true,
		AllowNone = true,
		SearchBarEnabled = true,
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			local set = {}
			local list = AreaDropdown.Value
			if type(list) == "table" then
				for _, name in ipairs(list) do set[name] = true end
			elseif list then
				set[list] = true
			end
			FarmCfg.Areas = set
		end,
	})

	-- Egg categories from the asset directory.
	local function EggCategoryNames()
		local names = {}
		if AssetsDir then
			for cat in pairs(AssetsDir) do names[#names + 1] = cat end
			table.sort(names)
		end
		return names
	end

	local EggDropdown = FarmSection:Dropdown({
		Title = "Target Eggs",
		Desc = "Empty = all eggs",
		Values = EggCategoryNames(),
		Value = nil,
		Multi = true,
		AllowNone = true,
		SearchBarEnabled = true,
		Callback = function()
			local set = {}
			local list = EggDropdown.Value
			if type(list) == "table" then
				for _, name in ipairs(list) do set[name] = true end
			elseif list then
				set[list] = true
			end
			FarmCfg.Eggs = set
		end,
	})

	local rarityValues = { "Disabled" }
	for _, r in ipairs(RarityLadder) do rarityValues[#rarityValues + 1] = r.name end

	FarmSection:Dropdown({
		Title = "Minimum Rarity",
		Values = rarityValues,
		Value = "Disabled",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			for _, r in ipairs(RarityLadder) do
				if r.name == v then FarmCfg.MinRarity = r.n return end
			end
			FarmCfg.MinRarity = 0
		end,
	})

	FarmSection:Dropdown({
		Title = "Steal Priority",
		Values = { "Rarity", "Closest", "Income" },
		Value = "Rarity",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			FarmCfg.Priority = v
		end,
	})

	FarmSection:Dropdown({
		Title = "Movement",
		Values = { "Hop", "Walk" },
		Value = "Hop",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			MoveCfg.Mode = v
			Movement.FallbackWalk = false
		end,
	})

	FarmSection:Slider({
		Title = "Steal Hop Size",
		Flag = "SAEHopSize",
		Step = 5,
		Value = { Min = 10, Max = 120, Default = 30 },
		Callback = function(v) MoveCfg.HopSize = v end,
	})

	FarmSection:Slider({
		Title = "Hop Speed",
		Desc = "Hops per second. Higher is faster but easier for the game to correct.",
		Flag = "SAEHopRate",
		Step = 1,
		Value = { Min = 4, Max = 50, Default = 10 },
		Callback = function(v) MoveCfg.HopRate = v end,
	})

	local Place = Tabs.Farm:Section({ Title = "Place Egg", Opened = true })

	Place:Toggle({
		Title = "Auto Place Egg",
		Desc = "Place carried eggs into your pen when you get home.",
		Flag = "SAEAutoPlace",
		Value = true,
		Callback = function(v) FarmCfg.AutoPlace = v end,
	})

	Place:Dropdown({
		Title = "Place Rule",
		Values = { "Always", "When Pen Full" },
		Value = "Always",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			FarmCfg.PlaceRule = v == "When Pen Full" and "Full" or "Always"
		end,
	})

	Place:Toggle({
		Title = "Auto Hatch Ready Eggs",
		Desc = "Hatch growing eggs as soon as they're ready.",
		Flag = "SAEAutoHatch",
		Value = true,
		Callback = function(v) FarmCfg.AutoHatch = v end,
	})

	local TM = Tabs.Farm:Section({ Title = "Treadmill", Opened = true })

	TM:Toggle({
		Title = "Auto Treadmill",
		Desc = "Train when idle. Pauses while carrying or stealing.",
		Flag = "SAEAutoTreadmill",
		Value = false,
		Callback = function(v)
			TreadmillCfg.On = v
			if not v then ExitTreadmill() end
		end,
	})

	local Safety = Tabs.Farm:Section({ Title = "Guard Safety", Opened = true })

	Safety:Toggle({
		Title = "Guard Warning",
		Desc = "Notify when a guard is chasing you.",
		Flag = "SAEGuardWarning",
		Value = false,
		Callback = function(v) GuardCfg.Warning = v end,
	})

	Safety:Toggle({
		Title = "Auto Drop Egg",
		Desc = "Drop the carried egg the moment a guard chases you.",
		Flag = "SAEAutoDrop",
		Value = false,
		Callback = function(v) GuardCfg.AutoDrop = v end,
	})

	Safety:Slider({
		Title = "Guard Chase Distance",
		Flag = "SAEChaseDist",
		Step = 1,
		Value = { Min = 10, Max = 60, Default = 25 },
		Callback = function(v) GuardCfg.Distance = v end,
	})
end

-- ============================================================ PROGRESS TAB

do
	local Auto = Tabs.Progress:Section({ Title = "Auto Upgrades", Opened = true })

	Auto:Toggle({
		Title = "Auto Upgrade Base",
		Desc = "Buy the next base upgrade whenever affordable.",
		Flag = "SAEUpBase",
		Value = false,
		Callback = function(v) ProgressCfg.Base = v end,
	})

	Auto:Toggle({
		Title = "Auto Upgrade Treadmill",
		Desc = "Buy the next treadmill whenever affordable.",
		Flag = "SAEUpTM",
		Value = false,
		Callback = function(v) ProgressCfg.Treadmill = v end,
	})

	local Claim = Tabs.Progress:Section({ Title = "Auto Claim", Opened = true })

	Claim:Toggle({
		Title = "Auto Claim Offline Money",
		Flag = "SAEClaimOffline",
		Value = false,
		Callback = function(v) ProgressCfg.Offline = v end,
	})

	Claim:Toggle({
		Title = "Auto Claim Index Rewards",
		Flag = "SAEClaimIndex",
		Value = false,
		Callback = function(v) ProgressCfg.Index = v end,
	})

	Tabs.Progress:Paragraph({
		Title = "Costs",
		Desc = "Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M",
	})
end

-- ============================================================ ESP TAB

do
	local Egg = Tabs.ESP:Section({ Title = "Eggs", Opened = true })

	Egg:Toggle({
		Title = "ESP Eggs",
		Desc = "Mark every area egg with name, rarity and distance.",
		Flag = "SAEEspEggs",
		Value = false,
		Callback = function(v) EspCfg.Eggs = v end,
	})

	Egg:Toggle({
		Title = "ESP Rare Eggs",
		Desc = "Only mark eggs at or above the threshold below.",
		Flag = "SAEEspRare",
		Value = false,
		Callback = function(v) EspCfg.RareEggs = v end,
	})

	local rarityValues = { "Common" }
	for _, r in ipairs(RarityLadder) do rarityValues[#rarityValues + 1] = r.name end

	Egg:Dropdown({
		Title = "Rare Threshold",
		Values = rarityValues,
		Value = "Mythic",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			for _, r in ipairs(RarityLadder) do
				if r.name == v then EspCfg.RareThreshold = r.n return end
			end
		end,
	})

	local Guards = Tabs.ESP:Section({ Title = "Guards", Opened = true })

	Guards:Toggle({
		Title = "ESP Guards",
		Desc = "Mark guards with state and distance.",
		Flag = "SAEEspGuards",
		Value = false,
		Callback = function(v) EspCfg.Guards = v end,
	})
end

-- ============================================================ PETS TAB

do
	local Fav = Tabs.Pets:Section({ Title = "Auto Favorite", Opened = true })

	Fav:Toggle({
		Title = "Auto Favorite",
		Flag = "SAEAutoFav",
		Value = false,
		Callback = function(v) PetCfg.AutoFavorite = v end,
	})

	local rarityValues = { "Disabled" }
	for _, r in ipairs(RarityLadder) do rarityValues[#rarityValues + 1] = r.name end

	Fav:Dropdown({
		Title = "Favorite Min Rarity",
		Values = rarityValues,
		Value = "Disabled",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			for _, r in ipairs(RarityLadder) do
				if r.name == v then PetCfg.FavMinRarity = r.n return end
			end
			PetCfg.FavMinRarity = 0
		end,
	})

	Fav:Input({
		Title = "Favorite Mutation",
		Placeholder = "Golden / Silver / empty = any",
		ClearTextOnFocus = false,
		Callback = function(v) PetCfg.FavMutation = v or "" end,
	})

	Fav:Button({
		Title = "Favorite Pets Now",
		Icon = "star",
		Callback = FavoriteNow,
	})

	local Sell = Tabs.Pets:Section({ Title = "Auto Sell", Opened = true })

	Sell:Toggle({
		Title = "Auto Sell",
		Flag = "SAEAutoSell",
		Value = false,
		Callback = function(v) PetCfg.AutoSell = v end,
	})

	Sell:Dropdown({
		Title = "Sell Rule",
		Values = { "Rarity Only", "Income Only", "Both" },
		Value = "Both",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			PetCfg.SellRule = v == "Rarity Only" and "Rarity"
				or (v == "Income Only" and "Income" or "Both")
		end,
	})

	local rarityValues = { "Disabled" }
	for _, r in ipairs(RarityLadder) do rarityValues[#rarityValues + 1] = r.name end

	Sell:Dropdown({
		Title = "Pet Max Rarity",
		Desc = "Sell pets at or below this rarity.",
		Values = rarityValues,
		Value = "Disabled",
		Callback = function(v)
			if type(v) == "table" then v = v[1] end
			for _, r in ipairs(RarityLadder) do
				if r.name == v then PetCfg.MaxRarity = r.n return end
			end
			PetCfg.MaxRarity = 0
		end,
	})

	Sell:Input({
		Title = "Pet Income Threshold",
		Desc = "Sell pets below this income. 0 or empty = disabled. e.g. 10M",
		Placeholder = "10M",
		ClearTextOnFocus = false,
		Callback = function(v)
			local n = ParseMoney(v)
			if n ~= nil then PetCfg.IncomeThreshold = n end
		end,
	})

	Sell:Button({
		Title = "Sell Pets Now",
		Icon = "coins",
		Callback = SellNow,
	})

	local Native = Tabs.Pets:Section({ Title = "Game Auto Sell", Opened = true })

	local rarityIds = {}
	for _, r in ipairs(RarityLadder) do rarityIds[#rarityIds + 1] = r.name end

	local NativeDropdown = Native:Dropdown({
		Title = "Auto Sell Rarities",
		Desc = "The game's own auto sell. Runs server side, works offline.",
		Values = rarityIds,
		Value = nil,
		Multi = true,
		AllowNone = true,
		SearchBarEnabled = true,
		Callback = function()
			local set = {}
			local list = NativeDropdown.Value
			if type(list) == "table" then
				for _, name in ipairs(list) do set[name] = true end
			elseif list then
				set[list] = true
			end
			if PushNativeAutoSell(set) then
				local n = 0
				for _ in pairs(set) do n = n + 1 end
				Notify("Pets", n == 0 and "Game auto sell off."
					or ("Game auto sell: %d rarit%s."):format(n, n == 1 and "y" or "ies"), 2, "coins")
			end
		end,
	})

	-- Mirror whatever the game already has set so the dropdown is not lying.
	SafeCall(function()
		local state = Invoke(E.GetAutoSell)
		if type(state) ~= "table" then return end
		local sel = {}
		for id, on in pairs(state) do
			if on then sel[#sel + 1] = id end
		end
		if #sel > 0 then NativeDropdown:Select(sel) end
	end)

	local Equip = Tabs.Pets:Section({ Title = "Auto Equip", Opened = true })

	Equip:Toggle({
		Title = "Auto Equip Best",
		Desc = "Equip the best pets into your pen (game's Equip Best).",
		Flag = "SAEEquipBest",
		Value = false,
		Callback = function(v) PetCfg.EquipBest = v end,
	})

	local Black = Tabs.Pets:Section({ Title = "Sell Blacklist", Opened = true })

	local function PetOptionText(uid, pet)
		local muts = table.concat(pet.ItemData.Mutations or {}, "+")
		local mut = muts ~= "" and (" (" .. muts .. ")") or ""
		return ("%s [%s]%s uid:%s"):format(
			EggName(pet.ItemData.Category), EggRarityId(pet.ItemData.Category), mut, uid)
	end

	local PetDropdown = Black:Dropdown({
		Title = "Add Pet To Blacklist",
		Desc = "Select a pet, it will never be sold",
		Values = {},
		Value = nil,
		AllowNone = true,
		SearchBarEnabled = true,
	})

	Black:Button({
		Title = "Blacklist Selected",
		Icon = "ban",
		Color = DANGER,
		Callback = function()
			local val = PetDropdown.Value
			if type(val) == "table" then val = val[1] end
			if not val then
				Notify("Pets", "Select a pet first.", 2, "triangle-alert")
				return
			end
			local uid = val:match("uid:(%S+)$")
			if uid then
				PetCfg.Blacklist[uid] = val:match("^(.-) uid:") or uid
				Notify("Pets", "Blacklisted.", 2, "ban")
			end
		end,
	})

	local BlackDropdown = Black:Dropdown({
		Title = "Blacklisted Pets",
		Values = {},
		Value = nil,
		AllowNone = true,
		SearchBarEnabled = true,
	})

	local function RefreshBlacklist()
		local opts = {}
		for uid, name in pairs(PetCfg.Blacklist) do
			opts[#opts + 1] = (name or uid) .. " uid:" .. uid
		end
		table.sort(opts)
		SafeCall(function() BlackDropdown:Refresh(opts) end)
	end

	Black:Button({
		Title = "Remove Selected",
		Icon = "minus",
		Callback = function()
			local val = BlackDropdown.Value
			if type(val) == "table" then val = val[1] end
			if not val then return end
			local uid = val:match("uid:(%S+)$")
			if uid then
				PetCfg.Blacklist[uid] = nil
				RefreshBlacklist()
			end
		end,
	})

	Black:Button({
		Title = "Clear Blacklist",
		Icon = "eraser",
		Callback = function()
			table.clear(PetCfg.Blacklist)
			RefreshBlacklist()
			Notify("Pets", "Blacklist cleared.", 2, "eraser")
		end,
	})

	-- Keep the pet picker and the blacklist list fresh.
	Scheduler:Every("PetList", 3, function()
		local pets = OwnedPets()
		local opts = {}
		for uid, pet in pairs(pets) do
			if not PetCfg.Blacklist[uid] then
				opts[#opts + 1] = PetOptionText(uid, pet)
			end
		end
		table.sort(opts)
		SafeCall(function() PetDropdown:Refresh(opts) end)
		RefreshBlacklist()
	end)

	Tabs.Pets:Paragraph({
		Title = "Note",
		Desc = "Blacklisted pets are never sold; favorited pets are protected too. Use Game Auto Sell for plain rarity rules, and the script's own Auto Sell when you need income or blacklist filtering.",
	})
end

-- ============================================================ SETTINGS

do
	local ConfigManager = Window.ConfigManager
	local ConfigSection = Tabs.Settings:Section({ Title = "Configs", Opened = true })

	if ConfigManager then
		local NameBox = ConfigSection:Input({
			Title = "Name",
			Placeholder = "my config",
			ClearTextOnFocus = false,
		})

		local List = ConfigSection:Dropdown({
			Title = "Saved",
			Values = ConfigManager:AllConfigs() or {},
			Value = nil,
			AllowNone = true,
		})

		ConfigSection:Button({
			Title = "Save",
			Icon = "save",
			Callback = function()
				local name = NameBox.Value
				if not name or name == "" then
					Notify("Configs", "Name it first.", 3, "triangle-alert")
					return
				end
				Window.CurrentConfig = ConfigManager:CreateConfig(name)
				if Window.CurrentConfig then
					Window.CurrentConfig:Save()
					SafeCall(function() List:Refresh(ConfigManager:AllConfigs()) end)
					Notify("Configs", "Saved '" .. name .. "'.", 2, "check")
				end
			end,
		})

		ConfigSection:Button({
			Title = "Load",
			Icon = "folder-open",
			Callback = function()
				local name = List.Value
				if typeof(name) == "table" then name = name[1] end
				if not name then return end
				Window.CurrentConfig = ConfigManager:Config(name)
				if Window.CurrentConfig then
					Window.CurrentConfig:Load()
					Notify("Configs", "Loaded '" .. name .. "'.", 2, "refresh-cw")
				end
			end,
		})
	else
		ConfigSection:Paragraph({
			Title = "Unavailable",
			Desc = "Your executor has no file access, so configs are disabled.",
		})
	end

	local UI = Tabs.Settings:Section({ Title = "Interface", Opened = true })

	UI:Keybind({
		Title = "Menu Key",
		Flag = "MenuKey",
		Value = "RightShift",
		Callback = function(key)
			local code = Enum.KeyCode[key]
			if code then Window:SetToggleKey(code) end
		end,
	})

	UI:Slider({
		Title = "UI Scale",
		Step = 0.05,
		Value = { Min = 0.5, Max = 1.5, Default = 1 },
		Callback = function(v) Window:SetUIScale(v) end,
	})

	UI:Toggle({
		Title = "Show Island",
		Desc = "The status pill at the top of the screen",
		Value = true,
		Callback = function(v) Island:Visible(v) end,
	})

	local Danger = Tabs.Settings:Section({ Title = "Unload", Opened = true })

	Danger:Button({
		Title = "Unload " .. HUB_NAME,
		Desc = "Restores everything this script changed and closes the menu",
		Icon = "power",
		Color = DANGER,
		Callback = function()
			Cleanup:Destroy()
			pcall(function() Window:Destroy() end)
		end,
	})
end

-- ============================================================ INFO

do
	local Section = Tabs.Info:Section({ Title = "Supra | Steal A Egg", Opened = true })

	Section:Paragraph({ Title = "Build", Desc = "Researched live via MCP on 2026-08-16 against PlaceVersion 364." })
	Section:Paragraph({ Title = "Features", Desc = "Auto steal, auto place, auto treadmill, guard safety, upgrades, claims, egg/guard ESP, pet favorite + sell." })
	Section:Paragraph({ Title = "Discord", Desc = DISCORD })

	Section:Button({
		Title = "Copy Discord Invite",
		Icon = "copy",
		Callback = function()
			setclipboard(DISCORD)
			Notify(HUB_NAME, "Invite copied to clipboard.", 2, "copy")
		end,
	})
end

-- ============================================================ BOOT

Window:SelectTab(1)
Notify(HUB_NAME, "Loaded. Press RightShift to toggle.", 4, "check")
