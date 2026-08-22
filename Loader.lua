if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(math.random())

local TIER = "Free"

local HUB_NAME   = "Supra"
local HUB_FOLDER = "SupraHub"
local REPO       = "https://raw.githubusercontent.com/LogicalGoy/WyndUil/main/"
local DISCORD    = "https://discord.gg/WfYDzQfE8y"
local LOGO_ID    = 101377976094026
local SCRIPT_REPO  = "https://raw.githubusercontent.com/gilgameshfate59/hobfooskated/main/"
local MANIFEST_URL = SCRIPT_REPO .. "scripts.json"

local CATALOGUE = {
	{
		Name = "Steal a Egg",
		File = "StealEgg.lua",
		Universe = 10563114921,
		Places = { 107778070777162 },
		Status = "Working",
		Tier = "Free",
	},
	{
		Name = "Grow a Chicken Fighter",
		File = "Chicken.lua",
		Universe = 10338952197,
		Places = { 94640181989498, 94939256104840 },
		Status = "Working",
		Tier = "Free",
	},
}

local STATUS, VERSION, UPDATED = "Working / Undetected", "v1.0.0", "20/08/26"

local C = {
	Backdrop = Color3.fromHex("#000000"),
	Card     = Color3.fromHex("#0E0E11"),
	Panel    = Color3.fromHex("#17171B"),
	PanelAlt = Color3.fromHex("#1E1E23"),
	Line     = Color3.fromHex("#2A2A31"),
	Text     = Color3.fromHex("#FFFFFF"),
	Muted    = Color3.fromHex("#8A8A93"),
	Good     = Color3.fromHex("#33C759"),
	Danger   = Color3.fromHex("#E5484D"),
}

local BRAND = Color3.fromHex("#4C8DFF")

local SWATCHES = {
	{ Name = "Blue",   Color = Color3.fromHex("#4C8DFF") },
	{ Name = "Purple", Color = Color3.fromHex("#7C5CFF") },
	{ Name = "Green",  Color = Color3.fromHex("#33C759") },
	{ Name = "Red",    Color = Color3.fromHex("#E5484D") },
	{ Name = "White",  Color = Color3.fromHex("#E6E6E6") },
}

local LANGS = {
	{ Code = "en", Name = "English"    },
	{ Code = "es", Name = "Espanol"    },
	{ Code = "pt", Name = "Portugues"  },
	{ Code = "fr", Name = "Francais"   },
	{ Code = "ru", Name = "Русский"    },
	{ Code = "tr", Name = "Turkce"     },
	{ Code = "zh", Name = "中文"        },
}

local cfg = {}

local STR = {
	en = {
		back = "Back",
		compile_fail = "Compile failed",
		dl_fail = "Failed to load",
		finish = "Finish",
		lang_sub = "This applies to the setup and to every script you load.",
		lang_title = "Choose your language",
		load = "Load Script",
		loading = "Loading...",
		next = "Next",
		no_scripts = "No script for this game yet.",
		unsupported = "This game is not supported. Pick a script below to load it anyway.",
		ready_sub = "Your choices are saved. You can re-run this setup any time.",
		ready_title = "You're all set",
		rerun = "Re-run setup",
		scripts = "SCRIPTS",
		terms_accept = "I have read and agree to the Terms of Service",
		terms_copied = "Copied",
		terms_copy = "Copy Discord invite",
		terms_sub = "Please read and accept before continuing.",
		terms_title = "Terms of Service",
		theme_sub = "Accent colour for the scripts you load.",
		theme_title = "Pick a theme",
		this_game = "THIS GAME",
		type = "Type",
		updated = "Updated",
		version = "Version",
	},
	es = {
		back = "Atras",
		compile_fail = "Fallo la compilacion",
		dl_fail = "Error al cargar",
		finish = "Finalizar",
		lang_sub = "Se aplica a la configuracion y a cada script que cargues.",
		lang_title = "Elige tu idioma",
		load = "Cargar script",
		loading = "Cargando...",
		next = "Siguiente",
		no_scripts = "Aun no hay script para este juego.",
		unsupported = "Este juego no es compatible. Elige un script abajo para cargarlo igualmente.",
		ready_sub = "Tus opciones estan guardadas. Puedes repetir la configuracion cuando quieras.",
		ready_title = "Todo listo",
		rerun = "Repetir configuracion",
		scripts = "SCRIPTS",
		terms_accept = "He leido y acepto los terminos del servicio",
		terms_copied = "Copiado",
		terms_copy = "Copiar invitacion de Discord",
		terms_sub = "Lee y acepta antes de continuar.",
		terms_title = "Terminos del servicio",
		theme_sub = "Color de acento para los scripts que cargues.",
		theme_title = "Elige un tema",
		this_game = "ESTE JUEGO",
		type = "Tipo",
		updated = "Actualizado",
		version = "Version",
	},
	pt = {
		back = "Voltar",
		compile_fail = "Falha ao compilar",
		dl_fail = "Falha ao carregar",
		finish = "Concluir",
		lang_sub = "Vale para a configuracao e para cada script que voce carregar.",
		lang_title = "Escolha seu idioma",
		load = "Carregar script",
		loading = "Carregando...",
		next = "Proximo",
		no_scripts = "Ainda nao ha script para este jogo.",
		unsupported = "Este jogo nao e suportado. Escolha um script abaixo para carregar mesmo assim.",
		ready_sub = "Suas escolhas foram salvas. Voce pode refazer a configuracao quando quiser.",
		ready_title = "Tudo pronto",
		rerun = "Refazer configuracao",
		scripts = "SCRIPTS",
		terms_accept = "Li e concordo com os termos de servico",
		terms_copied = "Copiado",
		terms_copy = "Copiar convite do Discord",
		terms_sub = "Leia e aceite antes de continuar.",
		terms_title = "Termos de servico",
		theme_sub = "Cor de destaque para os scripts que voce carregar.",
		theme_title = "Escolha um tema",
		this_game = "ESTE JOGO",
		type = "Tipo",
		updated = "Atualizado",
		version = "Versao",
	},
	fr = {
		back = "Retour",
		compile_fail = "Echec de compilation",
		dl_fail = "Echec du chargement",
		finish = "Terminer",
		lang_sub = "S'applique a la configuration et a chaque script charge.",
		lang_title = "Choisis ta langue",
		load = "Charger le script",
		loading = "Chargement...",
		next = "Suivant",
		no_scripts = "Pas encore de script pour ce jeu.",
		unsupported = "Ce jeu n'est pas pris en charge. Choisis un script ci-dessous pour le charger quand meme.",
		ready_sub = "Tes choix sont sauvegardes. Tu peux relancer la configuration quand tu veux.",
		ready_title = "Tout est pret",
		rerun = "Relancer la configuration",
		scripts = "SCRIPTS",
		terms_accept = "J'ai lu et j'accepte les conditions d'utilisation",
		terms_copied = "Copie",
		terms_copy = "Copier l'invitation Discord",
		terms_sub = "Lis et accepte avant de continuer.",
		terms_title = "Conditions d'utilisation",
		theme_sub = "Couleur d'accent pour les scripts charges.",
		theme_title = "Choisis un theme",
		this_game = "CE JEU",
		type = "Type",
		updated = "Mis a jour",
		version = "Version",
	},
	ru = {
		back = "Назад",
		compile_fail = "Ошибка компиляции",
		dl_fail = "Не удалось загрузить",
		finish = "Готово",
		lang_sub = "Применяется к настройке и ко всем загружаемым скриптам.",
		lang_title = "Выберите язык",
		load = "Загрузить скрипт",
		loading = "Загрузка...",
		next = "Далее",
		no_scripts = "Для этой игры пока нет скрипта.",
		unsupported = "Эта игра не поддерживается. Выберите скрипт ниже, чтобы всё равно загрузить.",
		ready_sub = "Ваш выбор сохранён. Настройку можно пройти заново в любой момент.",
		ready_title = "Всё готово",
		rerun = "Пройти настройку заново",
		scripts = "СКРИПТЫ",
		terms_accept = "Я прочитал и принимаю условия использования",
		terms_copied = "Скопировано",
		terms_copy = "Скопировать приглашение Discord",
		terms_sub = "Прочитайте и примите, чтобы продолжить.",
		terms_title = "Условия использования",
		theme_sub = "Акцентный цвет для загружаемых скриптов.",
		theme_title = "Выберите тему",
		this_game = "ЭТА ИГРА",
		type = "Тип",
		updated = "Обновлено",
		version = "Версия",
	},
	tr = {
		back = "Geri",
		compile_fail = "Derleme basarisiz",
		dl_fail = "Yuklenemedi",
		finish = "Bitir",
		lang_sub = "Kurulum ve yukledigin her betik icin gecerlidir.",
		lang_title = "Dilini sec",
		load = "Betigi yukle",
		loading = "Yukleniyor...",
		next = "Ileri",
		no_scripts = "Bu oyun icin henuz betik yok.",
		unsupported = "Bu oyun desteklenmiyor. Yine de yuklemek icin asagidan bir betik sec.",
		ready_sub = "Secimlerin kaydedildi. Kurulumu istedigin zaman tekrar yapabilirsin.",
		ready_title = "Her sey hazir",
		rerun = "Kurulumu tekrarla",
		scripts = "BETIKLER",
		terms_accept = "Hizmet sartlarini okudum ve kabul ediyorum",
		terms_copied = "Kopyalandi",
		terms_copy = "Discord davetini kopyala",
		terms_sub = "Devam etmeden once okuyup kabul et.",
		terms_title = "Hizmet sartlari",
		theme_sub = "Yukledigin betikler icin vurgu rengi.",
		theme_title = "Bir tema sec",
		this_game = "BU OYUN",
		type = "Tur",
		updated = "Guncellendi",
		version = "Surum",
	},
	zh = {
		back = "返回",
		compile_fail = "编译失败",
		dl_fail = "加载失败",
		finish = "完成",
		lang_sub = "适用于本次设置以及你加载的每个脚本。",
		lang_title = "选择语言",
		load = "加载脚本",
		loading = "加载中...",
		next = "下一步",
		no_scripts = "此游戏暂无脚本。",
		unsupported = "不支持此游戏。你仍可从下方选择一个脚本加载。",
		ready_sub = "你的选择已保存。你可以随时重新运行此设置。",
		ready_title = "全部完成",
		rerun = "重新运行设置",
		scripts = "脚本",
		terms_accept = "我已阅读并同意服务条款",
		terms_copied = "已复制",
		terms_copy = "复制 Discord 邀请",
		terms_sub = "请先阅读并接受后再继续。",
		terms_title = "服务条款",
		theme_sub = "你加载的脚本所用的强调色。",
		theme_title = "选择主题",
		this_game = "当前游戏",
		type = "类型",
		updated = "更新于",
		version = "版本",
	},
}

local function T(key)
	local pack = STR[cfg and cfg.Lang or "en"] or STR.en
	return pack[key] or STR.en[key] or key
end

local TERMS_BODY = [[SUPRA HUB — TERMS OF SERVICE

By purchasing Supra products or joining the Supra Discord, you agree to the following.

1 • LICENCE & ACCESS
Personal use only. Keys, access and credentials may not be shared, sold or transferred.

2 • REVERSE ENGINEERING & SECURITY
Reverse engineering, or attempting to bypass Supra's licensing or security systems, is strictly prohibited.

3 • REDISTRIBUTION & LEAKING
Do not leak, distribute, resell or privately share Supra keys or access with unauthorised users.

4 • REFUNDS & CHARGEBACKS
Digital purchases are final once access has been delivered, except where required by applicable law. Contact support before opening a payment dispute. Fraudulent or abusive disputes may result in termination of access and future purchase restrictions.

5 • SERVICE & UPDATES
Supra does not guarantee uninterrupted or permanent functionality. Roblox and other third-party updates may affect products. Supra may update, modify, replace, suspend or discontinue products or features.

6 • DISCORD RULES
Respect all members and staff. No harassment, threats, discrimination, NSFW content, scams, malicious links or files, impersonation, excessive spam, or intentional server disruption.

7 • ADVERTISING
Unauthorised advertising and self-promotion are prohibited, including promoting other products, script hubs, services or Discord servers through DMs or mentions.

8 • MODERATION & ENFORCEMENT
Staff may warn, restrict, mute, remove or terminate users who violate these terms. Severe violations may result in immediate action without prior warning.

9 • CHANGES & AGREEMENT
Supra may update these terms when necessary. Continued use of Supra products, or participation in the Discord after an update, constitutes acceptance of the revised terms.

By purchasing from or participating in Supra Hub, you confirm that you have read and agreed to these Terms of Service.]]

local CARD_W = 470
local PAD    = 20
local GAP    = 12

local cloneref = cloneref or function(o) return o end

local Players      = cloneref(game:GetService("Players"))
local HttpService  = cloneref(game:GetService("HttpService"))
local TweenService = cloneref(game:GetService("TweenService"))
local TextService  = cloneref(game:GetService("TextService"))
local LocaleService= cloneref(game:GetService("LocalizationService"))

local LocalPlayer = Players.LocalPlayer
local Camera      = workspace.CurrentCamera

local hasFiles = (isfile and writefile and readfile and isfolder and makefolder) and true or false
local setclip  = setclipboard or (syn and syn.setclipboard) or function() end

local function GetHui()
	if gethui then
		local ok, h = pcall(gethui)
		if ok and h then return h end
	end
	return cloneref(game:GetService("CoreGui"))
end

local function Run(fn, ...)
	local ok, err = pcall(fn, ...)
	if not ok then warn("[" .. HUB_NAME .. "] " .. tostring(err)) end
	return ok
end

local function New(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props or {}) do o[k] = v end
	if parent then o.Parent = parent end
	return o
end

local function Corner(r, parent)
	return New("UICorner", { CornerRadius = UDim.new(0, r) }, parent)
end

local function Stroke(color, thickness, parent)
	return New("UIStroke", {
		Color = color,
		Thickness = thickness or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, parent)
end

local function Stack(parent, gap, padding)
	New("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, gap or GAP),
	}, parent)
	if padding then
		New("UIPadding", {
			PaddingTop = UDim.new(0, padding),
			PaddingBottom = UDim.new(0, padding),
			PaddingLeft = UDim.new(0, padding),
			PaddingRight = UDim.new(0, padding),
		}, parent)
	end
	return parent
end

local function Text(parent, str, size, color, weight, order)
	return New("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, size + 4),
		Font = weight or Enum.Font.GothamMedium,
		Text = str,
		TextSize = size,
		TextColor3 = color or C.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = order or 1,
	}, parent)
end

local function Tween(o, props, t, style)
	local tw = TweenService:Create(o, TweenInfo.new(t or 0.18,
		style or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function CloseGlyph(parent, size)
	local btn = New("TextButton", {
		BackgroundTransparency = 1, Text = "",
		Size = UDim2.fromOffset(size, size),
		AutoButtonColor = false,
	}, parent)
	for _, rot in ipairs({ 45, -45 }) do
		New("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(size * 0.55, 1.5),
			BackgroundColor3 = C.Muted,
			BorderSizePixel = 0,
			Rotation = rot,
		}, btn)
	end
	return btn
end

local function Button(parent, label, opts)
	opts = opts or {}
	local b = New("TextButton", {
		BackgroundColor3 = opts.Fill or C.Panel,
		Size = UDim2.new(opts.Wide and 1 or 0, opts.Wide and 0 or (opts.Width or 96), 0, opts.Height or 38),
		Font = Enum.Font.GothamBold,
		Text = label,
		TextSize = opts.TextSize or 14,
		TextColor3 = opts.TextColor or C.Text,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		LayoutOrder = opts.Order or 1,
	}, parent)
	Corner(opts.Radius or 10, b)
	if opts.Outline then Stroke(C.Line, 1, b) end

	local base = b.BackgroundColor3
	b.MouseEnter:Connect(function() Tween(b, { BackgroundColor3 = base:Lerp(Color3.new(1,1,1), 0.10) }, 0.12) end)
	b.MouseLeave:Connect(function() Tween(b, { BackgroundColor3 = base }, 0.12) end)
	return b
end

local CONFIG_FILE = HUB_FOLDER .. "/loader.json"

local function LoadConfig()
	if not hasFiles then return end
	if not isfolder(HUB_FOLDER) then Run(makefolder, HUB_FOLDER) end
	if not isfile(CONFIG_FILE) then return end
	local ok, body = pcall(readfile, CONFIG_FILE)
	if not ok or not body or body == "" then return end
	local ok2, tbl = pcall(function() return HttpService:JSONDecode(body) end)
	if ok2 and type(tbl) == "table" then cfg = tbl end
end

local function SaveConfig()
	if not hasFiles then return end
	Run(writefile, CONFIG_FILE, HttpService:JSONEncode(cfg))
end

LoadConfig()

local MetaLabels = {}
local RebuildList

local function Normalise(raw)
	if type(raw) ~= "table" then return nil end

	local name = raw.Name or raw.name
	if type(name) ~= "string" then return nil end

	local places = {}
	local p = raw.Places or raw.places or raw.PlaceIds or raw.placeIds or raw.Place or raw.place
	if type(p) == "number" then
		places[1] = p
	elseif type(p) == "table" then
		for _, id in ipairs(p) do
			local n = tonumber(id)
			if n then places[#places + 1] = n end
		end
	end
	local universes = {}
	local u = raw.Universe or raw.universe or raw.Universes or raw.universes
		or raw.GameId or raw.gameId or raw.GameIds or raw.gameIds
	if type(u) == "number" then
		universes[1] = u
	elseif type(u) == "table" then
		for _, id in ipairs(u) do
			local n = tonumber(id)
			if n then universes[#universes + 1] = n end
		end
	end

	return {
		Name      = name,
		Url       = raw.Url or raw.url or (SCRIPT_REPO .. (raw.File or raw.file or "")),
		Places    = places,
		Universes = universes,
		Status    = raw.Status or raw.status or "Working",
		Tier      = raw.Tier or raw.tier or "Free",
	}
end

local function ApplyCatalogue(list)
	local out = {}
	for _, raw in ipairs(list or {}) do
		local e = Normalise(raw)
		if e then out[#out + 1] = e end
	end
	if #out > 0 then CATALOGUE = out end
end

ApplyCatalogue(CATALOGUE)

local function FetchManifest()
	local ok, body = pcall(game.HttpGet, game, MANIFEST_URL)
	if not ok or not body or body == "" then return end
	local ok2, d = pcall(function() return HttpService:JSONDecode(body) end)
	if not ok2 or type(d) ~= "table" then return end

	local hub = d.hub or d.Hub
	if type(hub) == "table" then
		STATUS  = hub.status  or hub.STATUS  or STATUS
		VERSION = hub.version or hub.VERSION or VERSION
		UPDATED = hub.updated or hub.UPDATED or UPDATED
	end

	ApplyCatalogue(d.scripts or d.Scripts)

	if MetaLabels.Version then MetaLabels.Version.Text = VERSION end
	if MetaLabels.Updated then MetaLabels.Updated.Text = UPDATED end
	if MetaLabels.Status then MetaLabels.Status.Text = STATUS end
	if RebuildList then Run(RebuildList) end
end

local function EntryForPlace()
	local pid, uid = game.PlaceId, game.GameId

	for _, e in ipairs(CATALOGUE) do
		for _, id in ipairs(e.Universes or {}) do
			if id == uid then return e end
		end
	end

	for _, e in ipairs(CATALOGUE) do
		for _, id in ipairs(e.Places) do
			if id == pid then return e end
		end
	end

	return nil
end

local function Locked(entry)
	return entry.Tier == "Premium" and TIER ~= "Premium"
end

local AvatarUrl = "rbxassetid://" .. LOGO_ID
local AvatarImage

task.spawn(function()
	local ok, img = pcall(function()
		return Players:GetUserThumbnailAsync(LocalPlayer.UserId,
			Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if ok and img and img ~= "" then
		AvatarUrl = img
		if AvatarImage then AvatarImage.Image = img end
	end
end)

local gui = New("ScreenGui", {
	Name = HttpService:GenerateGUID(false),
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 9999,
})
Run(function() gui.Parent = GetHui() end)
if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local Backdrop = New("TextButton", {
	BackgroundColor3 = C.Backdrop,
	BackgroundTransparency = 1,
	Size = UDim2.fromScale(1, 1),
	Text = "",
	AutoButtonColor = false,
	Modal = true,
}, gui)

local Card = New("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(CARD_W, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	BackgroundColor3 = C.Card,
	BorderSizePixel = 0,
}, gui)
Corner(18, Card)
Stroke(C.Line, 1, Card)

local CardScale = New("UIScale", { Scale = 1 }, Card)

-- Chrome that must always stay on screen: header, both divider lines and the
-- footer. The body gets whatever is left and scrolls inside it, so the Next
-- button can never be pushed out of the card.
local CHROME_H = 58 + 1 + 1 + 62

local function CardMetrics()
	local vp = Camera.ViewportSize
	-- Leave a margin so the card never touches the screen edge on a phone.
	local w = math.min(CARD_W, vp.X - 24)
	local h = vp.Y - (vp.Y < 500 and 24 or 60)
	return w, h
end

local CardLimit = New("UISizeConstraint", {
	MaxSize = Vector2.new(CardMetrics()),
}, Card)

Stack(Card, 0)

local Header = New("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 58),
	LayoutOrder = 1,
}, Card)

local Logo = New("ImageLabel", {
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, PAD, 0.5, 0),
	Size = UDim2.fromOffset(26, 26),
	BackgroundTransparency = 1,
	Image = "rbxassetid://" .. LOGO_ID,
	ScaleType = Enum.ScaleType.Fit,
}, Header)

New("TextLabel", {
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, PAD + 36, 0.5, -7),
	Size = UDim2.fromOffset(200, 18),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	Text = HUB_NAME,
	TextSize = 17,
	TextColor3 = C.Text,
	TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

local TierChip = New("TextLabel", {
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, PAD + 36, 0.5, 10),
	Size = UDim2.fromOffset(200, 12),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	Text = TIER:upper(),
	TextSize = 10,
	TextColor3 = BRAND,
	TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

local CloseBtn = CloseGlyph(Header, 20)
CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
CloseBtn.Position = UDim2.new(1, -PAD, 0.5, 0)

New("Frame", {
	BackgroundColor3 = C.Line,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, 1),
	LayoutOrder = 2,
}, Card)

-- Scrolls rather than grows. Previously this was a plain frame with
-- AutomaticSize.Y, so a tall step (the terms, on a short screen) pushed the
-- footer past the card's height cap and the Next button became unreachable --
-- which is exactly why mobile could not get past the terms.
local Body = New("ScrollingFrame", {
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, 0),
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	ScrollingDirection = Enum.ScrollingDirection.Y,
	ScrollBarThickness = 3,
	ScrollBarImageColor3 = C.Muted,
	ScrollBarImageTransparency = 0.5,
	ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
	LayoutOrder = 3,
}, Card)
Stack(Body, GAP, PAD)

local BodyLayout = Body:FindFirstChildOfClass("UIListLayout")

-- Hug the content when it is short, cap it when it is not.
local function FitBody()
	local w, h = CardMetrics()
	CardLimit.MaxSize = Vector2.new(w, h)
	local avail = math.max(h - CHROME_H, 80)
	local content = (BodyLayout and BodyLayout.AbsoluteContentSize.Y or 0) + PAD * 2
	Body.Size = UDim2.new(1, 0, 0, math.min(content, avail))
end

if BodyLayout then
	BodyLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(FitBody)
end
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(FitBody)
task.defer(FitBody)

local FooterLine = New("Frame", {
	BackgroundColor3 = C.Line,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, 1),
	LayoutOrder = 4,
}, Card)

local Footer = New("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 62),
	LayoutOrder = 5,
}, Card)

local BackBtn = New("TextButton", {
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, PAD, 0.5, 0),
	Size = UDim2.fromOffset(64, 32),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamMedium,
	Text = T("back"),
	TextSize = 14,
	TextColor3 = C.Muted,
	AutoButtonColor = false,
}, Footer)

local Dots = New("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(100, 8),
	BackgroundTransparency = 1,
}, Footer)
New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, Dots)

local NextBtn = New("TextButton", {
	AnchorPoint = Vector2.new(1, 0.5),
	Position = UDim2.new(1, -PAD, 0.5, 0),
	Size = UDim2.fromOffset(104, 36),
	BackgroundColor3 = BRAND,
	Font = Enum.Font.GothamBold,
	Text = T("next"),
	TextSize = 14,
	TextColor3 = Color3.new(1, 1, 1),
	AutoButtonColor = false,
	BorderSizePixel = 0,
}, Footer)
Corner(10, NextBtn)

local EASE_OUT  = Enum.EasingStyle.Quart
local EASE_BACK = Enum.EasingStyle.Back

local RestAlpha = setmetatable({}, { __mode = "k" })

local function AlphaProps(inst)
	local t = RestAlpha[inst]
	if t then return t end
	t = {}
	if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
		t.TextTransparency = inst.TextTransparency
		t.TextStrokeTransparency = inst.TextStrokeTransparency
	end
	if inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
		t.ImageTransparency = inst.ImageTransparency
	end
	if inst:IsA("GuiObject") then
		t.BackgroundTransparency = inst.BackgroundTransparency
	end
	if inst:IsA("UIStroke") then
		t.Transparency = inst.Transparency
	end
	RestAlpha[inst] = t
	return t
end

local function FadeTree(root, alpha, time)
	for _, d in ipairs(root:GetDescendants()) do
		local rest, goal = AlphaProps(d), nil
		for prop, base in pairs(rest) do
			goal = goal or {}
			goal[prop] = base + (1 - base) * alpha
		end
		if goal then
			if time and time > 0 then
				Tween(d, goal, time)
			else
				for prop, v in pairs(goal) do d[prop] = v end
			end
		end
	end
end

local function AnimateIn()
	Backdrop.BackgroundTransparency = 1
	CardScale.Scale = 0.94
	Card.Position = UDim2.new(0.5, 0, 0.5, 22)
	FadeTree(Body, 1, 0)

	Tween(Backdrop, { BackgroundTransparency = 0.45 }, 0.25)
	TweenService:Create(CardScale, TweenInfo.new(0.42, EASE_BACK, Enum.EasingDirection.Out),
		{ Scale = 1 }):Play()
	TweenService:Create(Card, TweenInfo.new(0.42, EASE_BACK, Enum.EasingDirection.Out),
		{ Position = UDim2.fromScale(0.5, 0.5) }):Play()
	task.delay(0.10, function()
		FadeTree(Body, 0, 0.24)
	end)
end

local EXIT_TIME = 0.22

local function AnimateOut()
	Tween(Backdrop, { BackgroundTransparency = 1 }, EXIT_TIME)
	FadeTree(Body, 1, EXIT_TIME * 0.7)
	TweenService:Create(CardScale, TweenInfo.new(EXIT_TIME, EASE_OUT, Enum.EasingDirection.In),
		{ Scale = 0.93 }):Play()
	TweenService:Create(Card, TweenInfo.new(EXIT_TIME, EASE_OUT, Enum.EasingDirection.In),
		{ Position = UDim2.new(0.5, 0, 0.5, 16) }):Play()
end

local swapToken = 0

local function SwapBody(build)
	swapToken += 1
	local token = swapToken
	FadeTree(Body, 1, 0.12)
	task.delay(0.13, function()
		if token ~= swapToken then return end
		build()
		FadeTree(Body, 1, 0)
		FadeTree(Body, 0, 0.20)
	end)
end

local function ClearBody()
	-- Back to the top, or a step entered after a scrolled one opens halfway down.
	Body.CanvasPosition = Vector2.new()
	for _, c in ipairs(Body:GetChildren()) do
		if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
	end
end

local function SetFooter(visible, backVisible, nextText, nextEnabled)
	FooterLine.Visible = visible
	Footer.Visible = visible
	BackBtn.Visible = backVisible
	BackBtn.Text = T("back")
	NextBtn.Text = nextText or "Next"
	NextBtn.BackgroundTransparency = nextEnabled == false and 0.6 or 0
	NextBtn.TextTransparency = nextEnabled == false and 0.5 or 0
	NextBtn.Active = nextEnabled ~= false
end

local function SetDots(count, index)
	for _, d in ipairs(Dots:GetChildren()) do
		if d:IsA("Frame") then d:Destroy() end
	end
	Dots.Visible = count > 0
	for i = 1, count do
		local on = i == index
		local d = New("Frame", {
			Size = UDim2.fromOffset(on and 16 or 6, 6),
			BackgroundColor3 = on and BRAND or C.Line,
			BorderSizePixel = 0,
			LayoutOrder = i,
		}, Dots)
		Corner(3, d)
	end
end

local function Destroy()
	AnimateOut()
	task.delay(EXIT_TIME + 0.02, function() Run(function() gui:Destroy() end) end)
end

CloseBtn.MouseButton1Click:Connect(Destroy)

local Step, Steps = 1, {}
local Show

Steps[1] = {
	Build = function()
		Text(Body, T("lang_title"), 19, C.Text, Enum.Font.GothamBold, 1)
		Text(Body, T("lang_sub"), 13, C.Muted, Enum.Font.Gotham, 2)

		local grid = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			LayoutOrder = 3,
		}, Body)
		New("UIGridLayout", {
			CellSize = UDim2.new(0.333, -6, 0, 40),
			CellPadding = UDim2.fromOffset(9, 9),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}, grid)

		for i, l in ipairs(LANGS) do
			local on = l.Code == cfg.Lang
			local t = New("TextButton", {
				BackgroundColor3 = on and BRAND or C.Panel,
				Font = Enum.Font.GothamMedium,
				Text = l.Name,
				TextSize = 13,
				TextColor3 = on and Color3.new(1, 1, 1) or C.Muted,
				AutoButtonColor = false,
				BorderSizePixel = 0,
				LayoutOrder = i,
			}, grid)
			Corner(9, t)
			t.MouseButton1Click:Connect(function()
				if cfg.Lang == l.Code then return end
				cfg.Lang = l.Code
				SaveConfig()
				Show(1)
			end)
		end

		SetFooter(true, false, T("next"), true)
	end,
}

Steps[2] = {
	Build = function()
		Text(Body, T("terms_title"), 19, C.Text, Enum.Font.GothamBold, 1)
		Text(Body, T("terms_sub"), 13, C.Muted, Enum.Font.Gotham, 2)

		-- Everything else on this step (title, subtitle, accept row, copy
		-- button, gaps) costs ~180px, so give the terms whatever is left of the
		-- usable area rather than a fixed 210 that does not fit a phone.
		local termsH = math.clamp(Camera.ViewportSize.Y - CHROME_H - 200, 96, 210)

		local scroll = New("ScrollingFrame", {
			BackgroundColor3 = C.Panel,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, termsH),
			CanvasSize = UDim2.new(),
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = C.Muted,
			ScrollBarImageTransparency = 0.4,
			LayoutOrder = 3,
		}, Body)
		Corner(10, scroll)
		New("UIPadding", {
			PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12),
			PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12),
		}, scroll)

		local body = New("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(0, 0),
			Font = Enum.Font.Gotham,
			Text = TERMS_BODY,
			TextSize = 12,
			TextColor3 = C.Muted,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			LineHeight = 1.25,
		}, scroll)

		local LINE = 1.25

		local function FitTerms()
			local w = math.max(scroll.AbsoluteSize.X - 32, 100)
			local ok, measured = pcall(function()
				return TextService:GetTextSize(body.Text, body.TextSize, body.Font,
					Vector2.new(w, math.huge))
			end)
			local height = ok and math.ceil(measured.Y * LINE) + 12 or 900
			body.Size = UDim2.fromOffset(w, height)
			scroll.CanvasSize = UDim2.fromOffset(0, height)
		end
		scroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(FitTerms)
		FitTerms()

		local accept = New("TextButton", {
			BackgroundColor3 = C.Panel,
			Size = UDim2.new(1, 0, 0, 44),
			Text = "",
			AutoButtonColor = false,
			BorderSizePixel = 0,
			LayoutOrder = 4,
		}, Body)
		Corner(10, accept)

		local check = New("Frame", {
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 13, 0.5, 0),
			Size = UDim2.fromOffset(20, 20),
			BackgroundColor3 = C.PanelAlt,
			BorderSizePixel = 0,
		}, accept)
		Corner(6, check)
		Stroke(C.Line, 1, check)

		local tick = New("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(10, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			Visible = false,
		}, check)
		Corner(3, tick)

		New("TextLabel", {
			Position = UDim2.fromOffset(45, 0),
			Size = UDim2.new(1, -56, 1, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			Text = T("terms_accept"),
			TextSize = 13,
			TextColor3 = C.Text,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, accept)

		local ok = cfg.Terms == true
		local function paint()
			tick.Visible = ok
			Tween(check, { BackgroundColor3 = ok and BRAND or C.PanelAlt }, 0.12)
			SetFooter(true, true, T("next"), ok)
		end
		accept.MouseButton1Click:Connect(function()
			ok = not ok
			cfg.Terms = ok
			paint()
		end)

		local link = Button(Body, T("terms_copy"),
			{ Wide = true, Height = 36, Fill = C.Panel, Outline = true, Order = 5 })
		link.MouseButton1Click:Connect(function()
			setclip(DISCORD)
			link.Text = T("terms_copied")
			task.delay(1.2, function() if link.Parent then link.Text = T("terms_copy") end end)
		end)

		paint()
	end,
}

Steps[3] = {
	Build = function()
		Text(Body, T("theme_title"), 19, C.Text, Enum.Font.GothamBold, 1)
		Text(Body, T("theme_sub"), 13, C.Muted, Enum.Font.Gotham, 2)

		local grid = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			LayoutOrder = 3,
		}, Body)
		New("UIGridLayout", {
			CellSize = UDim2.new(0.333, -6, 0, 74),
			CellPadding = UDim2.fromOffset(9, 9),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}, grid)

		local tiles, strokes = {}, {}
		local function paint()
			for hex, t in pairs(tiles) do
				local on = hex == cfg.AccentHex
				Tween(t, { BackgroundColor3 = on and C.PanelAlt or C.Panel }, 0.12)
				strokes[t].Transparency = on and 0 or 1
			end
		end

		for i, sw in ipairs(SWATCHES) do
			local hex = "#" .. sw.Color:ToHex():upper()
			local t = New("TextButton", {
				BackgroundColor3 = C.Panel,
				Text = "",
				AutoButtonColor = false,
				BorderSizePixel = 0,
				LayoutOrder = i,
			}, grid)
			Corner(10, t)
			local st = Stroke(sw.Color, 1.5, t)
			st.Transparency = 1
			strokes[t] = st

			local dot = New("Frame", {
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.5, 0, 0, 14),
				Size = UDim2.fromOffset(24, 24),
				BackgroundColor3 = sw.Color,
				BorderSizePixel = 0,
			}, t)
			Corner(12, dot)

			New("TextLabel", {
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.5, 0, 1, -12),
				Size = UDim2.new(1, 0, 0, 14),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamMedium,
				Text = sw.Name,
				TextSize = 12,
				TextColor3 = C.Muted,
			}, t)

			tiles[hex] = t
			t.MouseButton1Click:Connect(function()
				cfg.AccentHex = hex
				paint()
			end)
		end

		paint()
		SetFooter(true, true, T("next"), true)
	end,
}

Steps[4] = {
	Build = function()
		local wrap = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 96),
			LayoutOrder = 1,
		}, Body)

		local av = New("ImageLabel", {
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 4),
			Size = UDim2.fromOffset(84, 84),
			BackgroundColor3 = C.Panel,
			Image = AvatarUrl,
			BorderSizePixel = 0,
		}, wrap)
		Corner(42, av)
		Stroke(BRAND, 2, av)
		AvatarImage = av

		local title = Text(Body, T("ready_title"), 20, C.Text, Enum.Font.GothamBold, 2)
		title.TextXAlignment = Enum.TextXAlignment.Center

		local sub = Text(Body, T("ready_sub"), 13, C.Muted, Enum.Font.Gotham, 3)
		sub.TextXAlignment = Enum.TextXAlignment.Center

		SetFooter(true, true, T("finish"), true)
	end,
}

local Selected = nil
cfg.Lang = cfg.Lang or "en"
cfg.AccentHex = cfg.AccentHex or "#4C8DFF"

local function BuildMain()
	ClearBody()
	SetFooter(false, false)
	SetDots(0, 0)

	local top = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 76),
		LayoutOrder = 1,
	}, Body)

	local av = New("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.fromOffset(64, 64),
		BackgroundColor3 = C.Panel,
		Image = AvatarUrl,
		BorderSizePixel = 0,
	}, top)
	Corner(32, av)
	Stroke(BRAND, 2, av)
	AvatarImage = av

	local nameLbl = New("TextLabel", {
		Position = UDim2.fromOffset(78, 10),
		Size = UDim2.new(1, -78, 0, 20),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = LocalPlayer.DisplayName,
		TextSize = 17,
		TextColor3 = C.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, top)

	local userLbl = New("TextLabel", {
		Position = UDim2.fromOffset(78, 31),
		Size = UDim2.new(1, -78, 0, 16),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		Text = "@" .. LocalPlayer.Name,
		TextSize = 13,
		TextColor3 = C.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, top)

	local statusDot = New("Frame", {
		Position = UDim2.fromOffset(78, 54),
		Size = UDim2.fromOffset(7, 7),
		BackgroundColor3 = C.Good,
		BorderSizePixel = 0,
	}, top)
	Corner(4, statusDot)

	local statusText = New("TextLabel", {
		Position = UDim2.fromOffset(92, 48),
		Size = UDim2.new(1, -92, 0, 16),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = STATUS,
		TextSize = 12,
		TextColor3 = C.Good,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, top)
	MetaLabels.Status = statusText

	local meta = New("Frame", {
		BackgroundColor3 = C.Panel,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = 2,
	}, Body)
	Corner(10, meta)
	Stack(meta, 0, 4)

	local function MetaRow(label, value, order)
		local r = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 34),
			LayoutOrder = order,
		}, meta)
		New("TextLabel", {
			Position = UDim2.fromOffset(12, 0),
			Size = UDim2.new(0.5, 0, 1, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			Text = label,
			TextSize = 13,
			TextColor3 = C.Muted,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, r)
		local val = New("TextLabel", {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -12, 0, 0),
			Size = UDim2.new(0.5, 0, 1, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			Text = value,
			TextSize = 13,
			TextColor3 = C.Text,
			TextXAlignment = Enum.TextXAlignment.Right,
		}, r)
		return val
	end

	MetaLabels.Version = MetaRow(T("version"), VERSION, 1)
	MetaLabels.Updated = MetaRow(T("updated"), UPDATED, 2)
	MetaRow(T("type"), TIER, 3)

	Text(Body, T("scripts"), 13, C.Muted, Enum.Font.GothamBold, 3)

	local list = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = 4,
	}, Body)
	Stack(list, 8)

	local rows, rowStrokes = {}, {}

	local function paintRows()
		for entry, r in pairs(rows) do
			local on = entry == Selected
			Tween(r, { BackgroundColor3 = on and C.PanelAlt or C.Panel }, 0.12)
			rowStrokes[r].Transparency = on and 0 or 1
		end
	end

	function RebuildList()
		for _, c in ipairs(list:GetChildren()) do
			if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
		end
		rows, rowStrokes = {}, {}

		local here = EntryForPlace()

		if not Selected or not table.find(CATALOGUE, Selected) then
			Selected = here
		end

		if #CATALOGUE == 0 then
			Text(list, T("no_scripts"), 13, C.Muted, Enum.Font.Gotham, 1)
			return
		end

		if not here then
			Text(list, T("unsupported"), 13, C.Muted, Enum.Font.Gotham, 1)
		end

		for i, entry in ipairs(CATALOGUE) do
			local locked = Locked(entry)
			local r = New("TextButton", {
				BackgroundColor3 = C.Panel,
				Size = UDim2.new(1, 0, 0, 44),
				Text = "",
				AutoButtonColor = false,
				BorderSizePixel = 0,
				LayoutOrder = i,
			}, list)
			Corner(10, r)
			local st = Stroke(BRAND, 1.5, r)
			st.Transparency = 1
			rowStrokes[r] = st

			New("TextLabel", {
				Position = UDim2.fromOffset(14, 0),
				Size = UDim2.new(1, -100, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamMedium,
				Text = entry.Name,
				TextSize = 14,
				TextColor3 = locked and C.Muted or C.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
			}, r)

			local badge, fill
			if locked then
				badge, fill = "PREMIUM", C.PanelAlt
			elseif entry.Status ~= "Working" then
				badge, fill = entry.Status:upper(), C.Danger
			elseif entry == here then
				badge, fill = T("this_game"), BRAND
			end

			if badge then
				local chip = New("TextLabel", {
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -12, 0.5, 0),
					Size = UDim2.fromOffset(math.max(74, #badge * 7 + 16), 20),
					BackgroundColor3 = fill,
					Font = Enum.Font.GothamBold,
					Text = badge,
					TextSize = 10,
					TextColor3 = locked and C.Muted or Color3.new(1, 1, 1),
					BorderSizePixel = 0,
				}, r)
				Corner(6, chip)
			end

			rows[entry] = r
			r.MouseButton1Click:Connect(function()
				if locked then return end
				Selected = entry
				paintRows()
			end)
		end
		paintRows()
	end

	RebuildList()

	local load = Button(Body, T("load"),
		{ Wide = true, Height = 46, Fill = BRAND, Order = 5, TextSize = 15 })

	load.ClipsDescendants = true
	local fill = New("Frame", {
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 0, 1, 0),
		ZIndex = 0,
	}, load)

	local busy = false

	local function Progress(alpha, time)
		Tween(fill, { Size = UDim2.new(alpha, 0, 1, 0) }, time or 0.25)
	end

	local function Fail(key)
		load.Text = T(key)
		Tween(load, { BackgroundColor3 = C.Danger }, 0.15)
		Progress(1, 0.15)
		task.delay(1.6, function()
			if not load.Parent then return end
			busy = false
			load.Text = T("load")
			Tween(load, { BackgroundColor3 = BRAND }, 0.2)
			fill.Size = UDim2.new(0, 0, 1, 0)
		end)
	end

	load.MouseButton1Click:Connect(function()
		if busy then return end
		local entry = Selected
		if not entry or Locked(entry) or entry.Url == "" then return end
		local url = entry.Url
		busy = true
		load.Text = T("loading")

		Progress(0.7, 1.1)

		task.spawn(function()
			local ok, body = pcall(game.HttpGet, game, url)
			if not ok or not body or body == "" then
				Fail("dl_fail")
				return
			end
			Progress(0.9, 0.18)

			local chunk, err = loadstring(body)
			if not chunk then
				warn("[" .. HUB_NAME .. "] " .. tostring(err))
				Fail("compile_fail")
				return
			end
			Progress(1, 0.16)

			getgenv().Supra = {
				Lang = cfg.Lang or "en",
				AccentHex = cfg.AccentHex or "#4C8DFF",
				Tier = TIER,
				FromLoader = true,
			}

			task.wait(0.22)
			Destroy()
			task.delay(EXIT_TIME + 0.05, chunk)
		end)
	end)

	local strip = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 30),
		LayoutOrder = 6,
	}, Body)

	local rerun = New("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(110, 26),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		Text = T("rerun"),
		TextSize = 12,
		TextColor3 = C.Muted,
		TextXAlignment = Enum.TextXAlignment.Right,
		AutoButtonColor = false,
	}, strip)
	rerun.MouseButton1Click:Connect(function()
		Step = 1
		Show(1)
	end)
end

Show = function(n)
	if n > #Steps then
		cfg.Done = true
		SaveConfig()
		SwapBody(function()
			ClearBody()
			BuildMain()
		end)
		return
	end
	Step = n
	SwapBody(function()
		ClearBody()
		SetDots(#Steps, n)
		Steps[n].Build()
	end)
end

NextBtn.MouseButton1Click:Connect(function()
	if NextBtn.Active == false then return end
	SaveConfig()
	Show(Step + 1)
end)

BackBtn.MouseButton1Click:Connect(function()
	if Step > 1 then Show(Step - 1) end
end)

task.spawn(FetchManifest)

Card.Size = UDim2.fromOffset(CARD_W, 0)
task.defer(FitBody)

if cfg.Done and cfg.Terms then
	SetFooter(false, false)
	SetDots(0, 0)
	BuildMain()
else
	Step = 1
	SetDots(#Steps, 1)
	Steps[1].Build()
end

AnimateIn()
