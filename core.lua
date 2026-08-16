--[[
	SUPRA CORE
	Shared plumbing for every Supra script. Hosted, so a fix here reaches
	every script the next time someone runs one.

	Contains nothing UI-library-specific on purpose: it survived a Vanta to
	WindUI swap untouched, and it should survive the next one too.

	  local Core = loadstring(game:HttpGet(REPO .. "core.lua"))().Init({
	      HubName = "Supra",
	      Folder  = "SupraHub",
	      Discord = "https://discord.gg/...",
	      LogoId  = 91076191323745,
	      Accent  = Color3.fromHex("#4C8DFF"),
	  })

	  local Cleanup, Scheduler, Island, Util =
	      Core.Cleanup, Core.Scheduler, Core.Island, Core.Util
--]]

local Module = {}

function Module.Init(cfg)
	cfg = cfg or {}

	local HUB_NAME = cfg.HubName or "Supra"
	local HUB_FOLDER = cfg.Folder or "SupraHub"
	local DISCORD = cfg.Discord or ""
	local LOGO_ID = cfg.LogoId
	local ACCENT = cfg.Accent or Color3.fromRGB(76, 141, 255)

	local Core = {}

	-- ======================================================== SERVICES

	local cloneref = cloneref or function(o) return o end

	local Players = cloneref(game:GetService("Players"))
	local RunService = cloneref(game:GetService("RunService"))
	local UserInputService = cloneref(game:GetService("UserInputService"))
	local TweenService = cloneref(game:GetService("TweenService"))
	local HttpService = cloneref(game:GetService("HttpService"))
	local TextService = cloneref(game:GetService("TextService"))
	local MarketplaceService = cloneref(game:GetService("MarketplaceService"))
	local CoreGui = cloneref(game:GetService("CoreGui"))
	local Workspace = cloneref(game:GetService("Workspace"))

	local LocalPlayer = Players.LocalPlayer
	local Camera = Workspace.CurrentCamera

	-- ======================================================== SHIMS
	-- Every executor exposes a different subset. Guard once, here.

	local hasFiles = (isfile and writefile and readfile and isfolder and makefolder) and true or false

	Core.hasFiles = hasFiles
	Core.setclipboard = setclipboard or toclipboard or function() end
	Core.queueteleport = queue_on_teleport or (syn and syn.queue_on_teleport) or function() end
	Core.gethui = gethui or function() return CoreGui end

	-- Touch without a keyboard is a phone. Touch with one is a tablet or
	-- hybrid, where a small viewport still wants the compact layout.
	Core.IsMobile = (function()
		if not UserInputService.TouchEnabled then return false end
		if not UserInputService.KeyboardEnabled then return true end
		local vp = Camera and Camera.ViewportSize
		return vp ~= nil and (vp.X < 1024 or vp.Y < 768)
	end)()

	if hasFiles and not isfolder(HUB_FOLDER) then
		pcall(makefolder, HUB_FOLDER)
	end

	-- ======================================================== CLEANUP
	-- Everything a script creates registers here. Unload walks it once and
	-- the game is left exactly as it was found.

	local Cleanup = { Connections = {}, Instances = {}, Callbacks = {}, Dead = false }
	Core.Cleanup = Cleanup

	function Cleanup:Connection(c) self.Connections[#self.Connections + 1] = c return c end
	function Cleanup:Instance(i) self.Instances[#self.Instances + 1] = i return i end
	function Cleanup:Callback(f) self.Callbacks[#self.Callbacks + 1] = f return f end

	function Cleanup:Destroy()
		if self.Dead then return end
		self.Dead = true

		for _, fn in ipairs(self.Callbacks) do pcall(fn) end
		for _, c in ipairs(self.Connections) do pcall(function() c:Disconnect() end) end
		for _, i in ipairs(self.Instances) do pcall(function() i:Destroy() end) end

		table.clear(self.Callbacks)
		table.clear(self.Connections)
		table.clear(self.Instances)
	end

	local function SafeCall(fn, ...)
		local ok, err = pcall(fn, ...)
		if not ok then warn(("[%s] %s"):format(HUB_NAME, tostring(err))) end
		return ok
	end

	-- ======================================================== SCHEDULER
	-- One Heartbeat and one RenderStepped for the whole script. Features
	-- register named jobs instead of opening their own connections, so
	-- nothing can leak and the frame cost stays one table walk.

	local Scheduler = { Heart = {}, Frame = {}, Ticks = {} }
	Core.Scheduler = Scheduler

	function Scheduler:Job(name, fn) self.Heart[name] = fn end
	function Scheduler:OnRender(name, fn) self.Frame[name] = fn end
	function Scheduler:Every(name, interval, fn)
		self.Ticks[name] = { Interval = interval, Clock = 0, Fn = fn }
	end
	function Scheduler:Stop(name)
		self.Heart[name], self.Frame[name], self.Ticks[name] = nil, nil, nil
	end

	local function RunJob(name, fn, dt)
		local ok, err = pcall(fn, dt)
		if not ok then warn(("[%s] job '%s' errored: %s"):format(HUB_NAME, name, tostring(err))) end
	end

	Cleanup:Connection(RunService.Heartbeat:Connect(function(dt)
		for name, fn in pairs(Scheduler.Heart) do RunJob(name, fn, dt) end
		for name, job in pairs(Scheduler.Ticks) do
			job.Clock += dt
			if job.Clock >= job.Interval then
				job.Clock = 0
				RunJob(name, job.Fn, dt)
			end
		end
	end))

	Cleanup:Connection(RunService.RenderStepped:Connect(function(dt)
		for name, fn in pairs(Scheduler.Frame) do RunJob(name, fn, dt) end
	end))

	-- ======================================================== UTIL

	local Util = {}
	Core.Util = Util

	Util.SafeCall = SafeCall

	function Util.GetCharacter()
		local char = LocalPlayer.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hum or not hrp or hum.Health <= 0 then return end
		return char, hum, hrp
	end

	function Util.ReadJSON(path, fallback)
		if not hasFiles or not isfile(path) then return fallback end
		local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
		return ok and data or fallback
	end

	function Util.WriteJSON(path, data)
		if not hasFiles then return false end
		return pcall(function() writefile(path, HttpService:JSONEncode(data)) end)
	end

	function Util.PlayerNames()
		local names = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then names[#names + 1] = plr.Name end
		end
		table.sort(names)
		return names
	end

	-- Player dropdowns register here rather than each polling on a timer.
	-- Refreshing a dropdown rebuilds every option row, so a loop is expensive
	-- in a full server. Rebuild on join/leave only, debounced so a mass join
	-- costs one rebuild instead of thirty.
	local playerLists, listQueued = {}, false

	function Util.RegisterPlayerList(dropdown)
		playerLists[#playerLists + 1] = dropdown
		return dropdown
	end

	local function RefreshPlayerLists()
		if listQueued then return end
		listQueued = true
		task.delay(0.5, function()
			listQueued = false
			local names = Util.PlayerNames()
			for _, d in ipairs(playerLists) do
				pcall(function() d:Refresh(names) end)
			end
		end)
	end

	Cleanup:Connection(Players.PlayerAdded:Connect(RefreshPlayerLists))
	Cleanup:Connection(Players.PlayerRemoving:Connect(RefreshPlayerLists))

	-- ======================================================== ISLAND
	-- A Dynamic Island: a capsule at the top of the screen that idles by
	-- cycling the hub name, the current game and the Discord, and takes over
	-- as a live status readout the moment a feature claims it.
	--
	--   Island:Status("Autofarming")        claims it, stops the carousel
	--   Island:Detail("Rare: Dragon Fruit") second line under the status
	--   Island:Push("Sold 12 items", 3)     transient, reverts to Status
	--   Island:Clear()                      releases it, carousel resumes
	--   Island:SetOpener(fn)                what a tap should do
	--   Island:SetMenuOpen(bool)            hide while the menu is up
	--   Island:Visible(bool)

	local Island = {}
	Core.Island = Island

	do
		local IDLE_W = Core.IsMobile and 112 or 132
		local IDLE_H = Core.IsMobile and 30 or 34
		local TEXT_SIZE = Core.IsMobile and 12 or 13
		local ROTATE_SECONDS = 4

		local status, detail = nil, nil
		local pushToken, sizeToken = 0, 0
		local hovering, menuOpen, wanted = false, false, true
		local rotIndex = 1
		local currentW, currentH = IDLE_W, IDLE_H
		local opener = nil

		-- GetProductInfo yields and can fail, so it must never sit in the boot
		-- path. Fetch in the background; the carousel shows the placeholder
		-- until it lands.
		local gameName = "Unknown Game"
		task.spawn(function()
			local ok, info = pcall(function()
				return MarketplaceService:GetProductInfo(game.PlaceId)
			end)
			if ok and info and info.Name then gameName = info.Name end
		end)

		local function IdleItems()
			return { HUB_NAME, gameName, (DISCORD:gsub("https://", "")) }
		end

		-- // Instances // --

		-- Re-running the script without unloading would stack a new pill over
		-- the old one, and only the newest has an owner to clean it up. The
		-- ScreenGui name is randomised, so we identify strays by the child
		-- button instead and clear them before building ours.
		local function DestroyStrayIslands()
			local hosts = { Core.gethui(), LocalPlayer:FindFirstChild("PlayerGui") }
			for _, host in ipairs(hosts) do
				if host then
					for _, child in ipairs(host:GetChildren()) do
						if child:IsA("ScreenGui") and child:FindFirstChild("Island") then
							pcall(function() child:Destroy() end)
						end
					end
				end
			end
		end

		DestroyStrayIslands()

		local gui = Cleanup:Instance(Instance.new("ScreenGui"))
		gui.Name = HttpService:GenerateGUID(false)
		gui.ResetOnSpawn = false
		gui.IgnoreGuiInset = true
		gui.DisplayOrder = 9998
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		pcall(function() gui.Parent = Core.gethui() end)
		if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

		local pill = Instance.new("TextButton")
		pill.Name = "Island"
		pill.AnchorPoint = Vector2.new(0.5, 0)
		pill.Position = UDim2.new(0.5, 0, 0, 10)
		pill.Size = UDim2.fromOffset(IDLE_W, IDLE_H)
		pill.BackgroundColor3 = Color3.fromRGB(8, 9, 12)
		pill.BackgroundTransparency = 0.02
		pill.AutoButtonColor = false
		pill.Text = ""
		pill.BorderSizePixel = 0
		pill.ClipsDescendants = true
		pill.Parent = gui

		local scale = Instance.new("UIScale")
		scale.Parent = pill

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = pill

		local stroke = Instance.new("UIStroke")
		stroke.Color = ACCENT
		stroke.Transparency = 0.75
		stroke.Thickness = 1
		stroke.Parent = pill

		-- Hidden while idle. Real iOS shows no icon until an activity claims
		-- the island, and keeping it hidden is also what lets the text sit
		-- truly centred rather than pushed off by a fixed left inset.
		local logo = Instance.new("ImageLabel")
		logo.BackgroundTransparency = 1
		logo.AnchorPoint = Vector2.new(0, 0.5)
		logo.Position = UDim2.new(0, 12, 0.5, 0)
		logo.Size = UDim2.fromOffset(16, 16)
		logo.Image = LOGO_ID and ("rbxassetid://" .. LOGO_ID) or ""
		logo.ImageTransparency = 1
		logo.Visible = false
		logo.Parent = pill

		local title = Instance.new("TextLabel")
		title.BackgroundTransparency = 1
		title.AnchorPoint = Vector2.new(0.5, 0.5)
		title.Position = UDim2.new(0.5, 0, 0.5, 0)
		title.Size = UDim2.new(1, -28, 0, 15)
		title.Font = Enum.Font.GothamMedium
		title.TextSize = TEXT_SIZE
		title.TextColor3 = Color3.fromRGB(245, 245, 245)
		title.TextXAlignment = Enum.TextXAlignment.Center
		title.TextTruncate = Enum.TextTruncate.AtEnd
		title.Text = HUB_NAME
		title.Parent = pill

		local sub = Instance.new("TextLabel")
		sub.BackgroundTransparency = 1
		sub.AnchorPoint = Vector2.new(0.5, 0.5)
		sub.Position = UDim2.new(0.5, 0, 0.5, 10)
		sub.Size = UDim2.new(1, -28, 0, 13)
		sub.Font = Enum.Font.Gotham
		sub.TextSize = TEXT_SIZE - 2
		sub.TextColor3 = ACCENT
		sub.TextXAlignment = Enum.TextXAlignment.Center
		sub.TextTruncate = Enum.TextTruncate.AtEnd
		sub.TextTransparency = 0.2
		sub.Visible = false
		sub.Parent = pill

		-- // Motion // --

		local FADE = TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local PRESS = TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local SETTLE = TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

		-- Size overshoots ~5% then settles. A single eased tween reads as a
		-- web animation; the squish is why this feels like iOS.
		local function SpringSize(width, height)
			sizeToken += 1
			local token = sizeToken

			local overshoot = TweenService:Create(
				pill,
				TweenInfo.new(0.17, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Size = UDim2.fromOffset(math.floor(width * 1.05), math.floor(height * 1.05)) }
			)
			overshoot:Play()

			overshoot.Completed:Connect(function()
				if sizeToken ~= token then return end
				TweenService:Create(
					pill,
					TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ Size = UDim2.fromOffset(width, height) }
				):Play()
			end)
		end

		-- Old text lifts and fades, new text rises into place. Never a cut.
		local function SwapText(label, newText, baseOffset, restTransparency)
			if label.Text == newText then
				label.Position = UDim2.new(0.5, 0, 0.5, baseOffset)
				return
			end

			TweenService:Create(label, FADE, {
				TextTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, baseOffset - 5),
			}):Play()

			task.delay(0.13, function()
				label.Text = newText
				label.Position = UDim2.new(0.5, 0, 0.5, baseOffset + 5)
				TweenService:Create(label, FADE, {
					TextTransparency = restTransparency,
					Position = UDim2.new(0.5, 0, 0.5, baseOffset),
				}):Play()
			end)
		end

		local function Measure(text, size)
			local ok, bounds = pcall(function()
				return TextService:GetTextSize(text, size, Enum.Font.GothamMedium, Vector2.new(2000, 100))
			end)
			return ok and bounds.X or (#text * size * 0.55)
		end

		local function Render()
			local head = status or IdleItems()[rotIndex] or HUB_NAME
			local body = detail
			local twoLine = body ~= nil
			local claimed = status ~= nil

			-- Width is measured off the real string rather than guessed, so a
			-- long item name grows the capsule instead of truncating away.
			local widest = math.max(Measure(head, TEXT_SIZE), twoLine and Measure(body, TEXT_SIZE - 2) or 0)
			local padding = claimed and 62 or 34 -- room for the logo once claimed
			local maxWidth = math.min(400, Camera.ViewportSize.X - 40)

			currentW = math.clamp(math.floor(widest + padding), IDLE_W, maxWidth)
			currentH = twoLine and (IDLE_H + 16) or IDLE_H
			SpringSize(currentW, currentH)

			SwapText(title, head, twoLine and -9 or 0, 0)

			if twoLine then
				sub.Visible = true
				SwapText(sub, body, 10, 0.2)
			elseif sub.Visible then
				TweenService:Create(sub, FADE, { TextTransparency = 1 }):Play()
				task.delay(0.14, function()
					if detail == nil then sub.Visible = false end
				end)
			end

			logo.Visible = claimed and LOGO_ID ~= nil
			TweenService:Create(logo, FADE, { ImageTransparency = claimed and 0 or 1 }):Play()
			TweenService:Create(stroke, FADE, {
				Transparency = hovering and 0.35 or (claimed and 0.45 or 0.75),
			}):Play()
		end

		-- // API // --

		function Island:Status(text)
			pushToken += 1 -- cancels any in-flight Push revert
			status = text
			Render()
		end

		function Island:Detail(text)
			detail = text
			Render()
		end

		function Island:Push(text, seconds)
			pushToken += 1
			local token = pushToken
			local previous = status

			status = text
			Render()

			task.delay(seconds or 3, function()
				if pushToken ~= token then return end
				status = previous
				Render()
			end)
		end

		function Island:Clear()
			pushToken += 1
			status, detail = nil, nil
			Render()
		end

		-- // Morph // --
		-- Closing does not just hide the panel: a ghost of it collapses into the
		-- island, then the capsule snaps open horizontally. The ghost exists
		-- because WindUI runs its own close animation on the real frame, and two
		-- tweens fighting over one instance looks worse than a stand-in.

		local HOME = UDim2.new(0.5, 0, 0, 10)
		local morphToken = 0

		local SUCK = TweenInfo.new(0.30, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		local SNAP = TweenInfo.new(0.46, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		local FILL = TweenInfo.new(0.20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		-- fromPos/fromSize are the panel's absolute geometry. Omit them and the
		-- island simply snaps in without a ghost, which is what boot does.
		local function MorphIn(fromPos, fromSize)
			morphToken += 1
			local token = morphToken

			local delay = 0

			if fromPos and fromSize and fromSize.X > 0 then
				local ghost = Instance.new("Frame")
				ghost.AnchorPoint = Vector2.new(0.5, 0.5)
				ghost.Position = UDim2.fromOffset(fromPos.X + fromSize.X / 2, fromPos.Y + fromSize.Y / 2)
				ghost.Size = UDim2.fromOffset(fromSize.X, fromSize.Y)
				ghost.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
				ghost.BackgroundTransparency = 0.25
				ghost.BorderSizePixel = 0
				ghost.ZIndex = 0
				ghost.Parent = gui

				local gcorner = Instance.new("UICorner")
				gcorner.CornerRadius = UDim.new(0, 16)
				gcorner.Parent = ghost

				TweenService:Create(ghost, SUCK, {
					Position = UDim2.fromOffset(Camera.ViewportSize.X / 2, 10 + IDLE_H / 2),
					Size = UDim2.fromOffset(IDLE_W * 0.5, IDLE_H * 0.6),
					BackgroundTransparency = 1,
				}):Play()

				task.delay(0.32, function() pcall(function() ghost:Destroy() end) end)
				delay = 0.24 -- capsule opens as the ghost lands, not after it
			end

			task.delay(delay, function()
				if morphToken ~= token then return end

				-- Starts as a sliver at full height and springs out sideways, so
				-- the motion is horizontal rather than a uniform scale-up.
				pill.Position = HOME
				pill.Size = UDim2.fromOffset(22, currentH)
				pill.BackgroundTransparency = 0.02
				scale.Scale = 1
				title.TextTransparency = 1
				sub.TextTransparency = 1
				stroke.Transparency = 1
				pill.Visible = true

				TweenService:Create(pill, SNAP, {
					Size = UDim2.fromOffset(currentW, currentH),
				}):Play()

				-- Content fades in once the capsule is wide enough to hold it.
				task.delay(0.16, function()
					if morphToken ~= token then return end
					TweenService:Create(title, FILL, { TextTransparency = 0 }):Play()
					TweenService:Create(stroke, FILL, {
						Transparency = status and 0.45 or 0.75,
					}):Play()
					if detail ~= nil then
						TweenService:Create(sub, FILL, { TextTransparency = 0.2 }):Play()
					end
				end)
			end)
		end

		-- Opening runs it backwards: the capsule collapses sideways to a sliver
		-- and the panel takes over from there.
		local function MorphOut()
			morphToken += 1
			local token = morphToken

			local COLLAPSE = TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

			TweenService:Create(pill, COLLAPSE, {
				Size = UDim2.fromOffset(22, currentH),
				BackgroundTransparency = 1,
			}):Play()
			TweenService:Create(title, FILL, { TextTransparency = 1 }):Play()
			TweenService:Create(sub, FILL, { TextTransparency = 1 }):Play()
			TweenService:Create(stroke, FILL, { Transparency = 1 }):Play()

			task.delay(0.22, function()
				if morphToken ~= token then return end
				pill.Visible = false
				pill.Size = UDim2.fromOffset(currentW, currentH)
				pill.BackgroundTransparency = 0.02
			end)
		end

		function Island:Visible(on)
			wanted = on and true or false
			if wanted and not menuOpen then MorphIn() else MorphOut() end
		end

		-- The template hands over the panel's geometry so the ghost knows where
		-- to collapse from.
		function Island:SetMenuOpen(open, framePos, frameSize)
			menuOpen = open and true or false
			if wanted and not menuOpen then
				MorphIn(framePos, frameSize)
			else
				MorphOut()
			end
		end

		function Island:SetOpener(fn)
			opener = fn
		end

		-- // Carousel // --
		-- Idle only. A claimed island keeps its status; releasing it resumes
		-- here. Hover pauses it so the text cannot change under a click.

		Scheduler:Every("IslandRotate", ROTATE_SECONDS, function()
			if status ~= nil or hovering or menuOpen or not pill.Visible then return end

			local items = IdleItems()
			rotIndex = (rotIndex % #items) + 1
			Render()
		end)

		-- // Interaction // --

		local function ReleasePress()
			TweenService:Create(scale, SETTLE, { Scale = 1 }):Play()
		end

		pill.MouseEnter:Connect(function()
			hovering = true
			TweenService:Create(stroke, FADE, { Transparency = 0.35 }):Play()
		end)

		pill.MouseLeave:Connect(function()
			hovering = false
			TweenService:Create(stroke, FADE, {
				Transparency = status and 0.45 or 0.75,
			}):Play()
			ReleasePress()
		end)

		pill.MouseButton1Down:Connect(function()
			TweenService:Create(scale, PRESS, { Scale = 0.96 }):Play()
		end)

		pill.MouseButton1Up:Connect(ReleasePress)

		pill.MouseButton1Click:Connect(function()
			if opener then SafeCall(opener) end
		end)

		-- Registered as well as tracked by Cleanup:Instance, because the
		-- carousel and the morph both run through task.delay: an in-flight
		-- one firing after teardown must not find a live pill to show.
		Cleanup:Callback(function()
			morphToken += 1
			pushToken += 1
			pill.Visible = false
			pcall(function() gui:Destroy() end)
		end)

		-- Boot: lay out the content, then bounce in from centre so the very
		-- first appearance uses the same morph as every close after it.
		Render()
		MorphIn()
	end

	return Core
end

return Module
