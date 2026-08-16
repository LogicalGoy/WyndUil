--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /
    |__/|__/_/_//_/\_,_/\____/___/

    v1.6.65  |  2026-07-27  |  Roblox UI Library for scripts

    To view the source code, see the `src/` folder on the official GitHub repository.

    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/article-hub-studio/WindUI-Skibidi
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

type ConfigType__DARKLUA_TYPE_a={
Object:Instance,
Camera:Instance?,
Interactive:boolean?,
Height:number?,
Focused:boolean,

Window:any,
WindUI:any,
Tab:any,
Parent:Instance,
}local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()

return(cloneref or clonereference or function(b)
return b
end)end function a.b()

local b

local d={
New=nil,
Init=nil,
Wrappers=setmetatable({},{__mode="k"}),
Shapes={
Circle={
Image="rbxassetid://111665032676235",
Rect=Rect.new(512,512,512,512),
Radius=512,
},
CircleOutline={
Image="rbxassetid://108556680453287",
Rect=Rect.new(512,512,512,512),
Radius=512,
},
CircleGlass={
Image="rbxassetid://95600044758841",
Rect=Rect.new(512,512,512,512),
Radius=512,
},



SquircleH={
Image="rbxassetid://125083578015333",
Rect=Rect.new(512,325,512,325),
Radius=325,
},
SquircleHOutline={
Image="rbxassetid://107043713170567",
Rect=Rect.new(512,325,512,325),
Radius=325,
},
SquircleHGlass={
Image="rbxassetid://84819521201001",
Rect=Rect.new(512,325,512,325),
Radius=325,
},
["SquircleH-TL-TR"]={
Image="rbxassetid://90680657206619",
Rect=Rect.new(807,512,807,512),
Radius=325,
AutoChange=false,
},
["SquircleH-BL-BR"]={
Image="rbxassetid://99216342056719",
Rect=Rect.new(0,512,0,512),
Radius=325,
AutoChange=false,
},

SquircleV={
Image="rbxassetid://124965260437653",
Rect=Rect.new(325,512,325,512),
Radius=325,
},
SquircleVOutline={
Image="rbxassetid://88808835404198",
Rect=Rect.new(325,512,325,512),
Radius=325,
},
SquircleVGlass={
Image="rbxassetid://124982801466667",
Rect=Rect.new(325,512,325,512),
Radius=325,
},

Squircle={
Image="rbxassetid://89641024074289",
Rect=Rect.new(460,460,460,460),
Radius=310,
},
SquircleOutline={
Image="rbxassetid://74029063732681",
Rect=Rect.new(512,512,512,512),
Radius=310,
},
SquircleGlass={
Image="rbxassetid://131126436897551",
Rect=Rect.new(512,512,512,512),
Radius=310,
},

["Squircle-TL-TR"]={
Image="rbxassetid://75712142040725",
Rect=Rect.new(512,512,512,512),
Radius=310,
AutoChange=false,
},
["Squircle-BL-BR"]={
Image="rbxassetid://83676684425544",
Rect=Rect.new(512,0,512,0),
Radius=310,
AutoChange=false,
},Square=
{
Image="rbxassetid://82909646051652",
Rect=Rect.new(512,512,512,512),
Radius=512,
AutoChange=false,
},
},
}

function d.Init(e,f)
b=f
return e.New
end

function d.New(e,f,g,h,i,j,l)
local m={
Radius=f or 0,
Type=g or"Circle",
GetRadius=nil,
GetType=nil,
SetRadius=nil,
SetType=nil,
SetLinkedCorners=nil,
}

local p={
["Glass-0.7"]="SquircleGlass",
["Glass-1"]="SquircleGlass",
["Glass-1.4"]="SquircleGlass",
["Squircle-Outline"]="SquircleOutline",
}

local function GetShape(r)
return d.Shapes[p[r]or r]or d.Shapes.Circle
end

local r=b.New(j and"ImageButton"or"ImageLabel",{
Image="",
ScaleType=l~=false and"Slice"or nil,
SliceCenter=m.Type~="Squircle"and Rect.new(512,512,512,512)or nil,
SliceScale=1,
ThemeTag=h and h.ThemeTag or nil,
BackgroundTransparency=1,
},i)

for u,v in next,h do
if not table.find({"ThemeTag"},u)then
r[u]=v
end
end

function m.SetRadius(u,v)
m.Radius=v
r.SliceScale=math.max(v/GetShape(m.Type).Radius,0.0001)
return m
end

local function ApplyType(u)
m.Type=u
local v=GetShape(u)
r.Image=v.Image
r.SliceCenter=v.Rect
m:SetRadius(m.Radius)
end

function m.SetType(u,v)
if m.LinkedCorners then
m.LinkedBaseType=v
return m
end

ApplyType(v)
return m
end

function m.SetLinkedCorners(u,v,x)
if v then
if not m.LinkedCorners then
m.LinkedBaseType=m.Type
end
m.LinkedCorners=v
ApplyType"Square"

local z=r:FindFirstChild"WindUILinkedCorner"
if not z then
z=b.New("UICorner",{
Name="WindUILinkedCorner",
Parent=r,
})
end
b.ApplyCornerRadii(z,x or m.Radius,v)
else
m.LinkedCorners=nil
ApplyType(m.LinkedBaseType or"Squircle")
m.LinkedBaseType=nil
local z=r:FindFirstChild"WindUILinkedCorner"
if z then
z:Destroy()
end
end
return m
end

function m.GetRadius(u)
return m.Radius
end

function m.GetType(u)
return m.Type
end

m:SetRadius(f)
m:SetType(g)
d.Wrappers[r]=m

b.AddSignal(r:GetPropertyChangedSignal"AbsoluteSize",function()
local u=GetShape(m.Type)
if u.AutoChange==false or m.LinkedCorners then
return
end

if string.find(m.Type,"Squircle")then
local v=string.find(m.Type,"Glass")and"Glass"or nil
local x=string.find(m.Type,"Outline")and"Outline"or nil

local z=math.round(r.AbsoluteSize.X/b.UIScale)
local A=math.round(r.AbsoluteSize.Y/b.UIScale)

local B=m.Radius~=0 and m.Radius or math.min(z,A)/2
local C=d.Shapes.Squircle.Radius/1024
local F=B/math.min(z,A)

local G

if z>A then
if F>=C then
G="SquircleH"..(x or v or"")
else
G="Squircle"..(x or v or"")
end
elseif z<A then
if F>=C then
G="SquircleV"..(x or v or"")
else
G="Squircle"..(x or v or"")
end
else
if F>=C then
G="Circle"..(x or v or"")
else
G="Squircle"..(x or v or"")
end
end

if G~=m:GetType()then
m:SetType(G)
end
end
end)

return r,m
end

function d.GetWrapper(e,f)
return d.Wrappers[f]
end

return d end function a.c()

local b=a.load'a'

local d=b(game:GetService"ReplicatedStorage")
local e=b(game:GetService"HttpService")
local f=b(game:GetService"RunService")

local g="https://article-hub-studio.github.io/WindUI-Skibidi/vendor/icons/Main-v2.lua"

local function LoadBaseIcons()
local h=d:FindFirstChild"GetIcons"
if
h
and h:IsA"RemoteFunction"
and(f:IsStudio()or h:GetAttribute"WindUIIcons"==true)
then
local i,j=pcall(function()
return h:InvokeServer()
end)
if i and typeof(j)=="table"then
return j
end
end

local i,j=pcall(function()
if game.HttpGet then
return game:HttpGet(g)
end
return e:GetAsync(g)
end)
if i and type(j)=="string"and type(loadstring)=="function"then
local l=loadstring(j)
if l then
local m,p=pcall(l)
if m and typeof(p)=="table"then
return p
end
end
end

warn"[ WindUI.Icons ] Unable to load the base icon catalog; custom sources remain available"
return{}
end

local h=LoadBaseIcons()
h.AdapterVersion=3

local i={
lucidev="lucide",
lucideicons="lucide",
sf="sfsymbols",
sfsymbol="sfsymbols",
sf_symbols="sfsymbols",
gravityui="gravity",
gravity_ui="gravity",
}

h.Icons=if typeof(h.Icons)=="table"then h.Icons else{}
h.IconsType=h.IconsType or"lucide"
h.SourceAliases=if typeof(h.SourceAliases)=="table"then h.SourceAliases else{}
h.Resolvers=if typeof(h.Resolvers)=="table"then h.Resolvers else{}
h.FallbackAcrossSources=h.FallbackAcrossSources~=false

for j,l in i do
if h.SourceAliases[j]==nil then
h.SourceAliases[j]=l
end
end

local j

local function NormalizeSourceName(l)
if type(l)~="string"then
return nil
end

local m=l:lower():gsub("%s+",""):gsub("[^%w_%-]","")
if m==""then
return nil
end
return m
end

local function ResolveSourceAlias(l)
local m=NormalizeSourceName(l)
local p={}

for r=1,8 do
if not m or p[m]then
break
end
p[m]=true

local u=h.SourceAliases[m]
if not u then
break
end
m=NormalizeSourceName(u)
end

return m
end

local function NormalizeImage(l)
if type(l)=="number"then
return"rbxassetid://"..tostring(l)
end
if type(l)~="string"then
return nil
end

if l:match"^%d+$"then
return"rbxassetid://"..l
end
return l
end

local function IsDirectImage(l)
if type(l)=="number"then
return true
end
if type(l)~="string"then
return false
end

return l:match"^%d+$"~=nil
or l:match"^rbxassetid://"~=nil
or l:match"^rbxthumb://"~=nil
or l:match"^rbxgameasset://"~=nil
or l:match"^https?://"~=nil
end

local function NormalizeVector2(l)
if typeof(l)=="Vector2"then
return l
end
if typeof(l)=="table"then
return Vector2.new(tonumber(l.X or l.x or l[1])or 0,tonumber(l.Y or l.y or l[2])or 0)
end
return Vector2.zero
end

local function NormalizeDescriptor(l)
if IsDirectImage(l)then
return{
Image=NormalizeImage(l),
ImageRectSize=Vector2.zero,
ImageRectPosition=Vector2.zero,
Parts=nil,
}
end

if typeof(l)~="table"then
return nil
end

local m=l.Image or l.Asset or l.AssetId or l.Id or l.URL or l.Url
if not IsDirectImage(m)then
return nil
end

return{
Image=NormalizeImage(m),
ImageRectSize=NormalizeVector2(l.ImageRectSize or l.RectSize or l.Size),
ImageRectPosition=NormalizeVector2(
l.ImageRectPosition or l.ImageRectOffset or l.RectPosition or l.Offset
),
Parts=l.Parts,
}
end

local function ParseIconReference(l)
if typeof(l)=="table"then
return l.Source or l.Pack or l.Library or l.Type,l.Name or l.Icon or l.Key,l
end

if type(l)~="string"or IsDirectImage(l)then
return nil,l,l
end

local m,p=l:match"^@([%w_%-]+)/(.+)$"
if not m then
m,p=l:match"^([%w_%-]+):(.+)$"
end
if not m then
m,p=l:match"^([%w_%-]+)/(.+)$"
end

return m,p or l,l
end

local function FindSource(l)
local m=ResolveSourceAlias(l)
if not m then
return nil,nil
end

if h.Icons[m]then
return h.Icons[m],m
end

for p,r in h.Icons do
if NormalizeSourceName(p)==m then
return r,p
end
end

return nil,m
end

local function GetSourceNames()
local l={}
for m in h.Icons do
table.insert(l,tostring(m))
end
table.sort(l,function(m,p)
return m:lower()<p:lower()
end)
return l
end

local l

local function ResolvePackIcon(m,p,r)
if typeof(m)~="table"or p==nil then
return nil
end

local u=if typeof(m.Icons)=="table"then m.Icons else m
local v=u[p]
if v==nil then
local x=tostring(p):lower()
for z,A in u do
if tostring(z):lower()==x then
v=A
break
end
end
end

if typeof(v)=="table"and v.Alias then
return l(v.Alias,nil,(r or 0)+1)
end

local x=typeof(v)=="table"
and(v.Image or v.Asset or v.AssetId or v.Id or v.URL or v.Url)
or v
local z=NormalizeDescriptor(v)
if not z then
return nil
end

if typeof(m.Spritesheets)=="table"then
z.Image=m.Spritesheets[x]
or m.Spritesheets[tostring(x)]
or m.Spritesheets[z.Image]
or m.Spritesheets[tostring(z.Image)]
or z.Image
end

return z
end

local function ResolveProviderIcon(m,p)
local r=h.Resolvers[ResolveSourceAlias(m)]
if typeof(r)~="function"then
return nil
end

local u,v=pcall(r,p,m)
if not u then
warn(string.format("[ WindUI.Icons ] Source '%s' failed: %s",tostring(m),tostring(v)))
return nil
end

return NormalizeDescriptor(v)
end

l=function(m,p,r)
if(r or 0)>8 then
return nil
end

local u=NormalizeDescriptor(m)
if u then
return u
end

local v,x,z=ParseIconReference(m)
if typeof(z)=="table"and z.Alias then
return l(z.Alias,p,(r or 0)+1)
end

local A=ResolveSourceAlias(v or p or h.IconsType)
if A then
local B=FindSource(A)
local C=ResolvePackIcon(B,x,r)or ResolveProviderIcon(A,x)
if C then
return C
end
end

if v or not h.FallbackAcrossSources then
return nil
end

for B,C in GetSourceNames()do
if ResolveSourceAlias(C)~=A then
local F=ResolvePackIcon(h.Icons[C],x,r)
if F then
return F
end
end
end

for B,C in h.Resolvers do
if B~=A and typeof(C)=="function"then
local F=ResolveProviderIcon(B,x)
if F then
return F
end
end
end

return nil
end

local function FormatDescriptor(m,p)
if not m then
return nil
end

if p==false and m.ImageRectSize==Vector2.zero and not m.Parts then
return m.Image
end

return{m.Image,m}
end

function h.AddSourceAlias(m,p)
local r=NormalizeSourceName(m)
local u=NormalizeSourceName(p)
assert(r and u,"AddSourceAlias: alias and source must be non-empty strings")
h.SourceAliases[r]=u
return h
end

function h.RegisterIconSource(m,p,r)
local u=NormalizeSourceName(m)
assert(u,"RegisterIconSource: source must be a non-empty string")

if typeof(p)=="function"then
h.Resolvers[u]=p
elseif typeof(p)=="table"then
h.AddIcons(u,p)
else
error"RegisterIconSource: provider must be a function or icon table"
end

if typeof(r)=="table"then
for v,x in r.Aliases or{}do
h.AddSourceAlias(x,u)
end
end

return h
end

function h.AddIcons(m,p)
local r=NormalizeSourceName(m)
assert(r and typeof(p)=="table","AddIcons: packName must be string and iconsData must be table")

local u=h.Icons[r]
if typeof(u)~="table"or typeof(u.Icons)~="table"then
u={
Icons={},
Spritesheets={},
}
h.Icons[r]=u
end

for v,x in p do
local z=NormalizeDescriptor(x)
if z then
u.Icons[v]=z
u.Spritesheets[z.Image]=z.Image
elseif typeof(x)=="table"and x.Alias then
u.Icons[v]={Alias=x.Alias}
else
warn(string.format("[ WindUI.Icons ] Ignored invalid icon '%s:%s'",r,tostring(v)))
end
end

return h
end

h.RegisterIconPack=h.AddIcons
h.AddIconSource=h.RegisterIconSource

function h.AddIcon(m,p,r)
return h.AddIcons(m,{[p]=r})
end

function h.SetIconsType(m)
local p=ResolveSourceAlias(m)
assert(p,"SetIconsType: icon type must be a non-empty string")
h.IconsType=p
return h
end

function h.GetIconSources()
local m=GetSourceNames()
for p in h.Resolvers do
if not table.find(m,p)then
table.insert(m,p)
end
end
table.sort(m)
return m
end

function h.HasIcon(m,p)
return l(m,p,0)~=nil
end

function h.Init(m,p)
h.New=m
h.IconThemeTag=p
j=m
return h
end

function h.Icon(m,p,r)
return FormatDescriptor(l(m,p,0),r~=false)
end

function h.GetIcon(m,p)
return h.Icon(m,p,false)
end

function h.Icon2(m,p)
return h.Icon(m,p,true)
end

local function ResolveStyle(m,p,r)
local u=m[p]
if u==nil then
u=m[1]
end
if u==nil then
u=r
end

return{
ThemeTag=typeof(u)=="string"and u or nil,
Color=typeof(u)=="Color3"and u or nil,
Value=typeof(u)=="number"and u or nil,
}
end

local function CreateImageLabel(m)
if j then
return j("ImageLabel",m)
end

local p=Instance.new"ImageLabel"
for r,u in m do
if r~="ThemeTag"and u~=nil then
p[r]=u
end
end
return p
end

function h.Image(m)
m=if typeof(m)=="table"then m else{}
local p={
Icon=m.Icon,
Type=m.Type,
Colors=m.Colors or{h.IconThemeTag or Color3.new(1,1,1)},
Transparency=m.Transparency or{0},
Size=m.Size or UDim2.fromOffset(24,24),
IconFrame=nil,
}

local r=h.Icon2(p.Icon,p.Type)
local u=r and r[1]or""
local v=r and r[2]
or{
ImageRectSize=Vector2.zero,
ImageRectPosition=Vector2.zero,
}
local x=ResolveStyle(p.Colors,1,h.IconThemeTag or Color3.new(1,1,1))
local z=ResolveStyle(p.Transparency,1,0)

local A=CreateImageLabel{
Name="Icon",
Size=p.Size,
BackgroundTransparency=1,
ImageColor3=x.Color,
ImageTransparency=z.Value,
ThemeTag=x.ThemeTag and{
ImageColor3=x.ThemeTag,
ImageTransparency=z.ThemeTag,
}or nil,
Image=u,
ImageRectSize=v.ImageRectSize,
ImageRectOffset=v.ImageRectPosition,
}

local B=ParseIconReference(p.Icon)
for C,F in v.Parts or{}do
local G=h.Icon2(F,B or p.Type)
if G then
local H=ResolveStyle(p.Colors,C+1,x.Color or x.ThemeTag)
local J=ResolveStyle(p.Transparency,C+1,z.Value or 0)
CreateImageLabel{
Name="Part"..tostring(C),
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
ImageColor3=H.Color,
ImageTransparency=J.Value,
ThemeTag=H.ThemeTag and{
ImageColor3=H.ThemeTag,
ImageTransparency=J.ThemeTag,
}or nil,
Image=G[1],
ImageRectSize=G[2].ImageRectSize,
ImageRectOffset=G[2].ImageRectPosition,
Parent=A,
}
end
end

p.IconFrame=A
return p
end

return h end function a.d()

return function(b)
return{


Primary="Icon",

White=Color3.new(1,1,1),
Black=Color3.new(0,0,0),

Dialog="Accent",

Background="Accent",
BackgroundTransparency=0,
Hover="Text",

PanelBackground="White",
PanelBackgroundTransparency=0.95,

WindowBackground="Background",

WindowShadow="Black",


WindowTopbarTitle="Text",
WindowTopbarAuthor="Text",
WindowTopbarIcon="Icon",
WindowTopbarButtonIcon="Icon",


WindowSearchBarBackground="Dialog",

TabBackground="Hover",
TabBackgroundHover="Hover",
TabBackgroundHoverTransparency=0.97,
TabBackgroundActive="Hover",
TabBackgroundActiveTransparency=0.93,
TabText="Text",
TabTextTransparency=0.3,
TabTextTransparencyActive=0,
TabTitle="Text",
TabIcon="Icon",
TabIconTransparency=0.4,
TabIconTransparencyActive=0.1,
TabBorderTransparency=1,
TabBorderTransparencyActive=0.75,
TabBorder="White",

ElementBackground="Text",
ElementBackgroundTransparency=0.93,
ElementBackgroundHover=b:AddColor("ElementBackground","#ffffff",0.1),
ElementTitle="Text",
ElementDesc="Text",
ElementIcon="Icon",

RadioGroupBackground="ElementBackground",
RadioGroupText="Text",
RadioGroupBorder="Text",
RadioGroupActive="Primary",

CheckboxGroupBackground="ElementBackground",
CheckboxGroupText="Text",
CheckboxGroupBorder="Text",
CheckboxGroupActive="Primary",
CheckboxGroupIcon="White",

SegmentedControlBackground="ElementBackground",
SegmentedControlActive="Primary",
SegmentedControlText="Text",

StepperButton="ElementBackground",
StepperValueBackground="ElementBackground",
StepperIcon="Icon",
StepperText="Text",

BadgeBackground="Primary",
BadgeText="White",
BadgeIcon="White",

KeyValueIcon="Icon",
ChipListBackground="ElementBackground",
TimelineLine="Text",
AccordionBackground="ElementBackground",
AccordionIcon="Icon",
TabBoxTabBackground="ElementBackground",
TabBoxIcon="Icon",
EmptyStateIcon="Icon",
DiscordCardBackground="ElementBackground",
DiscordCardAccent="Primary",
Path2DBackground="ElementBackground",
Path2DTrack="ElementBackground",
Path2DLine="Primary",
Path2DMarker="Primary",
Path2DLabel="Text",

PopupBackground="Background",
PopupBackgroundTransparency="BackgroundTransparency",
PopupTitle="Text",
PopupContent="Text",
PopupIcon="Icon",

DialogBackground="Dialog",
DialogBackgroundTransparency="BackgroundTransparency",
DialogTitle="Text",
DialogContent="Text",
DialogIcon="Icon",

Toggle="Button",
ToggleBar="White",

Checkbox="Primary",
CheckboxIcon="White",
CheckboxBorder="White",
CheckboxBorderTransparency=0.75,

SliderIcon="Icon",

Slider="Primary",
SliderThumb="White",
SliderIconFrom="SliderIcon",
SliderIconTo="SliderIcon",

ProgressBar="Primary",
ProgressBarTrack="Text",
ProgressBarTrackTransparency=0.9,
ProgressBarText="Text",

Tooltip=Color3.fromHex"4C4C4C",
TooltipText="White",
TooltipSecondary="Primary",
TooltipSecondaryText="White",

TabSectionIcon="Icon",

SectionIcon="Icon",

SectionExpandIcon="Icon",
SectionExpandIconTransparency=0.4,
SectionBox="Text",
SectionBoxTransparency=0.95,
SectionBoxBorder="White",
SectionBoxBorderTransparency=0.75,
SectionBoxBackground="Text",
SectionBoxBackgroundTransparency=0.97,

SearchBarBorder="White",
SearchBarBorderTransparency=0.75,

Notification="Dialog",
NotificationTransparency=0.08,
NotificationGlass="Dialog",
NotificationGlassTransparency=0.28,
NotificationGlassSurface="White",
NotificationGlassSurfaceTransparency=0.91,
NotificationGlassHighlight="White",
NotificationGlassTextureTransparency=0.78,
Notification2="White",
Notification2Transparency=0.985,
NotificationTitle="Text",
NotificationTitleTransparency=0,
NotificationContent="Text",
NotificationContentTransparency=0.32,
NotificationDuration="White",
NotificationDurationTransparency=0.94,
NotificationBorder="White",
NotificationBorderTransparency=0.76,

DropdownTabBorder="White",
DropdownTabBackground="ElementBackground",
DropdownBackground="Background",

LabelBackground="White",
LabelBackgroundTransparency=0.95,

ViewportBackground="ElementBackground",
ViewportBackgroundTransparency="ElementBackgroundTransparency",
}
end end function a.e()

local b=a.load'a'

local d=b(game:GetService"RunService")
local e=b(game:GetService"UserInputService")
local f=b(game:GetService"TweenService")
local g=b(game:GetService"LocalizationService")
local h=b(game:GetService"HttpService")

local i=a.load'b'
local j=a.load'c'local l=

d.Heartbeat

j.SetIconsType"lucide"

local m

local p
p={
Font="rbxassetid://12187365364",
Localization=nil,
CanDraggable=true,
Theme=nil,
Themes=nil,
Icons=j,
IconAdapterVersion=j.AdapterVersion or 1,
Signals={},
Objects={},
LocalizationObjects={},
UIScale=1,
FontObjects={},
Language=string.match(g.SystemLocaleId,"^[a-z]+"),
Request=http_request or(syn and syn.request)or request,
DefaultProperties={
ScreenGui={
ResetOnSpawn=false,
ZIndexBehavior="Sibling",
},
CanvasGroup={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
Frame={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
TextLabel={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
RichText=true,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
AutoButtonColor=false,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextBox={
BackgroundColor3=Color3.new(1,1,1),
BorderColor3=Color3.new(0,0,0),
ClearTextOnFocus=false,
Text="",
TextColor3=Color3.new(0,0,0),
TextSize=14,
},
ImageLabel={
BackgroundTransparency=1,
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
},
ImageButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AutoButtonColor=false,
},
UIListLayout={
SortOrder="LayoutOrder",
},
ScrollingFrame={
ScrollBarImageTransparency=1,
BorderSizePixel=0,
},
VideoFrame={
BorderSizePixel=0,
},
},
Colors={
Red="#e53935",
Orange="#f57c00",
Green="#43a047",
Blue="#039be5",
White="#ffffff",
Grey="#484848",
},
ThemeFallbacks=nil,





















ThemeChangeCallbacks={},
}

function p.Init(r)
m=r

p.ThemeFallbacks=a.load'd'(p)

p.UIScale=r.UIScale

i:Init(p)
end

function p.AddSignal(r,u)
local v=r:Connect(u)
table.insert(p.Signals,v)
return v
end

function p.DisconnectSignal(r)
if not r then
return
end

local u=table.find(p.Signals,r)
if u then
table.remove(p.Signals,u)
end

r:Disconnect()
end

function p.DisconnectAll()
for r=#p.Signals,1,-1 do
local u=p.Signals[r]
p.Signals[r]=nil

if u then
u:Disconnect()
end
end

table.clear(p.Signals)
end

function p.SafeCallback(r,...)
if not r then
return
end

local u,v=pcall(r,...)
if not u then
if m and m.Window and m.Window.Debug then local
x, z=v:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..v)

return m:Notify{
Title="DEBUG Mode: Error",
Content=not z and v or v:sub(z+1),
Style="Error",
Duration=8,
}
end
end
end

function p.Gradient(r,u)
if m and m.Gradient then
return m:Gradient(r,u)
end

local v={}
local x={}

for z,A in next,r do
local B=tonumber(z)
if B then
B=math.clamp(B/100,0,1)
table.insert(v,ColorSequenceKeypoint.new(B,A.Color))
table.insert(x,NumberSequenceKeypoint.new(B,A.Transparency or 0))
end
end

table.sort(v,function(z,A)
return z.Time<A.Time
end)
table.sort(x,function(z,A)
return z.Time<A.Time
end)

if#v<2 then
error"ColorSequence requires at least 2 keypoints"
end

local z={
Color=ColorSequence.new(v),
Transparency=NumberSequence.new(x),
}

if u then
for A,B in pairs(u)do
z[A]=B
end
end

return z
end

function p.SetTheme(r)
if typeof(r)~="table"then
r=p.Theme or(p.Themes and p.Themes.Dark)
end
if typeof(r)~="table"then
return nil
end

local u=p.Theme
p.Theme=r
p.UpdateTheme(nil,false)

for v,x in next,p.ThemeChangeCallbacks do
p.SafeCallback(x,r,u)
end

return r
end

function p.AddFontObject(r)
table.insert(p.FontObjects,r)
p.UpdateFont(p.Font)
end

function p.UpdateFont(r)
p.Font=r
for u,v in next,p.FontObjects do
v.FontFace=Font.new(r,v.FontFace.Weight,v.FontFace.Style)
end
end

function p.GetThemeProperty(r,u)
local function getValue(v,x)
if typeof(x)~="table"then
return nil
end

local z=x[v]

if z==nil then
return nil
end

if typeof(z)=="string"and string.sub(z,1,1)=="#"then
return Color3.fromHex(z)
end

if typeof(z)=="Color3"then
return z
end

if typeof(z)=="number"then
return z
end

if typeof(z)=="table"and z.Color and z.Transparency then
return z
end

if typeof(z)=="function"then
return z(x)
end

return z
end

u=if typeof(u)=="table"then u else p.Theme

local v=getValue(r,u)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local x=p.GetThemeProperty(v,u)
if x~=nil then
return x
end
else
return v
end
end

local x=p.ThemeFallbacks and p.ThemeFallbacks[r]
if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,u)
else
return getValue(r,{[r]=x})
end
end

local z=p.Themes and p.Themes.Dark
v=getValue(r,z)
if v~=nil then
if typeof(v)=="string"and string.sub(v,1,1)~="#"then
local A=p.GetThemeProperty(v,z)
if A~=nil then
return A
end
else
return v
end
end

if x~=nil then
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
return p.GetThemeProperty(x,z)
else
return getValue(r,{[r]=x})
end
end

return nil
end

function p.AddThemeObject(r,u,v)
if p.Objects[r]then
for x,z in pairs(u)do
p.Objects[r].Properties[x]=z
end
else
p.Objects[r]={Object=r,Properties=u}
end

if not v then
p.UpdateTheme(r,false)
end
return r
end








function p.RemoveThemeProperty(r,u)
local v=p.Objects[r]
if v and v.Properties then
v.Properties[u]=nil
end
return r
end

function p.AddLangObject(r)
local u=p.LocalizationObjects[r]
if not u then
return
end

local v=u.Object

p.SetLangForObject(r)

return v
end

function p.UpdateTheme(r,u,v,x,z,A)
local function ApplyTheme(B)
for C,F in pairs(B.Properties or{})do
local G=p.GetThemeProperty(F,p.Theme)
if G~=nil then
if typeof(G)=="Color3"then
local H=B.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end

if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=G},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=G}):Play()
else
B.Object[C]=G
end
elseif typeof(G)=="table"and G.Color and G.Transparency then
B.Object[C]=Color3.new(1,1,1)

local H=B.Object:FindFirstChild"LibraryGradient"
if not H then
H=Instance.new"UIGradient"
H.Name="LibraryGradient"
H.Parent=B.Object
end

H.Color=G.Color
H.Transparency=G.Transparency

for J,L in pairs(G)do
if J~="Color"and J~="Transparency"and H[J]~=nil then
H[J]=L
end
end
elseif typeof(G)=="number"then
if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=G},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=G}):Play()
else
B.Object[C]=G
end
end
else
local H=B.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end
end
end
end

if r then
local B=p.Objects[r]
if B then
ApplyTheme(B)
end
else
for B,C in pairs(p.Objects)do
ApplyTheme(C)
end
end
end

function p.SetThemeTag(r,u,v,x,z)
p.AddThemeObject(r,u)
p.UpdateTheme(r,false,true,v,x,z)
end

function p.SetLangForObject(r)
if p.Localization and p.Localization.Enabled then
local u=p.LocalizationObjects[r]
if not u then
return
end

local v=u.Object
local x=u.TranslationId

local z=p.Localization.Translations[p.Language]
if z and z[x]then
v.Text=z[x]
else
local A=p.Localization
and p.Localization.Translations
and p.Localization.Translations.en
or nil
if A and A[x]then
v.Text=A[x]
else
v.Text="["..x.."]"
end
end
end
end

function p.ChangeTranslationKey(r,u,v)
if p.Localization and p.Localization.Enabled then
local x=string.match(v,"^"..p.Localization.Prefix.."(.+)")
if x then
for z,A in ipairs(p.LocalizationObjects)do
if A.Object==u then
A.TranslationId=x
p.SetLangForObject(z)
return
end
end

table.insert(p.LocalizationObjects,{
TranslationId=x,
Object=u,
})
p.SetLangForObject(#p.LocalizationObjects)
end
end
end

function p.UpdateLang(r)
if r then
p.Language=r
end

for u=1,#p.LocalizationObjects do
local v=p.LocalizationObjects[u]
if v.Object and v.Object.Parent~=nil then
p.SetLangForObject(u)
else
p.LocalizationObjects[u]=nil
end
end
end

function p.SetLanguage(r)
p.Language=r
p.UpdateLang()
end

function p.Icon(r,u)
return j.Icon(r,nil,u~=false)
end

function p.AddIcons(r,u)
return j.AddIcons(r,u)
end

function p.AddIcon(r,u,v)
return j.AddIcon(r,u,v)
end

function p.RegisterIconSource(r,u,v)
return j.RegisterIconSource(r,u,v)
end

p.RegisterIconPack=p.AddIcons
p.AddIconSource=p.RegisterIconSource

function p.AddIconSourceAlias(r,u)
return j.AddSourceAlias(r,u)
end

function p.SetIconSource(r)
return j.SetIconsType(r)
end

function p.GetIconSources()
return j.GetIconSources()
end

function p.HasIcon(r,u)
return j.HasIcon(r,u)
end

function p.New(r,u,v)
local x=Instance.new(r)

for z,A in next,p.DefaultProperties[r]or{}do
x[z]=A
end

for z,A in next,u or{}do
if z~="ThemeTag"then
x[z]=A
end
if p.Localization and p.Localization.Enabled and z=="Text"then
local B=string.match(A,"^"..p.Localization.Prefix.."(.+)")
if B then
local C=#p.LocalizationObjects+1
p.LocalizationObjects[C]={TranslationId=B,Object=x}

p.SetLangForObject(C)
end
end
end

for z,A in next,v or{}do
A.Parent=x
end

if u and u.ThemeTag then
p.AddThemeObject(x,u.ThemeTag)
end
if u and u.FontFace then
p.AddFontObject(x)
end
return x
end

function p.Tween(r,u,v,...)
return f:Create(r,TweenInfo.new(u,...),v)
end

function p.ClampTransparency(r,u)
local v=tonumber(r)
if v==nil then
return u
end

return math.clamp(v,0,1)
end

function p.ToUDimRadius(r,u)
if typeof(r)=="UDim"then
return r
end
if type(r)=="number"then
return UDim.new(0,math.max(r,0))
end

if typeof(u)=="UDim"then
return u
end

return UDim.new(0,tonumber(r)or tonumber(u)or 0)
end

function p.ApplyCornerRadii(r,u,v)
if typeof(r)~="Instance"or not r:IsA"UICorner"then
return r
end

local x=p.ToUDimRadius(u,r.CornerRadius)
local z=v
or{
TopLeft=true,
TopRight=true,
BottomLeft=true,
BottomRight=true,
}
local function ResolveCorner(A)
if A==false then
return UDim.new(0,0)
end
if typeof(A)=="UDim"then
return A
end
if type(A)=="number"then
return UDim.new(0,math.max(A,0))
end
return x
end

r.CornerRadius=x

pcall(function()
r.TopLeftRadius=ResolveCorner(z.TopLeft)
r.TopRightRadius=ResolveCorner(z.TopRight)
r.BottomRightRadius=ResolveCorner(z.BottomRight)
r.BottomLeftRadius=ResolveCorner(z.BottomLeft)
end)

return r
end

function p.CreateUIShadow(r,u)
local v
local x=pcall(function()
v=Instance.new"UIShadow"
for x,z in u or{}do
if x~="Parent"and x~="ThemeTag"then
v[x]=z
end
end
v.Parent=r or(u and u.Parent)
end)

if not x then
if v then
v:Destroy()
end
return nil
end

if u and u.ThemeTag then
p.AddThemeObject(v,u.ThemeTag)
end

return v
end

function p.ApplyLinkedCornerSurface(r,u,v,x)
if typeof(r)~="Instance"or not r:IsA"GuiObject"then
return nil
end

local z=i:GetWrapper(r)
if z and z.SetLinkedCorners then
z:SetLinkedCorners(x and v or nil,u)
return z
end

local A=r:FindFirstChild"WindUILinkedCorner"
local B=A or r:FindFirstChildWhichIsA"UICorner"
if not x then
if A then
A:Destroy()
elseif B then
p.ApplyCornerRadii(B,u,p.DefaultCornerMap())
end
return nil
end

A=B
if not A then
A=p.New("UICorner",{
Name="WindUILinkedCorner",
Parent=r,
})
end
p.ApplyCornerRadii(A,u,v)
return A
end

function p.DefaultCornerMap()
return{
TopLeft=true,
TopRight=true,
BottomLeft=true,
BottomRight=true,
}
end

function p.GetLinkedCornerDirection(r,u,v)
if typeof(v)=="table"then
local x=tostring(v.Orientation or v.Direction or""):lower()
if x=="horizontal"or x=="row"or x=="x"then
return true
elseif x=="vertical"or x=="column"or x=="y"then
return false
end
end

local x=u or(r and r.__type)

if x=="Group"then
return true
end

if x=="HStack"then
if r and r.IsStacked==true then
return false
end

local z=r and r.ElementFrame
local A=z and z:FindFirstChildWhichIsA"UIListLayout"
if A then
return A.FillDirection==Enum.FillDirection.Horizontal
end

return true
end

return false
end

function p.GetLinkedCornerShape(r,u,v,x,z)
return p:GetElementPosition(
r,
u,
p.GetLinkedCornerDirection(v,x,z),
z
)
end








































































function p.NewRoundFrame(r,u,v,x,z,A)
return i:New(r,u,v,x,z,nil)
end

local r=p.New local u=
p.Tween

function p.SetDraggable(v)
p.CanDraggable=v
end

function p.Drag(v,x,z)
local A=m.GenerateGUID()

local B
local C=false
local F,G
local H
local J={}

local L={
CanDraggable=true,
}

if not x or typeof(x)~="table"then
x={v}
end

local function TrackConnection(M,N)
local O=p.AddSignal(M,N)
table.insert(J,O)
return O
end

local function StopDragging()
if m and m.CurrentInput==A then
m.CurrentInput=nil
end

local M=C
C=false
H=nil
B=nil

if M and z and typeof(z)=="function"then
z(false,nil)
end
end

local function update(M)
if not C or not p.CanDraggable or not L.CanDraggable then
return
end

local N=M.Position-F
p.Tween(v,0.02,{
Position=UDim2.new(
G.X.Scale,
G.X.Offset+N.X,
G.Y.Scale,
G.Y.Offset+N.Y
),
}):Play()
end

for M,N in pairs(x)do
TrackConnection(N.InputBegan,function(O)
if not p.CanDraggable or not L.CanDraggable or C then
return
end

if
O.UserInputType==Enum.UserInputType.MouseButton1
or O.UserInputType==Enum.UserInputType.Touch
then
if m and m.CurrentInput and m.CurrentInput~=A then
return
end

m.CurrentInput=A

C=true
H=O
B=N
F=O.Position
G=v.Position

if z and typeof(z)=="function"then
z(true,B)
end
end
end)
end

TrackConnection(e.TouchEnded,function(M)
if H and H.UserInputType==Enum.UserInputType.Touch then
if M==H then
StopDragging()
end
end
end)

TrackConnection(e.InputChanged,function(M)
if not C then
return
end
if m.CurrentInput and m.CurrentInput~=A then
return
end

if H.UserInputType==Enum.UserInputType.MouseButton1 then
if M.UserInputType==Enum.UserInputType.MouseMovement then
update(M)
end
elseif H.UserInputType==Enum.UserInputType.Touch then
if M==H then
update(M)
end
end
end)

TrackConnection(e.InputEnded,function(M)
if not C or m.CurrentInput~=A then
return
end

if
M==H
or(
H.UserInputType==Enum.UserInputType.MouseButton1
and M.UserInputType==Enum.UserInputType.MouseButton1
)
then
StopDragging()
end
end)

function L.Set(M,N)
L.CanDraggable=N~=false
if not L.CanDraggable then
StopDragging()
end
end

function L.Destroy(M)
StopDragging()

for N=#J,1,-1 do
p.DisconnectSignal(J[N])
J[N]=nil
end

table.clear(J)
end

return L
end

j.Init(r,"Icon")

function p.SanitizeFilename(v)
local x=v:match"([^/]+)$"or v

x=x:gsub("%.[^%.]+$","")

x=x:gsub("[^%w%-_]","_")

if#x>50 then
x=x:sub(1,50)
end

return x
end

p.SupportsDirectImageLabel=true

function p.Image(v,x,z,A,B,C,F,G,H)
local J=if typeof(A)=="table"then A.Folder else A
J=tostring(J or"Temp")
x=p.SanitizeFilename(tostring(x or"Image"))
B=tostring(B or"Image")
H=H==true

if H and typeof(v)=="table"then
v=v.Image or v.Asset or v.AssetId or v.Id or v.Url or v.URL
end

local L=type(v)=="string"
and v:match"^https?://"~=nil
and v:find("roblox.com",1,true)==nil
local M=if H
or L
or typeof(v)=="Instance"
then nil
else p.Icon(v)
local N=(M or F)and C and(G or"Icon")or nil

local O=r("ImageLabel",{
Name="ImageLabel",
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
ScaleType=Enum.ScaleType.Crop,
ThemeTag=N and{
ImageColor3=N,
}or nil,
},{
r("UICorner",{
CornerRadius=UDim.new(0,tonumber(z)or 0),
}),
})
local P=if H
then O
else r("Frame",{
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
},{
O,
})

if typeof(v)=="Instance"then
if H then
local Q=if v:IsA"ImageLabel"or v:IsA"ImageButton"
then v
else v:FindFirstChildWhichIsA("ImageLabel",true)or v:FindFirstChildWhichIsA(
"ImageButton",
true
)
if Q then
O.Image=Q.Image
O.ImageRectOffset=Q.ImageRectOffset
O.ImageRectSize=Q.ImageRectSize
O.ImageColor3=Q.ImageColor3
O.ImageTransparency=Q.ImageTransparency
else
P.Visible=false
end
else
O:Destroy()
local Q=v:Clone()
Q.Name="ImageLabel"
if Q:IsA"GuiObject"then
Q.Size=UDim2.fromScale(1,1)
Q.Position=UDim2.fromScale(0.5,0.5)
Q.AnchorPoint=Vector2.new(0.5,0.5)
end
Q.Parent=P
end
elseif M then
O:Destroy()
local Q=j.Image{
Icon=v,
Size=UDim2.fromScale(1,1),
Colors={
N or false,
"Button",
},
}.IconFrame
Q.Name="ImageLabel"
Q.Parent=P
elseif L then
local Q="WindUI/"..J.."/assets/."..B.."-"..x..".png"
local R,S=pcall(function()
task.spawn(function()
local R=p.Request and p.Request{
Url=v,
Method="GET",
}or nil
local S=typeof(R)=="table"and R.Body or R

if S and writefile then
writefile(Q,S)
end

local T,U=pcall(getcustomasset,Q)
if T then
O.Image=U
elseif not T then
warn(string.format("[ WindUI.Creator ] Failed to load '%s': %s",Q,tostring(U)))
end
end)
end)

if not R then
warn(string.format("[ WindUI.Creator ] URL image is unavailable: %s",tostring(S)))
P.Visible=false
end
elseif v==nil or v==""then
P.Visible=false
elseif type(v)=="number"then
O.Image="rbxassetid://"..tostring(v)
elseif type(v)=="string"then
O.Image=v
else
warn(string.format("[ WindUI.Creator ] Unsupported image value: %s",typeof(v)))
P.Visible=false
end

return P
end

function p.Color3ToHSB(v)
local x,z,A=v.R,v.G,v.B
local B=math.max(x,z,A)
local C=math.min(x,z,A)
local F=B-C

local G=0
if F~=0 then
if B==x then
G=(z-A)/F%6
elseif B==z then
G=(A-x)/F+2
else
G=(x-z)/F+4
end
G=G*60
else
G=0
end

local H=(B==0)and 0 or(F/B)
local J=B

return{
h=math.floor(G+0.5),
s=H,
b=J,
}
end

function p.GetPerceivedBrightness(v)
local x=v.R
local z=v.G
local A=v.B
return 0.299*x+0.587*z+0.114*A
end

function p.GetTextColorForHSB(v,x)
local z=p.Color3ToHSB(v)local
A, B, C=z.h, z.s, z.b
if p.GetPerceivedBrightness(v)>(x or 0.5)then
return Color3.fromHSV(A/360,0,0.05)
else
return Color3.fromHSV(A/360,0,0.98)
end
end

function p.GetAverageColor(v)
local x,z,A=0,0,0
local B=v.Color.Keypoints
for C,F in ipairs(B)do

x=x+F.Value.R
z=z+F.Value.G
A=A+F.Value.B
end
local C=#B
return Color3.new(x/C,z/C,A/C)
end

function p.GenerateUniqueID(v)
return h:GenerateGUID(false)
end

function p.OnThemeChange(v,x)
if typeof(x)~="function"then
return
end

local z=h:GenerateGUID(false)
p.ThemeChangeCallbacks[z]=x

return{
Disconnect=function()
p.ThemeChangeCallbacks[z]=nil
end,
}
end

function p.AddColor(v,x,z,A)
A=math.clamp(A or 1,0,1)
if typeof(z)=="string"then
z=Color3.fromHex(z)
end

return function(B)
local C
if typeof(x)=="string"and string.sub(x,1,1)~="#"then
C=p.GetThemeProperty(x,B)
elseif typeof(x)=="string"then
C=Color3.fromHex(x)
else
C=x
end

if not C or typeof(C)~="Color3"then
return nil
end

return Color3.new(
math.clamp(C.R+z.R*A,0,1),
math.clamp(C.G+z.G*A,0,1),
math.clamp(C.B+z.B*A,0,1)
)
end
end

function p.GetElementPosition(v,x,z,A,B)
B=if typeof(B)=="table"then B else{}
if type(z)~="number"or z~=math.floor(z)then
return"Squircle",p.DefaultCornerMap(),{Position="Single",Count=1}
end

local C=x and x[z]
if C==nil then
return"Squircle",p.DefaultCornerMap(),{Position="Single",Count=1}
end

local F=if B.IncludeDefaultBreaks==false
then{}
else{
Divider=true,
Space=true,
Section=true,
}
if typeof(B.BreakTypes)=="table"then
for G,H in B.BreakTypes do
if type(G)=="number"then
F[tostring(H)]=true
else
F[tostring(G)]=H==true
end
end
end

local function GetFrame(G)
return G and(G.ElementFrame or(G.UIElements and G.UIElements.Main))
end

local function IsHidden(G)
if B.IgnoreHidden==false then
return false
end
local H=GetFrame(G)
return typeof(H)=="Instance"and H:IsA"GuiObject"and H.Visible==false
end

local function IsDelimiter(G)
return G==nil
or G.CornerBreak==true
or G.LinkCornerBreak==true
or F[tostring(G.__type)]==true
end

local function GetGroup(G)
if typeof(B.GroupBy)=="function"then
local H,J=pcall(B.GroupBy,G)
if H then
return J
end
elseif type(B.GroupBy)=="string"then
return G[B.GroupBy]
end

return G.CornerGroup or G.LinkCornerGroup or G.LinkedCornerGroup
end

if IsDelimiter(C)or IsHidden(C)then
return"Squircle",p.DefaultCornerMap(),{Position="Single",Count=1}
end

local G={}
for H,J in x or{}do
if type(H)=="number"and J~=nil then
table.insert(G,H)
end
end
table.sort(G)

local H={}
local J={}
local L
local M

local function Flush()
if#J>0 then
table.insert(H,J)
J={}
end
L=nil
M=nil
end

for N,O in G do
local P=x[O]
if IsHidden(P)then
if B.BridgeHidden~=true then
Flush()
else
M=O
end
elseif IsDelimiter(P)then
Flush()
else
local Q=P.LinkCorners==false or P.LinkCorner==false
local R=P.CornerBreakBefore==true or P.LinkCornerBreakBefore==true
local S=M~=nil and O-M>1 and B.BridgeSparse~=true
local T=L~=nil and GetGroup(L)~=GetGroup(P)
local U=L
and(L.CornerBreakAfter==true or L.LinkCornerBreakAfter==true)

if#J>0 and(Q or R or S or T or U)then
Flush()
end

table.insert(J,O)
L=P
M=O

if Q then
Flush()
end
end
end
Flush()

local N
local O
for P,Q in H do
for R,S in Q do
if S==z then
N=Q
O=R
break
end
end
if N then
break
end
end

if not N or not O then
return"Squircle",p.DefaultCornerMap(),{Position="Single",Count=1}
end

local P=#N
local Q=if B.Reverse==true then P-O+1 else O
local R=if B.InnerRadius~=nil
then p.ToUDimRadius(B.InnerRadius,UDim.new(0,0))
else false
local S="Squircle"
local T=p.DefaultCornerMap()
local U="Single"

if P>1 and Q==1 then
U="First"
if A then
S="Squircle-TL-BL"
T.TopRight=R
T.BottomRight=R
else
S="Squircle-TL-TR"
T.BottomLeft=R
T.BottomRight=R
end
elseif P>1 and Q==P then
U="Last"
if A then
S="Squircle-TR-BR"
T.TopLeft=R
T.BottomLeft=R
else
S="Squircle-BL-BR"
T.TopLeft=R
T.TopRight=R
end
elseif P>1 then
U="Middle"
S="Square"
if A then
T.TopLeft=R
T.TopRight=R
T.BottomLeft=R
T.BottomRight=R
else
T.TopLeft=R
T.TopRight=R
T.BottomLeft=R
T.BottomRight=R
end
end

local V={
Position=U,
Index=Q,
Count=P,
Horizontal=A==true,
SourceIndex=z,
Group=GetGroup(C),
}

if typeof(B.Resolver)=="function"then
local W,X,Y=pcall(B.Resolver,V,S,T,C)
if W then
S=X or S
T=Y or T
end
end

return S,T,V
end

return p end function a.f()

local b=game:GetService"TweenService"

local d={
Preset="Subtle",
Enabled=true,
Reduced=false,
}

d.Durations={
Fast=0.08,
Hover=0.1,
Press=0.12,
Select=0.14,
Focus=0.14,
DropdownOpen=0.16,
DropdownClose=0.14,
Notification=0.24,
NotificationClose=0.2,
WindowOpen=0.26,
WindowClose=0.2,
WindowMorph=0.42,
Resize=0.22,
Highlight=0.28,
Background=0.22,
Expand=0.2,
Switch=0.16,
Reveal=0.18,
}

d.PresetDurations={
Liquid={
Fast=0.1,
Hover=0.14,
Press=0.1,
Select=0.2,
Focus=0.18,
DropdownOpen=0.2,
DropdownClose=0.16,
WindowOpen=0.32,
WindowClose=0.22,
WindowMorph=0.46,
Resize=0.28,
Highlight=0.34,
Background=0.28,
Expand=0.24,
Switch=0.22,
Reveal=0.22,
},
Snappy={
Fast=0.06,
Hover=0.08,
Press=0.08,
Select=0.11,
Focus=0.1,
DropdownOpen=0.12,
DropdownClose=0.1,
WindowOpen=0.2,
WindowClose=0.16,
WindowMorph=0.3,
Resize=0.16,
Highlight=0.22,
Background=0.16,
Expand=0.16,
Switch=0.12,
Reveal=0.14,
},
}

d.PresetEasing={
Liquid={
Style=Enum.EasingStyle.Quint,
Direction=Enum.EasingDirection.Out,
},
Snappy={
Style=Enum.EasingStyle.Quart,
Direction=Enum.EasingDirection.Out,
},
}

d.PresetPressAmount={
Liquid=0.965,
Snappy=0.975,
}

local e=setmetatable({},{__mode="k"})

local f={}
function f.Play(g)end
function f.Cancel(g)end

local g={
Position=true,
Size=true,
CanvasPosition=true,
Rotation=true,
Scale=true,
}

local function IsPointerInput(h)
return h.UserInputType==Enum.UserInputType.MouseButton1 or h.UserInputType==Enum.UserInputType.Touch
end

local function ApplyProperties(h,i)
for j,m in next,i or{}do
h[j]=m
end
end

local function SplitReducedProperties(h)
local i={}
local j={}
local m=false
local p=false

for r,u in next,h or{}do
if g[r]then
i[r]=u
m=true
else
j[r]=u
p=true
end
end

return m and i or nil,p and j or nil
end

function d.GetDuration(h)
if typeof(h)=="string"then
local i=d.PresetDurations[d.Preset]
return(i and i[h])or d.Durations[h]or d.Durations.Fast
end

return math.max(tonumber(h)or d.Durations.Fast,0)
end

function d.IsEnabled(h)
return d.Enabled and d.Preset~="None"
end

function d.Configure(h,i)
if i==false then
d.Enabled=false
d.Preset="None"
return d:GetConfig()
end

if typeof(i)=="string"then
return d:SetPreset(i)
end

if typeof(i)=="table"then
if i.Preset~=nil then
d:SetPreset(i.Preset)
elseif i.Enabled~=false and d.Preset=="None"then
d:SetPreset"Subtle"
end
d.Enabled=i.Enabled~=false and d.Preset~="None"
d.Reduced=i.Reduced==true
else
d.Enabled=true
if d.Preset=="None"then
d.Preset="Subtle"
end
d.Reduced=false
end

return d:GetConfig()
end

function d.SetPreset(h,i)
i=tostring(i or"Subtle")

if i~="Subtle"and i~="Liquid"and i~="Snappy"and i~="None"then
i="Subtle"
end

d.Preset=i
d.Enabled=i~="None"

return d:GetConfig()
end

function d.SetReducedMotion(h,i)
d.Reduced=i==true
return d:GetConfig()
end

function d.GetConfig(h)
return{
Preset=d.Preset,
Enabled=d.Enabled,
Reduced=d.Reduced,
}
end

function d.ShouldAnimate(h)
if h and(h.Animation==false or h.Motion==false)then
return false
end

return d:IsEnabled()
end

function d.Cancel(h,i)
if not h then
return
end

local j=e[h]
if not j then
return
end

i=i or"Default"
local m=j[i]
if m then
m:Cancel()
j[i]=nil
end
end

function d.Tween(h,i,j,m,p,r)
if not h or typeof(h)~="Instance"then
return f
end

local u=d.GetDuration(i)
r=r or"Default"

local v
local x=j
if d.Reduced then
v,x=SplitReducedProperties(j)
u=math.min(u,d.Durations.Focus)
end

local z={}
local A

function z.Play(B)
d.Cancel(h,r)

if v then
ApplyProperties(h,v)
end

if not d:IsEnabled()or u<=0 or not x then
ApplyProperties(h,x or j)
return
end

local C=d.PresetEasing[d.Preset]
A=b:Create(
h,
TweenInfo.new(
u,
m or(C and C.Style)or Enum.EasingStyle.Quint,
p or(C and C.Direction)or Enum.EasingDirection.Out
),
x
)

e[h]=e[h]or{}
e[h][r]=A

A.Completed:Connect(function()
local F=e[h]
if F and F[r]==A then
F[r]=nil
end
end)

A:Play()
end

function z.Cancel(B)
if A then
A:Cancel()
end
d.Cancel(h,r)
end

return z
end

function d.Play(h,i,j,m,p,r)
local u=d.Tween(h,i,j,m,p,r)
u:Play()
return u
end

function d.GetScale(h)
if not h then
return nil
end

if h:IsA"UIScale"then
return h
end

local i=h:FindFirstChildOfClass"UIScale"
if not i then
i=Instance.new"UIScale"
i.Scale=1
i.Parent=h
end

return i
end

function d.Press(h,i,j)
local m=d.GetScale(h)
if not m then
return
end

if not d:IsEnabled()or d.Reduced then
if not i then
m.Scale=1
end
return
end

d.Play(
m,
"Press",
{Scale=i and(j or d.PresetPressAmount[d.Preset]or 0.97)or 1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Press"
)
end

function d.AttachPress(h,i,j)
if not h or not i then
return nil
end

j=j or{}
local m=j.Amount or 0.97
local p=j.Enabled

local r=d.GetScale(h)

local function CanPress()
if typeof(p)=="function"then
return p()
end
return p~=false
end

i.AddSignal(h.InputBegan,function(u)
if CanPress()and IsPointerInput(u)then
d.Press(r,true,m)
end
end)

i.AddSignal(h.InputEnded,function(u)
if IsPointerInput(u)then
d.Press(r,false,m)
end
end)

if h.MouseLeave then
i.AddSignal(h.MouseLeave,function()
d.Press(r,false,m)
end)
end

return r
end

return d end function a.g()

local b={}







function b.New(d,e,f)
local g={
Enabled=e.Enabled or false,
Translations=e.Translations or{},
Prefix=e.Prefix or"loc:",
DefaultLanguage=e.DefaultLanguage or"en"
}

f.Localization=g

return g
end



return b end function a.h()
local b=a.load'e'
local d=a.load'f'

local e=b.New
local f=b.Tween

local g=14
local h=58



local i=96
local j=72
local m=420
local p=240
local r=18
local u=10
local v=8
local x=30
local z=40
local A=44
local B=24
local C=30
local F=36
local G=2
local H=38
local J=48
local L=2
local M=4
local N=18
local O=14
local P=4
local Q=356
local R=300
local S=404

local T={
Info={
Icon="info",
Color=Color3.fromHex"#60A5FA",
},
Notice={
Icon="bell",
Color=Color3.fromHex"#38BDF8",
},
Success={
Icon="circle-check",
Color=Color3.fromHex"#34D399",
},
Warning={
Icon="triangle-alert",
Color=Color3.fromHex"#FBBF24",
},
Error={
Icon="circle-x",
Color=Color3.fromHex"#FB7185",
},
Neutral={
Icon="message-circle",
Color=Color3.fromHex"#A1A1AA",
},
}

local U={
default="Info",
info="Info",
notice="Notice",
message="Notice",
success="Success",
successful="Success",
ok="Success",
green="Success",
warn="Warning",
warning="Warning",
caution="Warning",
error="Error",
fail="Error",
failed="Error",
danger="Error",
neutral="Neutral",
}

local V={
default="Compact",
compact="Compact",
minimal="Compact",
pill="Compact",
capsule="Compact",
card="Card",
avatar="Card",
glass="Glass",
liquid="Glass",
liquidglass="Glass",
frosted="Glass",
legacy="Glass",
}

local W={
default="Normal",
normal="Normal",
modern="Normal",
toast="Normal",
window="Window",
windows="Window",
desktop="Window",
windownotification="Window",
windownotify="Window",
original="Originally",
originally="Originally",
legacy="Originally",
classic="Originally",
}

local X={
Holder=nil,
NotificationIndex=0,
Notifications={},
}

local function ResolveColor(Y,_)
if typeof(Y)=="Color3"then
return Y
end

if typeof(Y)=="string"and string.sub(Y,1,1)=="#"then
local aa,ab=pcall(Color3.fromHex,Y)
if aa then
return ab
end
end

return _
end

local function NormalizeStyleName(aa)
local ab=tostring(aa or"Info"):lower():gsub("%s+","")
return U[ab]or"Info"
end

local function NormalizeNotificationType(aa)
if aa==nil then
return nil
end

local ab=tostring(aa):lower():gsub("%s+","")
return W[ab]
end

local function NormalizeAppearance(aa,ab)
if aa==nil and(ab.Avatar~=nil or ab.Timestamp~=nil or ab.Time~=nil)then
return"Card"
end
local Y=tostring(aa or"Compact"):lower():gsub("%s+","")
return V[Y]or"Compact"
end

local function ResolveDuration(aa)
if aa==false then
return false
end

local ab=tonumber(aa)
if ab==nil then
return 5
end

return math.max(ab,0)
end

local function NormalizeIcon(aa)
if typeof(aa)=="number"then
return"rbxassetid://"..tostring(aa)
end
if typeof(aa)=="string"then
return aa
end
if typeof(aa)=="table"or typeof(aa)=="Instance"then
return aa
end
return nil
end

local function PaintIcon(aa,ab,Y)
if typeof(aa)~="Instance"then
return
end

local _={}
if aa:IsA"ImageLabel"or aa:IsA"ImageButton"then
table.insert(_,aa)
end

for ac,ad in aa:GetDescendants()do
if ad:IsA"ImageLabel"or ad:IsA"ImageButton"then
table.insert(_,ad)
end
end

for ac,ad in _ do
ad.ImageColor3=ab
if Y~=nil then
ad.ImageTransparency=Y
end
end
end

local function CreateCorner(aa,ab)
local ac=e("UICorner",{
CornerRadius=UDim.new(0,aa),
})
return b.ApplyCornerRadii(ac,aa,ab)
end

local function ResolveCornerValue(aa,ab,ac)
local ad=aa[ab]
if ad==nil then
ad=aa[ab.."Radius"]
end
if ad==nil then
return ac
end
return ad
end

local function GetActions(aa)
local ab={}
if typeof(aa)~="table"then
return ab
end

for ac=1,math.min(#aa,G)do
local ad=aa[ac]
if typeof(ad)=="table"then
table.insert(ab,ad)
end
end

return ab
end

local function TrimNotifications(aa,ab)
local ac={}
for ad,Y in X.Notifications do
if not Y.Closed then
table.insert(ac,Y)
end
end

table.sort(ac,function(ad,Y)
return ad.Index<Y.Index
end)

local ad=math.max(#ac-1,0)*v
for Y,_ in ac do
ad=ad+(_.LayoutHeight or 64)
end

while#ac>1 and(#ac>aa or ad>ab)do
local Y=table.remove(ac,1)
ad=ad-(Y.LayoutHeight or 64)-v
Y:Close"Overflow"
end
end

function X.Init(aa)
local ab={
Lower=false,
}

ab.Frame=e("Frame",{
Name="NotificationHolder",
Position=UDim2.new(1,-g,0,h),
AnchorPoint=Vector2.new(1,0),
Size=UDim2.new(1,-(g*2),1,-(h+j)),
Parent=aa,
BackgroundTransparency=1,
ClipsDescendants=false,
ZIndex=100,
},{
e("UISizeConstraint",{
MinSize=Vector2.new(p,0),
MaxSize=Vector2.new(m,10000),
}),
e("UIListLayout",{
HorizontalAlignment=Enum.HorizontalAlignment.Right,
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Top,
Padding=UDim.new(0,v),
}),
})








function ab.SetLower(ac)
ab.Lower=ac==true
local ad=if ab.Lower then i else h
ab.Frame.Position=UDim2.new(1,-g,0,ad)
ab.Frame.Size=UDim2.new(1,-(g*2),1,-(ad+j))
end

X.Holder=ab.Frame
return ab
end

function X.New(aa)
aa=if typeof(aa)=="table"then aa else{}

local ab=NormalizeNotificationType(aa.Type)
local ac=NormalizeNotificationType(aa.NotificationType)or ab
local ad=ac or"Normal"
local Y=if ab==nil then aa.Type else nil
local _=NormalizeStyleName(aa.Style or aa.Variant or Y)
local ae=if ad=="Window"
then"Window"
elseif ad=="Originally"then"Originally"
else NormalizeAppearance(aa.Appearance or aa.Layout,aa)
local af=T[_]or T.Info
local ag=ResolveColor(aa.AccentColor or aa.Color,af.Color)
local ah
local ai=if ad=="Window"
then(if aa.Avatar~=nil then aa.Avatar else aa.BodyIcon)
else(if aa.Avatar~=nil then aa.Avatar else aa.Icon)
if ai==false or ai==""then
ah=nil
elseif ai~=nil then
ah=NormalizeIcon(ai)
elseif ad~="Window"then
ah=af.Icon
end
local aj=aa.LiquidGlass==true
or aa.Glass==true
or ae=="Glass"
or(ad=="Window"and aa.LiquidGlass~=false and aa.Glass~=false)
local ak=aa.Decorated==true or aa.Accented==true or ae=="Glass"

local al={
Type=ad,
Title=tostring(aa.Title or"Notification"),
Content=aa.Content~=nil and tostring(aa.Content)or nil,
Icon=ah,
IsAvatar=aa.Avatar~=nil,
IconThemed=aa.IconThemed,
IconColor=ResolveColor(
aa.IconColor,
if ak
or aa.AccentColor~=nil
or aa.Color~=nil
then ag
else Color3.fromHex"#A1A1AA"
),
Style=_,
Appearance=ae,
LiquidGlass=aj,
Decorated=ak,
DarkOverlay=aa.DarkOverlay==true or aa.Overlay==true or ad=="Originally",
Timestamp=aa.Timestamp~=nil and tostring(aa.Timestamp)
or(aa.Time~=nil and tostring(aa.Time)or nil),
AppName=tostring(aa.AppName or aa.Application or aa.App or"WindUI"),
AppIcon=NormalizeIcon(
aa.AppIcon or aa.ApplicationIcon or(ad=="Window"and aa.Icon)or"bell"
),
Selection=aa.Selection or aa.Dropdown or aa.Select,
AccentColor=ag,
ProgressColor=ResolveColor(aa.ProgressColor,ag),
Background=aa.Background,
BackgroundImageTransparency=b.ClampTransparency(aa.BackgroundImageTransparency,0.35),
Duration=ResolveDuration(aa.Duration),
Buttons=GetActions(aa.Buttons),
CanClose=aa.CanClose~=false,
PauseOnHover=aa.PauseOnHover~=false,
OnOpen=aa.OnOpen,
OnClose=aa.OnClose,
UIElements={},
Closed=false,
Paused=false,
}

X.NotificationIndex=X.NotificationIndex+1
al.Index=X.NotificationIndex
X.Notifications[al.Index]=al

local am=aa.Holder or X.Holder
assert(am,"Notification holder is not initialized")

local an=al.Type=="Window"
local ao=al.Type=="Originally"
local ap=al.Appearance=="Card"or an
local aq=math.max(
tonumber(aa.Width)or(an and S or(ao and R or Q)),
p
)
local ar=if an or ao then 14 elseif ap then 12 else u
local as=math.max(
tonumber(aa.Radius)or(an and 20 or(ao and 18 or(ap and 20 or r))),
8
)
local at=if typeof(aa.Corners or aa.CornerRadii)=="table"
then aa.Corners or aa.CornerRadii
else aa
local au={
TopLeft=ResolveCornerValue(at,"TopLeft",as),
TopRight=ResolveCornerValue(at,"TopRight",as),
BottomRight=ResolveCornerValue(at,"BottomRight",as),
BottomLeft=ResolveCornerValue(at,"BottomLeft",as),
}
local av=if ap then z elseif ao then 38 else x
local aw=if al.Timestamp and not an then 72 else 0
local ax=typeof(al.Duration)=="number"and al.Duration>0
local ay=al.Icon and(av+9)or 0
local az=(al.CanClose and not an and C or 0)+aw
local aA=aa.Shadow~=false
local aB=aa.FallbackShadow==true
local aC=al.DarkOverlay
local aD={
BackgroundColor3=if aC
then(if al.LiquidGlass then"NotificationGlass"else"Notification")
else"NotificationGlassSurface",
}
if aa.Transparency==nil and aC then
aD.BackgroundTransparency=if al.LiquidGlass
then"NotificationGlassTransparency"
else"NotificationTransparency"
end
local aE
local aF=0
local aG=if ax then al.Duration else 0
local aH
local aI=false
local aJ=false
local aK=64
local aL={}

local function Connect(aM,aN)
local aO=aM:Connect(aN)
table.insert(aL,aO)
return aO
end

local function AttachPress(aM,aN)
Connect(aM.InputBegan,function(aO)
if
aO.UserInputType==Enum.UserInputType.MouseButton1
or aO.UserInputType==Enum.UserInputType.Touch
then
d.Press(aM,true,aN)
end
end)
Connect(aM.InputEnded,function(aO)
if
aO.UserInputType==Enum.UserInputType.MouseButton1
or aO.UserInputType==Enum.UserInputType.Touch
then
d.Press(aM,false,aN)
end
end)
Connect(aM.MouseLeave,function()
d.Press(aM,false,aN)
end)
end

local function AttachHover(aM,aN,aO,aP)
Connect(aM.MouseEnter,function()
d.Play(
aN,
"Hover",
{BackgroundTransparency=aO},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
end)
Connect(aM.MouseLeave,function()
d.Play(
aN,
"Hover",
{BackgroundTransparency=aP},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
end)
end

local function DisconnectSignals()
for aM,aN in aL do
aN:Disconnect()
end
table.clear(aL)
end

local aM=e("Frame",{
Name="NotificationContainer",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
ClipsDescendants=false,
LayoutOrder=-al.Index,
ZIndex=100,
Parent=am,
},{
e("UISizeConstraint",{
MinSize=Vector2.new(math.min(aq,p),0),
MaxSize=Vector2.new(aq,10000),
}),
})

local aN=e("UIScale",{
Name="TransitionScale",
Scale=0.965,
})

local aO=e("CanvasGroup",{
Name="NotificationTransition",
Active=true,
BackgroundTransparency=1,
GroupTransparency=1,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,aK),
Position=UDim2.new(0,N,0,0),
ClipsDescendants=false,
ZIndex=101,
Parent=aM,
},{
aN,
})

local aP=e("Frame",{
Name="Shadow",
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.78,
BorderSizePixel=0,
Size=UDim2.new(1,-4,1,-4),
Position=UDim2.new(0,2,0,P),
Visible=aA,
ZIndex=101,
Parent=aO,
},{
CreateCorner(as,au),
})

local aQ=e("UIStroke",{
Color=Color3.new(1,1,1),
Transparency=0.76,
Thickness=1,
ThemeTag={
Color="NotificationBorder",
Transparency="NotificationBorderTransparency",
},
})

local aR=e("Frame",{
Name="Notification",
BackgroundColor3=if aC then Color3.fromRGB(24,25,29)else Color3.new(1,1,1),
BackgroundTransparency=b.ClampTransparency(
aa.Transparency,
if aC
then(if al.LiquidGlass then 0.28 else 0.08)
else(if al.LiquidGlass then 0.64 else 0.72)
),
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ClipsDescendants=true,
ZIndex=102,
ThemeTag=aD,
Parent=aO,
},{
CreateCorner(as,au),
aQ,
})
aR:SetAttribute("Appearance",al.Appearance)
aR:SetAttribute("Type",al.Type)
aR:SetAttribute("LiquidGlass",al.LiquidGlass)
aR:SetAttribute("DarkOverlay",aC)
aR:SetAttribute("LayoutVersion",4)

local aS
if aA then
aS=b.CreateUIShadow(aR,{
Name="NativeShadow",
BlurRadius=b.ToUDimRadius(aa.ShadowBlur,UDim.new(0,16)),
Color=ResolveColor(aa.ShadowColor,Color3.new(0,0,0)),
Offset=if typeof(aa.ShadowOffset)=="UDim2"then aa.ShadowOffset else UDim2.fromOffset(0,5),
Spread=if typeof(aa.ShadowSpread)=="UDim2"then aa.ShadowSpread else UDim2.fromOffset(2,2),
Transparency=b.ClampTransparency(aa.ShadowTransparency,0.68),
ZIndex=0,
})
end
aP.Visible=aA and aS==nil and aB

local aT=e("Frame",{
Name="CapsuleSurface",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
BackgroundTransparency=if aC
then(if al.LiquidGlass then 0.91 else 0.985)
else(if al.LiquidGlass then 0.94 else 1),
Size=UDim2.fromScale(1,1),
ZIndex=103,
ThemeTag={
BackgroundColor3=if al.LiquidGlass then"NotificationGlassSurface"else"Notification2",
BackgroundTransparency=if aC
then(if al.LiquidGlass
then"NotificationGlassSurfaceTransparency"
else"Notification2Transparency")
else nil,
},
Parent=aR,
},{
CreateCorner(as,au),
})

local aU=b.NewRoundFrame(as,"SquircleGlass",{
Name="LiquidGlass",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=b.ClampTransparency(aa.GlassTransparency,0.78),
Size=UDim2.fromScale(1,1),
Visible=al.LiquidGlass,
ZIndex=104,
ThemeTag=if aa.GlassTransparency==nil
then{
ImageColor3="NotificationGlassHighlight",
ImageTransparency="NotificationGlassTextureTransparency",
}
else{
ImageColor3="NotificationGlassHighlight",
},
Parent=aR,
})

if typeof(al.Background)=="string"and al.Background~=""then
e("ImageLabel",{
Name="Background",
Image=al.Background,
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ScaleType=Enum.ScaleType.Crop,
ImageTransparency=al.BackgroundImageTransparency,
ZIndex=104,
Parent=aR,
},{
CreateCorner(as,au),
})
end

local aV=e("Frame",{
Name="ToneWash",
BackgroundColor3=al.AccentColor,
BackgroundTransparency=0.94,
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
Visible=al.Decorated,
ZIndex=105,
Parent=aR,
},{
CreateCorner(as,au),
e("UIGradient",{
Rotation=18,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.42),
NumberSequenceKeypoint.new(0.38,0.86),
NumberSequenceKeypoint.new(1,1),
},
}),
})

local aW=e("Frame",{
Name="AccentLine",
BackgroundColor3=al.AccentColor,
BackgroundTransparency=0.08,
BorderSizePixel=0,
Size=UDim2.new(0,3,0.48,0),
Position=UDim2.new(0,0,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
Visible=al.Decorated,
ZIndex=106,
Parent=aR,
},{
CreateCorner(3,{
TopLeft=au.TopLeft,
TopRight=3,
BottomRight=3,
BottomLeft=au.BottomLeft,
}),
e("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.32,0.08),
NumberSequenceKeypoint.new(0.68,0.08),
NumberSequenceKeypoint.new(1,1),
},
}),
})

local aX=e("Frame",{
Name="TopHighlight",
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.94,
BorderSizePixel=0,
Size=UDim2.new(0.72,0,0,1),
Position=UDim2.new(0.14,0,0,0),
ZIndex=106,
Parent=aR,
},{
e("UIGradient",{
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.5,0.15),
NumberSequenceKeypoint.new(1,1),
},
}),
})

local aY=e("Frame",{
Name="Body",
BackgroundTransparency=1,
Size=UDim2.new(1,-(ar*2),0,0),
Position=UDim2.fromOffset(ar,ar),
ZIndex=107,
Parent=aR,
})

local aZ=e("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,if an then 10 elseif ao then 5 else 8),
Parent=aY,
})

local a_
local a0
local a1
local a2
if an then
a_=e("Frame",{
Name="AppHeader",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,28),
LayoutOrder=0,
ZIndex=108,
Parent=aY,
})

if al.AppIcon then
a0=b.Image(
al.AppIcon,
al.AppName..":AppIcon",
4,
aa.Window and aa.Window.Folder,
"NotificationApp",
true,
aa.AppIconThemed,
"NotificationTitle"
)
a0.Name="AppIcon"
a0.Size=UDim2.fromOffset(22,22)
a0.Position=UDim2.new(0,0,0.5,0)
a0.AnchorPoint=Vector2.new(0,0.5)
a0.ZIndex=109
a0.Parent=a_
end

local a3=if a0 then 30 else 0
a1=e("TextLabel",{
Name="AppName",
Text=al.AppName,
TextSize=13,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
BackgroundTransparency=1,
Size=UDim2.new(1,-(a3+92),1,0),
Position=UDim2.fromOffset(a3,0),
ZIndex=109,
ThemeTag={
TextColor3="NotificationTitle",
},
Parent=a_,
})

a2=e("TextLabel",{
Name="AppTimestamp",
Text=al.Timestamp or os.date"%H:%M",
TextSize=11,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
TextXAlignment=Enum.TextXAlignment.Right,
BackgroundTransparency=1,
Size=UDim2.fromOffset(48,28),
Position=UDim2.new(1,-(al.CanClose and 46 or 0),0,0),
AnchorPoint=Vector2.new(1,0),
TextTransparency=0.3,
ZIndex=109,
ThemeTag={
TextColor3="NotificationContent",
},
Parent=a_,
})
end

local a3=e("Frame",{
Name="Header",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,math.max(al.Icon and av or 0,20)),
LayoutOrder=1,
ZIndex=107,
Parent=aY,
})

local a4
if al.Timestamp and not an then
a4=e("TextLabel",{
Name="Timestamp",
Text=al.Timestamp,
TextSize=11,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
TextXAlignment=Enum.TextXAlignment.Right,
TextYAlignment=Enum.TextYAlignment.Top,
TextTruncate=Enum.TextTruncate.AtEnd,
BackgroundTransparency=1,
Size=UDim2.fromOffset(aw,18),
Position=UDim2.new(1,-(al.CanClose and C or 0),0,1),
AnchorPoint=Vector2.new(1,0),
TextTransparency=0.22,
ZIndex=109,
ThemeTag={
TextColor3="NotificationContent",
},
Parent=a_ or a3,
})
end

local a5=e("Frame",{
Name="TextContainer",
BackgroundTransparency=1,
Size=UDim2.new(1,-(ay+az),0,0),
Position=UDim2.fromOffset(ay,0),
ZIndex=108,
Parent=a3,
})

local a6=e("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,2),
Parent=a5,
})

local a7=e("TextLabel",{
Name="Title",
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Text=al.Title,
TextWrapped=ap or ao or aa.Wrap==true,
TextTruncate=Enum.TextTruncate.AtEnd,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
TextSize=if an then 19 elseif ao then 18 elseif ap then 15 else 14,
LineHeight=1,
FontFace=Font.new(b.Font,Enum.FontWeight.SemiBold),
LayoutOrder=1,
ZIndex=108,
ThemeTag={
TextColor3="NotificationTitle",
TextTransparency="NotificationTitleTransparency",
},
Parent=a5,
},{
e("UISizeConstraint",{
MinSize=Vector2.new(0,18),
MaxSize=Vector2.new(10000,H),
}),
})

local a8=e("TextLabel",{
Name="Content",
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Text=al.Content or"",
TextWrapped=ap or ao or aa.Wrap==true,
TextTruncate=Enum.TextTruncate.AtEnd,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
TextSize=if an then 14 elseif ao then 15 else 12,
LineHeight=1.05,
FontFace=Font.new(b.Font,Enum.FontWeight.Regular),
LayoutOrder=2,
Visible=al.Content~=nil,
ZIndex=108,
ThemeTag={
TextColor3="NotificationContent",
TextTransparency="NotificationContentTransparency",
},
Parent=a5,
},{
e("UISizeConstraint",{
MinSize=Vector2.new(0,16),
MaxSize=Vector2.new(10000,J),
}),
})

local a9
local ba
if al.Icon then
local bb=not al.IsAvatar
and(
type(al.Icon)~="string"
or(al.Icon:match"^rbxassetid://"==nil and al.Icon:match"^https?://"==nil)
)
ba=b.Image(
al.Icon,
al.Title..":"..tostring(al.Icon),
al.IsAvatar and av/2 or 0,
aa.Window and aa.Window.Folder,
"Notification",
true,
al.IconThemed,
nil,
al.IsAvatar
)
ba.Name=if al.IsAvatar then"Avatar"else"Icon"
ba.Size=if al.IsAvatar
then UDim2.fromScale(1,1)
else UDim2.fromOffset(if ap then 22 else 18,if ap then 22 else 18)
ba.Position=UDim2.fromScale(0.5,0.5)
ba.AnchorPoint=Vector2.new(0.5,0.5)
ba.ZIndex=110
if bb and b.Icon(al.Icon)and al.IconThemed~=true then
PaintIcon(ba,al.IconColor,0)
end

a9=e("Frame",{
Name="IconBubble",
BackgroundColor3=if al.IsAvatar then Color3.new(1,1,1)else al.IconColor,
BackgroundTransparency=if al.IsAvatar then 0.9 elseif al.Decorated then 0.88 else 0.95,
BorderSizePixel=0,
Size=UDim2.fromOffset(av,av),
ClipsDescendants=true,
ZIndex=109,
Parent=a3,
},{
CreateCorner(av/2),
e("UIStroke",{
Color=al.IconColor,
Transparency=if al.Decorated then 0.72 else 0.88,
Thickness=1,
}),
e("UIGradient",{
Rotation=35,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,al.AccentColor:Lerp(Color3.new(1,1,1),0.16)),
ColorSequenceKeypoint.new(1,al.AccentColor),
},
}),
ba,
})
end

local bb
local bc
if al.CanClose then
local bd=b.Icon"x"
bc=e("Frame",{
Name="Surface",
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.98,
BorderSizePixel=0,
Size=UDim2.fromOffset(B,B),
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
ZIndex=109,
ThemeTag={
BackgroundColor3="Notification2",
},
},{
CreateCorner(B/2),
e("ImageLabel",{
Name="Icon",
Image=bd and bd[1]or"",
ImageRectSize=bd and bd[2]and bd[2].ImageRectSize or Vector2.zero,
ImageRectOffset=bd and bd[2]and bd[2].ImageRectPosition
or Vector2.zero,
BackgroundTransparency=1,
Size=UDim2.fromOffset(14,14),
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=0.46,
ZIndex=110,
ThemeTag={
ImageColor3="NotificationTitle",
},
}),
})

bb=e("TextButton",{
Name="CloseButton",
Text="",
AutoButtonColor=false,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(A,A),
Position=UDim2.new(1,4,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
ZIndex=109,
Parent=if an then a_ else a3,
},{
bc,
})
AttachPress(bb,0.96)
AttachHover(bb,bc,0.91,0.98)
end

local bd
local be
if an and al.Selection~=nil then
local bf=if typeof(al.Selection)=="table"
then al.Selection
else{Value=al.Selection}
local bg=if typeof(bf.Values or bf.Options)=="table"
then bf.Values or bf.Options
else{}
local bh=math.max(tonumber(bf.Index)or 1,1)

local function GetSelectionValue(bi)
if typeof(bi)=="table"then
return bi.Value or bi.Title or bi.Name
end
return bi
end

local bi=bf.Value or bf.Default
if bi~=nil and#bg>0 then
for bj,bk in bg do
local bl=GetSelectionValue(bk)
if bl==bi or tostring(bl)==tostring(bi)then
bh=bj
break
end
end
end
if bi==nil and#bg>0 then
bi=GetSelectionValue(bg[bh]or bg[1])
end
bi=bi or"Select"

local bj=b.Icon"chevron-down"
bd=e("TextButton",{
Name="Selection",
Text="",
AutoButtonColor=false,
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.9,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,40),
LayoutOrder=2,
ZIndex=108,
ThemeTag={
BackgroundColor3="Notification2",
},
Parent=aY,
},{
CreateCorner(10),
e("UIStroke",{
Color=Color3.new(1,1,1),
Transparency=0.8,
Thickness=1,
ThemeTag={
Color="NotificationBorder",
Transparency="NotificationBorderTransparency",
},
}),
e("TextLabel",{
Name="Value",
Text=tostring(bi),
TextSize=14,
FontFace=Font.new(b.Font,Enum.FontWeight.Medium),
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
BackgroundTransparency=1,
Size=UDim2.new(1,-48,1,0),
Position=UDim2.fromOffset(14,0),
ZIndex=109,
ThemeTag={
TextColor3="NotificationTitle",
},
}),
e("ImageLabel",{
Name="Chevron",
Image=bj and bj[1]or"",
ImageRectSize=bj and bj[2]and bj[2].ImageRectSize or Vector2.zero,
ImageRectOffset=bj and bj[2]and bj[2].ImageRectPosition or Vector2.zero,
ImageTransparency=0.35,
BackgroundTransparency=1,
Size=UDim2.fromOffset(16,16),
Position=UDim2.new(1,-14,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
ZIndex=109,
ThemeTag={
ImageColor3="NotificationTitle",
},
}),
})
be=bd.Value
AttachPress(bd,0.985)
AttachHover(bd,bd,0.84,0.9)

Connect(bd.MouseButton1Click,function()
if#bg>0 then
bh=(bh%#bg)+1
bi=GetSelectionValue(bg[bh])
be.Text=tostring(bi)
end
b.SafeCallback(bf.Callback,bi,bh,al)
end)
end

local bf
local bg=if an then 40 else F
if#al.Buttons>0 then
bf=e("Frame",{
Name="Actions",
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,bg),
LayoutOrder=if an then 3 else 2,
ZIndex=107,
Parent=aY,
})

e("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Left,
VerticalAlignment=Enum.VerticalAlignment.Top,
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,6),
Parent=bf,
})

for bh,bi in al.Buttons do
local bj=bh==1
local bk
if#al.Buttons==2 then
bk=UDim2.new(0.5,-3,0,bg)
else
bk=UDim2.new(1,0,0,bg)
end

local bl=if bj then 0.16 else 0.93
local bm=e("UIStroke",{
Color=if bj then al.AccentColor else Color3.new(1,1,1),
Transparency=if bj then 0.55 else 0.78,
Thickness=1,
ThemeTag=if bj
then nil
else{
Color="NotificationBorder",
Transparency="NotificationBorderTransparency",
},
})

local bn=e("TextButton",{
Name="Action"..bh,
Text=tostring(bi.Title or bi.Text or"Action"),
TextSize=12,
FontFace=Font.new(b.Font,Enum.FontWeight.SemiBold),
AutoButtonColor=false,
BackgroundColor3=if bj then al.AccentColor else Color3.new(1,1,1),
BackgroundTransparency=bl,
BorderSizePixel=0,
Size=bk,
LayoutOrder=bh,
ZIndex=108,
ThemeTag=if bj
then{
TextColor3="White",
}
else{
BackgroundColor3="Notification2",
TextColor3="NotificationTitle",
},
Parent=bf,
},{
CreateCorner(9),
bm,
})
AttachPress(bn,0.97)
AttachHover(bn,bn,if bj then 0.06 else 0.87,bl)

Connect(bn.MouseButton1Click,function()
b.SafeCallback(bi.Callback,al,bi)
if bi.Close~=false and bi.CloseOnClick~=false then
al:Close"Action"
end
end)
end
end

local bh=ax and d:IsEnabled()and not d.Reduced
local bi=e("Frame",{
Name="ProgressTrack",
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.94,
BorderSizePixel=0,
Size=if ao
then UDim2.new(1,-(ar*2),0,L)
else UDim2.new(0.32,0,0,L),
Position=UDim2.new(0.5,0,1,if ao then-3 else-5),
AnchorPoint=Vector2.new(0.5,1),
Visible=ax,
ZIndex=111,
ThemeTag={
BackgroundColor3="NotificationDuration",
BackgroundTransparency="NotificationDurationTransparency",
},
Parent=aR,
},{
CreateCorner(L),
})

local bj=e("Frame",{
Name="ProgressFill",
BackgroundColor3=al.ProgressColor,
BackgroundTransparency=b.ClampTransparency(aa.ProgressTransparency,0.12),
BorderSizePixel=0,
Size=UDim2.fromScale(1,1),
ZIndex=112,
Parent=bi,
},{
CreateCorner(L),
e("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,al.ProgressColor),
ColorSequenceKeypoint.new(1,al.ProgressColor:Lerp(Color3.new(1,1,1),0.22)),
},
}),
})

local function UpdateContainerHeight(bk)
local bl=math.max(math.ceil(aZ.AbsoluteContentSize.Y),a3.Size.Y.Offset)
aK=ar+bl+ar
al.LayoutHeight=aK
aO.Size=UDim2.new(1,0,0,aK)

if aI then
if bk==false then
aM.Size=UDim2.new(1,0,0,aK)
else
d.Play(
aM,
"Resize",
{Size=UDim2.new(1,0,0,aK)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Resize"
)
end
end

if aJ then
local bm=math.max(am.AbsoluteSize.Y,aK)
TrimNotifications(math.max(math.floor(tonumber(aa.MaxVisible)or M),1),bm)
end
end

local function UpdateTextHeight()
local bk=math.max(math.ceil(a6.AbsoluteContentSize.Y),20)
a5.Size=UDim2.new(1,-(ay+az),0,bk)
a3.Size=UDim2.new(1,0,0,math.max(bk,al.Icon and av or 0,20))
UpdateContainerHeight(aI)
end

Connect(a6:GetPropertyChangedSignal"AbsoluteContentSize",function()
UpdateTextHeight()
end)
Connect(aZ:GetPropertyChangedSignal"AbsoluteContentSize",function()
UpdateContainerHeight(aI)
end)

local function StopProgressTween()
if aE then
aE:Cancel()
aE=nil
end
end

local function CaptureRemainingTime()
if aH then
aG=math.max(aG-(os.clock()-aH),0)
aH=nil
end
al.Remaining=aG
end

local function SetProgressRatio(bk)
bj.Size=UDim2.new(math.clamp(bk,0,1),0,1,0)
end

local function StartTimer()
if not ax or not aI or al.Closed or al.Paused then
return
end

if aG<=0 then
al:Close"Timeout"
return
end

aF=aF+1
local bk=aF
aH=os.clock()
al.Remaining=aG

StopProgressTween()
local bl=aG/al.Duration
SetProgressRatio(bl)
if bh then
aE=f(
bj,
aG,
{Size=UDim2.new(0,0,1,0)},
Enum.EasingStyle.Linear,
Enum.EasingDirection.InOut
)
aE:Play()
end

task.delay(aG,function()
if bk==aF and not al.Closed and not al.Paused then
aG=0
al.Remaining=0
al:Close"Timeout"
end
end)
end

function al.Pause(bk)
if not ax or al.Closed or al.Paused then
return al
end

al.Paused=true
aF=aF+1
CaptureRemainingTime()
StopProgressTween()
SetProgressRatio(aG/al.Duration)
return al
end

function al.Resume(bk)
if not ax or al.Closed or not al.Paused then
return al
end

al.Paused=false
StartTimer()
return al
end

function al.GetRemainingDuration(bk)
if not ax then
return 0
end

local bl=aG
if aH then
bl=math.max(bl-(os.clock()-aH),0)
end
return bl
end

function al.Update(bk,bl)
if typeof(bl)~="table"or al.Closed then
return al
end

if bl.Title~=nil then
al.Title=tostring(bl.Title)
a7.Text=al.Title
end

if bl.Content~=nil then
al.Content=if bl.Content==false then nil else tostring(bl.Content)
a8.Text=al.Content or""
a8.Visible=al.Content~=nil
end

if bl.Duration~=nil then
local bm=al.Paused
aF=aF+1
CaptureRemainingTime()
StopProgressTween()
al.Duration=ResolveDuration(bl.Duration)
ax=typeof(al.Duration)=="number"and al.Duration>0
bh=ax and d:IsEnabled()and not d.Reduced
aG=if ax then al.Duration else 0
al.Remaining=aG
al.Paused=bm
bi.Visible=ax
SetProgressRatio(if ax then 1 else 0)
StartTimer()
end

UpdateTextHeight()
return al
end

function al.Close(bk,bl)
if al.Closed then
return al
end

al.Closed=true
al.CloseReason=tostring(bl or"Manual")
aF=aF+1
CaptureRemainingTime()
DisconnectSignals()
StopProgressTween()

d.Cancel(aM,"Open")
d.Cancel(aM,"Resize")
d.Cancel(aO,"Open")
d.Cancel(aN,"Open")
d.Play(
aM,
"NotificationClose",
{Size=UDim2.new(1,0,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Close"
)
d.Play(aO,"NotificationClose",{
Position=UDim2.new(0,O,0,0),
GroupTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Close")
d.Play(
aN,
"NotificationClose",
{Scale=0.98},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Close"
)

b.SafeCallback(al.OnClose,al,al.CloseReason)

local bm=if d:IsEnabled()and not d.Reduced
then d.GetDuration"NotificationClose"+0.02
else 0
task.delay(bm,function()
X.Notifications[al.Index]=nil
if aM.Parent then
aM:Destroy()
end
end)

return al
end

if bb then
Connect(bb.MouseButton1Click,function()
al:Close"Dismissed"
end)
end

if al.PauseOnHover then
Connect(aO.MouseEnter,function()
al:Pause()
end)
Connect(aO.MouseLeave,function()
al:Resume()
end)
end

al.UIElements={
Container=aM,
Main=aR,
Card=aR,
Type=al.Type,
Transition=aO,
TransitionScale=aN,
Shadow=aP,
NativeShadow=aS,
Stroke=aQ,
Surface=aT,
LiquidGlass=aU,
ToneWash=aV,
AccentLine=aW,
TopHighlight=aX,
Body=aY,
Header=a3,
AppHeader=a_,
AppIcon=a0,
AppName=a1,
AppTimestamp=a2,
TextContainer=a5,
Title=a7,
Content=a8,
Timestamp=a4,
Icon=ba,
Avatar=if al.IsAvatar then ba else nil,
IconBubble=a9,
CloseButton=bb,
CloseSurface=bc,
Actions=bf,
Selection=bd,
SelectionValue=be,
ProgressTrack=bi,
ProgressFill=bj,
}

UpdateTextHeight()
aJ=true
TrimNotifications(
math.max(math.floor(tonumber(aa.MaxVisible)or M),1),
math.max(am.AbsoluteSize.Y,aK)
)

task.spawn(function()
task.wait()
if al.Closed then
return
end

UpdateTextHeight()
aI=true
d.Play(
aM,
"Notification",
{Size=UDim2.new(1,0,0,aK)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Open"
)
d.Play(aO,"Notification",{
Position=UDim2.new(0,0,0,0),
GroupTransparency=0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Open")
d.Play(aN,"Notification",{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Open")

b.SafeCallback(al.OnOpen,al)
StartTimer()
end)

return al
end

return X end function a.i()












local aa=4294967296;local ab=aa-1;local function c(ac,ad)local ae,af=0,1;while ac~=0 or ad~=0 do local ag,ah=ac%2,ad%2;local ai=(ag+ah)%2;ae=ae+ai*af;ac=math.floor(ac/2)ad=math.floor(ad/2)af=af*2 end;return ae%aa end;local function k(ac,ad,ae,...)local af;if ad then ac=ac%aa;ad=ad%aa;af=c(ac,ad)if ae then af=k(af,ae,...)end;return af elseif ac then return ac%aa else return 0 end end;local function n(ac,ad,ae,...)local af;if ad then ac=ac%aa;ad=ad%aa;af=(ac+ad-c(ac,ad))/2;if ae then af=n(af,ae,...)end;return af elseif ac then return ac%aa else return ab end end;local function o(ac)return ab-ac end;local function q(ac,ad)if ad<0 then return lshift(ac,-ad)end;return math.floor(ac%4294967296/2^ad)end;local function s(ac,ad)if ad>31 or ad<-31 then return 0 end;return q(ac%aa,ad)end;local function lshift(ac,ad)if ad<0 then return s(ac,-ad)end;return ac*2^ad%4294967296 end;local function t(ac,ad)ac=ac%aa;ad=ad%32;local ae=n(ac,2^ad-1)return s(ac,ad)+lshift(ae,32-ad)end;local ac={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(ad)return string.gsub(ad,".",function(ae)return string.format("%02x",string.byte(ae))end)end;local function y(ad,ae)local af=""for ag=1,ae do local ah=ad%256;af=string.char(ah)..af;ad=(ad-ah)/256 end;return af end;local function D(ad,ae)local af=0;for ag=ae,ae+3 do af=af*256+string.byte(ad,ag)end;return af end;local function E(ad,ae)local af=64-(ae+9)%64;ae=y(8*ae,8)ad=ad.."\128"..string.rep("\0",af)..ae;assert(#ad%64==0)return ad end;local function I(ad)ad[1]=0x6a09e667;ad[2]=0xbb67ae85;ad[3]=0x3c6ef372;ad[4]=0xa54ff53a;ad[5]=0x510e527f;ad[6]=0x9b05688c;ad[7]=0x1f83d9ab;ad[8]=0x5be0cd19;return ad end;local function K(ad,ae,af)local ag={}for ah=1,16 do ag[ah]=D(ad,ae+(ah-1)*4)end;for ah=17,64 do local ai=ag[ah-15]local aj=k(t(ai,7),t(ai,18),s(ai,3))ai=ag[ah-2]ag[ah]=(ag[ah-16]+aj+ag[ah-7]+k(t(ai,17),t(ai,19),s(ai,10)))%aa end;local ah,ai,aj,ak,al,am,an,ao=af[1],af[2],af[3],af[4],af[5],af[6],af[7],af[8]for ap=1,64 do local aq=k(t(ah,2),t(ah,13),t(ah,22))local ar=k(n(ah,ai),n(ah,aj),n(ai,aj))local as=(aq+ar)%aa;local at=k(t(al,6),t(al,11),t(al,25))local au=k(n(al,am),n(o(al),an))local av=(ao+at+au+ac[ap]+ag[ap])%aa;ao=an;an=am;am=al;al=(ak+av)%aa;ak=aj;aj=ai;ai=ah;ah=(av+as)%aa end;af[1]=(af[1]+ah)%aa;af[2]=(af[2]+ai)%aa;af[3]=(af[3]+aj)%aa;af[4]=(af[4]+ak)%aa;af[5]=(af[5]+al)%aa;af[6]=(af[6]+am)%aa;af[7]=(af[7]+an)%aa;af[8]=(af[8]+ao)%aa end;local function Z(ad)ad=E(ad,#ad)local ae=I{}for af=1,#ad,64 do K(ad,af,ae)end;return w(y(ae[1],4)..y(ae[2],4)..y(ae[3],4)..y(ae[4],4)..y(ae[5],4)..y(ae[6],4)..y(ae[7],4)..y(ae[8],4))end;local ad;local ae={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local af={["/"]="/"}for ag,ah in pairs(ae)do af[ah]=ag end;local ag=function(ag)return"\\"..(ae[ag]or string.format("u%04x",ag:byte()))end;local ah=function(ah)return"null"end;local ai=function(ai,aj)local ak={}aj=aj or{}if aj[ai]then error"circular reference"end;aj[ai]=true;if rawget(ai,1)~=nil or next(ai)==nil then local al=0;for am in pairs(ai)do if type(am)~="number"then error"invalid table: mixed or invalid key types"end;al=al+1 end;if al~=#ai then error"invalid table: sparse array"end;for am,an in ipairs(ai)do table.insert(ak,ad(an,aj))end;aj[ai]=nil;return"["..table.concat(ak,",").."]"else for al,am in pairs(ai)do if type(al)~="string"then error"invalid table: mixed or invalid key types"end;table.insert(ak,ad(al,aj)..":"..ad(am,aj))end;aj[ai]=nil;return"{"..table.concat(ak,",").."}"end end;local aj=function(aj)return'"'..aj:gsub('[%z\1-\31\\"]',ag)..'"'end;local ak=function(ak)if ak~=ak or ak<=-math.huge or ak>=math.huge then error("unexpected number value '"..tostring(ak).."'")end;return string.format("%.14g",ak)end;local al={["nil"]=ah,table=ai,string=aj,number=ak,boolean=tostring}ad=function(am,an)local ao=type(am)local ap=al[ao]if ap then return ap(am,an)end;error("unexpected type '"..ao.."'")end;local am=function(am)return ad(am)end;local an;local ao=function(...)local ao={}for ap=1,select("#",...)do ao[select(ap,...)]=true end;return ao end;local ap=ao(" ","\t","\r","\n")local aq=ao(" ","\t","\r","\n","]","}",",")local ar=ao("\\","/",'"',"b","f","n","r","t","u")local as=ao("true","false","null")local at={["true"]=true,["false"]=false,null=nil}local au=function(au,av,aw,ax)for ay=av,#au do if aw[au:sub(ay,ay)]~=ax then return ay end end;return#au+1 end;local av=function(av,aw,ax)local ay=1;local az=1;for aA=1,aw-1 do az=az+1;if av:sub(aA,aA)=="\n"then ay=ay+1;az=1 end end;error(string.format("%s at line %d col %d",ax,ay,az))end;local aw=function(aw)local ax=math.floor;if aw<=0x7f then return string.char(aw)elseif aw<=0x7ff then return string.char(ax(aw/64)+192,aw%64+128)elseif aw<=0xffff then return string.char(ax(aw/4096)+224,ax(aw%4096/64)+128,aw%64+128)elseif aw<=0x10ffff then return string.char(ax(aw/262144)+240,ax(aw%262144/4096)+128,ax(aw%4096/64)+128,aw%64+128)end;error(string.format("invalid unicode codepoint '%x'",aw))end;local ax=function(ax)local ay=tonumber(ax:sub(1,4),16)local az=tonumber(ax:sub(7,10),16)if az then return aw((ay-0xd800)*0x400+az-0xdc00+0x10000)else return aw(ay)end end;local ay=function(ay,az)local aA=""local aB=az+1;local aC=aB;while aB<=#ay do local aD=ay:byte(aB)if aD<32 then av(ay,aB,"control character in string")elseif aD==92 then aA=aA..ay:sub(aC,aB-1)aB=aB+1;local aE=ay:sub(aB,aB)if aE=="u"then local aF=ay:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",aB+1)or ay:match("^%x%x%x%x",aB+1)or av(ay,aB-1,"invalid unicode escape in string")aA=aA..ax(aF)aB=aB+#aF else if not ar[aE]then av(ay,aB-1,"invalid escape char '"..aE.."' in string")end;aA=aA..af[aE]end;aC=aB+1 elseif aD==34 then aA=aA..ay:sub(aC,aB-1)return aA,aB+1 end;aB=aB+1 end;av(ay,az,"expected closing quote for string")end;local az=function(az,aA)local aB=au(az,aA,aq)local aC=az:sub(aA,aB-1)local aD=tonumber(aC)if not aD then av(az,aA,"invalid number '"..aC.."'")end;return aD,aB end;local aA=function(aA,aB)local aC=au(aA,aB,aq)local aD=aA:sub(aB,aC-1)if not as[aD]then av(aA,aB,"invalid literal '"..aD.."'")end;return at[aD],aC end;local aB=function(aB,aC)local aD={}local aE=1;aC=aC+1;while 1 do local aF;aC=au(aB,aC,ap,true)if aB:sub(aC,aC)=="]"then aC=aC+1;break end;aF,aC=an(aB,aC)aD[aE]=aF;aE=aE+1;aC=au(aB,aC,ap,true)local aG=aB:sub(aC,aC)aC=aC+1;if aG=="]"then break end;if aG~=","then av(aB,aC,"expected ']' or ','")end end;return aD,aC end;local aC=function(aC,aD)local aE={}aD=aD+1;while 1 do local aF,aG;aD=au(aC,aD,ap,true)if aC:sub(aD,aD)=="}"then aD=aD+1;break end;if aC:sub(aD,aD)~='"'then av(aC,aD,"expected string for key")end;aF,aD=an(aC,aD)aD=au(aC,aD,ap,true)if aC:sub(aD,aD)~=":"then av(aC,aD,"expected ':' after key")end;aD=au(aC,aD+1,ap,true)aG,aD=an(aC,aD)aE[aF]=aG;aD=au(aC,aD,ap,true)local aH=aC:sub(aD,aD)aD=aD+1;if aH=="}"then break end;if aH~=","then av(aC,aD,"expected '}' or ','")end end;return aE,aD end;local aD={['"']=ay,["0"]=az,["1"]=az,["2"]=az,["3"]=az,["4"]=az,["5"]=az,["6"]=az,["7"]=az,["8"]=az,["9"]=az,["-"]=az,t=aA,f=aA,n=aA,["["]=aB,["{"]=aC}an=function(aE,aF)local aG=aE:sub(aF,aF)local aH=aD[aG]if aH then return aH(aE,aF)end;av(aE,aF,"unexpected character '"..aG.."'")end;local aE=function(aE)if type(aE)~="string"then error("expected argument of type string, got "..type(aE))end;local aF,aG=an(aE,au(aE,1,ap,true))aG=au(aE,aG,ap,true)if aG<=#aE then av(aE,aG,"trailing garbage")end;return aF end;
local aF,aG,aH=am,aE,Z;





local aI={}

local aJ=a.load'a'


function aI.New(aK,aL)

local aM=aK;
local aN=aL;
local aO=true;


local aP=function(aP)end;


repeat task.wait(1)until game:IsLoaded();


local aQ=false;
local aR,aS,aT,aU,aV,aW,aX,aY,aZ=setclipboard or toclipboard,request or http_request or syn_request,string.char,tostring,string.sub,os.time,math.random,math.floor,gethwid or function()return aJ(game:GetService"Players").LocalPlayer.UserId end
local a_,a0="",0;


local a1="https://api.platoboost.app";
local a2=aS{
Url=a1 .."/public/connectivity",
Method="GET"
};
if a2.StatusCode~=200 and a2.StatusCode~=429 then
a1="https://api.platoboost.net";
end


function cacheLink()
if a0+(600)<aW()then
local a3=aS{
Url=a1 .."/public/start",
Method="POST",
Body=aF{
service=aM,
identifier=aH(aZ())
},
Headers={
["Content-Type"]="application/json",
["User-Agent"]="Roblox/Exploit"
}
};

if a3.StatusCode==200 then
local a4=aG(a3.Body);

if a4.success==true then
a_=a4.data.url;
a0=aW();
return true,a_
else
aP(a4.message);
return false,a4.message
end
elseif a3.StatusCode==429 then
local a4="you are being rate limited, please wait 20 seconds and try again.";
aP(a4);
return false,a4
end

local a4="Failed to cache link.";
aP(a4);
return false,a4
else
return true,a_
end
end

cacheLink();


local a3=function()
local a3=""
for a4=1,16 do
a3=a3 ..aT(aY(aX()*(26))+97)
end
return a3
end


for a4=1,5 do
local a5=a3();
task.wait(0.2)
if a3()==a5 then
local a6="platoboost nonce error.";
aP(a6);
error(a6);
end
end


local a4=function()
local a4,a5=cacheLink();

if a4 then
aR(a5);
end
end


local a5=function(a5)
local a6=a3();
local a7=a1 .."/public/redeem/"..aU(aM);

local a8={
identifier=aH(aZ()),
key=a5
}

if aO then
a8.nonce=a6;
end

local a9=aS{
Url=a7,
Method="POST",
Body=aF(a8),
Headers={
["Content-Type"]="application/json"
}
};

if a9.StatusCode==200 then
local b=aG(a9.Body);

if b.success==true then
if b.data.valid==true then
if aO then
if b.data.hash==aH("true".."-"..a6 .."-"..aN)then
return true
else
aP"failed to verify integrity.";
return false
end
else
return true
end
else
aP"key is invalid.";
return false
end
else
if aV(b.message,1,27)=="unique constraint violation"then
aP"you already have an active key, please wait for it to expire before redeeming it.";
return false
else
aP(b.message);
return false
end
end
elseif a9.StatusCode==429 then
aP"you are being rate limited, please wait 20 seconds and try again.";
return false
else
aP"server returned an invalid status code, please try again later.";
return false
end
end


local a6=function(a6)
if aQ==true then
return false,("A request is already being sent, please slow down.")
else
aQ=true;
end

local a7=a3();
local a8=a1 .."/public/whitelist/"..aU(aM).."?identifier="..aH(aZ()).."&key="..a6;

if aO then
a8=a8 .."&nonce="..a7;
end

local a9=aS{
Url=a8,
Method="GET",
};

aQ=false;

if a9.StatusCode==200 then
local b=aG(a9.Body);

if b.success==true then
if b.data.valid==true then
if aO then
if b.data.hash==aH("true".."-"..a7 .."-"..aN)then
return true,""
else
return false,("failed to verify integrity.")
end
else
return true
end
else
if aV(a6,1,4)=="KEY_"then
return true,a5(a6)
else
return false,("Key is invalid.")
end
end
else
return false,(b.message)
end
elseif a9.StatusCode==429 then
return false,("You are being rate limited, please wait 20 seconds and try again.")
else
return false,("Server returned an invalid status code, please try again later.")
end
end


local a7=function(a7)
local a8=a3();
local a9=a1 .."/public/flag/"..aU(aM).."?name="..a7;

if aO then
a9=a9 .."&nonce="..a8;
end

local b=aS{
Url=a9,
Method="GET",
};

if b.StatusCode==200 then
local ba=aG(b.Body);

if ba.success==true then
if aO then
if ba.data.hash==aH(aU(ba.data.value).."-"..a8 .."-"..aN)then
return ba.data.value
else
aP"failed to verify integrity.";
return nil
end
else
return ba.data.value
end
else
aP(ba.message);
return nil
end
else
return nil
end
end


return{
Verify=a6,
GetFlag=a7,
Copy=a4,
}
end


return aI end function a.j()






local aa=a.load'a'

local ab=aa(game:GetService"HttpService")
local ad={}

function ad.New(ae)
local af=gethwid or function()
return aa(game:GetService"Players").LocalPlayer.UserId
end
local ag,ah=request or http_request or syn_request,setclipboard or toclipboard

function ValidateKey(ai)
local aj="https://api.pandauth.com/api/v1/keys/validate"

local ak={
ServiceID=ae,
HWID=tostring(af()),
Key=tostring(ai),
}

local al=ab:JSONEncode(ak)
local am,an=pcall(function()
return ag{
Url=aj,
Method="POST",
Headers={
["User-Agent"]="Roblox/Exploit",
["Content-Type"]="application/json",
},
Body=al,
}
end)

if am and an then
if an.Success then
local ao,ap=pcall(function()
return ab:JSONDecode(an.Body)
end)

if ao and ap then
if ap.Authenticated_Status and ap.Authenticated_Status=="Success"then
return true,"Authenticated"
else
local aq=ap.Note or"Unknown reason"
return false,"Authentication failed: "..aq
end
else
return false,"JSON decode error"
end
else
warn(
" HTTP request was not successful. Code: "
..tostring(an.StatusCode)
.." Message: "
..an.StatusMessage
)
return false,"HTTP request failed: "..an.StatusMessage
end
else
return false,"Request pcall error"
end
end

function GetKeyLink()
return"https://new.pandadevelopment.net/getkey/"..tostring(ae).."?hwid="..tostring(af())
end

function CopyLink()
return ah(GetKeyLink())
end

return{
Verify=ValidateKey,
Copy=CopyLink,
}
end

return ad end function a.k()







local aa={}

function aa.New(ab,ad)
local ae="https://sdkapi-public.luarmor.net/library.lua"

local af=loadstring(game.HttpGet and game:HttpGet(ae)or HttpService:GetAsync(ae))()
local ag=setclipboard or toclipboard

af.script_id=ab

function ValidateKey(ah)
local ai=af.check_key(ah)


if ai.code=="KEY_VALID"then
return true,"Whitelisted!"
elseif ai.code=="KEY_HWID_LOCKED"then
return false,"Key linked to a different HWID. Please reset it using our bot"
elseif ai.code=="KEY_INCORRECT"then
return false,"Key is wrong or deleted!"
else
return false,"Key check failed:"..ai.message.." Code: "..ai.code
end
end

function CopyLink()
ag(tostring(ad))
end

return{
Verify=ValidateKey,
Copy=CopyLink,
}
end

return aa end function a.l()









local aa={}

function aa.New(ab,ad,ae)
JunkieProtected.API_KEY=ad
JunkieProtected.PROVIDER=ae
JunkieProtected.SERVICE_ID=ab

local function ValidateKey(af)
if not af or af==""then
print"No key provided!"

return false,"No key provided. Please get a key."
end

local ag=JunkieProtected.IsKeylessMode()
if ag and ag.keyless_mode then
print"Keyless mode enabled. Starting script..."
return true,"Keyless mode enabled. Starting script..."
end

local ah=JunkieProtected.ValidateKey{Key=af}
if ah=="valid"then
print"Key is valid! Starting script..."
load()
if _G.JD_IsPremium then
print"Premium user detected!"
else
print"Standard user"
end

return true,"Key is valid!"
else
local ai=JunkieProtected.GetKeyLink()
print"Invalid key!"

return false,"Invalid key. Get one from:"..ai
end
end

local function copyLink()
local af=JunkieProtected.GetKeyLink()

if setclipboard then
setclipboard(af)
end
end
return{
Verify=ValidateKey,
Copy=copyLink
}
end

return aa end function a.m()



return{
platoboost={
Name="Platoboost",
Icon="rbxassetid://75920162824531",
Args={"ServiceId","Secret"},

New=a.load'i'.New
},
pandadevelopment={
Name="Panda Development",
Icon="panda",
Args={"ServiceId"},

New=a.load'j'.New
},
luarmor={
Name="Luarmor",
Icon="rbxassetid://130918283130165",
Args={"ScriptId","Discord"},

New=a.load'k'.New
},
junkiedevelopment={
Name="Junkie Development",
Icon="rbxassetid://106310347705078",
Args={"ServiceId","ApiKey","Provider"},

New=a.load'l'.New
},


}end function a.n()



return[[
{
    "name": "windui",
    "version": "1.6.65",
    "main": "./dist/main.lua",
    "repository": "https://github.com/article-hub-studio/WindUI-Skibidi",
    "discord": "https://discord.gg/ftgs-development-hub-1300692552005189632",
    "author": "Footagesus",
    "description": "Roblox UI Library for scripts",
    "license": "MIT",
    "scripts": {
        "dev": "bash build/build.sh dev $INPUT_FILE",
        "build": "bash build/build.sh build $INPUT_FILE",
        "sync:pages": "bash build/sync-pages.sh",
        "live": "python3 -m http.server 8642",
        "watch": "chokidar . -i 'node_modules' -i 'dist' -i 'build' -c 'npm run dev --'",
        "live-build": "concurrently \"npm run live\" \"npm run watch --\"",
        "example-live-build": "INPUT_FILE=main_example.lua npm run live-build",
        "updater": "python3 updater/main.py",
        "docs:dev": "npm --prefix website run dev",
        "docs:build": "npm --prefix website run build",
        "docs:start": "npm --prefix website run start",
        "verify:notification": "stylua --syntax Luau --check src/components/Notification.lua tests/Notification.lua && node tests/notification-layout-safety.test.js",
        "verify:ui": "stylua --syntax Luau --check src/modules/Icons.lua src/modules/Creator.lua src/Init.lua src/components/Notification.lua src/components/window/Openbutton.lua src/themes/Fallbacks.lua tests/Notification.lua && node tests/notification-layout-safety.test.js && node tests/ui-library-advanced.test.js",
        "test:static": "node tests/acrylic-theme-safety.test.js && node tests/notification-layout-safety.test.js && node tests/ui-library-advanced.test.js && node tests/input-lifecycle-safety.test.js && node tests/type-window-presets.test.js && node tests/docs-theme-parser.test.js && node tests/pages-deploy.test.js && node tests/website-layout.test.js && node tests/island-notification.test.js"
    },
    "keywords": [
        "ui-library",
        "ui-design",
        "script",
        "script-hub",
        "exploiting"
    ],
    "devDependencies": {
        "chokidar-cli": "^3.0.0",
        "concurrently": "^9.2.0"
    }
}
]]end function a.o()

local aa={}

local ab=a.load'e'
local ad=ab.New
local ae=ab.Tween

function aa.New(af,ag,ah,ai,aj,ak,al,am)
ai=ai or"Primary"
local an=am or(not al and 10 or 999)
local ao
if ag and ag~=""then
ao=ad("ImageLabel",{
Image=ab.Icon(ag)[1],
ImageRectSize=ab.Icon(ag)[2].ImageRectSize,
ImageRectOffset=ab.Icon(ag)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ImageColor3=ai=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=ai=="White"and 0.4 or 0,
ThemeTag={
ImageColor3=ai~="White"and"Icon"or nil,
},
})
end

local ap=ad("TextButton",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=aj,
BackgroundTransparency=1,
},{
ab.NewRoundFrame(an,"Squircle",{
ThemeTag={
ImageColor3=ai~="White"and"Button"or nil,
},
ImageColor3=ai=="White"and Color3.new(1,1,1)or nil,
Size=UDim2.new(1,0,1,0),
Name="Squircle",
ImageTransparency=ai=="Primary"and 0 or ai=="White"and 0 or 0.9,
}),

ab.NewRoundFrame(an,"Squircle",{



ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(1,0,1,0),
Name="Special",
ImageTransparency=ai=="Secondary"and 0.95 or 1,
}),

ab.NewRoundFrame(an,"Shadow-sm",{



ImageColor3=Color3.new(0,0,0),
Size=UDim2.new(1,3,1,3),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Shadow",

ImageTransparency=1,
Visible=not al,
}),

ab.NewRoundFrame(an,"SquircleGlass",{
ThemeTag={
ImageColor3="White",
},
Size=UDim2.new(1,1,1,1),

ImageTransparency=0.9,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Outline",
},{













}),

ab.NewRoundFrame(an,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3=ai~="White"and"Text"or nil,
},
ImageColor3=ai=="White"and Color3.new(0,0,0)or nil,
ImageTransparency=1,
},{
ad("UIPadding",{
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
}),
ad("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
ao,
ad("TextLabel",{
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=af or"Button",
ThemeTag={
TextColor3=(ai~="Primary"and ai~="White")and"Text",
},
TextColor3=ai=="Primary"and Color3.new(1,1,1)
or ai=="White"and Color3.new(0,0,0)
or nil,
AutomaticSize="XY",
TextSize=18,
}),
}),
})

ab.AddSignal(ap.MouseEnter,function()
ae(ap.Frame,0.047,{ImageTransparency=0.95}):Play()
end)
ab.AddSignal(ap.MouseLeave,function()
ae(ap.Frame,0.047,{ImageTransparency=1}):Play()
end)
ab.AddSignal(ap.MouseButton1Click,function()
if ak then
ak:Close()()
end
if ah then
ab.SafeCallback(ah)
end
end)

return ap
end

return aa end function a.p()

local aa={}

local ab=a.load'e'
local ad=a.load'f'
local ae=ab.New

function aa.New(af,ag,ah,ai,aj,ak,al,am,an)
ai=ai or"Input"
local ao=al or 10
local ap
if ag and ag~=""then
ap=ae("ImageLabel",{
Image=ab.Icon(ag)[1],
ImageRectSize=ab.Icon(ag)[2].ImageRectSize,
ImageRectOffset=ab.Icon(ag)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
})
end

local aq=ai=="Textarea"

local ar=ae("TextBox",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,ap and-29 or 0,1,0),
PlaceholderText=af,
ClearTextOnFocus=am or false,
ClipsDescendants=true,
TextWrapped=aq,
MultiLine=aq,
TextXAlignment="Left",
TextYAlignment=ai~="Textarea"and"Center"or"Top",

ThemeTag={
PlaceholderColor3="PlaceholderText",
TextColor3="Text",
},
})

local as=ab.NewRoundFrame(ao,"Squircle",{
ThemeTag={
ImageColor3="Placeholder",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
})
local at=not an and ab.NewRoundFrame(ao-1,"SquircleGlass",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,1,1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageTransparency=0.8,
})or nil
local au=ab.NewRoundFrame(ao,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3="LabelBackground",
ImageTransparency="LabelBackgroundTransparency",
},


},{
ae("UIPadding",{
PaddingTop=UDim.new(0,ai~="Textarea"and 0 or 12),
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
PaddingBottom=UDim.new(0,ai~="Textarea"and 0 or 12),
}),
ae("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment=ai~="Textarea"and"Center"or"Top",
HorizontalAlignment="Left",
}),
ap,
ar,
})

local av=ae("Frame",{
Size=UDim2.new(1,0,0,42),
Parent=ah,
BackgroundTransparency=1,
},{
ae("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
as,
at,
au,
}),
})










if ak then
ab.AddSignal(ar:GetPropertyChangedSignal"Text",function()
if aj then
ab.SafeCallback(aj,ar.Text)
end
end)
else
ab.AddSignal(ar.FocusLost,function()
if aj then
ab.SafeCallback(aj,ar.Text)
end
end)
end

ab.AddSignal(ar.Focused,function()
ad.Play(as,"Focus",{ImageTransparency=0.78},nil,nil,"Focus")
if at then
ad.Play(at,"Focus",{ImageTransparency=0.65},nil,nil,"Focus")
end
end)
ab.AddSignal(ar.FocusLost,function()
ad.Play(as,"Focus",{ImageTransparency=0.85},nil,nil,"Focus")
if at then
ad.Play(at,"Focus",{ImageTransparency=0.8},nil,nil,"Focus")
end
end)

return av
end

return aa end function a.q()

local aa=a.load'e'
local ab=aa.New
local ad=aa.Tween




local ae={
Holder=nil,

Parent=nil,
}

function ae.Create(af,ag,ah,ai,aj)
local ak={
UICorner=28,
UIPadding=12,

Window=ah,
WindUI=ai,

UIElements={},
}

if af then
ak.UIPadding=0
end
if af then
ak.UICorner=26
end

ag=ag or"Dialog"

if not af then
ak.UIElements.FullScreen=ab("Frame",{
ZIndex=999,
BackgroundTransparency=1,
BackgroundColor3=Color3.fromHex"#000000",
Size=UDim2.new(1,0,1,0),
Active=false,
Visible=false,
Parent=ae.Parent
or(ah and ah.UIElements and ah.UIElements.Main and ah.UIElements.Main.Main),
},{
ab("UICorner",{
CornerRadius=UDim.new(0,ah.UICorner),
}),
})
end

ab("ImageLabel",{
Image="rbxassetid://8992230677",
ThemeTag={
ImageColor3="WindowShadow",

},
ImageTransparency=1,
Size=UDim2.new(1,100,1,100),
Position=UDim2.new(0,-50,0,-50),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})

ak.UIElements.Main=ab("Frame",{
Size=UDim2.new(0,280,0,0),
ThemeTag={
BackgroundColor3=ag.."Background",
},
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=false,
ZIndex=99999,
},{
ab("UIPadding",{
PaddingTop=UDim.new(0,ak.UIPadding),
PaddingLeft=UDim.new(0,ak.UIPadding),
PaddingRight=UDim.new(0,ak.UIPadding),
PaddingBottom=UDim.new(0,ak.UIPadding),
}),
})

ak.UIElements.MainContainer=aa.NewRoundFrame(ak.UICorner,"Squircle",{
Visible=false,

ImageTransparency=af and 0.15 or 0,
Parent=aj or ak.UIElements.FullScreen,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
AutomaticSize="XY",
ThemeTag={
ImageColor3=ag.."Background",
ImageTransparency=ag.."BackgroundTransparency",
},
ZIndex=9999,
},{






ak.UIElements.Main,




















})

function ak.Open(al)
if not af then
ak.UIElements.FullScreen.Visible=true
ak.UIElements.FullScreen.Active=true
end

task.spawn(function()
ak.UIElements.MainContainer.Visible=true

if not af then
ad(ak.UIElements.FullScreen,0.1,{BackgroundTransparency=0.65}):Play()
end
ad(ak.UIElements.MainContainer,0.1,{ImageTransparency=0}):Play()


task.spawn(function()
task.wait(0.05)
ak.UIElements.Main.Visible=true
end)
end)
end
function ak.Close(al)
if not af then
ad(ak.UIElements.FullScreen,0.1,{BackgroundTransparency=1}):Play()
ak.UIElements.FullScreen.Active=false
task.spawn(function()
task.wait(0.1)
ak.UIElements.FullScreen.Visible=false
end)
end
ak.UIElements.Main.Visible=false

ad(ak.UIElements.MainContainer,0.1,{ImageTransparency=1}):Play()



task.spawn(function()
task.wait(0.1)
if not af then
ak.UIElements.FullScreen:Destroy()
else
ak.UIElements.MainContainer:Destroy()
end
end)

return function()end
end


return ak
end

return ae end function a.r()

local aa={}

local ab=a.load'e'
local ad=a.load'f'
local ae=ab.New
local af=game:GetService"Workspace"

local ag=a.load'o'.New
local ah=a.load'p'.New

local function GetViewportSize()
local ai=af.CurrentCamera
return ai and ai.ViewportSize or Vector2.new(1280,720)
end

function aa.new(ai,aj,ak,al)
local am=a.load'q'
local an=am.Create(true,"Popup",ai.Window,ai.WindUI,ai.WindUI.ScreenGui.KeySystem)

local ao={}

local ap

local aq=GetViewportSize()
local ar=aq.X<560
local as=ai.KeySystem.Thumbnail and ai.KeySystem.Thumbnail.Image and not ar
local at=(as and ai.KeySystem.Thumbnail.Width)or 200

local au=ai.KeySystem.Width or 430
if as then
au=430+(at/2)
end
au=math.floor(math.min(au,math.max(300,aq.X-24)))

an.UIElements.Main.AutomaticSize="Y"
an.UIElements.Main.Size=UDim2.new(0,au,0,0)
an.UIElements.MainContainer.ClipsDescendants=true

local av=ae("UIScale",{
Name="Scale",
Scale=0.96,
Parent=an.UIElements.MainContainer,
})

ab.NewRoundFrame(26,"SquircleGlass",{
Name="GlassLayer",
Size=UDim2.new(1,1,1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageTransparency=0.84,
ZIndex=9998,
Parent=an.UIElements.MainContainer,
ThemeTag={
ImageColor3="Primary",
},
})

ab.NewRoundFrame(26,"SquircleOutline",{
Name="Outline",
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.62,
ZIndex=9998,
Parent=an.UIElements.MainContainer,
ThemeTag={
ImageColor3="Outline",
},
})

local aw

if ai.Icon then
aw=
ab.Image(ai.Icon,ai.Title..":"..ai.Icon,0,"Temp","KeySystem",ai.IconThemed)
aw.Size=UDim2.new(0,24,0,24)
aw.LayoutOrder=-1
end

local ax=ae("TextLabel",{
AutomaticSize="XY",
BackgroundTransparency=1,
Text=ai.KeySystem.Title or ai.Title,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
TextSize=20,
})

local ay=ae("TextLabel",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Text=ai.KeySystem.Subtitle or ai.KeySystem.Description or"Secure access gate",
TextXAlignment="Left",
TextTransparency=0.34,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
TextSize=13,
})

local az=ae("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ae("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aw,
ax,
})

local aA=ae("TextLabel",{
BackgroundTransparency=1,
Text="Waiting",
TextSize=12,
TextTransparency=0.08,
AutomaticSize="XY",
FontFace=Font.new(ab.Font,Enum.FontWeight.Bold),
ThemeTag={
TextColor3="Text",
},
})

local aB=ab.NewRoundFrame(999,"Squircle",{
Size=UDim2.new(0,0,0,28),
AutomaticSize="X",
ImageTransparency=0.84,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ae("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
ae("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,6),
}),
ab.NewRoundFrame(999,"Squircle",{
Name="Dot",
Size=UDim2.fromOffset(7,7),
ImageTransparency=0,
ThemeTag={
ImageColor3="Primary",
},
}),
aA,
})

local aC=ae("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{
ae("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
az,
aB,
})

az.Size=UDim2.new(1,-112,0,0)

local aD=ab.NewRoundFrame(18,"Squircle",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
ImageTransparency=0.86,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ae("UIGradient",{
Rotation=18,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.06),
NumberSequenceKeypoint.new(1,0.34),
},
}),
ae("UIPadding",{
PaddingTop=UDim.new(0,14),
PaddingLeft=UDim.new(0,14),
PaddingRight=UDim.new(0,14),
PaddingBottom=UDim.new(0,14),
}),
ae("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
}),
aC,
ay,
})

local aE=ah(ai.KeySystem.Placeholder or"Enter Key","key",nil,"Input",function(aE)
ap=aE
end)

local aF
if ai.KeySystem.Note and ai.KeySystem.Note~=""then
aF=ae("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=ai.KeySystem.Note,
TextSize=18,
TextTransparency=0.4,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
RichText=true,
TextWrapped=true,
})
end

local aG=ae("UIGradient",{
Name="FillGradient",
Rotation=0,
Offset=Vector2.new(-0.2,0),
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.08),
NumberSequenceKeypoint.new(0.45,0),
NumberSequenceKeypoint.new(1,0.2),
},
})
local aH=ab.NewRoundFrame(999,"Squircle",{
Name="Fill",
Size=UDim2.new(0.18,0,1,0),
ClipsDescendants=true,
ImageTransparency=0.02,
ZIndex=3,
ThemeTag={
ImageColor3="Primary",
},
},{
aG,
ab.NewRoundFrame(999,"SquircleGlass",{
Name="LiquidSheen",
Size=UDim2.new(0.42,0,1,0),
Position=UDim2.new(0.18,0,0,0),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0.7,
ZIndex=4,
},{
ae("UIGradient",{
Rotation=0,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.48,0.22),
NumberSequenceKeypoint.new(1,1),
},
}),
}),
})
local aI=ae("TextLabel",{
Size=UDim2.new(1,0,0,16),
BackgroundTransparency=1,
Text="Access check ready",
TextSize=12,
TextTransparency=0.34,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})
local aJ=ab.NewRoundFrame(999,"Squircle",{
Name="ProgressTrack",
Size=UDim2.new(1,0,0,10),
ClipsDescendants=true,
ImageTransparency=0.84,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ab.NewRoundFrame(999,"SquircleGlass",{
Name="TrackGlass",
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0.92,
ZIndex=2,
}),
aH,
ab.NewRoundFrame(999,"SquircleOutline",{
Name="TrackOutline",
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.72,
ZIndex=5,
ThemeTag={
ImageColor3="Outline",
},
}),
})
local aK=ae("Frame",{
Size=UDim2.new(1,0,0,30),
BackgroundTransparency=1,
},{
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,6),
}),
aI,
aJ,
})

local function SetState(aL,aM,aN)
aA.Text=tostring(aL or aA.Text)
aI.Text=tostring(aL or aI.Text)
if aN then
aB.Dot.ImageColor3=Color3.fromRGB(255,94,94)
aH.ImageColor3=Color3.fromRGB(255,94,94)
else
ab.SetThemeTag(aB.Dot,{
ImageColor3="Primary",
},0.12)
ab.SetThemeTag(aH,{
ImageColor3="Primary",
},0.12)
end
if aM~=nil then
aG.Offset=Vector2.new(-0.2,0)
ad.Play(aH,"Switch",{
Size=UDim2.new(math.clamp(tonumber(aM)or 0,0,1),0,1,0),
},nil,nil,"KeySystemProgress")
ad.Play(aG,"Background",{
Offset=Vector2.new(0.45,0),
},Enum.EasingStyle.Sine,Enum.EasingDirection.Out,"KeySystemProgressSheen")
end
end

local aL=ae("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
ae("Frame",{
BackgroundTransparency=1,
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
},{
ae("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
}),
}),
})

local aM
if as then
local aN
if ai.KeySystem.Thumbnail.Title then
aN=ae("TextLabel",{
Text=ai.KeySystem.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
aM=ae("ImageLabel",{
Image=ai.KeySystem.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,at,1,-12),
Position=UDim2.new(0,6,0,6),
Parent=an.UIElements.Main,
ScaleType="Crop",
},{
aN,
ae("UICorner",{
CornerRadius=UDim.new(0,20),
}),
})
end

ae("Frame",{

Size=UDim2.new(1,aM and-at or 0,1,0),
Position=UDim2.new(0,aM and at or 0,0,0),
BackgroundTransparency=1,
Parent=an.UIElements.Main,
},{
ae("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ae("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
aD,
aF,
aE,
aK,
aL,
ae("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
}),
}),
})





local aN=ag("Exit","log-out",function()
an:Close()()
end,"Tertiary",aL.Frame)

if aM then
aN.Parent=aM
aN.Size=UDim2.new(0,0,0,42)
aN.Position=UDim2.new(0,10,1,-10)
aN.AnchorPoint=Vector2.new(0,1)
end

local function NotifyKeySystem(aO,aP,aQ)
if ai.WindUI and ai.WindUI.Notify then
ai.WindUI:Notify{
Title="Key System",
Content=aO,
Icon=aP or"key",
Style=aQ,
}
end
end

local function CopyRawLink(aO)
aO=aO and tostring(aO)or""
if aO==""then
return false,"No key link configured."
end

local aP=setclipboard or toclipboard
if not aP then
return false,"Clipboard is not available on this executor."
end

aP(aO)
return true
end

local function PickServiceLink(aO)
return aO.Discord
or aO.URL
or aO.Url
or aO.url
or aO.Link
or aO.link
end

local function CopyServiceLink(aO)
local aP=PickServiceLink(aO.Config)
local aQ,aR

if aP then
aQ,aR=CopyRawLink(aP)
elseif aO.Instance and type(aO.Instance.Copy)=="function"then
aQ,aR=pcall(aO.Instance.Copy)
else
aQ,aR=false,aO.Error or"Service link is not ready."
end

if aQ then
SetState("Key link copied",0.36)
NotifyKeySystem("Key link copied to clipboard.","key","Success")
else
SetState("Copy unavailable",0.08,true)
NotifyKeySystem(tostring(aR or"Unable to copy key link."),"triangle-alert","Warning")
end
end

if ai.KeySystem.URL and not ai.KeySystem.API then
ag("Get key","key",function()
local aO,aP=CopyRawLink(ai.KeySystem.URL)
if aO then
SetState("Key link copied",0.36)
NotifyKeySystem("Key link copied to clipboard.","key","Success")
else
SetState("Copy unavailable",0.08,true)
NotifyKeySystem(tostring(aP),"triangle-alert","Warning")
end
end,"Secondary",aL.Frame)
end

if ai.KeySystem.API then
local aO={}
for aP,aQ in next,ai.KeySystem.API do
local aR=ai.WindUI.Services[aQ.Type]
if aR then
local aS={}
for aT,aU in next,aR.Args do
table.insert(aS,aQ[aU])
end

local aT,aU=pcall(function()
return aR.New(table.unpack(aS))
end)

local aV={
Config=aQ,
Definition=aR,
Instance=nil,
Error=nil,
}

if aT and aU then
aU.Type=aQ.Type
aV.Instance=aU
table.insert(ao,aU)
else
aV.Error=aU
end

table.insert(aO,aV)
end
end

local aP=math.min(240,math.max(190,au-42))
local aQ=false

if#aO==1 then
ag("Get key","key",function()
CopyServiceLink(aO[1])
end,"Secondary",aL.Frame)
elseif#aO>1 then
local aR=ag("Get key","key",nil,"Secondary",aL.Frame)

local aS=ab.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,1,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=0.9,
})

ae("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Parent=aR.Frame,
},{
aS,
ae("UIPadding",{
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
}),
})

local aT=ab.Image("chevron-down","chevron-down",0,"Temp","KeySystem",true)

aT.Size=UDim2.new(1,0,1,0)

ae("Frame",{
Size=UDim2.new(0,21,0,21),
Parent=aR.Frame,
BackgroundTransparency=1,
},{
aT,
})

local aU=ab.NewRoundFrame(15,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ZIndex=99999,
ThemeTag={
ImageColor3="Background",
},
},{
ae("UIPadding",{
PaddingTop=UDim.new(0,5),
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
PaddingBottom=UDim.new(0,5),
}),
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,5),
}),
})

local aV=ae("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(0,aP,0,0),
ClipsDescendants=true,
AnchorPoint=Vector2.new(1,0),
Parent=aR,
Position=UDim2.new(1,0,1,10),
ZIndex=99999,
},{
aU,
})

ae("TextLabel",{
Text="Select Service",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=15,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
TextXAlignment="Left",
Parent=aU,
ZIndex=100000,
},{
ae("UIPadding",{
PaddingTop=UDim.new(0,8),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,8),
}),
})

for aW,aX in next,aO do
local aY=aX.Config
local aZ=aX.Definition
local a_=aY.Icon or aZ.Icon or"key-round"
local a0=ab.Image(a_,a_,0,"Temp","KeySystem",true)
a0.Size=UDim2.new(0,20,0,20)
a0.ZIndex=100000

local a1=ab.NewRoundFrame(10,"Squircle",{
Size=UDim2.new(1,0,0,0),
ThemeTag={ImageColor3="Text"},
ImageTransparency=1,
Parent=aU,
AutomaticSize="Y",
ZIndex=100000,
},{
ae("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
}),
a0,
ae("UIPadding",{
PaddingTop=UDim.new(0,9),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,9),
}),
ae("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,-28,0,0),
AutomaticSize="Y",
ZIndex=100000,
},{
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,5),
HorizontalAlignment="Center",
}),
ae("TextLabel",{
Text=aY.Title or aZ.Name,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={TextColor3="Text"},
TextTransparency=0.05,
TextSize=18,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
TextXAlignment="Left",
ZIndex=100001,
}),
ae("TextLabel",{
Text=aY.Desc or"",
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
ThemeTag={TextColor3="Text"},
TextTransparency=0.2,
TextSize=16,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
TextWrapped=true,
Visible=aY.Desc and true or false,
TextXAlignment="Left",
ZIndex=100001,
}),
}),
},true)

ab.AddSignal(a1.MouseEnter,function()
ad.Play(a1,"Hover",{ImageTransparency=0.94},nil,nil,"ServiceHover")
end)
ab.AddSignal(a1.InputEnded,function()
ad.Play(a1,"Hover",{ImageTransparency=1},nil,nil,"ServiceHover")
end)
ad.AttachPress(a1,ab,{
Amount=0.985,
})
ab.AddSignal(a1.MouseButton1Click,function()
CopyServiceLink(aX)
end)
end

ab.AddSignal(aR.MouseButton1Click,function()
if not aQ then
ad.Play(
aV,
"Expand",
{Size=UDim2.new(0,aP,0,aU.AbsoluteSize.Y+1)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"KeyService"
)
ad.Play(aT,"Expand",{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"KeyServiceChevron")
else
ad.Play(
aV,
"Expand",
{Size=UDim2.new(0,aP,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"KeyService"
)
ad.Play(aT,"Expand",{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"KeyServiceChevron")
end
aQ=not aQ
end)
end
end

local function handleSuccess(aO,aP)
SetState("Access granted",1)
an:Close()()
if aP and writefile then
pcall(function()
writefile((ai.Folder or"Temp").."/"..aj..".key",tostring(aO))
end)
end
task.wait(0.35)
ak(true)
end

local aO=false
local aP=ag("Submit","arrow-right",function()
if aO then
return
end
aO=true
SetState("Checking key",0.72)

local aP=tostring(ap or"empty")
local function Reject(aQ)
aO=false
SetState("Invalid key",0.08,true)
ai.WindUI:Notify{
Title="Key System",
Content=aQ or"Invalid key.",
Icon="triangle-alert",
Style="Error",
}
end

if ai.KeySystem.KeyValidator then
local aQ,aR,aS=pcall(ai.KeySystem.KeyValidator,aP)
if not aQ then
Reject(tostring(aR))
return
end

if aR then
handleSuccess(aP,ai.KeySystem.SaveKey)
else
Reject(aS or"Invalid key.")
end
elseif not ai.KeySystem.API then
local aQ=type(ai.KeySystem.Key)=="table"and table.find(ai.KeySystem.Key,aP)
or ai.KeySystem.Key==aP

if aQ then
handleSuccess(aP,ai.KeySystem.SaveKey)
else
Reject"Invalid key."
end
else
local aQ,aR
for aS,aT in next,ao do
local aU,aV,aW=pcall(aT.Verify,aP)
if not aU then
local aX=aV
aV=false
aW=tostring(aX)
end
if aV then
aQ,aR=true,aW
break
end
aR=aW
end

if aQ then
handleSuccess(aP,ai.KeySystem.SaveKey~=false)
else
Reject(aR or"Invalid key.")
end
end
end,"Primary",aL)

aP.AnchorPoint=Vector2.new(1,0.5)
aP.Position=UDim2.new(1,0,0.5,0)










SetState("Waiting for key",0.18)
an:Open()
ad.Play(av,"DropdownOpen",{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"KeySystemScale")
end

return aa end function a.s()

local aa={}

local ab=a.load'e'
local ad=a.load'f'
local ae=ab.New
local af=game:GetService"Workspace"

local function AsConfig(ag)
if ag==true then
return{}
end
return typeof(ag)=="table"and ag or{}
end

local function ClampProgress(ag)
return math.clamp(tonumber(ag)or 0,0,1)
end

local function CreateIcon(ag,ah,ai,aj)
local ak=
ab.Image(ag or"sparkles",ag or"sparkles",0,aj or"Temp","LoadingScreen",true,true)
ak.Size=UDim2.fromOffset(ai or 22,ai or 22)
ak.Parent=ah
return ak
end

local function GetViewportSize()
local ag=af.CurrentCamera
return ag and ag.ViewportSize or Vector2.new(1280,720)
end

function aa.new(ag,ah)
ah=AsConfig(ah)

local ai=ah.Steps or{"Theme","Motion","Interface"}
if#ai==0 then
ai={"Interface"}
end
local aj=GetViewportSize()
local ak=math.floor(math.min(ah.Width or 360,math.max(286,aj.X-28)))
local al=math.max(tonumber(ah.Height)or 188,168)
local am={
Closed=false,
Progress=ClampProgress(ah.Progress or 0.08),
UIElements={},
}

local an=ae("Frame",{
Name=ah.Name or"WindUILoadingScreen",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Active=true,
ZIndex=ah.ZIndex or 11000,
Parent=ah.Parent or ag.ScreenGui,
})

local ao=ae("Frame",{
Name="Scrim",
Size=UDim2.new(1,0,1,0),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=1,
ZIndex=an.ZIndex,
Parent=an,
})

local ap=ae("CanvasGroup",{
Name="Content",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
GroupTransparency=1,
ZIndex=an.ZIndex+1,
Parent=an,
})

local aq=ab.NewRoundFrame(ah.Corner or 28,"Squircle",{
Name="Card",
Size=UDim2.fromOffset(ak,al),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageTransparency=1,
ZIndex=an.ZIndex+2,
Parent=ap,
ThemeTag={
ImageColor3="Background",
},
},{
ae("UIScale",{
Name="Scale",
Scale=0.96,
}),
ab.NewRoundFrame(ah.Corner or 28,"SquircleGlass",{
Name="Glass",
Size=UDim2.new(1,1,1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageTransparency=0.82,
ZIndex=an.ZIndex+3,
ThemeTag={
ImageColor3="Primary",
},
}),
ab.NewRoundFrame(ah.Corner or 28,"SquircleOutline",{
Name="Outline",
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.64,
ZIndex=an.ZIndex+4,
ThemeTag={
ImageColor3="Outline",
},
}),
})

ab.CreateUIShadow(aq,{
BlurRadius=UDim.new(0,tonumber(ah.ShadowBlur)or 24),
Color=Color3.new(0,0,0),
Offset=UDim2.fromOffset(0,8),
Spread=UDim2.fromOffset(2,2),
Transparency=ab.ClampTransparency(ah.ShadowTransparency,0.42),
ZIndex=0,
})

local ar=ae("Frame",{
Name="Body",
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
ZIndex=an.ZIndex+5,
Parent=aq,
},{
ae("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
}),
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,10),
SortOrder="LayoutOrder",
}),
})

local as=ab.NewRoundFrame(24,"Squircle",{
Name="Accent",
Size=UDim2.new(1,0,0,64),
ImageTransparency=0.82,
LayoutOrder=1,
ZIndex=an.ZIndex+5,
Parent=ar,
ThemeTag={
ImageColor3="Primary",
},
},{
ae("UIGradient",{
Name="AccentGradient",
Rotation=18,
Offset=Vector2.new(-0.25,0),
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.1),
NumberSequenceKeypoint.new(0.5,0.24),
NumberSequenceKeypoint.new(1,0.5),
},
}),
ae("UIPadding",{
PaddingLeft=UDim.new(0,14),
PaddingRight=UDim.new(0,14),
}),
ae("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,12),
}),
})

local at=ab.NewRoundFrame(999,"Squircle",{
Size=UDim2.fromOffset(42,42),
ImageTransparency=0.72,
ZIndex=an.ZIndex+6,
Parent=as,
ThemeTag={
ImageColor3="ElementBackground",
},
})
local au=CreateIcon(ah.Icon or"sparkles",at,21,ah.Folder)
au.AnchorPoint=Vector2.new(0.5,0.5)
au.Position=UDim2.new(0.5,0,0.5,0)

local av=ae("Frame",{
Size=UDim2.new(1,-54,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=as,
ZIndex=an.ZIndex+6,
},{
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,3),
}),
})

ae("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=ah.Title or"WindUI",
TextSize=18,
TextXAlignment="Left",
TextWrapped=true,
FontFace=Font.new(ab.Font,Enum.FontWeight.Bold),
Parent=av,
ThemeTag={
TextColor3="Text",
},
})

ae("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=ah.Desc or"Preparing interface",
TextSize=13,
TextTransparency=0.34,
TextXAlignment="Left",
TextWrapped=true,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Parent=av,
ThemeTag={
TextColor3="Text",
},
})

local aw=ae("Frame",{
Name="StatusRow",
Size=UDim2.new(1,0,0,18),
BackgroundTransparency=1,
LayoutOrder=2,
Parent=ar,
})

local ax=ae("TextLabel",{
Name="Status",
Size=UDim2.new(1,-48,1,0),
BackgroundTransparency=1,
Text=ah.Status or ai[1]or"Loading",
TextSize=13,
TextTransparency=0.18,
TextXAlignment="Left",
TextTruncate="AtEnd",
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Parent=aw,
ThemeTag={
TextColor3="Text",
},
})

local ay=ae("TextLabel",{
Name="Percent",
Size=UDim2.new(0,44,1,0),
Position=UDim2.fromScale(1,0),
AnchorPoint=Vector2.new(1,0),
BackgroundTransparency=1,
Text=tostring(math.floor(am.Progress*100+0.5)).."%",
TextSize=12,
TextTransparency=0.36,
TextXAlignment="Right",
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Parent=aw,
ThemeTag={
TextColor3="Text",
},
})

local az=ab.NewRoundFrame(999,"Squircle",{
Name="ProgressTrack",
Size=UDim2.new(1,0,0,10),
ImageTransparency=0.82,
LayoutOrder=3,
ZIndex=an.ZIndex+5,
Parent=ar,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ab.NewRoundFrame(999,"Squircle",{
Name="Fill",
Size=UDim2.new(am.Progress,0,1,0),
ImageTransparency=0.06,
ZIndex=an.ZIndex+6,
ThemeTag={
ImageColor3="Primary",
},
},{
ae("UIGradient",{
Name="FillGradient",
Rotation=0,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.05),
NumberSequenceKeypoint.new(0.5,0),
NumberSequenceKeypoint.new(1,0.18),
},
}),
}),
})

local aA=ae("Frame",{
Name="Steps",
Size=UDim2.new(1,0,0,28),
BackgroundTransparency=1,
LayoutOrder=4,
Parent=ar,
},{
ae("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
}),
})

local aB={}
for aC,aD in next,ai do
local aE=ab.NewRoundFrame(12,"Squircle",{
Size=UDim2.new(1/#ai,-6,1,0),
ImageTransparency=aC==1 and 0.84 or 0.94,
Parent=aA,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ae("UIPadding",{
PaddingLeft=UDim.new(0,8),
PaddingRight=UDim.new(0,8),
}),
ae("TextLabel",{
Name="Title",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Text=tostring(aD),
TextSize=11,
TextTransparency=aC==1 and 0.08 or 0.4,
TextTruncate="AtEnd",
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
})
table.insert(aB,aE)
end

local aC=0
local aD=1

local function UpdateStepVisuals(aE)
aD=math.clamp(tonumber(aE)or 1,1,math.max(#aB,1))
for aF,aG in next,aB do
local aH=aF<=aD
ad.Play(aG,"Switch",{ImageTransparency=aH and 0.84 or 0.94},nil,nil,"Step")
if aG.Title then
ad.Play(aG.Title,"Switch",{TextTransparency=aH and 0.08 or 0.4},nil,nil,"StepText")
end
end
end

function am.SetStatus(aE,aF)
ax.Text=tostring(aF or"")
return am
end

function am.SetProgress(aE,aF)
am.Progress=ClampProgress(aF)
ay.Text=tostring(math.floor(am.Progress*100+0.5)).."%"
ad.Play(az.Fill,"Switch",{
Size=UDim2.new(am.Progress,0,1,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"LoadingProgress")
if#aB>0 and ah.SyncSteps~=false then
UpdateStepVisuals(math.clamp(math.ceil(am.Progress*#aB),1,#aB))
end
return am
end

function am.Step(aE,aF,aG)
local aH=math.max(#aB,1)
local aI=math.clamp(tonumber(aF)or 1,1,aH)
if aG then
am:SetStatus(aG)
else
am:SetStatus(ai[aI]or ax.Text)
end
local aJ=aH==1 and 1 or(aI-1)/(aH-1)
am:SetProgress(aJ)
UpdateStepVisuals(aI)
return am
end

function am.Close(aE,aF)
if am.Closed then
return am
end
aC+=1
am.Closed=true
task.delay(tonumber(aF)or 0,function()
ad.Play(ap,"DropdownClose",{GroupTransparency=1},nil,nil,"LoadingContent")
ad.Play(ao,"DropdownClose",{BackgroundTransparency=1},nil,nil,"LoadingScrim")
ad.Play(aq,"DropdownClose",{ImageTransparency=1},nil,nil,"LoadingCard")
ad.Play(aq.Scale,"DropdownClose",{Scale=0.96},nil,nil,"LoadingScale")
task.wait(ad.GetDuration"DropdownClose"+0.03)
if an then
an:Destroy()
end
end)
return am
end

function am.Open(aE)
aC+=1
am.Closed=false
an.Visible=true
ao.BackgroundTransparency=1
ap.GroupTransparency=1
aq.ImageTransparency=1
aq.Scale.Scale=0.96
ad.Play(ao,"DropdownOpen",{
BackgroundTransparency=ah.ScrimTransparency or 0.2,
},nil,nil,"LoadingScrim")
ad.Play(ap,"DropdownOpen",{GroupTransparency=0},nil,nil,"LoadingContent")
ad.Play(
aq,
"DropdownOpen",
{ImageTransparency=ah.CardTransparency or 0.16},
nil,
nil,
"LoadingCard"
)
ad.Play(aq.Scale,"DropdownOpen",{Scale=1},nil,nil,"LoadingScale")
return am
end

function am.Play(aE,aF)
local aG=math.max(tonumber(aF)or tonumber(ah.Duration)or 1.2,0.05)
aC+=1
local aH=aC
local aI=os.clock()
local aJ=0

task.spawn(function()
while aH==aC and not am.Closed and an.Parent do
local aK=math.clamp((os.clock()-aI)/aG,0,1)
local aL=math.clamp(math.floor(aK*#ai)+1,1,math.max(#ai,1))

if aL~=aJ then
aJ=aL
if ah.AutoStatus~=false and ai[aL]then
am:SetStatus(ai[aL])
end
end

am:SetProgress(aK)
if aK>=1 then
break
end
task.wait(0.05)
end

if aH~=aC or am.Closed or not an.Parent then
return
end

am:SetStatus(ah.CompleteStatus or"Ready")
am:SetProgress(1)
am:Close(ah.CloseDelay or 0.18)
end)
return am
end

am.UIElements.Root=an
am.UIElements.Scrim=ao
am.UIElements.Content=ap
am.UIElements.Card=aq
am.UIElements.Body=ar
am.UIElements.Status=ax
am.UIElements.Percent=ay
am.UIElements.ProgressFill=az.Fill

am:Open()

if ad:IsEnabled()and not ad.Reduced then
task.spawn(function()
local aE=1
while not am.Closed and as and as.Parent do
local aF=as:FindFirstChild"AccentGradient"
local aG=az.Fill and az.Fill:FindFirstChild"FillGradient"
if aF then
ad.Play(
aF,
"Background",
{Offset=Vector2.new(aE*0.28,0)},
Enum.EasingStyle.Sine,
Enum.EasingDirection.InOut,
"LoadingSheen"
)
end
if aG then
ad.Play(
aG,
"Background",
{Offset=Vector2.new(aE*0.38,0)},
Enum.EasingStyle.Sine,
Enum.EasingDirection.InOut,
"LoadingFillSheen"
)
end
aE*=-1
task.wait(ad.GetDuration"Background"+0.18)
end
end)
end

if ah.Duration or ah.AutoClose then
am:Play(tonumber(ah.Duration)or 1.2)
end

return am
end

return aa end function a.t()




local aa=a.load'a'


local function map(ab,ad,ae,af,ag)
return(ab-ad)*(ag-af)/(ae-ad)+af
end

local function viewportPointToWorld(ab,ad)
local ae=aa(game:GetService"Workspace").CurrentCamera:ScreenPointToRay(ab.X,ab.Y)
return ae.Origin+ae.Direction*ad
end

local function getOffset()
local ab=aa(game:GetService"Workspace").CurrentCamera.ViewportSize.Y
return map(ab,0,2560,8,56)
end

return{viewportPointToWorld,getOffset}end function a.u()



local aa=a.load'a'


local ab=a.load'e'
local ad=ab.New


local ae,af=unpack(a.load't')
local ag=Instance.new("Folder",aa(game:GetService"Workspace").CurrentCamera)


local function createAcrylic()
local ah=ad("Part",{
Name="Body",
Color=Color3.new(0,0,0),
Material=Enum.Material.Glass,
Size=Vector3.new(1,1,0),
Anchored=true,
CanCollide=false,
Locked=true,
CastShadow=false,
Transparency=0.98,
},{
ad("SpecialMesh",{
MeshType=Enum.MeshType.Brick,
Offset=Vector3.new(0,0,-1E-6),
}),
})

return ah
end


local function createAcrylicBlur(ah)
local ai={}

ah=ah or 0.001
local aj={
topLeft=Vector2.new(),
topRight=Vector2.new(),
bottomRight=Vector2.new(),
}
local ak=createAcrylic()
ak.Parent=ag

local function updatePositions(al,am)
aj.topLeft=am
aj.topRight=am+Vector2.new(al.X,0)
aj.bottomRight=am+al
end

local function render()
local al=aa(game:GetService"Workspace").CurrentCamera
if al then
al=al.CFrame
end
local am=al
if not am then
am=CFrame.new()
end

local an=am
local ao=aj.topLeft
local ap=aj.topRight
local aq=aj.bottomRight

local ar=ae(ao,ah)
local as=ae(ap,ah)
local at=ae(aq,ah)

local au=(as-ar).Magnitude
local av=(as-at).Magnitude

ak.CFrame=
CFrame.fromMatrix((ar+at)/2,an.XVector,an.YVector,an.ZVector)
ak.Mesh.Scale=Vector3.new(au,av,0)
end

local function onChange(al)
local am=af()
local an=al.AbsoluteSize-Vector2.new(am,am)
local ao=al.AbsolutePosition+Vector2.new(am/2,am/2)

updatePositions(an,ao)
task.spawn(render)
end

local function renderOnChange()
local al=aa(game:GetService"Workspace").CurrentCamera
if not al then
return
end

table.insert(ai,al:GetPropertyChangedSignal"CFrame":Connect(render))
table.insert(ai,al:GetPropertyChangedSignal"ViewportSize":Connect(render))
table.insert(ai,al:GetPropertyChangedSignal"FieldOfView":Connect(render))
task.spawn(render)
end

ak.Destroying:Connect(function()
for al,am in ai do
pcall(function()
am:Disconnect()
end)
end
end)

renderOnChange()

return onChange,ak
end

return function(ah)
local ai={}
local aj,ak=createAcrylicBlur(ah)

local al=ad("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
})

ab.AddSignal(al:GetPropertyChangedSignal"AbsolutePosition",function()
aj(al)
end)

ab.AddSignal(al:GetPropertyChangedSignal"AbsoluteSize",function()
aj(al)
end)

ai.AddParent=function(am)
ab.AddSignal(am:GetPropertyChangedSignal"Visible",function()

end)
end

ai.SetVisibility=function(am)
ak.Transparency=am and 0.98 or 1
end

ai.Frame=al
ai.Model=ak

return ai
end end function a.v()


local aa=a.load'e'
local ab=a.load'u'

local ad=aa.New

return function(ae)
local af={}

af.Frame=ad("Frame",{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(255,255,255),
BorderSizePixel=0,
},{












ad("UICorner",{
CornerRadius=UDim.new(0,8),
}),

ad("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Name="Background",
ThemeTag={
BackgroundColor3="AcrylicMain",
},
},{
ad("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ad("Frame",{
BackgroundColor3=Color3.fromRGB(255,255,255),
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
},{










}),

ad("ImageLabel",{
Image="rbxassetid://9968344105",
ImageTransparency=0.98,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.new(0,128,0,128),
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
},{
ad("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ad("ImageLabel",{
Image="rbxassetid://9968344227",
ImageTransparency=0.9,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.new(0,128,0,128),
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
ThemeTag={
ImageTransparency="AcrylicNoise",
},
},{
ad("UICorner",{
CornerRadius=UDim.new(0,8),
}),
}),

ad("Frame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
ZIndex=2,
},{










}),
})


local ag

task.wait()
if ae.UseAcrylic then
ag=ab()

ag.Frame.Parent=af.Frame
af.Model=ag.Model
af.AddParent=ag.AddParent
af.SetVisibility=ag.SetVisibility
end

return af,ag
end end function a.w()



local aa=a.load'a'


local ab={
AcrylicBlur=a.load'u',

AcrylicPaint=a.load'v',
}

function ab.init()
local ad=Instance.new"DepthOfFieldEffect"
ad.FarIntensity=0
ad.InFocusRadius=0.1
ad.NearIntensity=1

local ae={}

function ab.Enable()
for af,ag in pairs(ae)do
ag.Enabled=false
end
ad.Parent=aa(game:GetService"Lighting")
end

function ab.Disable()
for af,ag in pairs(ae)do
ag.Enabled=ag.enabled
end
ad.Parent=nil
end

local function registerDefaults()
local function register(af)
if af:IsA"DepthOfFieldEffect"then
ae[af]={enabled=af.Enabled}
end
end

for af,ag in pairs(aa(game:GetService"Lighting"):GetChildren())do
register(ag)
end

if aa(game:GetService"Workspace").CurrentCamera then
for af,ag in pairs(aa(game:GetService"Workspace").CurrentCamera:GetChildren())do
register(ag)
end
end
end

registerDefaults()
ab.Enable()
end

return ab end function a.x()

local aa={}

local ab=a.load'e'
local ad=ab.New local ae=
ab.Tween


function aa.new(af,ag)
local ah={
Title=af.Title or"Dialog",
Content=af.Content,
Icon=af.Icon,
IconThemed=af.IconThemed,
Thumbnail=af.Thumbnail,
Buttons=af.Buttons,

IconSize=22,
}

local ai=a.load'q'
local aj=ai.Create(true,"Popup",af.WindUI.Window,af.WindUI,ag)

local ak=200

local al=430
if ah.Thumbnail and ah.Thumbnail.Image then
al=430+(ak/2)
end

aj.UIElements.Main.AutomaticSize="Y"
aj.UIElements.Main.Size=UDim2.new(0,al,0,0)



local am

if ah.Icon then
am=ab.Image(
ah.Icon,
ah.Title..":"..ah.Icon,
0,
af.WindUI.Window,
"Popup",
true,
af.IconThemed,
"PopupIcon"
)
am.Size=UDim2.new(0,ah.IconSize,0,ah.IconSize)
am.LayoutOrder=-1
end


local an=ad("TextLabel",{
AutomaticSize="Y",
BackgroundTransparency=1,
Text=ah.Title,
TextXAlignment="Left",
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="PopupTitle",
},
TextSize=20,
TextWrapped=true,
Size=UDim2.new(1,am and-ah.IconSize-14 or 0,0,0)
})

local ao=ad("Frame",{
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ad("UIListLayout",{
Padding=UDim.new(0,14),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),
am,an
})

local ap=ad("Frame",{
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
},{





ao,
})

local aq
if ah.Content and ah.Content~=""then
aq=ad("TextLabel",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Text=ah.Content,
TextSize=18,
TextTransparency=.2,
ThemeTag={
TextColor3="PopupContent",
},
BackgroundTransparency=1,
RichText=true,
TextWrapped=true,
})
end

local ar=ad("Frame",{
Size=UDim2.new(1,0,0,42),
BackgroundTransparency=1,
},{
ad("UIListLayout",{
Padding=UDim.new(0,9),
FillDirection="Horizontal",
HorizontalAlignment="Right"
})
})

local as
if ah.Thumbnail and ah.Thumbnail.Image then
local at
if ah.Thumbnail.Title then
at=ad("TextLabel",{
Text=ah.Thumbnail.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
AutomaticSize="XY",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})
end
as=ad("ImageLabel",{
Image=ah.Thumbnail.Image,
BackgroundTransparency=1,
Size=UDim2.new(0,ak,1,0),
Parent=aj.UIElements.Main,
ScaleType="Crop"
},{
at,
ad("UICorner",{
CornerRadius=UDim.new(0,0),
})
})
end

ad("Frame",{

Size=UDim2.new(1,as and-ak or 0,1,0),
Position=UDim2.new(0,as and ak or 0,0,0),
BackgroundTransparency=1,
Parent=aj.UIElements.Main
},{
ad("Frame",{

Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ad("UIListLayout",{
Padding=UDim.new(0,18),
FillDirection="Vertical",
}),
ap,
aq,
ar,
ad("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
})
}),
})

local at=a.load'o'.New

for au,av in next,ah.Buttons do
at(av.Title,av.Icon,av.Callback,av.Variant,ar,aj)
end

aj:Open()


return ah
end

return aa end function a.y()
return function(aa,ab)
return{
Dark={
Name="Dark",

Accent=Color3.fromHex"#18181b",
Dialog=Color3.fromHex"#1a1a1a",
Outline=Color3.fromHex"#FFFFFF",
Text=Color3.fromHex"#FFFFFF",
Placeholder=Color3.fromHex"#a1a1a1",
Background=Color3.fromHex"#101010",
Button=Color3.fromHex"#52525b",
Icon=Color3.fromHex"#a1a1aa",
Toggle=Color3.fromHex"#33C759",
Slider=Color3.fromHex"#0091FF",
Checkbox=Color3.fromHex"#0091FF",

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0.95,

SliderIcon=Color3.fromHex"#908F95",
Primary=Color3.fromHex"#0091FF",


LabelBackground=Color3.fromHex"#000000",
LabelBackgroundTransparency=0.83,

ElementBackground=Color3.fromHex"#2A2A2C",
ElementBackgroundTransparency=0,
},



Modern={
Name="Modern",

Accent=Color3.fromHex"#131617",
Dialog=Color3.fromHex"#1D2022",
Outline=Color3.fromHex"#FFFFFF",
Text=Color3.fromHex"#FFFFFF",
Placeholder=Color3.fromHex"#8E8F91",
Background=Color3.fromHex"#131617",
Button=Color3.fromHex"#29292A",
Icon=Color3.fromHex"#C4C6C8",

Primary=Color3.fromHex"#A2FF31",
Toggle=Color3.fromHex"#A2FF31",
Slider=Color3.fromHex"#A2FF31",
Checkbox=Color3.fromHex"#A2FF31",

ElementBackground=Color3.fromHex"#1D2022",
ElementBackgroundTransparency=0,

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0.97,

LabelBackground=Color3.fromHex"#FFFFFF",
LabelBackgroundTransparency=0.94,

TabBackgroundHover=Color3.fromHex"#FFFFFF",
TabBackgroundHoverTransparency=0.94,
TabBackgroundActive=Color3.fromHex"#FFFFFF",
TabBackgroundActiveTransparency=0.88,
TabTextTransparency=0.35,
TabIconTransparency=0.35,
TabBorderTransparency=1,
TabBorderTransparencyActive=1,



BadgeText=Color3.fromHex"#0E1112",
BadgeIcon=Color3.fromHex"#0E1112",
CheckboxIcon=Color3.fromHex"#0E1112",
CheckboxGroupIcon=Color3.fromHex"#0E1112",
TooltipSecondaryText=Color3.fromHex"#0E1112",



SegmentedControlActive=Color3.fromHex"#3A3D3F",

Tooltip=Color3.fromHex"#29292A",

SectionBoxTransparency=0.96,
SectionBoxBorderTransparency=0.88,
SearchBarBorderTransparency=0.88,
},

Light={
Name="Light",

Accent=Color3.fromHex"#efefef",
Dialog=Color3.fromHex"#f4f4f5",
Outline=Color3.fromHex"#ffffff",
Text=Color3.fromHex"#000000",
Placeholder=Color3.fromHex"#555555",
Background=Color3.fromHex"#FFFFFF",
Button=Color3.fromHex"#18181b",
Icon=Color3.fromHex"#52525b",
Toggle=Color3.fromHex"#33C759",
Slider=Color3.fromHex"#0091FF",
Checkbox=Color3.fromHex"#0091FF",

DropdownTabBackground=Color3.fromHex"#bebebe",
DropdownBackground=Color3.fromHex"#ffffff",

TabBackground=Color3.fromHex"#ffffff",
TabBackgroundHover=Color3.fromHex"#f3f3f3",
TabBackgroundHoverTransparency=0,
TabBackgroundActive=Color3.fromHex"#efefef",
TabBackgroundActiveTransparency=0,

PanelBackground=Color3.fromHex"#efefef",
PanelBackgroundTransparency=0,

LabelBackground=Color3.fromHex"#efefef",
LabelBackgroundTransparency=0,

ElementBackground=Color3.fromHex"#ffffff",
ElementBackgroundTransparency=0,
},

Rose={
Name="Rose",

Accent=Color3.fromHex"#be185d",
Dialog=Color3.fromHex"#4c0519",

Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#d67aa6",
Background=Color3.fromHex"#1f0308",
Button=Color3.fromHex"#e95f74",
Icon=Color3.fromHex"#fb7185",

ElementBackground=Color3.fromHex"#381E23",
ElementBackgroundTransparency=0,
},

Plant={
Name="Plant",

Accent=Color3.fromHex"#166534",
Dialog=Color3.fromHex"#052e16",

Text=Color3.fromHex"#f0fdf4",
Placeholder=Color3.fromHex"#4fbf7a",
Background=Color3.fromHex"#0a1b0f",
Button=Color3.fromHex"#16a34a",
Icon=Color3.fromHex"#4ade80",

ElementBackground=Color3.fromHex"#28342A",
ElementBackgroundTransparency=0,
},

Red={
Name="Red",

Accent=Color3.fromHex"#991b1b",
Dialog=Color3.fromHex"#450a0a",

Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#d95353",
Background=Color3.fromHex"#1c0606",
Button=Color3.fromHex"#dc2626",
Icon=Color3.fromHex"#ef4444",

ElementBackground=Color3.fromHex"#322221",
ElementBackgroundTransparency=0,
},

Indigo={
Name="Indigo",

Accent=Color3.fromHex"#3730a3",
Dialog=Color3.fromHex"#1e1b4b",

Text=Color3.fromHex"#f1f5f9",
Placeholder=Color3.fromHex"#7078d9",
Background=Color3.fromHex"#0f0a2e",
Button=Color3.fromHex"#4f46e5",
Icon=Color3.fromHex"#6366f1",

ElementBackground=Color3.fromHex"#282543",
ElementBackgroundTransparency=0,
},

Sky={
Name="Sky",

Accent=Color3.fromHex"#00d4ff",
Dialog=Color3.fromHex"#0a4d66",

Text=Color3.fromHex"#e6f7ff",
Placeholder=Color3.fromHex"#66b3cc",
Background=Color3.fromHex"#051a26",
Button=Color3.fromHex"#00a8cc",
Icon=Color3.fromHex"#2db8d9",

Toggle=Color3.fromHex"#00d9d9",
Slider=Color3.fromHex"#00d4ff",
Checkbox=Color3.fromHex"#00d4ff",

PanelBackground=Color3.fromHex"#0d3a47",
PanelBackgroundTransparency=0.8,

ElementBackground=Color3.fromHex"#172E3B",
ElementBackgroundTransparency=0,
},

Violet={
Name="Violet",

Accent=Color3.fromHex"#6d28d9",
Dialog=Color3.fromHex"#3c1361",

Text=Color3.fromHex"#faf5ff",
Placeholder=Color3.fromHex"#8f7ee0",
Background=Color3.fromHex"#1e0a3e",
Button=Color3.fromHex"#7c3aed",
Icon=Color3.fromHex"#8b5cf6",

ElementBackground=Color3.fromHex"#342650",
ElementBackgroundTransparency=0,
},

Amber={
Name="Amber",

Accent=aa:Gradient({
["0"]={Color=Color3.fromHex"#b45309",Transparency=0},
["100"]={Color=Color3.fromHex"#d97706",Transparency=0},
},{Rotation=45}),

Dialog=aa:Gradient({
["0"]={Color=Color3.fromHex"#451a03",Transparency=0},
["100"]={Color=Color3.fromHex"#6b2e05",Transparency=0},
},{Rotation=90}),






Text=aa:Gradient({
["0"]={Color=Color3.fromHex"#fffbeb",Transparency=0},
["100"]={Color=Color3.fromHex"#fff7ed",Transparency=0},
},{Rotation=45}),

Placeholder=aa:Gradient({
["0"]={Color=Color3.fromHex"#d1a326",Transparency=0},
["100"]={Color=Color3.fromHex"#fbbf24",Transparency=0},
},{Rotation=45}),

Background=aa:Gradient({
["0"]={Color=Color3.fromHex"#1c1003",Transparency=0},
["100"]={Color=Color3.fromHex"#3f210d",Transparency=0},
},{Rotation=90}),

Button=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#f59e0b",Transparency=0},
},{Rotation=45}),

Icon=Color3.fromHex"#f59e0b",

Toggle=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#f59e0b",Transparency=0},
},{Rotation=45}),

Slider=Color3.fromHex"#d97706",

Checkbox=aa:Gradient({
["0"]={Color=Color3.fromHex"#d97706",Transparency=0},
["100"]={Color=Color3.fromHex"#fbbf24",Transparency=0},
},{Rotation=45}),

PanelBackground=Color3.fromHex"#FFFFFF",
PanelBackgroundTransparency=0.95,

ElementBackground=Color3.fromHex"#3A2E22",
ElementBackgroundTransparency=0,
},

Emerald={
Name="Emerald",

Accent=Color3.fromHex"#047857",
Dialog=Color3.fromHex"#022c22",

Text=Color3.fromHex"#ecfdf5",
Placeholder=Color3.fromHex"#3fbf8f",
Background=Color3.fromHex"#011411",
Button=Color3.fromHex"#059669",
Icon=Color3.fromHex"#10b981",

ElementBackground=Color3.fromHex"#202E2A",
ElementBackgroundTransparency=0,
},

Midnight={
Name="Midnight",

Accent=Color3.fromHex"#1e3a8a",
Dialog=Color3.fromHex"#0c1e42",

Text=Color3.fromHex"#dbeafe",
Placeholder=Color3.fromHex"#2f74d1",
Background=Color3.fromHex"#0a0f1e",
Button=Color3.fromHex"#2563eb",
Primary=Color3.fromHex"#2563eb",
Icon=Color3.fromHex"#5591f4",

ElementBackground=Color3.fromHex"#242836",
ElementBackgroundTransparency=0,
},

Crimson={
Name="Crimson",

Accent=Color3.fromHex"#b91c1c",
Dialog=Color3.fromHex"#450a0a",

Text=Color3.fromHex"#fef2f2",
Placeholder=Color3.fromHex"#6f757b",
Background=Color3.fromHex"#0c0404",
Button=Color3.fromHex"#991b1b",
Icon=Color3.fromHex"#dc2626",

ElementBackground=Color3.fromHex"#251F1F",
ElementBackgroundTransparency=0,
},

MonokaiPro={
Name="Monokai Pro",

Accent=Color3.fromHex"#fc9867",
Dialog=Color3.fromHex"#1e1e1e",

Text=Color3.fromHex"#fcfcfa",
Placeholder=Color3.fromHex"#afafaf",
Background=Color3.fromHex"#191622",
Button=Color3.fromHex"#ab9df2",
Icon=Color3.fromHex"#a9dc76",

ElementBackground=Color3.fromHex"#323039",
ElementBackgroundTransparency=0,

Metadata={
PullRequest=23,
},
},

CottonCandy={
Name="Cotton Candy",

Accent=Color3.fromHex"#ec4899",
Dialog=Color3.fromHex"#2d1b3d",

Text=Color3.fromHex"#fdf2f8",
Placeholder=Color3.fromHex"#8a5fd3",
Background=Color3.fromHex"#1a0b2e",
Button=Color3.fromHex"#d946ef",
Slider=Color3.fromHex"#d946ef",
Icon=Color3.fromHex"#06b6d4",

ElementBackground=Color3.fromHex"#312643",
ElementBackgroundTransparency=0,
},

Mellowsi={
Name="Mellowsi",

Accent=Color3.fromHex"#342A1E",
Dialog=Color3.fromHex"#291C13",

Text=Color3.fromHex"#F5EBDD",
Placeholder=Color3.fromHex"#9C8A73",
Background=Color3.fromHex"#1C1002",
Button=Color3.fromHex"#342A1E",
Icon=Color3.fromHex"#C9B79C",

Toggle=Color3.fromHex"#a9873f",
Slider=Color3.fromHex"#C9A24D",
Checkbox=Color3.fromHex"#C9A24D",

ElementBackground=Color3.fromHex"#33291E",
ElementBackgroundTransparency=0,

Metadata={
PullRequest=52,
},
},

Rainbow={
Name="Rainbow",

Accent=aa:Gradient({
["0"]={Color=Color3.fromHex"#00ff41",Transparency=0},
["33"]={Color=Color3.fromHex"#00ffff",Transparency=0},
["66"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["100"]={Color=Color3.fromHex"#8000ff",Transparency=0},
},{Rotation=45}),

Dialog=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#8000ff",Transparency=0},
["50"]={Color=Color3.fromHex"#0080ff",Transparency=0},
["75"]={Color=Color3.fromHex"#00ff80",Transparency=0},
["100"]={Color=Color3.fromHex"#ff8000",Transparency=0},
},{Rotation=135}),


Text=Color3.fromHex"#ffffff",
Placeholder=Color3.fromHex"#00ff80",

Background=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0040",Transparency=0},
["20"]={Color=Color3.fromHex"#ff4000",Transparency=0},
["40"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["60"]={Color=Color3.fromHex"#00ff40",Transparency=0},
["80"]={Color=Color3.fromHex"#0040ff",Transparency=0},
["100"]={Color=Color3.fromHex"#4000ff",Transparency=0},
},{Rotation=90}),

Button=aa:Gradient({
["0"]={Color=Color3.fromHex"#ff0080",Transparency=0},
["25"]={Color=Color3.fromHex"#ff8000",Transparency=0},
["50"]={Color=Color3.fromHex"#ffff00",Transparency=0},
["75"]={Color=Color3.fromHex"#80ff00",Transparency=0},
["100"]={Color=Color3.fromHex"#00ffff",Transparency=0},
},{Rotation=60}),

Icon=Color3.fromHex"#ffffff",
},
}
end end function a.z()

local aa={}

local ab=a.load'e'
local ad=ab.New local ae=
ab.Tween

function aa.New(af,ag,ah,ai,aj,ak)
local al=aj or 10
local am
if ag and ag~=""then
am=ad("ImageLabel",{
Image=ab.Icon(ag)[1],
ImageRectSize=ab.Icon(ag)[2].ImageRectSize,
ImageRectOffset=ab.Icon(ag)[2].ImageRectPosition,
Size=UDim2.new(0,21,0,21),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
})
end

local an=ad("TextLabel",{
BackgroundTransparency=1,
TextSize=17,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
Size=UDim2.new(1,am and-29 or 0,1,0),
TextXAlignment="Left",
ThemeTag={
TextColor3=ai and"Placeholder"or"Text",
},
Text=af,
})

local ao=ad("TextButton",{
Size=UDim2.new(1,0,0,42),
Parent=ah,
BackgroundTransparency=1,
Text="",
},{
ad("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ab.NewRoundFrame(al,"Squircle",{
ThemeTag={
ImageColor3="Placeholder",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
}),
not ak and ab.NewRoundFrame(al,"SquircleGlass",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,1,1,1),
ImageTransparency=0.9,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
})or nil,
ab.NewRoundFrame(al,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Frame",
ThemeTag={
ImageColor3="LabelBackground",
ImageTransparency="LabelBackgroundTransparency",
},


},{
ad("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
ad("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
am,
an,
}),
}),
})

return ao
end

return aa end function a.A()

local aa={}

local ab=a.load'a'
local ad=ab(game:GetService"UserInputService")

local ae=a.load'e'
local af=ae.New

function aa.New(ag,ah,ai,aj,ak)
local al=af("Frame",{
Size=UDim2.new(0,aj,1,0),
BackgroundTransparency=1,
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
Parent=ah,
ZIndex=999,
Active=true,
})

local am=ae.NewRoundFrame(aj/2,"Squircle",{
Size=UDim2.new(1,0,0,0),
ImageTransparency=0.85,
ThemeTag={ImageColor3="Text"},
Parent=al,
})

local an=af("Frame",{
Size=UDim2.new(1,12,1,12),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Active=true,
ZIndex=999,
Parent=am,
})

local ao=ae:GenerateUniqueID()
local ap=false
local aq,ar

local function UpdateVisuals()
local as=ag.AbsoluteCanvasSize.Y
local at=ag.AbsoluteWindowSize.Y

if as<=at then
am.Visible=false
return
end

am.Visible=true

local au=math.clamp(at/as,0.05,1)
am.Size=UDim2.new(1,0,au,0)

local av=as-at
local aw=1-au

if av>0 then
local ax=ag.CanvasPosition.Y/av
am.Position=UDim2.new(0,0,math.clamp(ax*aw,0,aw),0)
else
am.Position=UDim2.new(0,0,0,0)
end
end

local function StopDrag()
if ak.CurrentInput==ao then
ak.CurrentInput=nil
end
ap=false
ag.ScrollingEnabled=true
if aq then
ae.DisconnectSignal(aq)
aq=nil
end
if ar then
ae.DisconnectSignal(ar)
ar=nil
end
end

ae.AddSignal(an.InputBegan,function(as)
if
as.UserInputType~=Enum.UserInputType.MouseButton1
and as.UserInputType~=Enum.UserInputType.Touch
then
return
end
if ap then
return
end
if ak.CurrentInput and ak.CurrentInput~=ao then
return
end

ak.CurrentInput=ao

ap=true
ag.ScrollingEnabled=false

local at=as.Position.Y
local au=ag.CanvasPosition.Y

aq=ae.AddSignal(ad.InputChanged,function(av)
if as.UserInputType==Enum.UserInputType.Touch and av~=as then
return
end
if
av.UserInputType==Enum.UserInputType.MouseMovement
or av.UserInputType==Enum.UserInputType.Touch
then
local aw=av.Position.Y-at

local ax=ag.AbsoluteCanvasSize.Y
local ay=ag.AbsoluteWindowSize.Y
local az=math.max(ax-ay,0)

local aA=al.AbsoluteSize.Y
local aB=am.AbsoluteSize.Y
local aC=math.max(aA-aB,1)

local aD=aw*(az/aC)

ag.CanvasPosition=
Vector2.new(ag.CanvasPosition.X,math.clamp(au+aD,0,az))
end
end)

ar=ae.AddSignal(ad.InputEnded,function(av)
local aw=as.UserInputType==Enum.UserInputType.Touch and av==as
local ax=as.UserInputType==Enum.UserInputType.MouseButton1
and av.UserInputType==Enum.UserInputType.MouseButton1
if aw or ax then
StopDrag()
end
end)
end)

ae.AddSignal(ag:GetPropertyChangedSignal"AbsoluteWindowSize",UpdateVisuals)
ae.AddSignal(ag:GetPropertyChangedSignal"AbsoluteCanvasSize",UpdateVisuals)
ae.AddSignal(ag:GetPropertyChangedSignal"CanvasPosition",UpdateVisuals)

UpdateVisuals()

return al
end

return aa end function a.B()

local aa={}

local ab=a.load'e'
local ad=ab.New
local ae=ab.Tween

function aa.New(af,ag,ah)
local ai={
Title=ag.Title or"Tag",
Icon=ag.Icon,
Color=ag.Color or Color3.fromHex"#315dff",
Radius=ag.Radius or 999,
Border=ag.Border or false,

TagFrame=nil,
Height=26,
Padding=10,
TextSize=14,
IconSize=16,
}

local aj
if ai.Icon then
aj=ab.Image(ai.Icon,ai.Icon,0,ag.Window,"Tag",false)

aj.Size=UDim2.new(0,ai.IconSize,0,ai.IconSize)
aj.ImageLabel.ImageColor3=typeof(ai.Color)=="Color3"
and ab.GetTextColorForHSB(ai.Color)
or typeof(ai.Color)=="string"
and(ab.GetTextColorForHSB(ab.GetThemeProperty(ai.Color,ab.Theme)))
end

local ak=ad("TextLabel",{
BackgroundTransparency=1,
AutomaticSize="XY",
TextSize=ai.TextSize,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
Text=ai.Title,
TextColor3=typeof(ai.Color)=="Color3"and ab.GetTextColorForHSB(ai.Color)or typeof(
ai.Color
)=="string"and(ab.GetTextColorForHSB(ab.GetThemeProperty(ai.Color,ab.Theme))),
})

local al

if typeof(ai.Color)=="table"then
al=ad"UIGradient"
for am,an in next,ai.Color do
al[am]=an
end

ak.TextColor3=ab.GetTextColorForHSB(ab.GetAverageColor(al))
if aj then
aj.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ab.GetAverageColor(al))
end
end

local am=ab.NewRoundFrame(ai.Radius,"Squircle",{
AutomaticSize="X",
Size=UDim2.new(0,0,0,ai.Height),
Parent=ah,
ImageColor3=typeof(ai.Color)=="Color3"and ai.Color
or typeof(ai.Color)=="table"and Color3.new(1,1,1)
or nil,
ThemeTag=typeof(ai.Color)=="string"and{
ImageColor3=ai.Color,
},
},{
al,
ab.NewRoundFrame(ai.Radius+1,"SquircleGlass",{
Size=UDim2.new(1,1,1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=0.75,
}),
ad("Frame",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
Name="Content",
BackgroundTransparency=1,
},{
aj,
ak,
ad("UIPadding",{
PaddingLeft=UDim.new(0,ai.Padding),
PaddingRight=UDim.new(0,ai.Padding),
}),
ad("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,ai.Padding/1.5),
}),
}),
})

function ai.SetTitle(an,ao)
ai.Title=ao
ak.Text=ao

return ai
end

function ai.SetColor(an,ao)
ai.Color=ao
if typeof(ao)=="table"then
local ap=ab.GetAverageColor(ao)
ae(ak,0.06,{TextColor3=ab.GetTextColorForHSB(ap)}):Play()
local aq=am:FindFirstChildOfClass"UIGradient"or ad("UIGradient",{Parent=am})
for ar,as in next,ao do
aq[ar]=as
end
ae(am,0.06,{ImageColor3=Color3.new(1,1,1)}):Play()
else
if al then
al:Destroy()
end
ae(ak,0.06,{TextColor3=ab.GetTextColorForHSB(ao)}):Play()
if aj then
ae(aj.ImageLabel,0.06,{ImageColor3=ab.GetTextColorForHSB(ao)}):Play()
end
ae(am,0.06,{ImageColor3=ao}):Play()
end

return ai
end

function ai.SetIcon(an,ao)
ai.Icon=ao

if ao then
aj=ab.Image(ao,ao,0,ag.Window,"Tag",false)

aj.Size=UDim2.new(0,ai.IconSize,0,ai.IconSize)
aj.Parent=am

if typeof(ai.Color)=="Color3"then
aj.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ai.Color)
elseif typeof(ai.Color)=="table"then
aj.ImageLabel.ImageColor3=ab.GetTextColorForHSB(ab.GetAverageColor(al))
end
else
if aj then
aj:Destroy()
aj=nil
end
end
return ai
end

function ai.Destroy(an)
am:Destroy()
return ai
end

ab:OnThemeChange(function(an,ao)
ak.TextColor3=ab.GetTextColorForHSB(ab.GetThemeProperty(ai.Color,ab.Theme))
aj.ImageLabel.ImageColor3=
ab.GetTextColorForHSB(ab.GetThemeProperty(ai.Color,ab.Theme))
end)

return ai
end

return aa end function a.C()

local aa=a.load'a'


local ab=aa(game:GetService"RunService")
local ad=aa(game:GetService"HttpService")

local ae

local af
af={
Folder=nil,
Path=nil,
Configs={},
Parser={
Colorpicker={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Default:ToHex(),
transparency=ag.Transparency or nil,
}
end,
Load=function(ag,ah)
if ag and ag.Update then
ag:Update(Color3.fromHex(ah.value),ah.transparency or nil)
end
end
},
Dropdown={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Value,
}
end,
Load=function(ag,ah)
if ag and ag.Select then
ag:Select(ah.value)
end
end
},
Input={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Value,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(ah.value)
end
end
},
Keybind={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Value,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(ah.value)
end
end
},
RadioGroup={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Get and ag:Get()or ag.Value,
}
end,
Load=function(ag,ah)
if ag and ag.Select then
ag:Select(ah.value,false)
end
end
},
CheckboxGroup={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Get and ag:Get()or ag.Values,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(ah.value or{},false)
end
end
},
SegmentedControl={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Get and ag:Get()or ag.Value,
}
end,
Load=function(ag,ah)
if ag and ag.Select then
ag:Select(ah.value,false)
end
end
},
TextArea={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Get and ag:Get()or ag.Value,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(ah.value or"",false)
end
end
},
Slider={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Value.Default,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(tonumber(ah.value))
end
end
},
Stepper={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Get and ag:Get()or ag.Value.Default,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(tonumber(ah.value),false)
end
end
},
TabBox={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Get and ag:Get()or ag.SelectedValue,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(ah.value)
end
end
},
ChipList={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Get and ag:Get()or ag.Values,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(ah.value,false)
end
end
},
Toggle={
Save=function(ag)
return{
__type=ag.__type,
value=ag.Value,
}
end,
Load=function(ag,ah)
if ag and ag.Set then
ag:Set(ah.value)
end
end
},
}
}

function af.Init(ag,ah)
if not ah.Folder then
warn"[ WindUI.ConfigManager ] Window.Folder is not specified."
return false
end
if ab:IsStudio()or not writefile then
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return false
end

ae=ah
af.Folder=ae.Folder
af.Path="WindUI/"..tostring(af.Folder).."/config/"

if not isfolder(af.Path)then
makefolder(af.Path)
end

local ai=af:AllConfigs()

for aj,ak in next,ai do
local al=af.Path..tostring(ak)..".json"
if isfile and readfile and isfile(al)then
local am,an=pcall(function()
return readfile(al)
end)
if am then
af.Configs[ak]=an
end
end
end

return af
end

function af.SetPath(ag,ah)
if not ah then
warn"[ WindUI.ConfigManager ] Custom path is not specified."
return false
end

af.Path=ah
if not ah:match"/$"then
af.Path=ah.."/"
end

if not isfolder(af.Path)then
makefolder(af.Path)
end

return true
end

function af.CreateConfig(ag,ah,ai)
local aj={
Path=af.Path..ah..".json",
Elements={},
CustomData={},
AutoLoad=ai or false,
Version=1.2,
}

if not ah then
return false,"No config file is selected"
end

function aj.SetAsCurrent(ak)
ae:SetCurrentConfig(aj)
end

function aj.Register(ak,al,am)
aj.Elements[al]=am
end

function aj.Set(ak,al,am)
aj.CustomData[al]=am
end

function aj.Get(ak,al)
return aj.CustomData[al]
end

function aj.SetAutoLoad(ak,al)
aj.AutoLoad=al
end

function aj.Save(ak)
if ae.PendingFlags then
for al,am in next,ae.PendingFlags do
aj:Register(al,am)
end
end

local al={
__version=aj.Version,
__elements={},
__autoload=aj.AutoLoad,
__custom=aj.CustomData
}

for am,an in next,aj.Elements do
if af.Parser[an.__type]then
al.__elements[tostring(am)]=af.Parser[an.__type].Save(an)
end
end

local am=ad:JSONEncode(al)
if writefile then
local an,ao=pcall(function()
writefile(aj.Path,am)
end)
if not an then
return false,"Failed to save config: "..tostring(ao)
end
else
return false,"writefile function is not available"
end

return al
end

function aj.Load(ak)
if isfile and not isfile(aj.Path)then
return false,"Config file does not exist"
end

local al,am=pcall(function()
local al=readfile or function()
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio."
return nil
end
return ad:JSONDecode(al(aj.Path))
end)

if not al then
return false,"Failed to parse config file"
end

if not am.__version then
local an={
__version=aj.Version,
__elements=am,
__custom={}
}
am=an
end

if ae.PendingFlags then
for an,ao in next,ae.PendingFlags do
aj:Register(an,ao)
end
end

ae.PendingConfigData=am.__elements or{}

for an,ao in next,(am.__elements or{})do
if typeof(ao)=="table"and aj.Elements[an]and af.Parser[ao.__type]then
task.spawn(function()
local ap,aq=pcall(function()
af.Parser[ao.__type].Load(aj.Elements[an],ao)
end)
if not ap then
warn("[ WindUI.ConfigManager ] Failed to load element '"..tostring(an).."': "..tostring(aq))
end
end)
end
end

aj.CustomData=am.__custom or{}

return aj.CustomData
end

function aj.Delete(ak)
if not delfile then
return false,"delfile function is not available"
end

if not isfile(aj.Path)then
return false,"Config file does not exist"
end

local al,am=pcall(function()
delfile(aj.Path)
end)

if not al then
return false,"Failed to delete config file: "..tostring(am)
end

af.Configs[ah]=nil

if ae.CurrentConfig==aj then
ae.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function aj.GetData(ak)
return{
elements=aj.Elements,
custom=aj.CustomData,
autoload=aj.AutoLoad
}
end


if isfile(aj.Path)then
local ak,al=pcall(function()
return ad:JSONDecode(readfile(aj.Path))
end)

if ak and al and al.__autoload then
aj.AutoLoad=true

task.spawn(function()
task.wait(0.5)
local am,an=pcall(function()
return aj:Load()
end)
if am then
if ae.Debug then print("[ WindUI.ConfigManager ] AutoLoaded config: "..ah)end
else
warn("[ WindUI.ConfigManager ] Failed to AutoLoad config: "..ah.." - "..tostring(an))
end
end)
end
end


aj:SetAsCurrent()
af.Configs[ah]=aj
return aj
end

function af.Config(ag,ah,ai)
return af:CreateConfig(ah,ai)
end

function af.GetAutoLoadConfigs(ag)
local ah={}

for ai,aj in pairs(af.Configs)do
if aj.AutoLoad then
table.insert(ah,ai)
end
end

return ah
end

function af.DeleteConfig(ag,ah)
if not delfile then
return false,"delfile function is not available"
end

local ai=af.Path..ah..".json"

if not isfile(ai)then
return false,"Config file does not exist"
end

local aj,ak=pcall(function()
delfile(ai)
end)

if not aj then
return false,"Failed to delete config file: "..tostring(ak)
end

af.Configs[ah]=nil

if ae.CurrentConfig and ae.CurrentConfig.Path==ai then
ae.CurrentConfig=nil
end

return true,"Config deleted successfully"
end

function af.AllConfigs(ag)
if not listfiles then return{}end

local ah={}
if not isfolder(af.Path)then
makefolder(af.Path)
return ah
end

for ai,aj in next,listfiles(af.Path)do
local ak=aj:match"([^\\/]+)%.json$"
if ak then
table.insert(ah,ak)
end
end

return ah
end

function af.GetConfig(ag,ah)
return af.Configs[ah]
end

return af end function a.D()
















local aa={
Theme=true,
Description=true,
}

local ab={


modern={
Description="Flat near-black cards with wide gaps and a lime accent",
Theme="Modern",

NewElements=true,
LiquidGlass=false,
LinkElementCorners=false,
ElementGap=10,
ElementsRadius=18,
ElementTransparency=0,
BackgroundOverlayTransparency=0.35,
BackgroundColor=Color3.fromHex"#131617",
ShadowTransparency=0.35,
Radius=24,
SideBarWidth=210,
Topbar={Height=46,ButtonsType="Mac"},
HideSearchBar=false,
},



glass={
Description="Translucent liquid-glass elements with linked corners",

NewElements=true,
LiquidGlass=true,
LinkElementCorners=true,
ElementGap=1,
ElementTransparency=0.18,
BackgroundOverlayTransparency=0.5,
BackgroundColor=Color3.fromHex"#101821",
Radius=20,
SideBarWidth=210,
Topbar={Height=48,ButtonsType="Mac"},
CornerLink={InnerRadius=0,BridgeHidden=true},
HideSearchBar=false,
},

default={
Description="The original WindUI look",

NewElements=false,
LiquidGlass=false,
LinkElementCorners=false,
ElementGap=8,
ElementTransparency=nil,
BackgroundOverlayTransparency=0.62,
BackgroundColor=nil,
Radius=16,
SideBarWidth=200,
Topbar={Height=52,ButtonsType="Default"},
},
}

local ad={
modern="modern",
card="modern",
cards="modern",
flat="modern",

glass="glass",
liquid="glass",
liquidglass="glass",
acrylic="glass",

default="default",
classic="default",
legacy="default",
original="default",
}

local ae={
Presets=ab,
Aliases=ad,
}


local function Normalize(af)
if typeof(af)~="string"then
return nil
end
return(string.gsub(string.lower(af),"[%s_%-%./]",""))
end


function ae.Resolve(af)
local ag=Normalize(af)
if not ag then
return nil
end
return ad[ag]or(ab[ag]and ag)or nil
end


function ae.Get(af)
local ag=ae.Resolve(af)
return ag and ab[ag]or nil
end


function ae.GetTheme(af)
local ag=ae.Get(af)
return ag and ag.Theme or nil
end


function ae.List()
local af={}
for ag in next,ab do
table.insert(af,ag)
end
table.sort(af)
return af
end




function ae.Apply(af)
if af==nil or af.TypeWindow==nil then
return nil
end

local ag=ae.Resolve(af.TypeWindow)
if not ag then
warn(
"[ WindUI ] Unknown TypeWindow '"
..tostring(af.TypeWindow)
.."'. Expected one of: "
..table.concat(ae.List(),", ")
)
return nil
end

for ah,ai in next,ab[ag]do
if not aa[ah]and af[ah]==nil then
af[ah]=ai
end
end

af.TypeWindow=ag
return ag
end

return ae end function a.E()

local aa={}

local ab=a.load'e'
local ad=a.load'f'
local ae=ab.New
local af=ab.Tween

local ag=a.load'a'

local ah=ag(game:GetService"TextService")

local ai={
TopCenter={
Position=UDim2.new(0.5,0,0,8),
AnchorPoint=Vector2.new(0.5,0),
},
TopLeft={
Position=UDim2.new(0,14,0,8),
AnchorPoint=Vector2.new(0,0),
},
TopRight={
Position=UDim2.new(1,-14,0,8),
AnchorPoint=Vector2.new(1,0),
},
BottomCenter={
Position=UDim2.new(0.5,0,1,-14),
AnchorPoint=Vector2.new(0.5,1),
},
BottomLeft={
Position=UDim2.new(0,14,1,-14),
AnchorPoint=Vector2.new(0,1),
},
BottomRight={
Position=UDim2.new(1,-14,1,-14),
AnchorPoint=Vector2.new(1,1),
},
}

local aj={
hidden="Idle",
hide="Idle",
idle="Idle",
island="Idle",
closed="Collapsed",
circle="Collapsed",
icon="Collapsed",
mini="Collapsed",
collapsed="Collapsed",
compact="Compact",
default="Compact",
pill="Compact",
open="Expanded",
expanded="Expanded",
dynamic="Expanded",
}

local function Pick(ak,al)
if ak~=nil then
return ak
end
return al
end

local function NormalizeState(ak)
return aj[tostring(ak or"Compact"):lower()]or"Compact"
end

local function NormalizeColorSequence(ak,al)
if typeof(ak)=="ColorSequence"then
return ak
end
if typeof(ak)=="Color3"then
return ColorSequence.new(ak)
end
return al
end

local function GetInnerCornerRadius(ak,al)
if typeof(ak)~="UDim"then
return UDim.new(1,0)
end
if ak.Scale~=0 then
return UDim.new(ak.Scale,math.max(ak.Offset,0))
end
return UDim.new(0,math.max(ak.Offset-al,0))
end












local ak={}
local al=ab.Font
local am={}

local function MeasureKey(an,ao,ap)
return tostring(an).."\0"..tostring(ao).."\0"..tostring(ap.Value)
end



local function RefineMeasurement(an,ao,ap,aq,ar,as)
if am[ar]then
return
end
am[ar]=true

task.spawn(function()
local at,au=pcall(function()
local at=Instance.new"GetTextBoundsParams"
at.Text=tostring(an or"")
at.Size=ao
at.Font=Font.new(ab.Font,ap)
at.Width=aq
return ah:GetTextBoundsAsync(at)
end)

am[ar]=nil
if not at or typeof(au)~="Vector2"then
return
end

local av=math.ceil(au.X)
if ak[ar]~=av then
ak[ar]=av
ab.SafeCallback(as)
end
end)
end

local function MeasureText(an,ao,ap,aq,ar)
aq=aq or Enum.FontWeight.Medium


if al~=ab.Font then
al=ab.Font
ak={}
end

local as=MeasureKey(an,ao,aq)
local at=ak[as]
if at then
return at
end

local au=
ah:GetTextSize(tostring(an or""),ao,Enum.Font.GothamMedium,Vector2.new(ap,1000))
local av=math.ceil(au.X)
ak[as]=av
RefineMeasurement(an,ao,aq,ap,as,ar)
return av
end

function aa.New(an)
local ao=ColorSequence.new(Color3.fromHex"#40C9FF",Color3.fromHex"#E81CFF")
local ap={
Title=an.Title or"Open",
Content=nil,
Icon=an.Icon,
Enabled=true,
Visible=false,
OnlyMobile=true,
Draggable=true,
Position="TopCenter",
State="Compact",
Height=44,
IdleWidth=78,
IdleHeight=28,
ExpandedHeight=68,
ExpandedWidth=220,
MaxWidth=380,
IconSize=22,
Padding=12,
Gap=9,
Scale=1,
CornerRadius=UDim.new(1,0),
StrokeThickness=1,
StrokeTransparency=0.7,
Color=ao,
BackgroundColor=Color3.fromRGB(7,8,11),
BackgroundTransparency=0.08,
TextColor=nil,
TextTransparency=nil,
AutoCollapse=nil,
AutoHide=4,
WakeOnShow=true,
Shadow=true,
ShadowBlur=UDim.new(0,18),
ShadowColor=Color3.new(0,0,0),
ShadowOffset=UDim2.fromOffset(0,5),
ShadowSpread=UDim2.fromOffset(2,2),
ShadowTransparency=0.5,
FallbackShadow=false,
MorphWindow=true,
MorphDuration=0.42,
OnStateChange=nil,
}

local aq={
Button=nil,
Container=nil,
IconSize=ap.IconSize,
Scale=ap.Scale,
State=ap.State,
Config=ap,
UIElements={},
}

local ar=0
local as=0
local at={}
local au
local av

local aw=ae("Frame",{
Name="OpenButtonContainer",
Size=UDim2.fromOffset(ap.Height,ap.Height),
Position=ai.TopCenter.Position,
AnchorPoint=ai.TopCenter.AnchorPoint,
Parent=an.Parent,
BackgroundTransparency=1,
Active=true,
Visible=false,
ZIndex=98,
})

local ax=ae("UIScale",{
Name="Scale",
Scale=ap.Scale,
Parent=aw,
})

local ay=ae("Frame",{
Name="Shadow",
Size=UDim2.new(1,4,1,4),
Position=UDim2.fromOffset(-2,3),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.58,
BorderSizePixel=0,
ZIndex=98,
Parent=aw,
},{
ae("UICorner",{
CornerRadius=ap.CornerRadius,
}),
})

local az=ae("UIGradient",{
Name="UIGradient",
Color=ap.Color,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.12),
NumberSequenceKeypoint.new(0.5,0.52),
NumberSequenceKeypoint.new(1,0.18),
},
})

local aA=ae("UIStroke",{
Name="UIStroke",
Thickness=ap.StrokeThickness,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Color=Color3.new(1,1,1),
Transparency=ap.StrokeTransparency,
},{
az,
})

local aB=ae("Frame",{
Name="OpenButton",
Size=UDim2.fromScale(1,1),
BackgroundColor3=ap.BackgroundColor,
BackgroundTransparency=ap.BackgroundTransparency,
BorderSizePixel=0,
ClipsDescendants=true,
Active=true,
ZIndex=99,
Parent=aw,
},{
ae("UICorner",{
CornerRadius=ap.CornerRadius,
}),
aA,
ae("Frame",{
Name="Surface",
Size=UDim2.fromScale(1,1),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.965,
BorderSizePixel=0,
ZIndex=99,
},{
ae("UICorner",{
CornerRadius=ap.CornerRadius,
}),
ae("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.48),
NumberSequenceKeypoint.new(0.45,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
}),
})

local aC=ab.CreateUIShadow(aB,{
Name="NativeShadow",
Enabled=ap.Shadow,
BlurRadius=ap.ShadowBlur,
Color=ap.ShadowColor,
Offset=ap.ShadowOffset,
Spread=ap.ShadowSpread,
Transparency=ap.ShadowTransparency,
ZIndex=0,
})
ay.Visible=ap.Shadow and aC==nil and ap.FallbackShadow

local aD=ae("Frame",{
Name="Drag",
Size=UDim2.fromOffset(36,36),
Position=UDim2.fromOffset(4,4),
BackgroundTransparency=1,
ZIndex=102,
Parent=aB,
})

local aE=ab.Image("move","OpenButtonDrag",0,an.Folder,"OpenButton",true,true)
aE.Name="Icon"
aE.Size=UDim2.fromOffset(17,17)
aE.Position=UDim2.fromScale(0.5,0.5)
aE.AnchorPoint=Vector2.new(0.5,0.5)
aE.Parent=aD
local aF=aE:FindFirstChildWhichIsA"ImageLabel"
if aF then
aF.ImageTransparency=0.42
end

local aG=ae("Frame",{
Name="Divider",
Size=UDim2.new(0,1,1,-18),
Position=UDim2.new(0,44,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.88,
BorderSizePixel=0,
ZIndex=102,
Parent=aB,
})

local aH=ae("TextButton",{
Name="TextButton",
Text="",
AutoButtonColor=false,
Size=UDim2.new(1,-45,1,0),
Position=UDim2.fromOffset(45,0),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=1,
BorderSizePixel=0,
ClipsDescendants=true,
ZIndex=101,
Parent=aB,
},{
ae("UICorner",{
CornerRadius=GetInnerCornerRadius(ap.CornerRadius,4),
}),
})

local aI=ae("Frame",{
Name="HoverSurface",
Size=UDim2.fromScale(1,1),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=1,
BorderSizePixel=0,
ZIndex=101,
Parent=aH,
},{
ae("UICorner",{
CornerRadius=GetInnerCornerRadius(ap.CornerRadius,4),
}),
})

local aJ=ae("CanvasGroup",{
Name="TextStack",
Size=UDim2.new(1,-58,1,0),
Position=UDim2.fromOffset(46,0),
BackgroundTransparency=1,
GroupTransparency=0,
ZIndex=103,
Parent=aH,
})

local aK=ae("TextLabel",{
Name="Title",
Text=ap.Title,
TextSize=15,
FontFace=Font.new(ab.Font,Enum.FontWeight.SemiBold),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ZIndex=103,
ThemeTag={
TextColor3="Text",
},
Parent=aJ,
})

local aL=ae("TextLabel",{
Name="Content",
Text="",
TextSize=12,
FontFace=Font.new(ab.Font,Enum.FontWeight.Regular),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,0,0,18),
Position=UDim2.fromOffset(0,35),
BackgroundTransparency=1,
TextTransparency=0.38,
Visible=false,
ZIndex=103,
ThemeTag={
TextColor3="Text",
},
Parent=aJ,
})

local aM=ab.Image("chevron-up","OpenButtonExpand",0,an.Folder,"OpenButton",true,true)
aM.Name="TrailingIcon"
aM.Size=UDim2.fromOffset(15,15)
aM.Position=UDim2.new(1,-17,0.5,0)
aM.AnchorPoint=Vector2.new(0.5,0.5)
aM.Visible=false
aM.ZIndex=103
aM.Parent=aH
local aN=aM:FindFirstChildWhichIsA"ImageLabel"
if aN then
aN.ImageTransparency=0.48
end

local function StopTween(aO)
local aP=at[aO]
if aP then
aP:Cancel()
at[aO]=nil
end
end

local function Animate(aO,aP,aQ)
StopTween(aO)


if aP<=0 or not ad:IsEnabled()or ad.Reduced then
for aR,aS in aQ do
aO[aR]=aS
end
return nil
end

local aR=af(aO,aP,aQ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
at[aO]=aR
aR:Play()
return aR
end

local function ApplyPosition(aO)
if typeof(aO)=="UDim2"then
aw.Position=aO
aw.AnchorPoint=Vector2.new(0.5,0.5)
return
end

local aP=ai[tostring(aO or"TopCenter")]or ai.TopCenter
aw.Position=aP.Position
aw.AnchorPoint=aP.AnchorPoint
end

local function GetDragWidth(aO,aP)
if not ap.Draggable or aO=="Collapsed"or aO=="Idle"then
return 0
end
return aP
end

local function GetTargetSize(aO,aP)
if aO=="Idle"then
return Vector2.new(ap.IdleWidth,ap.IdleHeight)
end

local aQ=if aO=="Expanded"then ap.ExpandedHeight else ap.Height
if aO=="Collapsed"then
return Vector2.new(ap.Height,ap.Height)
end

local aR=math.max(ap.MaxWidth-120,80)


local aS=MeasureText(ap.Title,15,aR,Enum.FontWeight.SemiBold,aP)
local aT=if aO=="Expanded"and ap.Content
then MeasureText(ap.Content,12,aR,Enum.FontWeight.Regular,aP)
else 0
local aU=math.max(aS,aT)
local aV=GetDragWidth(aO,aQ)
local aW=if au then ap.IconSize+ap.Gap else 0
local aX=if aO=="Expanded"then 24 else 0
local aY=aV+(ap.Padding*2)+aW+aU+aX
if aO=="Expanded"then
aY=math.max(aY,ap.ExpandedWidth)
end

return Vector2.new(math.clamp(aY,aQ,ap.MaxWidth),aQ)
end

local aO




local function ReflowFromMeasurement()
if aq.State then
aO(aq.State)
end
end

function aO(aP,aQ)
aP=NormalizeState(aP)
local aR=if aQ==false then 0 else 0.28
local aS=GetTargetSize(aP,ReflowFromMeasurement)
local aT=GetDragWidth(aP,aS.Y)
local aU=ap.Padding
local aV=au~=nil
local aW=if aV then ap.IconSize+ap.Gap else 0
local aX=if aP=="Expanded"then 24 else 0

aq.State=aP
ap.State=aP
aD.Visible=aT>0
aG.Visible=aT>0
aK.Visible=aP~="Collapsed"and aP~="Idle"
aL.Visible=aP=="Expanded"and ap.Content~=nil and ap.Content~=""
aM.Visible=aP=="Expanded"

Animate(aw,aR,{Size=UDim2.fromOffset(aS.X,aS.Y)})
Animate(aH,aR,{
Size=UDim2.new(1,-aT,1,0),
Position=UDim2.fromOffset(aT,0),
})





Animate(aD,aR,{
Size=UDim2.fromOffset(math.max(aS.Y-8,0),math.max(aS.Y-8,0)),
Position=UDim2.fromOffset(4,4),
})
Animate(aG,aR,{Position=UDim2.new(0,aT,0.5,0)})

if au then
local aY=if aP=="Collapsed"or aP=="Idle"
then aS.X/2
else aU+ap.IconSize/2
Animate(au,aR,{
Position=UDim2.fromOffset(aY,aS.Y/2),
Size=UDim2.fromOffset(
if aP=="Idle"then 0 else ap.IconSize,
if aP=="Idle"then 0 else ap.IconSize
),
})
end

local aY=aU+aW
Animate(aJ,aR,{
Position=UDim2.fromOffset(aY,0),
Size=UDim2.new(1,-(aY+aU+aX),1,0),
})
Animate(aK,aR,{
Size=if aL.Visible then UDim2.new(1,0,0,22)else UDim2.fromScale(1,1),
Position=if aL.Visible then UDim2.fromOffset(0,13)else UDim2.fromOffset(0,0),
})
aL.Text=tostring(ap.Content or"")

ab.SafeCallback(ap.OnStateChange,aP,aq)
end

local function CancelAutoHide()
as=as+1
end

local function ScheduleAutoHide(aP)
CancelAutoHide()
if ap.AutoHide==false or aq.State=="Idle"or not aw.Visible then
return
end

local aQ=tonumber(aP)
if aQ==nil then
aQ=tonumber(ap.AutoHide)
end
if aQ==nil or aQ<=0 then
return
end

local aR=as
task.delay(aQ,function()
if aR==as and aw.Parent and aw.Visible then
aq:SetState"Idle"
end
end)
end

function aq.SetIcon(aP,aQ,aR)
if au then
au:Destroy()
au=nil
end

ap.Icon=aQ
if aQ~=nil and aQ~=false and aQ~=""then
au=ab.Image(
aQ,
ap.Title..":OpenButton",
0,
an.Folder,
"OpenButton",
true,
an.IconThemed
)
au.Name="Icon"
au.AnchorPoint=Vector2.new(0.5,0.5)
au.ZIndex=103
au.Parent=aH
end

if not aR then
aO(aq.State,false)
end
return aq
end

function aq.SetTitle(aP,aQ)
ap.Title=tostring(aQ or"")
aK.Text=ap.Title
ab:ChangeTranslationKey(aK,ap.Title)
aO(aq.State,true)
return aq
end

function aq.SetContent(aP,aQ)
ap.Content=if aQ==nil or aQ==false then nil else tostring(aQ)
aL.Text=ap.Content or""
aO(aq.State,true)
return aq
end

function aq.SetState(aP,aQ,aR,aS)
ar=ar+1
CancelAutoHide()
if typeof(aR)=="table"then
if aR.Title~=nil then
ap.Title=tostring(aR.Title)
aK.Text=ap.Title
end
if aR.Content~=nil or aR.Description~=nil then
local aT=if aR.Content~=nil then aR.Content else aR.Description
ap.Content=if aT==false then nil else tostring(aT or"")
end
if aR.Icon~=nil then
aq:SetIcon(aR.Icon,true)
end
end

aO(aQ,aS)
ScheduleAutoHide()
return aq
end

function aq.GetState(aP)
return aq.State
end

function aq.GetMorphTarget(aP)
local aQ=aB or aw
local aR=aQ.AbsoluteSize
local aS=aQ.AbsolutePosition+(aR/2)
return{
Position=aS,
Size=aR,
Duration=math.max(tonumber(ap.MorphDuration)or 0.42,0),
Enabled=ap.MorphWindow~=false and ap.Enabled~=false,
}
end

function aq.Expand(aP,aQ,aR)
aq:SetState("Expanded",aQ)
local aS=ar
local aT=tonumber(aR)or tonumber(ap.AutoCollapse)
if aT and aT>0 then
CancelAutoHide()
task.delay(aT,function()
if aS==ar and aw.Parent then
aq:Compact()
end
end)
end
return aq
end

function aq.Collapse(aP,aQ)
return aq:SetState("Collapsed",aQ)
end

function aq.Compact(aP,aQ)
return aq:SetState("Compact",aQ)
end

function aq.Idle(aP,aQ)
return aq:SetState("Idle",aQ)
end

aq.Hide=aq.Idle

function aq.Wake(aP,aQ)
return aq:Compact(aQ)
end

function aq.ToggleExpanded(aP,aQ)
if aq.State=="Expanded"then
return aq:Compact(aQ)
end
return aq:Expand(aQ)
end

function aq.Push(aP,aQ,aR)
local aS=aq.State
aq:SetState("Expanded",aQ)
CancelAutoHide()
local aT=ar
local aU=math.max(tonumber(aR)or 3,0)
task.delay(aU,function()
if aT==ar and aw.Parent then
aq:SetState(aS)
end
end)
return aq
end

aq.Notify=aq.Push

function aq.Visible(aP,aQ)
aw.Visible=aQ==true
if aw.Visible then
if ap.WakeOnShow and aq.State=="Idle"then
aq:SetState"Compact"
else
ScheduleAutoHide()
end
else
CancelAutoHide()
end
return aq
end

function aq.SetScale(aP,aQ)
ap.Scale=math.max(tonumber(aQ)or 1,0.1)
aq.Scale=ap.Scale
StopTween(ax)
ax.Scale=ap.Scale
return aq
end

function aq.Pulse(aP)
local aQ=ap.Scale
Animate(ax,0.08,{Scale=aQ*0.94})
task.delay(0.08,function()
if ax.Parent then
Animate(ax,0.16,{Scale=aQ})
end
end)
return aq
end

function aq.Edit(aP,aQ)
aQ=if typeof(aQ)=="table"then aQ else{}
ap.Title=tostring(Pick(aQ.Title,ap.Title))
local aR=Pick(aQ.Content,Pick(aQ.Description,ap.Content))
ap.Content=if aR==false or aR==nil then nil else tostring(aR)
ap.Enabled=Pick(aQ.Enabled,ap.Enabled)
ap.OnlyMobile=Pick(aQ.OnlyMobile,ap.OnlyMobile)
ap.Draggable=Pick(aQ.Draggable,ap.Draggable)
ap.Position=Pick(aQ.Position,Pick(aQ.Preset,ap.Position))
ap.Height=math.max(tonumber(Pick(aQ.Height,ap.Height))or 44,34)
ap.IdleWidth=math.max(tonumber(Pick(aQ.IdleWidth,ap.IdleWidth))or 78,44)
ap.IdleHeight=math.max(tonumber(Pick(aQ.IdleHeight,ap.IdleHeight))or 28,20)
ap.ExpandedHeight=
math.max(tonumber(Pick(aQ.ExpandedHeight,ap.ExpandedHeight))or 68,ap.Height)
ap.ExpandedWidth=math.max(tonumber(Pick(aQ.ExpandedWidth,ap.ExpandedWidth))or 220,120)
ap.MaxWidth=math.max(tonumber(Pick(aQ.MaxWidth,ap.MaxWidth))or 380,ap.ExpandedWidth)
ap.IconSize=math.max(tonumber(Pick(aQ.IconSize,ap.IconSize))or 22,12)
ap.Padding=math.max(tonumber(Pick(aQ.Padding,ap.Padding))or 12,4)
ap.Gap=math.max(tonumber(Pick(aQ.Gap,ap.Gap))or 9,0)
ap.CornerRadius=Pick(aQ.CornerRadius,ap.CornerRadius)
ap.StrokeThickness=math.max(tonumber(Pick(aQ.StrokeThickness,ap.StrokeThickness))or 1,0)
ap.StrokeTransparency=
ab.ClampTransparency(Pick(aQ.StrokeTransparency,ap.StrokeTransparency),0.7)
ap.Scale=math.max(tonumber(Pick(aQ.Scale,ap.Scale))or 1,0.1)
ap.Color=NormalizeColorSequence(aQ.Color,ap.Color)
ap.BackgroundColor=Pick(aQ.BackgroundColor,ap.BackgroundColor)
ap.BackgroundTransparency=ab.ClampTransparency(
Pick(aQ.BackgroundTransparency,Pick(aQ.Transparency,ap.BackgroundTransparency)),
0.08
)
ap.TextColor=Pick(aQ.TextColor,ap.TextColor)
ap.TextTransparency=ab.ClampTransparency(
Pick(aQ.TextTransparency,ap.TextTransparency),
ap.TextTransparency
)
ap.AutoCollapse=Pick(aQ.AutoCollapse,ap.AutoCollapse)
ap.AutoHide=Pick(aQ.AutoHide,ap.AutoHide)
ap.WakeOnShow=Pick(aQ.WakeOnShow,ap.WakeOnShow)
ap.Shadow=Pick(aQ.Shadow,ap.Shadow)
ap.ShadowBlur=ab.ToUDimRadius(aQ.ShadowBlur,ap.ShadowBlur)
ap.ShadowColor=if typeof(aQ.ShadowColor)=="Color3"
then aQ.ShadowColor
else ap.ShadowColor
ap.ShadowOffset=if typeof(aQ.ShadowOffset)=="UDim2"
then aQ.ShadowOffset
else ap.ShadowOffset
ap.ShadowSpread=if typeof(aQ.ShadowSpread)=="UDim2"
then aQ.ShadowSpread
else ap.ShadowSpread
ap.ShadowTransparency=
ab.ClampTransparency(Pick(aQ.ShadowTransparency,ap.ShadowTransparency),0.5)
ap.FallbackShadow=Pick(aQ.FallbackShadow,ap.FallbackShadow)
ap.MorphWindow=Pick(aQ.MorphWindow,Pick(aQ.WindowMorph,ap.MorphWindow))
ap.MorphDuration=math.max(
tonumber(Pick(aQ.MorphDuration,Pick(aQ.WindowMorphDuration,ap.MorphDuration)))or 0.42,
0
)
ap.OnStateChange=Pick(aQ.OnStateChange,ap.OnStateChange)

local aS=aQ.State or aQ.Mode
if aQ.OnlyIcon==true or aQ.Style=="Circle"then
aS=aS or"Collapsed"
elseif aQ.OnlyIcon==false and aS==nil then
aS="Compact"
end

an.IsOpenButtonEnabled=ap.Enabled~=false
if ap.OnlyMobile==false then
an.IsPC=false
end
if av then
av:Set(ap.Draggable)
end

ApplyPosition(ap.Position)
aq:SetScale(ap.Scale)
aB.BackgroundColor3=ap.BackgroundColor
aB.BackgroundTransparency=ap.BackgroundTransparency
aB.UICorner.CornerRadius=ap.CornerRadius
aH.UICorner.CornerRadius=GetInnerCornerRadius(ap.CornerRadius,4)
aI.UICorner.CornerRadius=GetInnerCornerRadius(ap.CornerRadius,4)
ay.UICorner.CornerRadius=ap.CornerRadius
ay.Visible=ap.Shadow and aC==nil and ap.FallbackShadow
if aC then
aC.Enabled=ap.Shadow
aC.BlurRadius=ap.ShadowBlur
aC.Color=ap.ShadowColor
aC.Offset=ap.ShadowOffset
aC.Spread=ap.ShadowSpread
aC.Transparency=ap.ShadowTransparency
end
aA.Thickness=ap.StrokeThickness
aA.Transparency=ap.StrokeTransparency
az.Color=ap.Color
aK.Text=ap.Title
aL.Text=tostring(ap.Content or"")
if ap.TextColor then
aK.TextColor3=ap.TextColor
aL.TextColor3=ap.TextColor
end
if ap.TextTransparency~=nil then
aK.TextTransparency=ap.TextTransparency
end

if aQ.Icon~=nil then
aq:SetIcon(aQ.Icon,true)
elseif not au and ap.Icon then
aq:SetIcon(ap.Icon,true)
end

aO(aS or aq.State,aQ.Animate~=false)
if aQ.Visible~=nil then
aq:Visible(aQ.Visible)
elseif aw.Visible then
ScheduleAutoHide()
end
return aq
end

function aq.Destroy(aP)
ar=ar+1
CancelAutoHide()
local aQ={}
for aR in at do
table.insert(aQ,aR)
end
for aR,aS in aQ do
StopTween(aS)
end
aw:Destroy()
end

ab.AddSignal(aH.MouseEnter,function()
Animate(aI,0.12,{BackgroundTransparency=0.94})
end)
ab.AddSignal(aH.MouseLeave,function()
Animate(aI,0.16,{BackgroundTransparency=1})
end)
ab.AddSignal(aH.InputBegan,function(aP)
if
aP.UserInputType==Enum.UserInputType.MouseButton1
or aP.UserInputType==Enum.UserInputType.Touch
then
aq:Pulse()
end
end)

av=ab.Drag(aw)
aq.Button=aB
aq.Container=aw
aq.UIElements={
Container=aw,
Button=aB,
MainAction=aH,
Drag=aD,
Divider=aG,
Title=aK,
Content=aL,
TextStack=aJ,
HoverSurface=aI,
TrailingIcon=aM,
Stroke=aA,
Shadow=ay,
NativeShadow=aC,
Scale=ax,
}

if ap.Icon then
aq:SetIcon(ap.Icon)
else
aO(ap.State,false)
end

return aq
end

return aa end function a.F()

local aa={}

local ab=a.load'e'
local ad=a.load'f'
local ae=ab.New

local af={
TopLeft={UDim2.new(0,14,0,14),Vector2.new(0,0)},
TopRight={UDim2.new(1,-14,0,14),Vector2.new(1,0)},
BottomLeft={UDim2.new(0,14,1,-14),Vector2.new(0,1)},
BottomRight={UDim2.new(1,-14,1,-14),Vector2.new(1,1)},
TopCenter={UDim2.new(0.5,0,0,14),Vector2.new(0.5,0)},
BottomCenter={UDim2.new(0.5,0,1,-14),Vector2.new(0.5,1)},
}

local function NormalizeConfig(ag)
if ag==false then
return{Visible=false}
end
if typeof(ag)=="string"then
return{Title=ag}
end
if typeof(ag)~="table"then
return{}
end
return ag or{}
end

function aa.New(ag,ah)
local ai={}
local aj
local ak

local al=ae("TextLabel",{
BackgroundTransparency=1,
Text=ag.Title or"WindUI",
TextSize=13,
TextXAlignment="Left",
AutomaticSize="XY",
FontFace=Font.new(ab.Font,Enum.FontWeight.Bold),
ThemeTag={
TextColor3="Text",
},
})

local am=ae("TextLabel",{
BackgroundTransparency=1,
Text="v"..tostring(ah and ah.Version or""),
TextSize=11,
TextTransparency=0.42,
TextXAlignment="Left",
AutomaticSize="XY",
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})

local an=ae("Frame",{
Size=UDim2.new(0,0,0,0),
Position=af.BottomRight[1],
AnchorPoint=af.BottomRight[2],
BackgroundTransparency=1,
Parent=ag.Parent,
Active=true,
Visible=false,
ZIndex=120,
})

local ao=ab.NewRoundFrame(14,"Squircle",{
Name="Watermark",
Size=UDim2.new(0,0,0,36),
AutomaticSize="XY",
ImageTransparency=0.18,
Parent=an,
ZIndex=120,
ThemeTag={
ImageColor3="Background",
},
},{
ae("UIStroke",{
ApplyStrokeMode="Border",
Color=Color3.new(1,1,1),
Transparency=0.82,
Thickness=1,
}),




ab.NewRoundFrame(14,"Squircle",{
Name="Sheen",
Size=UDim2.fromScale(1,1),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0,
ZIndex=120,
},{
ae("UIGradient",{
Rotation=24,
Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromRGB(210,235,255)),
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.48,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
}),
ae("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ae("Frame",{
Name="Text",
AutomaticSize="XY",
BackgroundTransparency=1,
},{
ae("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,1),
}),
al,
am,
}),
ae("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingTop=UDim.new(0,7),
PaddingBottom=UDim.new(0,7),
}),
})

ab.AddSignal(ao:GetPropertyChangedSignal"AbsoluteSize",function()
an.Size=UDim2.fromOffset(ao.AbsoluteSize.X,ao.AbsoluteSize.Y)
end)

ak=ab.Drag(an)

local function SetIcon(ap)
if aj then
aj:Destroy()
aj=nil
end
if not ap or ap==""then
return
end

aj=ab.Image(ap,ap,0,ag.Folder,"Watermark",true,true,"Icon")
aj.Size=UDim2.new(0,16,0,16)
aj.LayoutOrder=-1
aj.Parent=ao
end

function ai.Visible(ap,aq)
an.Visible=aq~=false
end

function ai.Edit(ap,aq)
aq=NormalizeConfig(aq)

if aq.Visible==false or aq.Enabled==false then
ai:Visible(false)
return ai
end

if aq.Title~=nil then
al.Text=tostring(aq.Title)
ab:ChangeTranslationKey(al,al.Text)
end
if aq.Desc~=nil or aq.Subtitle~=nil then
am.Text=tostring(aq.Desc or aq.Subtitle or"")
am.Visible=am.Text~=""
ab:ChangeTranslationKey(am,am.Text)
end
if aq.Icon~=nil then
SetIcon(aq.Icon)
end
if aq.Position and af[aq.Position]then
an.Position=af[aq.Position][1]
an.AnchorPoint=af[aq.Position][2]
elseif typeof(aq.Position)=="UDim2"then
an.Position=aq.Position
end
if typeof(aq.AnchorPoint)=="Vector2"then
an.AnchorPoint=aq.AnchorPoint
end
if aq.Transparency~=nil then
ao.ImageTransparency=ab.ClampTransparency(aq.Transparency,ao.ImageTransparency)
end
if aq.Scale then
local ar=ao:FindFirstChildOfClass"UIScale"or ae("UIScale",{Parent=ao})
ar.Scale=tonumber(aq.Scale)or 1
end
if ak then
ak:Set(aq.Draggable~=false)
end

ai:Visible(true)
ad.Play(ao,"Reveal",{ImageTransparency=ao.ImageTransparency},nil,nil,"Watermark")
return ai
end

function ai.SetTitle(ap,aq)
al.Text=tostring(aq or"")
end

function ai.SetDesc(ap,aq)
am.Text=tostring(aq or"")
am.Visible=am.Text~=""
end

function ai.Destroy(ap)
an:Destroy()
end

ai.Container=an
ai.Main=ao

return ai
end

return aa end function a.G()

local aa=game:GetService"UserInputService"
local ab=game:GetService"Workspace"

local ad=a.load'e'
local ae=a.load'f'
local af=ad.New

local ag={}

local function GetImageTarget(ah)
if typeof(ah)~="Instance"then
return nil
end

if ah:IsA"ImageLabel"or ah:IsA"ImageButton"then
return ah
end

return ah:FindFirstChildWhichIsA"ImageLabel"or ah:FindFirstChildWhichIsA"ImageButton"
end

local function ContainsPoint(ah,ai)
if typeof(ah)~="Instance"or not ah.Visible then
return false
end

local aj=ah.AbsolutePosition
local ak=ah.AbsoluteSize

return ai.X>=aj.X
and ai.X<=aj.X+ak.X
and ai.Y>=aj.Y
and ai.Y<=aj.Y+ak.Y
end

local function Trim(ah)
ah=tostring(ah or"")
ah=string.gsub(ah,"^%s+","")
ah=string.gsub(ah,"%s+$","")
return ah
end

local function GetThemeList(ah)
local ai={}

for aj,ak in next,ah:GetThemes()or{}do
table.insert(ai,{
Key=aj,
Name=ak.Name or aj,
})
end

table.sort(ai,function(aj,ak)
return aj.Name<ak.Name
end)

return ai
end

function ag.New(ah,ai,aj)
local ak=typeof(ah.Settings)=="table"and ah.Settings or{}
local al=ak.DefaultConfig or"default"
local am=ak.Width or 360
local an=ak.Height or 410
local ao=ak.PageHeight or(an-142)
local ap={
Open=false,
Button=nil,
Token=0,
SelectedTab="config",
UIElements={},
ThemeButtons={},
TabButtons={},
Pages={},
}

local function GetViewportSize()
local aq=ab.CurrentCamera
return aq and aq.ViewportSize or Vector2.new(1280,720)
end

local function Notify(aq,ar,as,at)
if ai.Notify then
ai:Notify{
Title=aq,
Content=ar,
Icon=as,
Style=at,
}
end
end

local function CreateIcon(aq,ar,as)
local at=ad.Image(aq,aq,0,ah.Folder,"SettingsMenu",true,true,"Icon")
at.Size=UDim2.new(0,as or 16,0,as or 16)
at.Parent=ar
return at
end

local function CreateText(aq,ar,as,at,au)
return af("TextLabel",{
BackgroundTransparency=1,
Text=ar or"",
TextSize=as or 14,
TextTransparency=au or 0,
TextWrapped=true,
TextXAlignment="Left",
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Parent=aq,
FontFace=Font.new(ad.Font,at or Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})
end

local function CreatePanel(aq)
return ad.NewRoundFrame(ah.ElementConfig.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ImageTransparency=0.9,
Parent=aq,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
af("UIGradient",{
Rotation=35,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.05),
NumberSequenceKeypoint.new(1,0.2),
},
}),
af("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
}),
af("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
})
end

local function CreateActionButton(aq,ar,as,at,au)
local av=ad.NewRoundFrame(14,"Squircle",{
Size=UDim2.new(1,0,0,34),
ImageTransparency=at=="Primary"and 0 or 0.9,
ThemeTag={
ImageColor3=at=="Primary"and"Primary"or"ElementBackground",
},
Parent=aq,
},{
af("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
af("UIListLayout",{
Padding=UDim.new(0,7),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
as and CreateIcon(as,nil,15)or nil,
af("TextLabel",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
BackgroundTransparency=1,
Text=ar,
TextSize=13,
FontFace=Font.new(ad.Font,Enum.FontWeight.SemiBold),
TextColor3=at=="Primary"and Color3.new(1,1,1)or nil,
ThemeTag={
TextColor3=at~="Primary"and"Text"or nil,
},
}),
},true)

ae.AttachPress(av,ad,{
Amount=0.97,
})

ad.AddSignal(av.MouseButton1Click,function()
ad.SafeCallback(au)
end)

return av
end

local aq=ad.NewRoundFrame(ah.ElementConfig.UICorner,"Squircle",{
Name="SettingsDropdown",
Size=UDim2.new(0,am,0,an),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.fromOffset(0,0),
ImageTransparency=1,
Visible=false,
Active=false,
ZIndex=10000,
Parent=ai.ScreenGui,
ThemeTag={
ImageColor3="Background",
},
},{
af("UIScale",{
Name="Scale",
Scale=0.98,
}),
ad.NewRoundFrame(ah.ElementConfig.UICorner,"SquircleGlass",{
Name="GlassLayer",
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.72,
ZIndex=10000,
ThemeTag={
ImageColor3="Primary",
},
}),
ad.NewRoundFrame(ah.ElementConfig.UICorner,"SquircleOutline",{
Name="Outline",
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.72,
ZIndex=10001,
ThemeTag={
ImageColor3="Outline",
},
}),
})

local ar=af("Frame",{
Name="SettingsScrim",
Size=UDim2.new(1,0,1,0),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=1,
Visible=false,
Active=false,
ZIndex=9998,
Parent=ai.ScreenGui,
})

local as=af("CanvasGroup",{
Name="Content",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
GroupTransparency=1,
ZIndex=10002,
Parent=aq,
},{
af("UIPadding",{
PaddingTop=UDim.new(0,12),
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
PaddingBottom=UDim.new(0,12),
}),
af("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

ap.UIElements.Root=aq
ap.UIElements.Scale=aq.Scale
ap.UIElements.Scrim=ar
ap.UIElements.Content=as
ap.UIElements.GlassLayer=aq.GlassLayer
ap.UIElements.Outline=aq.Outline

local at
local au

local function UpdateRootPosition()
local av=GetViewportSize()
local aw=12
local ax=math.floor(math.min(am,math.max(280,av.X-(aw*2))))
local ay=math.floor(math.min(an,math.max(300,av.Y-(aw*2))))
local az=Vector2.new(1,0)
local aA=av.X-aw
local aB=aw+ah.Topbar.Height

aq.Size=UDim2.fromOffset(ax,ay)
if at then
at.Size=UDim2.new(1,0,0,math.max(154,ay-142))
end
if au then
au.Size=UDim2.new(1,0,0,math.max(116,ay-238))
end

if ap.Button and ap.Button.AbsoluteSize.X>0 then
local aC=ap.Button.AbsolutePosition
local aD=ap.Button.AbsoluteSize
aA=aC.X+aD.X
aB=aC.Y+aD.Y+10
end

if aA-ax<aw then
aA=math.min(av.X-aw,aw+ax)
end
if aB+ay>av.Y-aw then
aB=math.max(aw,av.Y-ay-aw)
end

aq.AnchorPoint=az
aq.Position=UDim2.fromOffset(aA,aB)
ar.Size=UDim2.fromOffset(av.X,av.Y)
end

local av=af("Frame",{
Name="Header",
LayoutOrder=1,
Size=UDim2.new(1,0,0,40),
BackgroundTransparency=1,
Parent=as,
},{
af("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
})

local aw=CreateIcon("settings",nil,17)
ad.NewRoundFrame(999,"Squircle",{
Size=UDim2.new(0,36,0,36),
ImageTransparency=0.86,
ThemeTag={
ImageColor3="Primary",
},
Parent=av,
},{
aw,
ad.NewRoundFrame(999,"SquircleGlass",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.8,
ThemeTag={
ImageColor3="Primary",
},
}),
})
aw.Position=UDim2.new(0.5,0,0.5,0)
aw.AnchorPoint=Vector2.new(0.5,0.5)
aw.ZIndex=10002

local ax=af("Frame",{
Size=UDim2.new(1,-46,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=av,
},{
af("UIListLayout",{
Padding=UDim.new(0,2),
FillDirection="Vertical",
}),
})
CreateText(ax,"Settings",16,Enum.FontWeight.Bold,0)
CreateText(ax,"Config, theme and runtime controls",12,Enum.FontWeight.Medium,0.42)

local ay=ad.NewRoundFrame(16,"Squircle",{
Name="SettingsTabs",
LayoutOrder=2,
Size=UDim2.new(1,0,0,38),
ImageTransparency=0.9,
Parent=as,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
af("UIPadding",{
PaddingTop=UDim.new(0,4),
PaddingLeft=UDim.new(0,4),
PaddingRight=UDim.new(0,4),
PaddingBottom=UDim.new(0,4),
}),
af("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
SortOrder="LayoutOrder",
}),
})

at=af("Frame",{
Name="Pages",
LayoutOrder=3,
Size=UDim2.new(1,0,0,ao),
BackgroundTransparency=1,
ClipsDescendants=true,
Parent=as,
})

local function CreateTabButton(az,aA,aB,aC)
local aD=CreateIcon(aB,nil,14)
local aE=af("TextLabel",{
Name="Title",
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
BackgroundTransparency=1,
Text=aA,
TextSize=12,
TextTruncate="AtEnd",
FontFace=Font.new(ad.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
})

local aF=ad.NewRoundFrame(12,"Squircle",{
Name=az,
LayoutOrder=aC,
Size=UDim2.new(0.3333333333333333,-3,1,0),
ImageTransparency=1,
Parent=ay,
ThemeTag={
ImageColor3="Primary",
},
},{
af("UIPadding",{
PaddingLeft=UDim.new(0,8),
PaddingRight=UDim.new(0,8),
}),
af("UIListLayout",{
Padding=UDim.new(0,5),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
aD,
aE,
},true)

local aG=GetImageTarget(aD)
ap.TabButtons[az]={
Button=aF,
Label=aE,
Icon=aG,
}

ae.AttachPress(aF,ad,{
Amount=0.98,
})

ad.AddSignal(aF.MouseButton1Click,function()
ap:SelectTab(az)
end)

return aF
end

local function CreatePage(az)
local aA=af("CanvasGroup",{
Name=az,
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
GroupTransparency=1,
Visible=false,
Active=false,
Parent=at,
},{
af("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

ap.Pages[az]=aA
return aA
end

local az=CreatePage"config"
local aA=CreatePage"theme"
local aB=CreatePage"about"

CreateTabButton("config","Config","save",1)
CreateTabButton("theme","Theme","palette",2)
CreateTabButton("about","Info","badge-info",3)

local aC=CreatePanel(az)
CreateText(aC,"Config Profile",13,Enum.FontWeight.Bold,0.05)

local aD=ad.NewRoundFrame(12,"Squircle",{
Size=UDim2.new(1,0,0,36),
ImageTransparency=0.9,
ThemeTag={
ImageColor3="ElementBackground",
},
Parent=aC,
},{
af("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
})

local aE=af("TextBox",{
Name="ConfigName",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ClearTextOnFocus=false,
Text=al,
PlaceholderText="default",
TextSize=13,
TextXAlignment="Left",
FontFace=Font.new(ad.Font,Enum.FontWeight.Medium),
Parent=aD,
ThemeTag={
TextColor3="Text",
PlaceholderColor3="Placeholder",
},
})

local aF=CreateText(aC,"No saved configs",12,Enum.FontWeight.Medium,0.45)

local aG=af("Frame",{
Name="HStack",
Size=UDim2.new(1,0,0,34),
BackgroundTransparency=1,
Parent=aC,
},{
af("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
HorizontalAlignment="Center",
VerticalAlignment="Center",
}),
})

local aH=CreatePanel(az)
CreateText(aH,"Runtime",13,Enum.FontWeight.Bold,0.05)
local aI=CreateText(aH,"Theme: "..tostring(ai:GetCurrentTheme()),12,Enum.FontWeight.Medium,0.28)
CreateText(aH,"Settings use glass morph layers and tabbed pages.",12,Enum.FontWeight.Medium,0.45)

local function GetConfigName()
local aJ=Trim(aE.Text)
return aJ~=""and aJ or al
end

local function RefreshConfigMeta()
local aJ=ah.ConfigManager
if not aJ or typeof(aJ)~="table"then
aF.Text="Config is unavailable in this environment"
return
end

local aK,aL=pcall(function()
return aJ:AllConfigs()
end)
local aM=aK and#aL or 0
aF.Text=aM==1 and"1 saved config"or tostring(aM).." saved configs"
end

local aJ=CreateActionButton(aG,"Save","save","Primary",function()
local aJ=ah.ConfigManager
if not aJ or typeof(aJ)~="table"then
Notify("Config unavailable","Config save needs file access.","triangle-alert","Warning")
return
end

local aK=GetConfigName()
local aL,aM,aN=pcall(function()
local aL=aJ:Config(aK)
aL:Set("theme",ai:GetCurrentTheme())
return aL:Save()
end)

if aL and aM then
RefreshConfigMeta()
Notify("Config saved","Saved '"..aK.."'.","check","Success")
else
Notify("Config save failed",tostring(aN or aM),"triangle-alert","Error")
end
end)
aJ.Size=UDim2.new(0.5,-4,1,0)

local aK=CreateActionButton(aG,"Load","download","Secondary",function()
local aK=ah.ConfigManager
if not aK or typeof(aK)~="table"then
Notify("Config unavailable","Config load needs file access.","triangle-alert","Warning")
return
end

local aL=GetConfigName()
local aM,aN,aO=pcall(function()
local aM=aK:Config(aL)
local aN=aM:Load()
if aN and aN.theme then
ai:SetTheme(aN.theme)
end
return aN
end)

if aM and aN then
aI.Text="Theme: "..tostring(ai:GetCurrentTheme())
Notify("Config loaded","Loaded '"..aL.."'.","refresh-cw","Success")
else
Notify("Config load failed",tostring(aO or aN),"triangle-alert","Error")
end
end)
aK.Size=UDim2.new(0.5,-4,1,0)

local aL=CreatePanel(aA)
CreateText(aL,"Theme Picker",13,Enum.FontWeight.Bold,0.05)
CreateText(aL,"Tap a theme to apply it instantly.",12,Enum.FontWeight.Medium,0.45)

au=af("ScrollingFrame",{
Name="ThemeList",
Size=UDim2.new(1,0,0,ak.ThemeListHeight or 214),
BackgroundTransparency=1,
ScrollBarThickness=0,
AutomaticCanvasSize="Y",
CanvasSize=UDim2.new(0,0,0,0),
Parent=aL,
},{
af("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
})

local function UpdateThemeButtons()
local aM=ai:GetCurrentTheme()
aI.Text="Theme: "..tostring(aM)
for aN,aO in next,ap.ThemeButtons do
local aP=aN==aM
ae.Play(aO.Button,"Switch",{ImageTransparency=aP and 0.82 or 0.94},nil,nil,"Theme")
ae.Play(aO.Label,"Switch",{TextTransparency=aP and 0 or 0.24},nil,nil,"Theme")
if aO.Check then
ae.Play(aO.Check,"Switch",{ImageTransparency=aP and 0 or 1},nil,nil,"Theme")
end
end
end

for aM,aN in next,GetThemeList(ai)do
local aO=CreateIcon("check",nil,14)
local aP=ad.NewRoundFrame(12,"Squircle",{
Size=UDim2.new(1,0,0,32),
ImageTransparency=0.94,
ThemeTag={
ImageColor3="Primary",
},
Parent=au,
},{
af("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
af("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,8),
VerticalAlignment="Center",
}),
af("TextLabel",{
Name="Title",
Size=UDim2.new(1,-22,1,0),
BackgroundTransparency=1,
Text=aN.Name,
TextSize=13,
TextXAlignment="Left",
TextTruncate="AtEnd",
FontFace=Font.new(ad.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
aO,
},true)

local aQ=GetImageTarget(aO)
if aQ then
aQ.ImageTransparency=1
end

ap.ThemeButtons[aN.Key]={
Button=aP,
Label=aP.Title,
Check=aQ,
}

ae.AttachPress(aP,ad,{
Amount=0.985,
})

ad.AddSignal(aP.MouseButton1Click,function()
ai:SetTheme(aN.Key)
UpdateThemeButtons()
end)
end

local aM=CreatePanel(aB)
CreateText(aM,"WindUI Settings",13,Enum.FontWeight.Bold,0.05)
CreateText(aM,"Use Config for save/load and Theme for quick visual switching.",12,Enum.FontWeight.Medium,0.36)

local aN=af("Frame",{
Name="VStack",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=aM,
},{
af("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
})

local function CreateInfoRow(aO,aP)
return ad.NewRoundFrame(12,"Squircle",{
Size=UDim2.new(1,0,0,34),
ImageTransparency=0.94,
ThemeTag={
ImageColor3="ElementBackground",
},
Parent=aN,
},{
af("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
af("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
af("TextLabel",{
Size=UDim2.new(0.44,0,1,0),
BackgroundTransparency=1,
Text=aO,
TextSize=12,
TextXAlignment="Left",
TextTransparency=0.38,
FontFace=Font.new(ad.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
}),
af("TextLabel",{
Size=UDim2.new(0.56,0,1,0),
BackgroundTransparency=1,
Text=aP,
TextSize=12,
TextXAlignment="Right",
TextTruncate="AtEnd",
FontFace=Font.new(ad.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
})
end

CreateInfoRow("Folder",tostring(ah.Folder or"WindUI"))
CreateInfoRow("Topbar",tostring(ah.Topbar.ButtonsType or"Default"))
CreateInfoRow("Motion",tostring(ae:GetConfig().Preset))

function ap.SetButton(aO,aP)
ap.Button=aP
end

function ap.SelectTab(aO,aP)
if not ap.Pages[aP]then
return
end

ap.SelectedTab=aP
for aQ,aR in next,ap.TabButtons do
local aS=aQ==aP
ae.Play(aR.Button,"Switch",{ImageTransparency=aS and 0.82 or 1},nil,nil,"SettingsTab")
ae.Play(aR.Label,"Switch",{TextTransparency=aS and 0 or 0.3},nil,nil,"SettingsTab")
if aR.Icon then
ae.Play(aR.Icon,"Switch",{ImageTransparency=aS and 0 or 0.35},nil,nil,"SettingsTab")
end
end

for aQ,aR in next,ap.Pages do
local aS=aQ==aP
aR.Active=aS
if aS then
aR.Visible=true
aR.GroupTransparency=1
ae.Play(aR,"Reveal",{GroupTransparency=0},nil,nil,"SettingsPage")
else
aR.Visible=false
aR.GroupTransparency=1
end
end
end

function ap.OpenMenu(aO)
if ap.Open then
return
end

ap.Open=true
ap.Token=ap.Token+1
RefreshConfigMeta()
UpdateThemeButtons()
ap:SelectTab(ap.SelectedTab)
UpdateRootPosition()
aq.Visible=true
aq.Active=true
ap.UIElements.Scrim.Visible=true
aq.ImageTransparency=1
ap.UIElements.Scrim.BackgroundTransparency=1
ap.UIElements.Content.GroupTransparency=1
ap.UIElements.GlassLayer.ImageTransparency=1
ap.UIElements.Outline.ImageTransparency=1
ap.UIElements.Scale.Scale=0.98
ae.Play(aq,"DropdownOpen",{ImageTransparency=0.18},nil,nil,"Settings")
ae.Play(ap.UIElements.Scrim,"DropdownOpen",{BackgroundTransparency=ak.ScrimTransparency or 0.72},nil,nil,"SettingsScrim")
ae.Play(ap.UIElements.Content,"DropdownOpen",{GroupTransparency=0},nil,nil,"SettingsContent")
ae.Play(ap.UIElements.GlassLayer,"DropdownOpen",{ImageTransparency=0.78},nil,nil,"SettingsGlass")
ae.Play(ap.UIElements.Outline,"DropdownOpen",{ImageTransparency=0.72},nil,nil,"SettingsOutline")
ae.Play(ap.UIElements.Scale,"DropdownOpen",{Scale=1},nil,nil,"SettingsScale")
end

function ap.CloseMenu(aO)
if not ap.Open then
return
end

ap.Open=false
ap.Token=ap.Token+1
local aP=ap.Token
aq.Active=false
ae.Play(aq,"DropdownClose",{ImageTransparency=1},nil,nil,"Settings")
ae.Play(ap.UIElements.Scrim,"DropdownClose",{BackgroundTransparency=1},nil,nil,"SettingsScrim")
ae.Play(ap.UIElements.Content,"DropdownClose",{GroupTransparency=1},nil,nil,"SettingsContent")
ae.Play(ap.UIElements.GlassLayer,"DropdownClose",{ImageTransparency=1},nil,nil,"SettingsGlass")
ae.Play(ap.UIElements.Outline,"DropdownClose",{ImageTransparency=1},nil,nil,"SettingsOutline")
ae.Play(ap.UIElements.Scale,"DropdownClose",{Scale=0.98},nil,nil,"SettingsScale")
task.delay(ae.GetDuration"DropdownClose",function()
if aP==ap.Token then
aq.Visible=false
ap.UIElements.Scrim.Visible=false
end
end)
end

function ap.Toggle(aO)
if ap.Open then
ap:CloseMenu()
else
ap:OpenMenu()
end
end

ad.AddSignal(aa.InputBegan,function(aO)
if not ap.Open then
return
end
if aO.UserInputType~=Enum.UserInputType.MouseButton1 and aO.UserInputType~=Enum.UserInputType.Touch then
return
end

if ContainsPoint(aq,aO.Position)or ContainsPoint(ap.Button,aO.Position)then
return
end

ap:CloseMenu()
end)

RefreshConfigMeta()
UpdateThemeButtons()
ap:SelectTab"config"

return ap
end

return ag end function a.H()

local aa=game:GetService"UserInputService"
local ab=game:GetService"Workspace"

local ad=a.load'e'
local ae=a.load'f'
local af=ad.New

local ag={}

local function ContainsPoint(ah,ai)
if typeof(ah)~="Instance"or not ah.Visible then
return false
end

local aj=ah.AbsolutePosition
local ak=ah.AbsoluteSize

return ai.X>=aj.X
and ai.X<=aj.X+ak.X
and ai.Y>=aj.Y
and ai.Y<=aj.Y+ak.Y
end

local function NormalizeKey(ah)
if typeof(ah)=="EnumItem"then
return ah.Name,ah
end
if typeof(ah)=="string"and Enum.KeyCode[ah]then
return ah,Enum.KeyCode[ah]
end
return"None",nil
end

function ag.New(ah,ai,aj)
local ak=typeof(ah.KeyBindMenu)=="table"and ah.KeyBindMenu or{}
local al=(aa.TouchEnabled and not aa.KeyboardEnabled)or ah.IsPC==false
local am=ak.Compact==true or(ak.Compact~=false and al)
local an=ak.Width or(am and 330 or 326)
local ao=ak.Height or(am and 300 or 354)
local ap=am and 10 or 14
local aq=am and 6 or 10
local ar=ak.QuickKeys or{"RightShift","F","LeftControl"}
local as={
Open=false,
Button=nil,
Token=0,
Capturing=false,
UserMoved=false,
StoredPosition=nil,
TargetPosition=nil,
UIElements={},
}

local function Notify(at,au,av,aw)
if ai.Notify then
ai:Notify{
Title=at,
Content=au,
Icon=av,
Style=aw,
}
end
end

local function GetViewportSize()
local at=ab.CurrentCamera
return at and at.ViewportSize or Vector2.new(1280,720)
end

local function GetScrimTransparency()
if ak.Scrim==false or ak.ShowScrim==false then
return 1
end
if ak.ScrimTransparency~=nil then
return ak.ScrimTransparency
end
return am and 1 or 0.78
end

local function CreateIcon(at,au,av)
local aw=ad.Image(at,at,0,ah.Folder,"KeyBindMenu",true,true,"Icon")
aw.Size=UDim2.new(0,av or 16,0,av or 16)
aw.Parent=au
return aw
end

local function CreateText(at,au,av,aw,ax)
return af("TextLabel",{
BackgroundTransparency=1,
Text=au or"",
TextSize=av or 14,
TextTransparency=ax or 0,
TextXAlignment="Left",
TextWrapped=true,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Parent=at,
FontFace=Font.new(ad.Font,aw or Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})
end

local at=ad.NewRoundFrame(ah.ElementConfig.UICorner,"Squircle",{
Name="KeyBindMenu",
Size=UDim2.new(0,an,0,ao),
AnchorPoint=am and Vector2.new(0.5,1)or Vector2.new(1,0),
Position=UDim2.fromOffset(0,0),
ImageTransparency=1,
Visible=false,
Active=false,
ClipsDescendants=true,
ZIndex=10020,
Parent=ai.ScreenGui,
ThemeTag={
ImageColor3="Background",
},
},{
af("UIScale",{
Name="Scale",
Scale=0.98,
}),
ad.NewRoundFrame(ah.ElementConfig.UICorner,"SquircleGlass",{
Name="GlassLayer",
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ZIndex=10020,
ThemeTag={
ImageColor3="Primary",
},
}),
ad.NewRoundFrame(ah.ElementConfig.UICorner,"SquircleOutline",{
Name="Outline",
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ZIndex=10021,
ThemeTag={
ImageColor3="Outline",
},
}),
})

local au=af("Frame",{
Name="KeyBindScrim",
Size=UDim2.new(1,0,1,0),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=1,
Visible=false,
Active=false,
ZIndex=10018,
Parent=ai.ScreenGui,
})

local av=af("CanvasGroup",{
Name="Content",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
GroupTransparency=1,
ZIndex=10022,
Parent=at,
},{
af("UIPadding",{
PaddingTop=UDim.new(0,ap),
PaddingLeft=UDim.new(0,ap),
PaddingRight=UDim.new(0,ap),
PaddingBottom=UDim.new(0,ap),
}),
af("UIListLayout",{
Padding=UDim.new(0,aq),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

as.UIElements.Root=at
as.UIElements.Scale=at.Scale
as.UIElements.Scrim=au
as.UIElements.Content=av
as.UIElements.GlassLayer=at.GlassLayer
as.UIElements.Outline=at.Outline

local function IsImageBackground(aw)
if typeof(aw)~="string"then
return false
end
if string.sub(aw,1,1)=="#"then
return false
end
if string.match(aw,"^video:")then
return false
end
return aw~=""
end

local function GetBackgroundKind(aw)
if aw==nil or aw==false then
return nil,nil,{}
end

if typeof(aw)=="table"then
local ax=aw.Type or aw.Kind or aw.Mode
if aw.Video or ax=="Video"or ax=="video"then
return"Video",
aw.Video or aw.Url or aw.URL or aw.Source or aw.Asset or aw.Path,
aw
end
if
aw.Image
or aw.Url
or aw.URL
or aw.Asset
or aw.Path
or ax=="Image"
or ax=="image"
then
return"Image",
aw.Image or aw.Url or aw.URL or aw.Asset or aw.Path or aw.Source,
aw
end
if aw.Gradient then
return"Gradient",aw.Gradient,aw
end
if ax=="Gradient"or ax=="gradient"or aw.Rotation~=nil or aw.Offset~=nil then
return"Gradient",aw,aw
end
if typeof(aw.Color)=="ColorSequence"or typeof(aw.Transparency)=="NumberSequence"then
return"Gradient",aw,aw
end
return nil,nil,aw
end

if typeof(aw)=="string"then
local ax=string.match(aw,"^video:(.+)")
local ay=aw:match"^([^?#]+)"or aw
if ax or string.match(ay:lower(),"%.webm$")then
return"Video",ax or aw,{}
end
if IsImageBackground(aw)then
return"Image",aw,{}
end
end

return nil,nil,{}
end

local function FindWindowBackgroundVideo()
local aw=ah.UIElements and ah.UIElements.Main
local ax=aw and aw:FindFirstChild"Background"
local ay=ax and ax:FindFirstChild"BackgroundVideo"
if ay and ay:IsA"VideoFrame"then
return ay.Video
end
return nil
end

local function ApplyGradientProperty(aw,ax,ay)
if ax=="Transparency"and typeof(ay)=="number"then
return
end
pcall(function()
aw[ax]=ay
end)
end

local function ApplyBackgroundMedia()
if ak.UseWindowBackground==false then
return
end

local aw,ax=GetBackgroundKind(ak.Background)
local ay,az=GetBackgroundKind(ah.Background)
local aA=ak.BackgroundGradient
or(aw=="Gradient"and ax)
or ah.BackgroundGradient
or(ay=="Gradient"and az)
local aB=ak.BackgroundImage
or(aw=="Image"and ax)
or(ay=="Image"and az)
local aC=(aw=="Video"and ax)
or(ay=="Video"and(FindWindowBackgroundVideo()or az))

if aB then
as.UIElements.BackgroundImage=af("ImageLabel",{
Name="BackgroundImage",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=tostring(aB),
ImageTransparency=ak.BackgroundImageTransparency
or ah.BackgroundImageTransparency
or 0.46,
ScaleType=ak.BackgroundScaleType or ah.BackgroundScaleType or"Crop",
ZIndex=10019,
Parent=at,
},{
af("UICorner",{
CornerRadius=UDim.new(0,ah.ElementConfig.UICorner),
}),
})
end

if aC then
as.UIElements.BackgroundVideo=af("VideoFrame",{
Name="BackgroundVideo",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Video=tostring(aC),
Looped=true,
Volume=0,
ZIndex=10019,
Parent=at,
},{
af("UICorner",{
CornerRadius=UDim.new(0,ah.ElementConfig.UICorner),
}),
})
as.UIElements.BackgroundVideo:Play()
end

if aA then
local aD=af"UIGradient"
for aE,aF in next,aA do
ApplyGradientProperty(aD,aE,aF)
end

as.UIElements.BackgroundGradient=ad.NewRoundFrame(ah.ElementConfig.UICorner,"Squircle",{
Name="BackgroundGradient",
Size=UDim2.new(1,0,1,0),
ImageTransparency=ak.BackgroundGradientTransparency
or ak.BackgroundOverlayTransparency
or ah.BackgroundOverlayTransparency
or 0.55,
ZIndex=10019,
Parent=at,
},{
aD,
})
end
end

ApplyBackgroundMedia()

local aw=af("Frame",{
Name="DragHandle",
Size=UDim2.new(1,0,0,8),
BackgroundTransparency=1,
LayoutOrder=0,
Visible=am,
Parent=av,
},{
af("Frame",{
Size=UDim2.new(0,42,0,4),
Position=UDim2.new(0.5,0,0,1),
AnchorPoint=Vector2.new(0.5,0),
BackgroundColor3=Color3.fromRGB(255,255,255),
BackgroundTransparency=0.72,
},{
af("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
})

local ax=af("Frame",{
Name="Header",
Size=UDim2.new(1,0,0,am and 34 or 42),
BackgroundTransparency=1,
Active=true,
LayoutOrder=1,
Parent=av,
},{
af("UIListLayout",{
Padding=UDim.new(0,am and 8 or 10),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
})

local ay=CreateIcon("keyboard",nil,am and 15 or 18)
ad.NewRoundFrame(999,"Squircle",{
Size=UDim2.new(0,am and 32 or 38,0,am and 32 or 38),
ImageTransparency=0.86,
Parent=ax,
ThemeTag={
ImageColor3="Primary",
},
},{
ay,
})
ay.Position=UDim2.new(0.5,0,0.5,0)
ay.AnchorPoint=Vector2.new(0.5,0.5)

local az=af("Frame",{
Size=UDim2.new(1,am and-78 or-48,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ax,
},{
af("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,2),
}),
})
CreateText(
az,
ak.Title or(am and"Keybind"or"KeyBind Menu"),
am and 14 or 16,
Enum.FontWeight.Bold,
0
)
local aA=CreateText(
az,
ak.Desc or(am and"Mobile quick toggle controls."or"Set the window toggle shortcut."),
am and 11 or 12,
Enum.FontWeight.Medium,
0.42
)
if ak.HideDesc~=nil then
aA.Visible=not ak.HideDesc
else
aA.Visible=not am
end

local aB=CreateIcon("x",nil,13)
local aC=ad.NewRoundFrame(999,"Squircle",{
Size=am and UDim2.new(0,28,0,28)or UDim2.new(0,0,0,0),
ImageTransparency=0.9,
Visible=am,
Parent=ax,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
aB,
},true)
aB.Position=UDim2.new(0.5,0,0.5,0)
aB.AnchorPoint=Vector2.new(0.5,0.5)

ad.AddSignal(aC.MouseButton1Click,function()
as:CloseMenu()
end)

local aD=ad.NewRoundFrame(16,"Squircle",{
Size=UDim2.new(1,0,0,am and 48 or 58),
ImageTransparency=am and 0.8 or 0.88,
LayoutOrder=2,
Parent=av,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
af("UIStroke",{
ApplyStrokeMode="Border",
Color=Color3.new(1,1,1),
Transparency=am and 0.8 or 0.88,
Thickness=1,
}),
af("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
af("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
})

local aE=NormalizeKey(ah.ToggleKey or ak.DefaultKey or ak.Value)
af("TextLabel",{
Size=UDim2.new(0.4,0,1,0),
BackgroundTransparency=1,
Text="Current",
TextSize=am and 11 or 12,
TextXAlignment="Left",
TextTransparency=0.44,
FontFace=Font.new(ad.Font,Enum.FontWeight.Medium),
Parent=aD,
ThemeTag={
TextColor3="Text",
},
})

local aF=af("TextLabel",{
Size=UDim2.new(0.6,0,1,0),
BackgroundTransparency=1,
Text=aE,
TextSize=am and 16 or 18,
TextXAlignment="Right",
FontFace=Font.new(ad.Font,Enum.FontWeight.Bold),
Parent=aD,
ThemeTag={
TextColor3="Text",
},
})

local aG=ad.NewRoundFrame(16,"Squircle",{
Name="ElementBindings",
Size=UDim2.new(1,0,0,am and 84 or 94),
ImageTransparency=am and 0.86 or 0.9,
LayoutOrder=3,
Parent=av,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
af("UIStroke",{
ApplyStrokeMode="Border",
Color=Color3.new(1,1,1),
Transparency=am and 0.82 or 0.9,
Thickness=1,
}),
af("UIPadding",{
PaddingTop=UDim.new(0,8),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,8),
}),
af("UIListLayout",{
Padding=UDim.new(0,5),
FillDirection="Vertical",
SortOrder="LayoutOrder",
}),
})

local aH=af("TextLabel",{
Name="Header",
Size=UDim2.new(1,0,0,14),
BackgroundTransparency=1,
Text="Element keybinds",
TextSize=am and 11 or 12,
TextXAlignment="Left",
TextTransparency=0.3,
LayoutOrder=1,
Parent=aG,
FontFace=Font.new(ad.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
})

local aI=af("ScrollingFrame",{
Name="List",
Size=UDim2.new(1,0,1,-19),
BackgroundTransparency=1,
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ScrollBarThickness=0,
LayoutOrder=2,
Parent=aG,
},{
af("UIListLayout",{
Padding=UDim.new(0,5),
FillDirection="Vertical",
SortOrder="LayoutOrder",
}),
})

local aJ=af("TextLabel",{
Name="Empty",
Size=UDim2.new(1,0,0,28),
BackgroundTransparency=1,
Text="No element keybinds",
TextSize=am and 11 or 12,
TextTransparency=0.48,
FontFace=Font.new(ad.Font,Enum.FontWeight.Medium),
Parent=aI,
ThemeTag={
TextColor3="Text",
},
})

local aK=af("Frame",{
Size=UDim2.new(1,0,0,am and 38 or 38),
BackgroundTransparency=1,
LayoutOrder=4,
Parent=av,
},{
af("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
HorizontalAlignment="Center",
}),
})

local function CreateButton(aL,aM,aN,aO,aP)
local aQ=ad.NewRoundFrame(14,"Squircle",{
Size=UDim2.new(0.5,-4,1,0),
ImageTransparency=aO=="Primary"and(am and 0.08 or 0.18)or(am and 0.84 or 0.9),
Parent=aL,
ThemeTag={
ImageColor3=aO=="Primary"and"Primary"or"ElementBackground",
},
},{
af("UIPadding",{
PaddingLeft=UDim.new(0,am and 8 or 10),
PaddingRight=UDim.new(0,am and 8 or 10),
}),
af("UIListLayout",{
Padding=UDim.new(0,am and 5 or 7),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
aN and CreateIcon(aN,nil,am and 13 or 15)or nil,
af("TextLabel",{
Name="Title",
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
BackgroundTransparency=1,
Text=aM,
TextSize=am and 12 or 13,
FontFace=Font.new(ad.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
},true)

ae.AttachPress(aQ,ad,{
Amount=0.97,
})

ad.AddSignal(aQ.MouseButton1Click,function()
ad.SafeCallback(aP)
end)

return aQ
end

local aL

local function ApplyKey(aM,aN)
local aO,aP=NormalizeKey(aM)
ah:SetToggleKey(aP)
aF.Text=aO
if not aN then
Notify(
"Keybind updated",
aP and("Toggle key: "..aO)or"Toggle key cleared.",
"keyboard",
"Success"
)
end
end

local function StopCapture()
as.Capturing=false
if aL then
ad.DisconnectSignal(aL)
aL=nil
end
end

function as.Capture(aM)
if as.Capturing then
return
end

as.Capturing=true
aF.Text="Press key..."

aL=ad.AddSignal(aa.InputBegan,function(aN)
if aN.UserInputType~=Enum.UserInputType.Keyboard then
return
end
if aN.KeyCode==Enum.KeyCode.Unknown then
return
end
if aN.KeyCode==Enum.KeyCode.Escape then
StopCapture()
local aO=NormalizeKey(ah.ToggleKey)
aF.Text=aO
return
end

ApplyKey(aN.KeyCode)
StopCapture()
end)
end

local aM=CreateButton(aK,am and"Bind"or"Set Key","scan-line","Primary",function()
as:Capture()
end)
local aN=CreateButton(aK,"Clear","x","Secondary",function()
StopCapture()
ApplyKey(nil)
end)

local aO=af("Frame",{
Name="QuickKeys",
Size=UDim2.new(1,0,0,am and 34 or 32),
BackgroundTransparency=1,
LayoutOrder=5,
Parent=av,
},{
af("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Center",
}),
})

local function ShortKeyName(aP)
local aQ=tostring(aP)
if not am then
return aQ
end

aQ=aQ:gsub("Right","R")
aQ=aQ:gsub("Left","L")
aQ=aQ:gsub("Control","Ctrl")
return aQ
end

for aP,aQ in next,ar do local
aR, aS=NormalizeKey(aQ)
if aS then
CreateButton(aO,ShortKeyName(aQ),nil,"Secondary",function()
StopCapture()
ApplyKey(aS)
end).Size=
UDim2.new(1/#ar,-4,1,0)
end
end

local aP={}
local aQ={}

local function ClearElementRows()
for aR,aS in next,aQ do
if aS then
aS:Disconnect()
end
end
for aR,aS in next,aP do
if aS and aS.Destroy then
aS:Destroy()
end
end
for aR in next,aQ do
aQ[aR]=nil
end
for aR in next,aP do
aP[aR]=nil
end
end

local function NormalizeElementKey(aR)
local aS,aT=NormalizeKey(aR)
if aT then
return ShortKeyName(aS),aT
end
if typeof(aR)=="string"and aR~=""then
return ShortKeyName(aR),nil
end
return nil,nil
end

local function GetElementKeybind(aR)
if typeof(aR)~="table"then
return nil,nil
end

local aS=aR.Keybind
or aR.KeyBind
or aR.Shortcut
or aR.Bind
or aR.Hotkey
or(aR.__type=="Keybind"and aR.Value)
return NormalizeElementKey(aS)
end

local function GetElementIcon(aR)
if aR.__type=="Toggle"then
return"toggle-right"
elseif aR.__type=="Button"then
return"mouse-pointer-click"
end
return"keyboard"
end

local function ActivateElement(aR,aS)
if typeof(aR)~="table"then
return
end
if aR.Locked then
return
end
if aR.__type=="Toggle"and aR.Toggle then
aR:Toggle()
return
end
if aR.__type=="Button"and aR.Press then
aR:Press()
return
end
if aR.Callback then
ad.SafeCallback(aR.Callback,aS)
end
end

local function CreateElementRow(aR,aS,aT)
local aU=ad.NewRoundFrame(12,"Squircle",{
Name="ElementBind",
Size=UDim2.new(1,0,0,am and 28 or 32),
ImageTransparency=am and 0.9 or 0.92,
LayoutOrder=aT,
Parent=aI,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
af("UIPadding",{
PaddingLeft=UDim.new(0,8),
PaddingRight=UDim.new(0,8),
}),
af("UIListLayout",{
Padding=UDim.new(0,7),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
CreateIcon(GetElementIcon(aR),nil,am and 13 or 14),
af("TextLabel",{
Name="Title",
Size=UDim2.new(1,-84,1,0),
BackgroundTransparency=1,
Text=aR.Title or aR.__type or"Element",
TextSize=am and 11 or 12,
TextXAlignment="Left",
TextTruncate="AtEnd",
FontFace=Font.new(ad.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
af("TextLabel",{
Name="Key",
Size=UDim2.new(0,56,0,am and 20 or 22),
BackgroundTransparency=1,
Text=aS,
TextSize=am and 11 or 12,
TextXAlignment="Right",
TextTransparency=0.14,
FontFace=Font.new(ad.Font,Enum.FontWeight.Bold),
ThemeTag={
TextColor3="Text",
},
}),
},true)

ae.AttachPress(aU,ad,{
Amount=0.98,
})

local aV=aU.MouseButton1Click:Connect(function()
ActivateElement(aR,aS)
end)

table.insert(aQ,aV)
table.insert(aP,aU)
end

local function RenderElementBindings()
ClearElementRows()

local aR=0
for aS,aT in next,ah.AllElements or{}do
local aU=GetElementKeybind(aT)
if aU then
aR+=1
CreateElementRow(aT,aU,aR)
end
end

aJ.Visible=aR==0
aH.Text=aR>0 and("Element keybinds ("..aR..")")or"Element keybinds"
end

if ah.ToggleKey==nil and ak.DefaultKey and ak.ApplyDefault~=false then local
aR, aS=NormalizeKey(ak.DefaultKey)
if aS then
ApplyKey(aS,true)
end
end

local function UpdateRootPosition()
local aR=GetViewportSize()
local aS=12

if am then
an=math.min(ak.Width or 330,math.max(240,aR.X-(aS*2)))
ao=ak.Height or 300
at.Size=UDim2.fromOffset(an,ao)
at.AnchorPoint=Vector2.new(0.5,1)
as.TargetPosition=UDim2.fromOffset(aR.X/2,aR.Y-aS)
at.Position=as.TargetPosition
au.Size=UDim2.fromOffset(aR.X,aR.Y)

if as.UserMoved and as.StoredPosition then
at.Position=as.StoredPosition
as.TargetPosition=as.StoredPosition
end

return
end

local aT=aR.X-aS
local aU=aS+ah.Topbar.Height

if as.Button and as.Button.AbsoluteSize.X>0 then
local aV=as.Button.AbsolutePosition
local aW=as.Button.AbsoluteSize
aT=aV.X+aW.X
aU=aV.Y+aW.Y+10
end

if aT-an<aS then
aT=math.min(aR.X-aS,aS+an)
end
if aU+ao>aR.Y-aS then
aU=math.max(aS,aR.Y-ao-aS)
end

at.Position=UDim2.fromOffset(aT,aU)
as.TargetPosition=at.Position
au.Size=UDim2.fromOffset(aR.X,aR.Y)

if as.UserMoved and as.StoredPosition then
at.Position=as.StoredPosition
end
end

function as.SetButton(aR,aS)
as.Button=aS
end

local aR=ad.Drag(at,{ax,aw},function(aR)
if not aR then
as.UserMoved=true
as.StoredPosition=at.Position
end
end)
as.UIElements.Drag=aR

function as.OpenMenu(aS)
if as.Open then
return
end

as.Open=true
as.Token+=1
RenderElementBindings()
UpdateRootPosition()
local aT=as.TargetPosition or at.Position
at.Visible=true
at.Active=true
au.Visible=true
if am then
at.Position=UDim2.new(
aT.X.Scale,
aT.X.Offset,
aT.Y.Scale,
aT.Y.Offset+18
)
end
at.ImageTransparency=1
av.GroupTransparency=1
at.GlassLayer.ImageTransparency=1
at.Outline.ImageTransparency=1
at.Scale.Scale=0.98
au.BackgroundTransparency=1
ae.Play(at,"DropdownOpen",{
ImageTransparency=ak.BackgroundTransparency or(am and 0.48 or 0.18),
Position=aT,
},nil,nil,"KeyBindMenu")
ae.Play(av,"DropdownOpen",{GroupTransparency=0},nil,nil,"KeyBindContent")
ae.Play(
at.GlassLayer,
"DropdownOpen",
{ImageTransparency=am and 0.92 or 0.78},
nil,
nil,
"KeyBindGlass"
)
ae.Play(
at.Outline,
"DropdownOpen",
{ImageTransparency=am and 0.48 or 0.72},
nil,
nil,
"KeyBindOutline"
)
ae.Play(at.Scale,"DropdownOpen",{Scale=1},nil,nil,"KeyBindScale")
ae.Play(
au,
"DropdownOpen",
{BackgroundTransparency=GetScrimTransparency()},
nil,
nil,
"KeyBindScrim"
)
end

function as.CloseMenu(aS)
if not as.Open then
return
end

as.Open=false
as.Token+=1
local aT=as.Token
StopCapture()
at.Active=false
local aU=at.Position
if am then
aU=UDim2.new(
at.Position.X.Scale,
at.Position.X.Offset,
at.Position.Y.Scale,
at.Position.Y.Offset+18
)
end
ae.Play(at,"DropdownClose",{ImageTransparency=1,Position=aU},nil,nil,"KeyBindMenu")
ae.Play(av,"DropdownClose",{GroupTransparency=1},nil,nil,"KeyBindContent")
ae.Play(at.GlassLayer,"DropdownClose",{ImageTransparency=1},nil,nil,"KeyBindGlass")
ae.Play(at.Outline,"DropdownClose",{ImageTransparency=1},nil,nil,"KeyBindOutline")
ae.Play(at.Scale,"DropdownClose",{Scale=0.98},nil,nil,"KeyBindScale")
ae.Play(au,"DropdownClose",{BackgroundTransparency=1},nil,nil,"KeyBindScrim")
task.delay(ae.GetDuration"DropdownClose",function()
if aT==as.Token then
at.Visible=false
au.Visible=false
end
end)
end

function as.Toggle(aS)
if as.Open then
as:CloseMenu()
else
as:OpenMenu()
end
end

ad.AddSignal(aa.InputBegan,function(aS)
if not as.Open then
return
end
if
aS.UserInputType~=Enum.UserInputType.MouseButton1
and aS.UserInputType~=Enum.UserInputType.Touch
then
return
end
if ContainsPoint(at,aS.Position)or ContainsPoint(as.Button,aS.Position)then
return
end
as:CloseMenu()
end)

as.UIElements.CurrentKey=aF
as.UIElements.SetButton=aM
as.UIElements.ClearButton=aN

return as
end

return ag end function a.I()

local aa={}

local ab=a.load'e'
local ad=ab.New
local ae=ab.Tween


function aa.New(af,ag,ah,ai,aj,ak)
local al={
Container=nil,
TooltipSize=16,

TooltipArrowSizeX=aj=="Small"and 16 or 24,
TooltipArrowSizeY=aj=="Small"and 6 or 9,

PaddingX=aj=="Small"and 12 or 14,
PaddingY=aj=="Small"and 7 or 9,

Radius=999,

TitleFrame=nil,
}

ai=ai or""
ak=ak~=false

local am=ad("TextLabel",{
AutomaticSize="XY",
TextWrapped=ak,
BackgroundTransparency=1,
FontFace=Font.new(ab.Font,Enum.FontWeight.Medium),
Text=af,
TextSize=aj=="Small"and 15 or 17,
TextTransparency=1,
ThemeTag={
TextColor3="Tooltip"..ai.."Text",
}
})

al.TitleFrame=am

local an=ad("UIScale",{
Scale=.9
})

local ao=ad("Frame",{
AnchorPoint=Vector2.new(0.5,0),
AutomaticSize="XY",
BackgroundTransparency=1,
Parent=ag,

Visible=false
},{
ad("UISizeConstraint",{
MaxSize=Vector2.new(400,math.huge)
}),
ad("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
LayoutOrder=99,
Visible=ah,
Name="Arrow",
},{
ad("ImageLabel",{
Size=UDim2.new(0,al.TooltipArrowSizeX,0,al.TooltipArrowSizeY),
BackgroundTransparency=1,

Image="rbxassetid://105854070513330",
ThemeTag={
ImageColor3="Tooltip"..ai,
},
},{










}),
}),
ab.NewRoundFrame(al.Radius,"Squircle",{
AutomaticSize="XY",
ThemeTag={
ImageColor3="Tooltip"..ai,
},
ImageTransparency=1,
Name="Background",
},{



ad("Frame",{



AutomaticSize="XY",
BackgroundTransparency=1,
},{
ad("UICorner",{
CornerRadius=UDim.new(0,16),
}),
ad("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Horizontal",
VerticalAlignment="Center"
}),

am,
ad("UIPadding",{
PaddingTop=UDim.new(0,al.PaddingY),
PaddingLeft=UDim.new(0,al.PaddingX),
PaddingRight=UDim.new(0,al.PaddingX),
PaddingBottom=UDim.new(0,al.PaddingY),
}),
})
}),
an,
ad("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
})
al.Container=ao

function al.Open(ap)
ao.Visible=true


ae(ao.Background,.2,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ae(ao.Arrow.ImageLabel,.2,{ImageTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ae(am,.2,{TextTransparency=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ae(an,.22,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

function al.Close(ap,aq)

ae(ao.Background,.3,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ae(ao.Arrow.ImageLabel,.2,{ImageTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ae(am,.3,{TextTransparency=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ae(an,.35,{Scale=.9},Enum.EasingStyle.Quint,Enum.EasingDirection.In):Play()

aq=aq~=false
if aq then
task.wait(.35)

ao.Visible=false
ao:Destroy()
end
end

return al
end



return aa end function a.J()
local aa=game:GetService"TweenService"

local ab=a.load'e'
local ad=a.load'f'
local ae=ab.New

local af={}

local function GetImageTarget(ag)
if typeof(ag)~="Instance"then
return nil
end

if ag:IsA"ImageLabel"or ag:IsA"ImageButton"then
return ag
end

return ag:FindFirstChildWhichIsA("ImageLabel",true)or ag:FindFirstChildWhichIsA("ImageButton",true)
end

local function AsColor(ag,ah)
if typeof(ag)=="Color3"then
return ag
end

if typeof(ag)=="string"then
local ai,aj=pcall(function()
return Color3.fromHex(ag)
end)
if ai then
return aj
end
end

return ah
end

local function NewGradient(ag,ah,ai,aj)
return ae("UIGradient",{
Rotation=ag or 0,
Offset=ah or Vector2.new(0,0),
Color=ColorSequence.new(ai),
Transparency=NumberSequence.new(aj),
})
end

function af.Apply(ag,ah)
if typeof(ag)~="Instance"then
return nil
end

ah=typeof(ah)=="table"and ah or{}

local ai=ah.Corner or 16
local aj=ah.ZIndex or ag.ZIndex or 1
local ak=ah.Compact==true
local al=ah.Animated~=false

local am=AsColor(ah.EdgeColor,Color3.fromRGB(255,215,92))
local an=AsColor(ah.DeepColor,Color3.fromRGB(84,54,10))
local ao=AsColor(ah.MidColor,Color3.fromRGB(206,147,39))
local ap=AsColor(ah.HotColor,Color3.fromRGB(255,241,166))

pcall(function()
ag.ClipsDescendants=true
end)

local aq=ae("Frame",{
Name=ah.Name or"GoldenEffect",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Active=false,
ZIndex=aj+20,
Parent=ag,
})

local ar=ab.NewRoundFrame(ai,"Squircle",{
Name="GoldenFill",
Size=UDim2.new(1,0,1,0),
ImageColor3=an,
ImageTransparency=ah.FillTransparency or 0.76,
Active=false,
ZIndex=aj+20,
Parent=aq,
},{
NewGradient(24,Vector2.new(-0.1,0),{
ColorSequenceKeypoint.new(0,an),
ColorSequenceKeypoint.new(0.42,ao),
ColorSequenceKeypoint.new(0.72,ap),
ColorSequenceKeypoint.new(1,an),
},{
NumberSequenceKeypoint.new(0,0.18),
NumberSequenceKeypoint.new(0.52,0.04),
NumberSequenceKeypoint.new(1,0.22),
}),
})

local as=ab.NewRoundFrame(ai,"SquircleOutline",{
Name="GoldenOutline",
Size=UDim2.new(1,0,1,0),
ImageColor3=am,
ImageTransparency=ah.OutlineTransparency or 0.22,
Active=false,
ZIndex=aj+22,
Parent=aq,
},{
NewGradient(35,Vector2.new(0,0),{
ColorSequenceKeypoint.new(0,am),
ColorSequenceKeypoint.new(0.5,ap),
ColorSequenceKeypoint.new(1,ao),
},{
NumberSequenceKeypoint.new(0,0.04),
NumberSequenceKeypoint.new(0.48,0),
NumberSequenceKeypoint.new(1,0.12),
}),
})

local at=NewGradient(18,Vector2.new(-1.15,0),{
ColorSequenceKeypoint.new(0,ap),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,ap),
},{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.42,1),
NumberSequenceKeypoint.new(0.5,0.15),
NumberSequenceKeypoint.new(0.58,1),
NumberSequenceKeypoint.new(1,1),
})

local au=ab.NewRoundFrame(ai,"Squircle",{
Name="GoldenSheen",
Size=UDim2.new(1,0,1,0),
ImageColor3=ap,
ImageTransparency=ah.SheenTransparency or 0.74,
Active=false,
ZIndex=aj+23,
Parent=aq,
},{
at,
})

local av=ae("Frame",{
Name="Sparkles",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Active=false,
ClipsDescendants=true,
ZIndex=aj+24,
Parent=aq,
})

local aw={}
local ax=ah.Points or{
{0.16,0.28,0},
{0.76,0.22,0.42},
{0.34,0.72,0.82},
{0.88,0.64,1.12},
}

for ay,az in ipairs(ax)do
local aA=ak and 9 or 12
local aB=ab.Image("sparkles","GoldenSparkle"..ay,0,"Temp","GoldenEffect",false,true)
aB.Name="Sparkle"..ay
aB.Size=UDim2.fromOffset(aA,aA)
aB.AnchorPoint=Vector2.new(0.5,0.5)
aB.Position=UDim2.fromScale(az[1],az[2])
aB.BackgroundTransparency=1
aB.ZIndex=aj+24
aB.Parent=av

local aC=GetImageTarget(aB)
if aC then
aC.ImageColor3=ap
aC.ImageTransparency=0.62
aC.ZIndex=aj+24
end

local aD=ae("UIScale",{
Scale=0.72,
Parent=aB,
})

table.insert(aw,{
Frame=aB,
Image=aC,
Scale=aD,
Delay=az[3]or 0,
})
end

local ay={
Root=aq,
Fill=ar,
Outline=as,
Sheen=au,
Sparkles=aw,
Running=true,
}

function ay.Destroy(az)
az.Running=false
if az.Root then
az.Root:Destroy()
end
end

if ad:IsEnabled()and not ad.Reduced and al then
task.spawn(function()
while ay.Running and aq.Parent do
at.Offset=Vector2.new(-1.15,0)
local az=aa:Create(
at,
TweenInfo.new(ah.SheenDuration or 1.65,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
{Offset=Vector2.new(1.15,0)}
)
az:Play()
az.Completed:Wait()
task.wait(ah.SheenPause or 0.42)
end
end)

for az,aA in ipairs(aw)do
task.spawn(function()
task.wait(aA.Delay)
while ay.Running and aq.Parent and aA.Frame.Parent do
aA.Scale.Scale=0.72
aA.Frame.Rotation=-18
if aA.Image then
aA.Image.ImageTransparency=0.68
end

local aB=aa:Create(
aA.Scale,
TweenInfo.new(0.34,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
{Scale=1.12}
)
local aC=aA.Image and aa:Create(
aA.Image,
TweenInfo.new(0.22,Enum.EasingStyle.Sine,Enum.EasingDirection.Out),
{ImageTransparency=0.12}
)
local aD=aa:Create(
aA.Frame,
TweenInfo.new(0.58,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
{Rotation=22}
)

aB:Play()
aD:Play()
if aC then
aC:Play()
end
aB.Completed:Wait()

local aE=aa:Create(
aA.Scale,
TweenInfo.new(0.24,Enum.EasingStyle.Sine,Enum.EasingDirection.In),
{Scale=0.78}
)
local aF=aA.Image and aa:Create(
aA.Image,
TweenInfo.new(0.28,Enum.EasingStyle.Sine,Enum.EasingDirection.In),
{ImageTransparency=0.72}
)
aE:Play()
if aF then
aF:Play()
end
aE.Completed:Wait()
task.wait(ah.SparklePause or 1.2)
end
end)
end
end

return ay
end

return af end function a.K()

game:GetService"ReplicatedStorage"
local aa=a.load'e'
local ab=a.load'f'
local ad=aa.New
local ae=aa.NewRoundFrame
local af=a.load'J'

local ag=a.load'a'

ag(game:GetService"UserInputService")

local ah=a.load'B'

local function Color3ToHSB(ai)
local aj,ak,al=ai.R,ai.G,ai.B
local am=math.max(aj,ak,al)
local an=math.min(aj,ak,al)
local ao=am-an

local ap=0
if ao~=0 then
if am==aj then
ap=(ak-al)/ao%6
elseif am==ak then
ap=(al-aj)/ao+2
else
ap=(aj-ak)/ao+4
end
ap=ap*60
else
ap=0
end

local aq=(am==0)and 0 or(ao/am)
local ar=am

return{
h=math.floor(ap+0.5),
s=aq,
b=ar,
}
end

local function GetPerceivedBrightness(ai)
local aj=ai.R
local ak=ai.G
local al=ai.B
return 0.299*aj+0.587*ak+0.114*al
end

local function GetTextColorForHSB(ai)
local aj=Color3ToHSB(ai)local
ak, al, am=aj.h, aj.s, aj.b
if GetPerceivedBrightness(ai)>0.5 then
return Color3.fromHSV(ak/360,0,0.05)
else
return Color3.fromHSV(ak/360,0,0.98)
end
end

local function Coalesce(...)
for ai=1,select("#",...)do
local aj=select(ai,...)
if aj~=nil then
return aj
end
end
return nil
end

return function(ai)
local aj={
Title=ai.Title,
Desc=ai.Desc or nil,
Hover=ai.Hover,
Thumbnail=ai.Thumbnail,
ThumbnailSize=ai.ThumbnailSize or 80,
Image=ai.Image,
IconThemed=ai.IconThemed or false,
ImageSize=ai.ImageSize or 30,
Color=ai.Color,
Scalable=ai.Scalable,
Parent=ai.Parent,
Justify=ai.Justify or"Between",
UIPadding=ai.Window.ElementConfig.UIPadding,
UICorner=ai.Window.ElementConfig.UICorner,
Transparency=Coalesce(
ai.Transparency,
ai.ParentConfig and ai.ParentConfig.Transparency,
ai.ParentConfig and ai.ParentConfig.ElementTransparency,
ai.Window.ElementConfig.Transparency
),
GlassTransparency=Coalesce(
ai.GlassTransparency,
ai.ParentConfig and ai.ParentConfig.GlassTransparency,
ai.Window.ElementConfig.GlassTransparency
),
LiquidGlass=Coalesce(
ai.LiquidGlass,
ai.ParentConfig and ai.ParentConfig.LiquidGlass,
ai.ParentConfig and ai.ParentConfig.GlassLiquid,
ai.Window.ElementConfig.LiquidGlass
),
Golden=ai.Golden==true
or ai.Premium==true
or(ai.ParentConfig and(ai.ParentConfig.Golden==true or ai.ParentConfig.Premium==true)),
CornerStyle=Coalesce(
ai.CornerStyle,
ai.ParentConfig and ai.ParentConfig.CornerStyle,
ai.ParentConfig and ai.ParentConfig.ElementCornerStyle,
ai.Window.ElementConfig.CornerStyle
),
Size=ai.Size or"Default",
Tags=ai.Tags or{},
UIElements={},

Index=ai.Index,
LinkCorners=ai.LinkCorners,
CornerGroup=ai.CornerGroup or ai.LinkCornerGroup,
CornerBreak=ai.CornerBreak,
CornerBreakBefore=ai.CornerBreakBefore,
CornerBreakAfter=ai.CornerBreakAfter,
}

local ak=aj.Size=="Small"and-4 or aj.Size=="Large"and 4 or 0
local al=aj.Size=="Small"and-4 or aj.Size=="Large"and 4 or 0

local am=aj.ImageSize
local an=aj.ThumbnailSize
local ao=true

local ap=aj.CornerStyle=="Native"or aj.CornerStyle=="PerCorner"
local aq=aa.ClampTransparency(aj.Transparency,nil)
local ar
local as
local at
local au
local av
local aw={}
local ax={
TopLeft=true,
TopRight=true,
BottomLeft=true,
BottomRight=true,
}

local ay=0

local function NewLayerCorner()
local az=ad("UICorner",{
CornerRadius=UDim.new(0,aj.UICorner),
})
table.insert(aw,az)
return az
end

local az
local aA
if aj.Thumbnail then
az=aa.Image(
aj.Thumbnail,
aj.Title,
ai.Window.NewElements and aj.UICorner-11 or(aj.UICorner-4),
ai.Window.Folder,
"Thumbnail",
false,
aj.IconThemed
)
az.Size=UDim2.new(1,0,0,an)
end
if aj.Image then
aA=aa.Image(
aj.Image,
aj.Title,
ai.Window.NewElements and aj.UICorner-11 or(aj.UICorner-4),
ai.Window.Folder,
"Image",
aj.IconThemed,
not aj.Color and true or false,
"ElementIcon"
)

if typeof(aj.Color)=="string"and not string.find(aj.Image,"rbxthumb")then
aA.ImageLabel.ImageColor3=GetTextColorForHSB(Color3.fromHex(aa.Colors[aj.Color]))
elseif typeof(aj.Color)=="Color3"and not string.find(aj.Image,"rbxthumb")then
aA.ImageLabel.ImageColor3=GetTextColorForHSB(aj.Color)
end

aA.Size=UDim2.new(0,am,0,am)

ay=am
end

local function CreateText(aB,aC)
local aD=typeof(aj.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[aj.Color]))
or typeof(aj.Color)=="Color3"and GetTextColorForHSB(aj.Color)

return ad("TextLabel",{
BackgroundTransparency=1,
Text=aB or"",
TextSize=aC=="Desc"and 15 or 17,
TextXAlignment="Left",
ThemeTag={
TextColor3=not aj.Color and("Element"..aC)or nil,
},
TextColor3=aj.Color and aD or nil,
TextTransparency=aC=="Desc"and 0.3 or 0,
TextWrapped=true,
Size=UDim2.new(aj.Justify=="Between"and 1 or 0,0,0,0),
AutomaticSize=aj.Justify=="Between"and"Y"or"XY",
FontFace=Font.new(aa.Font,aC=="Desc"and Enum.FontWeight.Medium or Enum.FontWeight.SemiBold),
})
end

local aB=CreateText(aj.Title,"Title")
local aC=CreateText(aj.Desc,"Desc")
if not aj.Title or aj.Title==""then
aC.Visible=false
end
if not aj.Desc or aj.Desc==""then
aC.Visible=false
end

aj.UIElements.Title=aB
aj.UIElements.Desc=aC

aj.UIElements.Container=ad("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ad("UIListLayout",{
Padding=UDim.new(0,aj.UIPadding),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment=aj.Justify=="Between"and"Left"or"Center",
}),
az,
ad("Frame",{
Size=UDim2.new(
aj.Justify=="Between"and 1 or 0,
aj.Justify=="Between"and-ai.TextOffset or 0,
0,
0
),
AutomaticSize=aj.Justify=="Between"and"Y"or"XY",
BackgroundTransparency=1,
Name="TitleFrame",
},{
ad("UIListLayout",{
Padding=UDim.new(0,aj.UIPadding),
FillDirection="Horizontal",
VerticalAlignment=ai.Window.NewElements and(aj.Justify=="Between"and"Top"or"Center")
or"Center",
HorizontalAlignment=aj.Justify~="Between"and aj.Justify or"Center",
}),
aA,
ad("Frame",{
BackgroundTransparency=1,
AutomaticSize=aj.Justify=="Between"and"Y"or"XY",
Size=UDim2.new(
aj.Justify=="Between"and 1 or 0,
aj.Justify=="Between"and(aA and-ay-aj.UIPadding or-ay)
or 0,
1,
0
),
Name="TitleFrame",
},{
ad("UIPadding",{
PaddingTop=UDim.new(0,(ai.Window.NewElements and aj.UIPadding/2 or 0)+al),
PaddingLeft=UDim.new(0,(ai.Window.NewElements and aj.UIPadding/2 or 0)+ak),
PaddingRight=UDim.new(
0,
(ai.Window.NewElements and aj.UIPadding/2 or 0)+ak
),
PaddingBottom=UDim.new(
0,
(ai.Window.NewElements and aj.UIPadding/2 or 0)+al
),
}),
ad("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ad("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=-99,
BackgroundTransparency=1,
ScrollingDirection="X",
CanvasSize=UDim2.new(0,0,0,0),
ScrollBarThickness=0,
Visible=false,
},{
ad("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
Padding=UDim.new(0,ai.Window.UIPadding/2),
}),
}),
ad("Frame",{
Name="Space",
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Visible=false,
}),
aB,
aC,
}),
}),
})

for aD,aE in next,ai.Tags or{}do
if not aj.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.Visible then
aj.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.Visible=true
aj.UIElements.Container.TitleFrame.TitleFrame.Space.Visible=true
end
ah:New(aE,aj.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame)
end

aa.AddSignal(
aj.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.UIListLayout:GetPropertyChangedSignal
"AbsoluteContentSize"
,
function()
aj.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.Size=UDim2.new(
1,
0,
0,
aj.UIElements.Container.TitleFrame.TitleFrame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y
/ai.ParentConfig.UIScale
)
end
)





local aD=aa.Image("lock","lock",0,ai.Window.Folder,"Lock",false)
aD.Size=UDim2.new(0,20,0,20)
aD.ImageLabel.ImageColor3=Color3.new(1,1,1)
aD.ImageLabel.ImageTransparency=0.4

local aE=ad("TextLabel",{
Text="Locked",
TextSize=18,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
AutomaticSize="XY",
BackgroundTransparency=1,
TextColor3=Color3.new(1,1,1),
TextTransparency=0.05,
})

local aF=ad("Frame",{
Size=UDim2.new(1,aj.UIPadding*2,1,aj.UIPadding*2),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ZIndex=9999999,
})

local aG,aH=ae(aj.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.25,
ImageColor3=Color3.new(0,0,0),
Visible=false,
Active=false,
Parent=aF,
},{
NewLayerCorner(),
ad("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
aD,
aE,
},nil,true)local

aI=ae(aj.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=aF,
},{
ad("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)

local aJ,aK=ae(aj.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=aF,
},{
NewLayerCorner(),
ad("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)local

aL=ae(aj.UICorner,"Squircle-Outline",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Visible=false,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=aF,
},{
ad("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
ad("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
},nil,true)

local aM,aN=ae(aj.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
Active=false,
ThemeTag={
ImageColor3="Text",
},
Parent=aF,
},{
NewLayerCorner(),
ad("UIGradient",{
Name="HoverGradient",
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
ad("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
Padding=UDim.new(0,8),
}),
},nil,true)

local function GetElementColor()
if typeof(aj.Color)=="string"then
return Color3.fromHex(aa.Colors[aj.Color])
end
if typeof(aj.Color)=="Color3"then
return aj.Color
end
return nil
end

local function GetBackgroundTransparency()
if aq~=nil then
return aq
end
if aj.LiquidGlass then
return aa.ClampTransparency(aj.GlassTransparency,0.24)
end
if aj.Color then
return 0.05
end
if not ai.Window.NewElements then
return 0.93
end
return nil
end

local function ApplyNativeCorners(aO)
ax=aO or ax
if as then
aa.ApplyCornerRadii(as,UDim.new(0,aj.UICorner),ax)
end
for aP,aQ in aw do
aa.ApplyCornerRadii(aQ,UDim.new(0,aj.UICorner),ax)
end
end





local function CreateLiquidGlassChildren()




at=ad("UIGradient",{
Enabled=aj.LiquidGlass==true,
Rotation=25,
Offset=Vector2.new(-0.35,0),
Color=ColorSequence.new(Color3.new(1,1,1)),
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.38,0.975),
NumberSequenceKeypoint.new(0.5,0.93),
NumberSequenceKeypoint.new(0.62,0.975),
NumberSequenceKeypoint.new(1,1),
},
})






au=ad("Frame",{
Name="LiquidSheen",
Size=UDim2.fromScale(1,1),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0,
Visible=aj.LiquidGlass==true,
ZIndex=1,
Active=false,
},{
NewLayerCorner(),
at,
})

av=ad("UIStroke",{
Enabled=aj.LiquidGlass==true,
ApplyStrokeMode="Border",
Thickness=1,
Color=Color3.new(1,1,1),
Transparency=0.88,
})

return{
av,
au,
}
end

local function CreateNativeBackground()
as=ad("UICorner",{
CornerRadius=UDim.new(0,aj.UICorner),
})

local aO={
as,
}

for aP,aQ in next,CreateLiquidGlassChildren()do
table.insert(aO,aQ)
end

return ad("Frame",{
Name="NativeBackground",
Size=UDim2.new(1,aj.UIPadding*2,1,aj.UIPadding*2),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
BackgroundColor3=GetElementColor()or nil,
BackgroundTransparency=GetBackgroundTransparency()or 0,
ThemeTag=not aj.Color and{
BackgroundColor3="ElementBackground",
BackgroundTransparency=aq==nil
and not aj.LiquidGlass
and"ElementBackgroundTransparency"
or nil,
}or nil,
ZIndex=0,
Active=false,
},aO)
end

local aO={}
if ap then
ar=CreateNativeBackground()
table.insert(aO,ar)
end

table.insert(aO,aj.UIElements.Container)
table.insert(aO,aF)
table.insert(
aO,
ad("UIPadding",{
PaddingTop=UDim.new(0,aj.UIPadding),
PaddingLeft=UDim.new(0,aj.UIPadding),
PaddingRight=UDim.new(0,aj.UIPadding),
PaddingBottom=UDim.new(0,aj.UIPadding),
})
)






local aP=not ap and aj.LiquidGlass==true
if not ap then


table.insert(
aO,
aa.NewRoundFrame(aj.UICorner,"SquircleGlass",{
Name="LiquidSheen",
Size=UDim2.fromScale(1,1),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0.86,
Visible=aP,
ZIndex=0,
Active=false,
})
)
end

local aQ,aR=ae(aj.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ImageTransparency=ap and 1 or GetBackgroundTransparency(),



Parent=ai.Parent,
ThemeTag={


ImageColor3=not ap
and not aj.Color
and((aP or ai.Window.NewElements)and"ElementBackground"or"Text")
or nil,
ImageTransparency=not ap
and not aj.Color
and aq==nil
and not aj.LiquidGlass
and(ai.Window.NewElements and"ElementBackgroundTransparency"or nil)
or nil,
},
ImageColor3=not ap and GetElementColor()or nil,
},aO,true,true)

aj.UIElements.Main=aQ
aj.UIElements.Locked=aG
ApplyNativeCorners(ax)

if aj.Golden then
aj.UIElements.GoldenEffect=af.Apply(aF,{
Corner=aj.UICorner,
Compact=aj.Size=="Small",
FillTransparency=0.8,
OutlineTransparency=0.18,
SheenTransparency=0.82,
})

aB.TextColor3=Color3.fromRGB(255,232,144)
aC.TextColor3=Color3.fromRGB(255,224,138)
aC.TextTransparency=math.min(aC.TextTransparency+0.08,0.72)
end

if aj.Hover then
aa.AddSignal(aQ.MouseMoved,function(aS,aT)
if ao and aQ.AbsoluteSize.X>0 then
aM.HoverGradient.Offset=Vector2.new(((aS-aQ.AbsolutePosition.X)/aQ.AbsoluteSize.X)-0.5,0)
aL.HoverGradient.Offset=
Vector2.new(((aS-aQ.AbsolutePosition.X)/aQ.AbsoluteSize.X)-0.5,0)
if at then
at.Offset=
Vector2.new(((aS-aQ.AbsolutePosition.X)/aQ.AbsoluteSize.X)-0.5,0)
end
end
end)

aa.AddSignal(aQ.MouseEnter,function()
if ao then

aL.Visible=true
ab.Play(
aM,
"Hover",
{ImageTransparency=0.9},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
ab.Play(
aL,
"Hover",
{ImageTransparency=0.8},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
if ar and aj.LiquidGlass then
ab.Play(ar,"Hover",{
BackgroundTransparency=math.max(
(aq or aj.GlassTransparency or 0.24)-0.06,
0
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Hover")
end
end
end)
aa.AddSignal(aQ.InputEnded,function()
if ao then

ab.Play(
aM,
"Hover",
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
ab.Play(
aL,
"Hover",
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
if ar and aj.LiquidGlass then
ab.Play(
ar,
"Hover",
{BackgroundTransparency=GetBackgroundTransparency()or 0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
end
end
end)
aa.AddSignal(aQ.MouseLeave,function()
if ao then
ab.Play(
aM,
"Hover",
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
ab.Play(
aL,
"Hover",
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
if ar and aj.LiquidGlass then
ab.Play(
ar,
"Hover",
{BackgroundTransparency=GetBackgroundTransparency()or 0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
end
end
end)
end

if aj.Scalable then
ab.AttachPress(aQ,aa,{
Amount=0.985,
Enabled=function()
return ao
end,
})
end

function aj.SetTitle(aS,aT)
aj.Title=aT
aB.Text=aT
end

function aj.SetDesc(aS,aT)
aj.Desc=aT
aC.Text=aT or""
if not aT then
aC.Visible=false
elseif not aC.Visible then
aC.Visible=true
end
end






local function ReleaseSurfaceTransparencyTheming()
if ar then
aa.RemoveThemeProperty(ar,"BackgroundTransparency")
end
aa.RemoveThemeProperty(aQ,"ImageTransparency")
end

function aj.SetTransparency(aS,aT)
aq=aa.ClampTransparency(aT,aq or 0)
aj.Transparency=aq
ReleaseSurfaceTransparencyTheming()

if ar then
ab.Play(
ar,
"Focus",
{BackgroundTransparency=aq},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"ElementTransparency"
)
else
ab.Play(
aQ,
"Focus",
{ImageTransparency=aq},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"ElementTransparency"
)
end
end

function aj.SetLiquidGlass(aS,aT)
aj.LiquidGlass=aT==true

if av then
av.Enabled=aj.LiquidGlass
end
if at then
at.Enabled=aj.LiquidGlass
end
if au then
au.Visible=aj.LiquidGlass
end



local aU=aQ and aQ:FindFirstChild"LiquidSheen"
if aU then
aU.Visible=aj.LiquidGlass
end

if aq~=nil then
return
end

ReleaseSurfaceTransparencyTheming()

if ar then
ar.BackgroundTransparency=GetBackgroundTransparency()or 0
else

aQ.ImageTransparency=GetBackgroundTransparency()or 0
end
end

function aj.Colorize(aS,aT,aU)
if aj.Color then
aT[aU]=typeof(aj.Color)=="string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[aj.Color]))
or typeof(aj.Color)=="Color3"and GetTextColorForHSB(aj.Color)
or nil
end
end

if ai.ElementTable then
aa.AddSignal(aB:GetPropertyChangedSignal"Text",function()
if aj.Title~=aB.Text then
aj:SetTitle(aB.Text)
ai.ElementTable.Title=aB.Text
end
end)
aa.AddSignal(aC:GetPropertyChangedSignal"Text",function()
if aj.Desc~=aC.Text then
aj:SetDesc(aC.Text)
ai.ElementTable.Desc=aC.Text
end
end)
end





function aj.SetThumbnail(aS,aT,aU)
aj.Thumbnail=aT
if aU then
aj.ThumbnailSize=aU
an=aU
end

if az then
if aT then
az:Destroy()
az=aa.Image(
aT,
aj.Title,
aj.UICorner-3,
ai.Window.Folder,
"Thumbnail",
false,
aj.IconThemed
)
if az then
az.Size=UDim2.new(1,0,0,an)
az.Parent=aj.UIElements.Container
local aV=aj.UIElements.Container:FindFirstChild"UIListLayout"
if aV then
az.LayoutOrder=-1
end
end
else
az.Visible=false
end
else
if aT then
az=aa.Image(
aT,
aj.Title,
aj.UICorner-3,
ai.Window.Folder,
"Thumbnail",
false,
aj.IconThemed
)
if az then
az.Size=UDim2.new(1,0,0,an)
az.Parent=aj.UIElements.Container
local aV=aj.UIElements.Container:FindFirstChild"UIListLayout"
if aV then
az.LayoutOrder=-1
end
end
end
end
end

function aj.SetImage(aS,aT,aU)
aj.Image=aT
if aU then
aj.ImageSize=aU
am=aU
end

if aT then
local aV=aA and aA.Parent or aj.UIElements.Container.TitleFrame
if aA then
aA:Destroy()
end

aA=aa.Image(
aT,
aT,
aj.UICorner-3,
ai.Window.Folder,
"Image",
not aj.Color and true or false
)
if aA then
if typeof(aj.Color)=="string"and not string.find(aj.Image,"rbxthumb")then
aA.ImageLabel.ImageColor3=
GetTextColorForHSB(Color3.fromHex(aa.Colors[aj.Color]))
elseif typeof(aj.Color)=="Color3"and not string.find(aj.Image,"rbxthumb")then
aA.ImageLabel.ImageColor3=GetTextColorForHSB(aj.Color)
end

aA.Visible=true
aA.Parent=aV
aA.LayoutOrder=-99

aA.Size=UDim2.new(0,am,0,am)
ay=aj.ImageSize+aj.UIPadding
end
else
if aA then
aA.Visible=true
end
ay=0
end

aj.UIElements.Container.TitleFrame.TitleFrame.Size=UDim2.new(1,-ay,1,0)
end

function aj.Destroy(aS)
aQ:Destroy()
end

function aj.Lock(aS,aT)
ao=false
aG.Active=true
aG.Visible=true
aE.Text=aT or"Locked"
end

function aj.Unlock(aS)
ao=true
aG.Active=false
aG.Visible=false
end

function aj.Highlight(aS)
local aT=ad("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.1,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.9,0.9),
NumberSequenceKeypoint.new(1,1),
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=aI,
})

local aU=ad("UIGradient",{
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.15,0.8),
NumberSequenceKeypoint.new(0.5,0.1),
NumberSequenceKeypoint.new(0.85,0.8),
NumberSequenceKeypoint.new(1,1),
},
Rotation=0,
Offset=Vector2.new(-1,0),
Parent=aJ,
})

aI.ImageTransparency=0.65
aJ.ImageTransparency=0.88

ab.Play(aT,"Highlight",{
Offset=Vector2.new(1,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Highlight")

ab.Play(aU,"Highlight",{
Offset=Vector2.new(1,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Highlight")

task.spawn(function()
task.wait(ab.GetDuration"Highlight")
aI.ImageTransparency=1
aJ.ImageTransparency=1
aT:Destroy()
aU:Destroy()
end)
end

function aj.UpdateShape(aS)
if ai.Window.NewElements then
local aT=ai.ParentConfig
and ai.ParentConfig.ParentTable
and ai.ParentConfig.ParentTable.__type
or ai.ParentType
local aU=aj.LinkCorners~=false
and(
aj.LinkCorners==true
or ai.Window.ElementConfig.LinkCorners
or(ai.ParentConfig and ai.ParentConfig.LinkCorners==true)
)

local aV="Squircle"
local aW={Position="Single",Count=1}
local aX={
TopLeft=true,
TopRight=true,
BottomLeft=true,
BottomRight=true,
}

if aU then
aV,aX,aW=aa.GetLinkedCornerShape(
aS.Elements,
aj.Index,
aS,
aT,
ai.CornerLink
or(ai.ParentConfig and ai.ParentConfig.CornerLink)
or ai.Window.ElementConfig.CornerLink
)
end

if aV and aQ then
local aY=ap and aW.Count>1
local aZ=if aY
then"Square"
else(aV=="Squircle-TL-BL"or aV=="Squircle-TR-BR")and"Squircle"or aV

aR:SetType(aZ)
aH:SetType(aZ)
aK:SetType(aZ)

aN:SetType(aZ)

ApplyNativeCorners(aX)
end
end
end





return aj
end end function a.L()

local aa=a.load'e'
local ab=aa.New

local ad={}

local ae=a.load'o'.New

function ad.New(af,ag)
ag.Hover=false
ag.TextOffset=0
ag.ParentConfig=ag
ag.IsButtons=ag.Buttons and#ag.Buttons>0 and true or false

local ah={
__type="Paragraph",
Title=ag.Title or"Paragraph",
Desc=ag.Desc or nil,

Locked=ag.Locked or false,
}
local ai=a.load'K'(ag)

ah.ParagraphFrame=ai
if ag.Buttons and#ag.Buttons>0 then
local aj=ab("Frame",{
Size=UDim2.new(1,0,0,38),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=ai.UIElements.Container,
},{
ab("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
}),
})

for ak,al in next,ag.Buttons do
local am=ae(
al.Title,
al.Icon,
al.Callback,
al.Variant or"White",
aj,
nil,
nil,
ag.Window.NewElements and 999 or 10
)
am.Size=UDim2.new(1,0,0,38)

end
end

return ah.__type,ah
end

return ad end function a.M()

local aa=a.load'e'local ab=
aa.New
local ad=game:GetService"UserInputService"

local ae={}

local function NormalizeKey(af)
if typeof(af)=="EnumItem"then
return af.Name,af
end
if typeof(af)=="string"and Enum.KeyCode[af]then
return af,Enum.KeyCode[af]
end
return nil,nil
end

local function GetImageTarget(af)
if typeof(af)~="Instance"then
return nil
end

if af:IsA"ImageLabel"or af:IsA"ImageButton"then
return af
end

return af:FindFirstChildWhichIsA("ImageLabel",true)or af:FindFirstChildWhichIsA("ImageButton",true)
end

function ae.New(af,ag)
local ah,ai=
NormalizeKey(ag.Keybind or ag.KeyBind or ag.Shortcut or ag.Bind or ag.Hotkey)
local aj={
__type="Button",
Title=ag.Title or"Button",
Desc=ag.Desc or nil,
Icon=ag.Icon or"mouse-pointer-click",
IconThemed=ag.IconThemed or false,
IconColor=ag.IconColor or nil,
Color=ag.Color,
Justify=ag.Justify or"Between",
IconAlign=ag.IconAlign or"Right",
Locked=ag.Locked or false,
LockedTitle=ag.LockedTitle,
Golden=ag.Golden==true or ag.Premium==true,
Premium=ag.Premium==true or ag.Golden==true,
Keybind=ah,
KeyCode=ai,
Callback=ag.Callback or function()end,
UIElements={},
}

local ak=true

aj.ButtonFrame=a.load'K'{
Title=aj.Title,
Desc=aj.Desc,
Parent=ag.Parent,




Window=ag.Window,
Color=aj.Color,
Justify=aj.Justify,
TextOffset=20,
Hover=true,
Scalable=true,
Tab=ag.Tab,
Index=ag.Index,
ElementTable=aj,
ParentConfig=ag,
Size=ag.Size,
Tags=ag.Tags,
Golden=aj.Golden,
Premium=aj.Premium,
}














aj.UIElements.ButtonIcon=aa.Image(
aj.Icon,
aj.Icon,
0,
ag.Window.Folder,
"Button",
not(aj.Color or aj.IconColor)and true or nil,
aj.IconThemed
)

aj.UIElements.ButtonIcon.Size=UDim2.new(0,20,0,20)
aj.UIElements.ButtonIcon.Parent=aj.Justify=="Between"and aj.ButtonFrame.UIElements.Main
or aj.ButtonFrame.UIElements.Container.TitleFrame
aj.UIElements.ButtonIcon.LayoutOrder=aj.IconAlign=="Left"and-99999 or 99999
aj.UIElements.ButtonIcon.AnchorPoint=Vector2.new(1,0.5)
aj.UIElements.ButtonIcon.Position=UDim2.new(1,0,0.5,0)

local al=GetImageTarget(aj.UIElements.ButtonIcon)
if al then
if aj.IconColor then
al.ImageColor3=aj.IconColor
elseif aj.Golden then
al.ImageColor3=Color3.fromRGB(255,222,105)
end
aj.ButtonFrame:Colorize(al,"ImageColor3")
end

function aj.Lock(am)
aj.Locked=true
ak=false
return aj.ButtonFrame:Lock(aj.LockedTitle)
end
function aj.Unlock(am)
aj.Locked=false
ak=true
return aj.ButtonFrame:Unlock()
end

if aj.Locked then
aj:Lock()
end

function aj.Press(am)
if ak then
task.spawn(function()
aa.SafeCallback(aj.Callback)
end)
end
end

aa.AddSignal(aj.ButtonFrame.UIElements.Main.MouseButton1Click,function()
aj:Press()
end)

if aj.KeyCode then
aa.AddSignal(ad.InputBegan,function(am,an)
if an or ad:GetFocusedTextBox()then
return
end
if am.UserInputType==Enum.UserInputType.Keyboard and am.KeyCode==aj.KeyCode then
aj:Press()
end
end)
end

return aj.__type,aj
end

return ae end function a.N()

local aa={}

local ab=a.load'e'
local ad=a.load'f'
local ae=ab.New

local af=game:GetService"UserInputService"

local function Coalesce(...)
for ag=1,select("#",...)do
local ah=select(ag,...)
if ah~=nil then
return ah
end
end
return nil
end

function aa.New(ag,ah,ai,aj,ak,al,am)
am=if typeof(am)=="table"then am else{}

local an=if typeof(am.Window)=="table"then am.Window else nil




local ao=Coalesce(
am.GlassSpritesheet,
am.Spritesheet,
an and an.ToggleGlass,
true
)==true



local ap=Coalesce(
am.Drag,
am.Draggable,
am.Swipe,
an and an.ToggleDrag,
al
)==true

local aq=am.HoldAnimation~=false and am.Hold~=false
local ar={
UseGlassSpritesheet=ao,
UseDrag=ap,
UseHoldAnimation=aq,
GlassSpritesheet={
Id="rbxassetid://77297718671545",
MirroredId="rbxassetid://92258969882244",
Size=Vector2.new(102,128),
Total=80,
Cols=10,
},
}

function ar.GetGlassFrame(as,at:number):(string,Vector2,Vector2)
local au=ar.GlassSpritesheet
local av:number

if at<=0.4 then
av=math.floor((at/0.4)*(au.Total-1))
elseif at<0.6 then
av=au.Total-1
else
av=math.floor(((at-0.6)/0.4)*(au.Total-1))
end

av=math.clamp(av,0,au.Total-1)

local aw=at>=0.6
if aw then
av=(au.Total-1)-av
end

local ax=if aw then au.MirroredId else au.Id
return ax,
au.Size,
Vector2.new(
(av%au.Cols)*au.Size.X,
math.floor(av/au.Cols)*au.Size.Y
)
end

local as=12
local at
local au=if ah and ah~=""then ab.Icon(ah)else nil
if au then
local av=math.clamp(tonumber(ai)or 13,10,al and 16 or 13)
at=ae("ImageLabel",{
Size=UDim2.fromOffset(av,av),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Image=au[1],
ImageRectOffset=au[2].ImageRectPosition,
ImageRectSize=au[2].ImageRectSize,
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
})
end

local av=ae("Frame",{
Size=UDim2.new(0,2,0,26),
BackgroundTransparency=1,
Parent=aj,
})

local aw=ab.NewRoundFrame(as,"Squircle",{
ImageTransparency=0.85,
ThemeTag={
ImageColor3="Text",
},
Parent=av,
Size=UDim2.new(0,al and 52 or 41,0,24),
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(0,0,0.5,0),
Name="ToggleFrame",
},{
ab.NewRoundFrame(as,"Squircle",{
Size=UDim2.fromScale(1,1),
Name="Layer",
ThemeTag={
ImageColor3="Toggle",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(as,"SquircleOutline",{
Size=UDim2.fromScale(1,1),
Name="Stroke",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=1,
},{
ae("UIGradient",{
Rotation=90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
},
}),
}),
ab.NewRoundFrame(as,"Squircle",{
Size=UDim2.new(0,al and 30 or 20,0,20),
Position=UDim2.new(0,2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
ImageTransparency=1,
Name="Frame",
},{
ab.NewRoundFrame(as,"Squircle",{
Size=UDim2.fromScale(1,1),
ImageTransparency=0,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Name="Bar",
},{
ab.New("Frame",{
Size=UDim2.fromScale(1,1),
BackgroundColor3=Color3.new(1,1,1),
Name="Highlight",
BackgroundTransparency=1,
},{
ab.NewRoundFrame(9999,"SquircleGlass",{
Size=UDim2.new(1,1,1,1),
ImageColor3=Color3.new(1,1,1),
Name="SquircleGlass",
ImageTransparency=0.5,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
}),
ab.NewRoundFrame(as,"Squircle",{
Size=UDim2.fromScale(1,1),
Name="GlassBackground",
ImageTransparency=0,
ThemeTag={
ImageColor3="ElementBackground",
},
ZIndex=-1,
}),
ae("ImageLabel",{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
Name="Glass",
ImageTransparency=if ao then 0.85 else 1,
Visible=ao,
},{
ae("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
ab.NewRoundFrame(as,"Squircle",{
Size=UDim2.fromScale(1,1),
Name="BarOverlay",
ThemeTag={
ImageColor3="ToggleBar",
},
ZIndex=999,
}),
}),
at,
ae("UIScale",{
Scale=1,
}),
}),
}),
ae("TextButton",{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
Name="Hitbox",
Text="",
}),
})

local ax
local ay
local az
local aA=if al then 30 else 20
local aB=aw.Size.X.Offset
local aC

local function SetGlassFrame(aD)
if not ao then
return
end

local aE,aF,aG=ar:GetGlassFrame(aD)
local aH=aw.Frame.Bar.Highlight.Glass
aH.Image=aE
aH.ImageRectSize=aF
aH.ImageRectOffset=aG
end

local function Render(aD,aE)
local aF=if aD
then UDim2.new(0,aB-aA-2,0.5,0)
else UDim2.new(0,2,0.5,0)
local aG=if aD then 0 else 1
local aH=if aD then 0 else 0.85
local aI=if aD then 0 else 1

if ao then
ab.SetThemeTag(
aw.Frame.Bar.Highlight.Glass,
{ImageColor3=if aD then"Toggle"else"Text"},
0.1
)
SetGlassFrame(if aD then 1 else 0)
end

if aE then



ad.Cancel(aw.Frame,"Position")
ad.Cancel(aw.Layer,"Layer")
ad.Cancel(aw.Frame.Bar.Highlight.Glass,"Glass")

aw.Frame.Position=aF
aw.Layer.ImageTransparency=aG
aw.Frame.Bar.Highlight.Glass.ImageTransparency=aH
if at then
ad.Cancel(at,"Icon")
at.ImageTransparency=aI
end
return
end

ad.Play(
aw.Frame,
"Select",
{Position=aF},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Position"
)
ad.Play(aw.Layer,"Select",{ImageTransparency=aG},nil,nil,"Layer")
if ao then
ad.Play(
aw.Frame.Bar.Highlight.Glass,
"Select",
{ImageTransparency=aH},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Glass"
)
end
if at then
ad.Play(at,"Select",{ImageTransparency=aI},nil,nil,"Icon")
end
end

function ar.Set(aD,aE,aF,aG)
aE=aE==true
if aC~=aE then
aC=aE
Render(aE,aG==true)
end

if ak and aF~=false then
task.defer(function()
ab.SafeCallback(ak,aE)
end)
end
end

function ar.BeginHold(aD)
if not aq then
return
end

ad.Play(
aw.Frame.Bar.UIScale,
"Focus",
{Scale=1.22},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Press"
)
ad.Play(
aw.Frame.Bar.Highlight.BarOverlay,
"Focus",
{ImageTransparency=0.84},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Press"
)
end

function ar.EndHold(aD)
if not aq then
return
end

ad.Play(
aw.Frame.Bar.UIScale,
"Focus",
{Scale=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Press"
)
ad.Play(
aw.Frame.Bar.Highlight.BarOverlay,
"Focus",
{ImageTransparency=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Press"
)
end

local function DisconnectDrag()
if ax then
ab.DisconnectSignal(ax)
ax=nil
end
if ay then
ab.DisconnectSignal(ay)
ay=nil
end
end

local function ReleaseOwnedInput()
if am.WindUI and az and am.WindUI.CurrentInput==az then
am.WindUI.CurrentInput=nil
end
az=nil
end

function ar.Animate(aD,aE,aF)
if not ap or not am.Window or am.Window.IsToggleDragging then
return
end

am.Window.IsToggleDragging=true
az=am.WindUI and am.WindUI.CurrentInput or nil
local aG=aE.Position.X
local aH=aE.Position.Y
local aI=aw.Frame.Position.X.Offset
local aJ=false
local aK=false

ar:BeginHold()

DisconnectDrag()
ax=ab.AddSignal(af.InputChanged,function(aL)
if not am.Window.IsToggleDragging then
return
end
if
aL.UserInputType~=Enum.UserInputType.MouseMovement
and aL.UserInputType~=Enum.UserInputType.Touch
then
return
end
if aE.UserInputType==Enum.UserInputType.Touch and aL~=aE then
return
end

local aM=math.abs(aL.Position.X-aG)
local aN=math.abs(aL.Position.Y-aH)
if not aK and aN>10 and aN>aM then
aJ=true
return
end
if aJ then
return
end
if aM>6 then
aK=true
end

local aO=aL.Position.X-aG
local aP=math.clamp(aI+aO,2,aB-aA-2)
local aQ=math.clamp((aP-2)/(aB-aA-4),0,1)

SetGlassFrame(aQ)
aw.Frame.Position=UDim2.new(0,aP,0.5,0)
end)

ay=ab.AddSignal(af.InputEnded,function(aL)
if not am.Window.IsToggleDragging then
return
end
local aM=aE.UserInputType==Enum.UserInputType.Touch and aL==aE
local aN=aE.UserInputType==Enum.UserInputType.MouseButton1
and aL.UserInputType==Enum.UserInputType.MouseButton1
if not aM and not aN then
return
end

am.Window.IsToggleDragging=false
DisconnectDrag()
ReleaseOwnedInput()
aC=nil

if aJ then
aF:Set(aF.Value,false,false)
elseif not aK then
aF:Set(not aF.Value,true,false)
else
local aO=aw.Frame.Position.X.Offset
local aP=aO+(aA/2)>aB/2
aF:Set(aP,true,false)
end

ar:EndHold()
end)
end

function ar.Destroy(aD)
local aE=az~=nil or ax~=nil or ay~=nil
DisconnectDrag()
ar:EndHold()
if aE and am.Window then
am.Window.IsToggleDragging=false
end
ReleaseOwnedInput()
end

ar:Set(ag,false,true)
return av,ar
end

return aa end function a.O()

local aa={}

local ab=a.load'e'
local ad=a.load'f'local ae=
ab.New

function aa.New(af,ag,ah,ai,aj,ak)
local al={}

ag=ag or"sfsymbols:checkmark"

local am=9

local an=ab.Image(
ag,
ag,
0,
(ak and ak.Window.Folder or"Temp"),
"Checkbox",
true,
false,
"CheckboxIcon"
)
an.Size=UDim2.new(1,-26+ah,1,-26+ah)
an.AnchorPoint=Vector2.new(0.5,0.5)
an.Position=UDim2.new(0.5,0,0.5,0)

local ao=ab.NewRoundFrame(am,"Squircle",{
ImageTransparency=0.85,
ThemeTag={
ImageColor3="Text",
},
Parent=ai,
Size=UDim2.new(0,26,0,26),
},{
ab.NewRoundFrame(am,"Squircle",{
Size=UDim2.new(1,0,1,0),
Name="Layer",
ThemeTag={
ImageColor3="Checkbox",
},
ImageTransparency=1,
}),
ab.NewRoundFrame(am,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
Name="Stroke",
ThemeTag={
ImageColor3="CheckboxBorder",
ImageTransparency="CheckboxBorderTransparency",
},
},{







}),

an,
},true)




function al.Set(ap,aq,ar,as)
aq=aq==true

local at=if aq then 0 else 1
local au=if aq then 0 else 1

if as==true then
ao.Layer.ImageTransparency=at
an.ImageLabel.ImageTransparency=au
else
ad.Play(ao.Layer,"Fast",{
ImageTransparency=at,
},nil,nil,"State")
ad.Play(an.ImageLabel,"Fast",{
ImageTransparency=au,
},nil,nil,"State")
end

if aj and ar~=false then
task.defer(function()
ab.SafeCallback(aj,aq)
end)
end
end

return ao,al
end

return aa end function a.P()

local aa=a.load'e'local ab=
aa.New local ad=
aa.Tween
local ae=game:GetService"UserInputService"

local af=a.load'N'.New
local ag=a.load'O'.New

local ah={}

local function NormalizeKey(ai)
if typeof(ai)=="EnumItem"then
return ai.Name,ai
end
if typeof(ai)=="string"and Enum.KeyCode[ai]then
return ai,Enum.KeyCode[ai]
end
return nil,nil
end

function ah.New(ai,aj)
local ak,al=
NormalizeKey(aj.Keybind or aj.KeyBind or aj.Shortcut or aj.Bind or aj.Hotkey)
local am={
__type="Toggle",
Title=aj.Title or"Toggle",
Desc=aj.Desc or nil,
Locked=aj.Locked or false,
LockedTitle=aj.LockedTitle,
Value=aj.Value,
Icon=aj.Icon or nil,
IconSize=aj.IconSize or 23,
Type=aj.Type or"Toggle",
Keybind=ak,
KeyCode=al,
Callback=aj.Callback or function()end,
UIElements={},
}
am.ToggleFrame=a.load'K'{
Title=am.Title,
Desc=am.Desc,




Window=aj.Window,
Parent=aj.Parent,
TextOffset=(52),
Hover=false,
Tab=aj.Tab,
Index=aj.Index,
ElementTable=am,
ParentConfig=aj,
Tags=aj.Tags,
}

local an=true

if am.Value==nil then
am.Value=false
end

function am.Lock(ao)
am.Locked=true
an=false
return am.ToggleFrame:Lock(am.LockedTitle)
end
function am.Unlock(ao)
am.Locked=false
an=true
return am.ToggleFrame:Unlock()
end

if am.Locked then
am:Lock()
end

local ao=am.Value

local ap,aq
if am.Type=="Toggle"then
ap,aq=af(
ao,
am.Icon,
am.IconSize,
am.ToggleFrame.UIElements.Main,
am.Callback,
aj.Window.NewElements,
aj
)
elseif am.Type=="Checkbox"then
ap,aq=ag(
ao,
am.Icon,
am.IconSize,
am.ToggleFrame.UIElements.Main,
am.Callback,
aj
)
else
error("Unknown Toggle Type: "..tostring(am.Type))
end

ap.AnchorPoint=Vector2.new(1,aj.Window.NewElements and 0 or 0.5)
ap.Position=UDim2.new(1,0,aj.Window.NewElements and 0 or 0.5,0)

function am.Set(ar,as,at,au)
if an then
aq:Set(as,at,au or false)
ao=as
am.Value=as
end
end

function am.Toggle(ar,as,at)
am:Set(not am.Value,as,at==true)
end

am:Set(ao,false,true)

local ar=if aq.UseDrag then aj.WindUI.GenerateGUID()else nil

if aj.Window.NewElements and aq.Animate and aq.UseDrag then
if am.Type=="Toggle"then
aa.AddSignal(ap.ToggleFrame.Hitbox.InputBegan,function(as)
if
not am.Locked
and not aj.Window.IsToggleDragging
and(
as.UserInputType==Enum.UserInputType.MouseButton1
or as.UserInputType==Enum.UserInputType.Touch
)
then
if aj.WindUI.CurrentInput and aj.WindUI.CurrentInput~=ar then
return
end

aj.WindUI.CurrentInput=ar
aq:Animate(as,am)
end
end)
end





else
if am.Type=="Toggle"then
aa.AddSignal(ap.ToggleFrame.Hitbox.InputBegan,function(as)
if
not am.Locked
and(
as.UserInputType==Enum.UserInputType.MouseButton1
or as.UserInputType==Enum.UserInputType.Touch
)
then
aq:BeginHold()
end
end)
aa.AddSignal(ap.ToggleFrame.Hitbox.InputEnded,function(as)
if
as.UserInputType==Enum.UserInputType.MouseButton1
or as.UserInputType==Enum.UserInputType.Touch
then
aq:EndHold()
end
end)
aa.AddSignal(ap.ToggleFrame.Hitbox.MouseLeave,function()
aq:EndHold()
end)
aa.AddSignal(ap.ToggleFrame.Hitbox.MouseButton1Click,function()
if not am.Locked then
am:Toggle(nil,false)
end
end)
elseif am.Type=="Checkbox"then
aa.AddSignal(ap.MouseButton1Click,function()
am:Toggle(nil,false)
end)
end
end

function am.Cleanup(as)
if aq.Destroy then
aq:Destroy()
end
end

if am.KeyCode then
aa.AddSignal(ae.InputBegan,function(as,at)
if at or ae:GetFocusedTextBox()then
return
end
if as.UserInputType==Enum.UserInputType.Keyboard and as.KeyCode==am.KeyCode then
am:Toggle(nil,false)
end
end)
end

return am.__type,am
end

return ah end function a.Q()

local aa=a.load'a'
local ad=aa(game:GetService"UserInputService")
local ae=aa(game:GetService"RunService")

local af=a.load'e'
local ag=a.load'f'
local ah=af.New

local ai={}

function ai.New(aj,ak)
local al={
__type="Slider",
Title=ak.Title or nil,
Desc=ak.Desc or nil,
Locked=ak.Locked or nil,
LockedTitle=ak.LockedTitle,
Value=ak.Value or{
Min=ak.Min or 0,
Max=ak.Max or 100,
Default=ak.Default or ak.Min or 0,
},
Icons=ak.Icons or nil,
IsTooltip=ak.IsTooltip or false,
IsTextbox=ak.IsTextbox,
Step=ak.Step or 1,
Callback=ak.Callback or function()end,
UIElements={},
IsFocusing=false,

Width=ak.Width or 130,
TextBoxWidth=ak.Window.NewElements and 40 or 30,
ThumbSize=13,
IconSize=26,
}
if typeof(al.Icons)=="table"and next(al.Icons)==nil then
al.Icons={
From="sfsymbols:sunMinFill",
To="sfsymbols:sunMaxFill",
}
end
if al.IsTextbox==nil and al.Title==nil then
al.IsTextbox=false
else
al.IsTextbox=al.IsTextbox~=false
end

local am
local an
local ao
local ap=false

al.Value.Min=tonumber(al.Value.Min)or 0
al.Value.Max=tonumber(al.Value.Max)or 100



if al.Value.Max<al.Value.Min then
al.Value.Min,al.Value.Max=al.Value.Max,al.Value.Min
end


al.Step=math.abs(tonumber(al.Step)or 1)
if al.Step<=0 then
al.Step=1
end

al.Value.Default=tonumber(al.Value.Default)or al.Value.Min

local aq=al.Step%1~=0
local ar=0
if aq then

local as=tostring(al.Step)
local at=as:find"%."
if at then
ar=#as:sub(at+1)
end
end

local function Round(as)
return math.floor(as+0.5)
end

local function FormatValue(as)
local at=tonumber(as)or al.Value.Min
if aq then
local au=10^ar
return tonumber(string.format("%."..ar.."f",Round(at*au)/au))
end
return Round(at)
end




local function CalculateValue(as)
local at=tonumber(as)or al.Value.Min
local au=Round(at/al.Step)*al.Step
return math.clamp(FormatValue(au),al.Value.Min,al.Value.Max)
end



local function DeltaFor(as)
local at=al.Value.Max-al.Value.Min
if at==0 then
return 0
end
return math.clamp(((tonumber(as)or al.Value.Min)-al.Value.Min)/at,0,1)
end

local as=CalculateValue(al.Value.Default)
al.Value.Default=as

local at=as
local au=DeltaFor(as)

local av=true

local aw,ax
local ay=32
if al.Icons then
if al.Icons.From then
aw=af.Image(
al.Icons.From,
al.Icons.From,
0,
ak.Window.Folder,
"SliderIconFrom",
true,
true,
"SliderIconFrom"
)
aw.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
ay=ay+al.IconSize-2
end
if al.Icons.To then
ax=af.Image(
al.Icons.To,
al.Icons.To,
0,
ak.Window.Folder,
"SliderIconTo",
true,
true,
"SliderIconTo"
)
ax.Size=UDim2.new(0,al.IconSize,0,al.IconSize)
ay=ay+al.IconSize-2
end
end
al.SliderFrame=a.load'K'{
Title=al.Title,
Desc=al.Desc,
Parent=ak.Parent,
TextOffset=al.Width,
Hover=false,
Tab=ak.Tab,
Index=ak.Index,
Window=ak.Window,
ElementTable=al,
ParentConfig=ak,
Tags=ak.Tags,
}

al.UIElements.SliderIcon=af.NewRoundFrame(99,"Squircle",{
ImageTransparency=0.95,
Size=UDim2.new(1,not al.IsTextbox and-ay or(-al.TextBoxWidth-8),0,4),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Frame",
ThemeTag={
ImageColor3="Text",
},
},{
af.NewRoundFrame(99,"Squircle",{
Name="Frame",
Size=UDim2.new(au,0,1,0),
ImageTransparency=0.1,
ThemeTag={
ImageColor3="Slider",
},
},{
af.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(
0,
ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize+2),
0,
ak.Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2)
),
Position=UDim2.new(1,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="SliderThumb",
},
Name="Thumb",
},{
af.NewRoundFrame(999,"SquircleGlass",{
Size=UDim2.new(1,0,1,0),
ImageColor3=Color3.new(1,1,1),
Name="Highlight",
ImageTransparency=0.5,
}),
}),
}),
})

al.UIElements.SliderContainer=ah("Frame",{
Size=UDim2.new(al.Title==nil and 1 or 0,al.Title==nil and 0 or al.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,al.IsTextbox and(ak.Window.NewElements and-16 or 0)or 0,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Parent=al.SliderFrame.UIElements.Main,
},{
ah("UIListLayout",{
Padding=UDim.new(0,al.Title~=nil and 8 or 12),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=al.Icons
and(al.Icons.From and(al.Icons.To and"Center"or"Left")or al.Icons.To and"Right")
or"Center",
}),
aw,
al.UIElements.SliderIcon,
ax,
ah("TextBox",{
Size=UDim2.new(0,al.TextBoxWidth,0,0),
TextXAlignment="Left",
Text=FormatValue(as),
ThemeTag={
TextColor3="Text",
},
TextTransparency=0.4,
AutomaticSize="Y",
TextSize=15,
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
LayoutOrder=-1,
Visible=al.IsTextbox,
}),
})

local az
if al.IsTooltip then
az=a.load'I'.New(
as,
al.UIElements.SliderIcon.Frame.Thumb,
true,
"Secondary",
"Small",
false
)
az.Container.AnchorPoint=Vector2.new(0.5,1)
az.Container.Position=UDim2.new(0.5,0,0,-8)
end

local function SetFillSize(aA,aB)
local aC=UDim2.new(aA,0,1,0)
if aB==0 or not ag.ShouldAnimate(ak)then


ag.Cancel(al.UIElements.SliderIcon.Frame,"Fill")
al.UIElements.SliderIcon.Frame.Size=aC
else
ag.Play(al.UIElements.SliderIcon.Frame,aB or"Fast",{Size=aC},nil,nil,"Fill")
end
end




local function SetThumbGlass(aA)
local aB=al.UIElements.SliderIcon and al.UIElements.SliderIcon.Frame.Thumb
local aC=aB and aB:FindFirstChild"Highlight"
if not aC then
return
end

ag.Play(
aC,
"Focus",
{ImageTransparency=if aA then 0.18 else 0.5},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Glass"
)
end

function al.Lock(aA)
al.Locked=true
av=false
return al.SliderFrame:Lock(al.LockedTitle)
end
function al.Unlock(aA)
al.Locked=false
av=true
return al.SliderFrame:Unlock()
end

if al.Locked then
al:Lock()
end

local aA=ak.Tab.UIElements.ContainerFrame
local aB=ak.WindUI.GenerateGUID()

local function DisconnectSliderInput()
local aC=ap
or an~=nil
or ao~=nil
or ak.WindUI.CurrentInput==aB

if an then
af.DisconnectSignal(an)
an=nil
end
if ao then
af.DisconnectSignal(ao)
ao=nil
end

ap=false
if aC then
aA.ScrollingEnabled=true
end
if ak.WindUI.CurrentInput==aB then
ak.WindUI.CurrentInput=nil
end
end

local function FinishSliderInput()
local aC=ap
DisconnectSliderInput()
if not aC then
return
end

SetThumbGlass(false)

if ak.Window.NewElements then
ag.Play(al.UIElements.SliderIcon.Frame.Thumb,"Focus",{
ImageTransparency=0,
Size=UDim2.new(
0,
ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize+2),
0,
ak.Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Thumb")
end
if az then
az:Close(false)
end
end

local function TrackIsMeasurable()
local aC=al.UIElements.SliderIcon
return aC~=nil and aC.AbsoluteSize.X>0
end


local function DeltaForInput(aC)
local aD=al.UIElements.SliderIcon
if not aD then
return 0
end

local aE=aD.AbsoluteSize.X
if aE<=0 then
return 0
end

local aF=if am
then(aC.Position and aC.Position.X or 0)
else ad:GetMouseLocation().X

return math.clamp((aF-aD.AbsolutePosition.X)/aE,0,1)
end




local function Commit(aC,aD)
local aE=CalculateValue(aC)
if aE==at then
return aE
end

at=aE
al.Value.Default=aE

SetFillSize(DeltaFor(aE),aD)
if al.UIElements.SliderContainer then
al.UIElements.SliderContainer.TextBox.Text=tostring(aE)
end
if az then
az.TitleFrame.Text=tostring(aE)
end

af.SafeCallback(al.Callback,aE)
return aE
end

function al.Set(aC,aD,aE)
if not av or al.IsFocusing or ap then
return
end

if aD==nil then
aD=al.Value.Default
end

if
aE
and not(
aE.UserInputType==Enum.UserInputType.MouseButton1
or aE.UserInputType==Enum.UserInputType.Touch
)
then
aE=nil
end

if not aE then
as=Commit(aD,"Fast")
return as
end



if not TrackIsMeasurable()then
return as
end





if ak.WindUI.CurrentInput and ak.WindUI.CurrentInput~=aB then
return as
end
ak.WindUI.CurrentInput=aB

am=aE.UserInputType==Enum.UserInputType.Touch
aA.ScrollingEnabled=false
ap=true
SetThumbGlass(true)

local aF=al.Value.Max-al.Value.Min
local function TrackValue(aG)
return al.Value.Min+aG*aF
end

as=Commit(TrackValue(DeltaForInput(aE)),0)

an=af.AddSignal(ae.RenderStepped,function()
if not TrackIsMeasurable()then
return
end
as=Commit(TrackValue(DeltaForInput(aE)),0)
end)

ao=af.AddSignal(ad.InputEnded,function(aG)
local aH=aE.UserInputType==Enum.UserInputType.Touch and aG==aE
local aI=aE.UserInputType==Enum.UserInputType.MouseButton1
and aG.UserInputType==Enum.UserInputType.MouseButton1
if aH or aI then
FinishSliderInput()
end
end)

return as
end




local function SetBound(aC,aD,aE)
local aF=tonumber(aD)or aE
al.Value[aC]=aF

if al.Value.Max<al.Value.Min then
al.Value.Min,al.Value.Max=al.Value.Max,al.Value.Min
end

local aG=tonumber(al.Value.Default)or at or al.Value.Min
local aH=CalculateValue(aG)

if aH~=at then

Commit(aH,"Fast")
else

SetFillSize(DeltaFor(aH),"Fast")
if al.UIElements.SliderContainer then
al.UIElements.SliderContainer.TextBox.Text=tostring(aH)
end
end
end

function al.SetMax(aC,aD)
SetBound("Max",aD,100)
end

function al.SetMin(aC,aD)
SetBound("Min",aD,0)
end

af.AddSignal(al.UIElements.SliderContainer.TextBox.FocusLost,function()
local aC=tonumber(al.UIElements.SliderContainer.TextBox.Text)
if aC then

al:Set(aC)
end


al.UIElements.SliderContainer.TextBox.Text=tostring(at)
if az then
az.TitleFrame.Text=tostring(at)
end
end)

af.AddSignal(al.UIElements.SliderContainer.InputBegan,function(aC)
if al.Locked or ap then
return
end
if
aC.UserInputType~=Enum.UserInputType.MouseButton1
and aC.UserInputType~=Enum.UserInputType.Touch
then
return
end

al:Set(as,aC)



if not ap then
return
end

if ak.Window.NewElements then
ag.Play(al.UIElements.SliderIcon.Frame.Thumb,"Focus",{
ImageTransparency=0.85,
Size=UDim2.new(
0,
(ak.Window.NewElements and(al.ThumbSize*2)or al.ThumbSize)+8,
0,
al.ThumbSize+8
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Thumb")
end
if az then
az:Open()
end
end)

function al.Cleanup(aC)
DisconnectSliderInput()
SetThumbGlass(false)
if az then
az:Close(false)
end
end

return al.__type,al
end

return ai end function a.R()

local aa=a.load'e'
local ad=aa.New
local ae=aa.Tween

local af={}

local function ToFiniteNumber(ag)
local ah=tonumber(ag)
if ah==nil or ah~=ah or math.abs(ah)==math.huge then
return nil
end

return ah
end

local function FormatNumber(ag)
if ag%1==0 then
return tostring(ag)
end

return tostring(tonumber(string.format("%.2f",ag)))
end

function af.New(ag,ah)
local ai=typeof(ah.Value)=="table"and ah.Value or{}
local aj=ToFiniteNumber(ai.Min)or ToFiniteNumber(ah.Min)or 0
local ak=ToFiniteNumber(ai.Max)or ToFiniteNumber(ah.Max)or 100

if aj>ak then
aj,ak=ak,aj
end

local al=typeof(ah.Value)=="number"and ah.Value
or ToFiniteNumber(ai.Default)
or ToFiniteNumber(ah.Default)
or aj
al=ToFiniteNumber(al)or aj

local am=ah.Indeterminate==true

local an=ah.ShowValue
if an==nil then
an=not am
end

local ao=math.max(ToFiniteNumber(ah.ValueWidth)or 44,0)

local ap={
__type="ProgressBar",
Title=ah.Title or"Progress",
Desc=ah.Desc or nil,
Value={
Min=aj,
Max=ak,
Default=math.clamp(al,aj,ak),
},
ShowValue=an,
DisplayMode=ah.DisplayMode or"Percent",
Format=ah.Format,
Animate=ah.Animate~=false,
AnimationDuration=math.max(ToFiniteNumber(ah.AnimationDuration)or 0.15,0),
Indeterminate=am,
IndeterminateText=ah.IndeterminateText or"",
Speed=math.max(ToFiniteNumber(ah.Speed)or 1,0.01),
ControlGap=math.max(ToFiniteNumber(ah.ControlGap)or 16,0),
UIElements={},

Width=math.max(ToFiniteNumber(ah.Width)or 160,0),
ValueWidth=ao,
}

local function GetRatio(aq)
if ap.Value.Max==ap.Value.Min then
return aq>=ap.Value.Max and 1 or 0
end

return math.clamp((aq-ap.Value.Min)/(ap.Value.Max-ap.Value.Min),0,1)
end

local function GetValueText(aq,ar)
if ap.Indeterminate then
return tostring(ap.IndeterminateText)
end

local as=ar*100

if typeof(ap.Format)=="function"then
local at,au=
pcall(ap.Format,aq,as,ap.Value.Min,ap.Value.Max)

if at and au~=nil then
return tostring(au)
end
end

if ap.DisplayMode=="Value"then
return FormatNumber(aq)
elseif ap.DisplayMode=="Fraction"then
return FormatNumber(aq).."/"..FormatNumber(ap.Value.Max)
end

return tostring(math.floor(as+0.5)).."%"
end

ap.ProgressBarFrame=a.load'K'{
Title=ap.Title,
Desc=ap.Desc,
Parent=ah.Parent,
TextOffset=ap.Width+ap.ControlGap,
Hover=false,
Tab=ah.Tab,
Index=ah.Index,
Window=ah.Window,
ElementTable=ap,
ParentConfig=ah,
Tags=ah.Tags,
}

ap.UIElements.Fill=aa.NewRoundFrame(99,"Squircle",{
Name="Fill",
Size=ap.Indeterminate and UDim2.new(0.3,0,1,0)
or UDim2.new(GetRatio(ap.Value.Default),0,1,0),
Position=ap.Indeterminate and UDim2.new(-0.3,0,0,0)or UDim2.new(0,0,0,0),
ThemeTag={
ImageColor3="ProgressBar",
},
})

ap.UIElements.Bar=aa.NewRoundFrame(99,"Squircle",{
Name="Bar",
Size=UDim2.new(1,ap.ShowValue and-(ap.ValueWidth+8)or 0,0,6),
ClipsDescendants=true,
ImageTransparency=0.9,
ThemeTag={
ImageColor3="ProgressBarTrack",
ImageTransparency="ProgressBarTrackTransparency",
},
},{
ap.UIElements.Fill,
})

ap.UIElements.Value=ad("TextLabel",{
Name="Value",
Size=UDim2.new(0,ap.ValueWidth,0,20),
BackgroundTransparency=1,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
Text=GetValueText(ap.Value.Default,GetRatio(ap.Value.Default)),
TextSize=14,
TextTransparency=0.25,
TextTruncate="AtEnd",
TextXAlignment="Right",
Visible=ap.ShowValue,
ThemeTag={
TextColor3="ProgressBarText",
},
})

ap.UIElements.Container=ad("Frame",{
Name="ProgressBarContainer",
Size=UDim2.new(0,ap.Width,0,36),
Position=UDim2.new(1,0,ah.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,ah.Window.NewElements and 0 or 0.5),
BackgroundTransparency=1,
Parent=ap.ProgressBarFrame.UIElements.Main,
},{
ad("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
HorizontalAlignment="Right",
VerticalAlignment="Center",
}),
ap.UIElements.Bar,
ap.UIElements.Value,
})

if ap.Indeterminate then
local aq=ae(
ap.UIElements.Fill,
1/ap.Speed,
{Position=UDim2.new(1,0,0,0)},
Enum.EasingStyle.Linear,
Enum.EasingDirection.InOut,-1

)
aa.AddSignal(ap.UIElements.Bar.Destroying,function()
aq:Cancel()
end)
aq:Play()
end

local function Update(aq,ar)
local as=ToFiniteNumber(aq)
if as==nil then
return ap.Value.Default
end

as=math.clamp(as,ap.Value.Min,ap.Value.Max)
ap.Value.Default=as

local at=GetRatio(as)
local au=UDim2.new(at,0,1,0)

if ap.UIElements.Fill and not ap.Indeterminate then
if ar or not ap.Animate or ap.AnimationDuration<=0 then
ap.UIElements.Fill.Size=au
else
ae(
ap.UIElements.Fill,
ap.AnimationDuration,
{Size=au},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end

ap.UIElements.Value.Text=GetValueText(as,at)

return as
end

function ap.Set(aq,ar)
return Update(ar,false)
end

function ap.Get(aq)
return ap.Value.Default
end

function ap.GetPercentage(aq)
return GetRatio(ap.Value.Default)*100
end

function ap.SetRange(aq,ar,as)
ar=ToFiniteNumber(ar)
as=ToFiniteNumber(as)

if ar==nil or as==nil then
return ap.Value.Min,ap.Value.Max
end

if ar>as then
ar,as=as,ar
end

ap.Value.Min=ar
ap.Value.Max=as
Update(ap.Value.Default,false)

return ar,as
end

function ap.SetMin(aq,ar)
ar=ToFiniteNumber(ar)
if ar==nil then
return ap.Value.Min
end

ap:SetRange(ar,math.max(ar,ap.Value.Max))
return ap.Value.Min
end

function ap.SetMax(aq,ar)
ar=ToFiniteNumber(ar)
if ar==nil then
return ap.Value.Max
end

ap:SetRange(math.min(ap.Value.Min,ar),ar)
return ap.Value.Max
end

Update(ap.Value.Default,true)

return ap.__type,ap
end

return af end function a.S()

local aa=a.load'a'

local ad=aa(game:GetService"UserInputService")

local ae=a.load'e'
local af=ae.New local ag=
ae.Tween

local ah={
UICorner=6,
UIPadding=8,
}

local ai=a.load'z'.New

local aj={
MouseButton1="MouseLeft",
MouseLeft="MouseLeft",
MouseLeftButton="MouseLeft",
MouseButton2="MouseRight",
MouseRight="MouseRight",
MouseRightButton="MouseRight",
}

local function NormalizeKeyCode(ak)
local al
if typeof(ak)=="EnumItem"then
al=ak.Name
elseif type(ak)=="string"then
al=ak
else
return"F"
end

return aj[al]or al
end

local function GetInputKey(ak)
if ak.UserInputType==Enum.UserInputType.Keyboard and ak.KeyCode~=Enum.KeyCode.Unknown then
return ak.KeyCode.Name
elseif ak.UserInputType==Enum.UserInputType.MouseButton1 then
return"MouseLeft"
elseif ak.UserInputType==Enum.UserInputType.MouseButton2 then
return"MouseRight"
end

return nil
end

local function IsMatchingRelease(ak,al)
if al=="MouseLeft"then
return ak.UserInputType==Enum.UserInputType.MouseButton1
elseif al=="MouseRight"then
return ak.UserInputType==Enum.UserInputType.MouseButton2
end

return ak.UserInputType==Enum.UserInputType.Keyboard and ak.KeyCode.Name==al
end

function ah.New(ak,al)
local am={
__type="Keybind",
Title=al.Title or"Keybind",
Desc=al.Desc or nil,
Locked=al.Locked or false,
LockedTitle=al.LockedTitle,
Value=NormalizeKeyCode(al.Value)or"F",
Callback=al.Callback or function()end,
CanChange=al.CanChange~=false,
Blacklist=typeof(al.Blacklist)=="table"and al.Blacklist or{},
Picking=false,
UIElements={},
}

local an={}

for ao,ap in next,am.Blacklist do
an[NormalizeKeyCode(ap)]=true
end

local ao=true

am.KeybindFrame=a.load'K'{
Title=am.Title,
Desc=am.Desc,
Parent=al.Parent,
TextOffset=85,
Hover=am.CanChange,
Tab=al.Tab,
Index=al.Index,
Window=al.Window,
ElementTable=am,
ParentConfig=al,
Tags=al.Tags,
}

am.UIElements.Keybind=ai(
am.Value,
nil,
am.KeybindFrame.UIElements.Main,
nil,
al.Window.NewElements and 12 or 10
)

am.UIElements.Keybind.Size=
UDim2.new(0,24+am.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,0,42)
am.UIElements.Keybind.AnchorPoint=Vector2.new(1,0.5)
am.UIElements.Keybind.Position=UDim2.new(1,0,0.5,0)
am.UIElements.Keybind.Interactable=false

af("UIScale",{
Parent=am.UIElements.Keybind,
Scale=0.85,
})

ae.AddSignal(
am.UIElements.Keybind.Frame.Frame.TextLabel:GetPropertyChangedSignal"TextBounds",
function()
am.UIElements.Keybind.Size=
UDim2.new(0,24+am.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,0,42)
end
)

local ap
local aq

local function DisconnectCaptureConnection(ar)
if ar then
ae.DisconnectSignal(ar)
end
end

local function StopPicking(ar)
DisconnectCaptureConnection(ap)
DisconnectCaptureConnection(aq)
ap=nil
aq=nil
am.Picking=false

if ar then
am.UIElements.Keybind.Frame.Frame.TextLabel.Text=am.Value
end
end

function am.Lock(ar)
StopPicking(true)
am.Locked=true
ao=false
return am.KeybindFrame:Lock(am.LockedTitle)
end
function am.Unlock(ar)
am.Locked=false
ao=true
return am.KeybindFrame:Unlock()
end

function am.Set(ar,as)
local at=NormalizeKeyCode(as)
StopPicking(false)
am.Value=at
am.UIElements.Keybind.Frame.Frame.TextLabel.Text=at
end

if am.Locked then
am:Lock()
end

ae.AddSignal(am.KeybindFrame.UIElements.Main.MouseButton1Click,function()
if not ao or not am.CanChange then
return
end

StopPicking(false)
am.Picking=true
am.UIElements.Keybind.Frame.Frame.TextLabel.Text="..."

ap=ae.AddSignal(ad.InputBegan,function(ar)
local as=GetInputKey(ar)
if not as then
return
end
if as=="Escape"then
StopPicking(true)
return
end
if an[as]then
return
end

DisconnectCaptureConnection(ap)
ap=nil

aq=ae.AddSignal(ad.InputEnded,function(at)
if not IsMatchingRelease(at,as)then
return
end

am.Value=as
am.UIElements.Keybind.Frame.Frame.TextLabel.Text=as
StopPicking(false)
end)
end)
end)

ae.AddSignal(ad.InputBegan,function(ar,as)
if ad:GetFocusedTextBox()then
return
end
if not ao then
return
end
if am.Picking then
return
end

if ar.UserInputType==Enum.UserInputType.Keyboard then
if ar.KeyCode.Name==am.Value then
ae.SafeCallback(am.Callback,ar.KeyCode.Name)
end
elseif ar.UserInputType==Enum.UserInputType.MouseButton1 and am.Value=="MouseLeft"then
ae.SafeCallback(am.Callback,"MouseLeft")
elseif ar.UserInputType==Enum.UserInputType.MouseButton2 and am.Value=="MouseRight"then
ae.SafeCallback(am.Callback,"MouseRight")
end
end)

return am.__type,am
end

return ah end function a.T()

local aa=a.load'e'local ad=
aa.New local ae=
aa.Tween

local af={
UICorner=8,
UIPadding=8,
}local ag=a.load'o'

.New
local ah=a.load'p'.New

function af.New(ai,aj)
local ak={
__type="Input",
Title=aj.Title or"Input",
Desc=aj.Desc or nil,
Type=aj.Type or"Input",
Locked=aj.Locked or false,
LockedTitle=aj.LockedTitle,
InputIcon=aj.InputIcon or false,
Placeholder=aj.Placeholder or"Enter Text...",
Value=aj.Value or"",
Callback=aj.Callback or function()end,
ClearTextOnFocus=aj.ClearTextOnFocus or false,
UIElements={},

Width=150,
}

local al=true

ak.InputFrame=a.load'K'{
Title=ak.Title,
Desc=ak.Desc,
Parent=aj.Parent,
TextOffset=ak.Width,
Hover=false,
Tab=aj.Tab,
Index=aj.Index,
Window=aj.Window,
ElementTable=ak,
ParentConfig=aj,
Tags=aj.Tags,
}

local am=ah(
ak.Placeholder,
ak.InputIcon,
ak.Type=="Textarea"and ak.InputFrame.UIElements.Container or ak.InputFrame.UIElements.Main,
ak.Type,
function(am)
ak:Set(am,true)
end,
nil,
aj.Window.NewElements and 12 or 10,
ak.ClearTextOnFocus
)

if ak.Type~="Textarea"then
am.Size=UDim2.new(0,ak.Width,0,36)
am.Position=UDim2.new(1,0,aj.Window.NewElements and 0 or 0.5,0)
am.AnchorPoint=Vector2.new(1,aj.Window.NewElements and 0 or 0.5)
else
am.Size=UDim2.new(1,0,0,148)
end






function ak.Lock(an)
ak.Locked=true
al=false
return ak.InputFrame:Lock(ak.LockedTitle)
end
function ak.Unlock(an)
ak.Locked=false
al=true
return ak.InputFrame:Unlock()
end

function ak.Set(an,ao,ap)
if al then
ak.Value=ao
aa.SafeCallback(ak.Callback,ao)

if not ap then
am.Frame.Frame.TextBox.Text=ao
end
end
end

function ak.SetPlaceholder(an,ao)
am.Frame.Frame.TextBox.PlaceholderText=ao
ak.Placeholder=ao
end

ak:Set(ak.Value)

if ak.Locked then
ak:Lock()
end

return ak.__type,ak
end

return af end function a.U()

local aa=a.load'e'
local af=aa.New

local ag={}

function ag.New(ah,ai)
local aj=af("Frame",{
Size=ai.ParentType~="Group"and UDim2.new(1,0,0,1)or UDim2.new(0,1,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=.9,
ThemeTag={
BackgroundColor3="Text"
}
})
local ak=af("Frame",{
Parent=ai.Parent,
Size=ai.ParentType~="Group"and UDim2.new(1,-7,0,7)or UDim2.new(0,7,1,-7),
BackgroundTransparency=1,
},{
aj
})

return"Divider",{__type="Divider",ElementFrame=ak}
end

return ag end function a.V()
local aa={}

local af=a.load'a'

local ag=af(game:GetService"UserInputService")
local ah=af(game:GetService"Players").LocalPlayer:GetMouse()
local ai=af(game:GetService"Workspace")
local aj=ai.CurrentCamera local ak=

workspace.CurrentCamera

local al=a.load'e'
local am=a.load'f'
local an=al.New
local ao=al.Tween

local ap=0.76

function aa.New(aq,ar,as,at)
local au={}
local av=string.lower(tostring(ar.CenterTarget or"Window"))
local aw=aq.Window and aq.Window.UIElements and aq.Window.UIElements.Main
local ax=if typeof(aw)=="Instance"
then aw:FindFirstChild"Main"or aw
else nil
local ay=ar.Centered
and av~="screen"
and av~="viewport"
and typeof(ax)=="Instance"
local az=if ay then ax else aq.WindUI.DropdownGui
local aA={}

ar.InternalCenter=ay
ar.PopupParent=az

if not ar.Callback then
at="Menu"
end

ar.UIElements.UIListLayout=an("UIListLayout",{
Padding=UDim.new(0,as.MenuPadding/1.5),
FillDirection="Vertical",
HorizontalAlignment="Center",
})

ar.UIElements.Menu=al.NewRoundFrame(
as.MenuCorner,
ar.Glass and"SquircleGlass"or"Squircle",
{
ThemeTag={
ImageColor3="DropdownBackground",
},
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
ZIndex=242,
},
{
an("UIPadding",{
PaddingTop=UDim.new(0,as.MenuPadding),
PaddingLeft=UDim.new(0,as.MenuPadding),
PaddingRight=UDim.new(0,as.MenuPadding),
PaddingBottom=UDim.new(0,as.MenuPadding),
}),
an("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,as.MenuPadding),
}),
an("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,ar.SearchBarEnabled and-as.MenuPadding-as.SearchBarHeight),

ClipsDescendants=true,
LayoutOrder=999,
Name="Frame",
},{
an("UICorner",{
CornerRadius=UDim.new(0,as.MenuCorner-as.MenuPadding),
}),
an("ScrollingFrame",{
Size=UDim2.new(1,0,1,0),
ScrollBarThickness=0,
ScrollingDirection="Y",
AutomaticCanvasSize="Y",
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
ScrollBarImageTransparency=1,
},{
ar.UIElements.UIListLayout,
}),
}),
}
)
ar.UIElements.MenuScale=an("UIScale",{
Name="MenuScale",
Scale=1,
Parent=ar.UIElements.Menu,
})

if ar.Centered and ar.Backdrop then
ar.UIElements.Backdrop=an("TextButton",{
Name="DropdownBackdrop",
Size=UDim2.fromScale(1,1),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=1,
Text="",
AutoButtonColor=false,
Visible=false,
Active=true,
ZIndex=240,
Parent=az,
})
end

ar.UIElements.MenuCanvas=an("Frame",{
Size=UDim2.new(0,ar.MenuWidth,0,300),
BackgroundTransparency=1,
Position=UDim2.new(-10,0,-10,0),
Visible=false,
Active=false,
ZIndex=241,

Parent=az,
AnchorPoint=Vector2.new(1,0),
},{
ar.UIElements.Menu,
an("UISizeConstraint",{
MinSize=Vector2.new(ar.Compact and 148 or 170,0),
MaxSize=Vector2.new(ar.MenuMaxWidth or 420,ar.MenuMaxHeight or 340),
}),
})

local function GetLayoutScale()
local aB=aq.UIScale or al.UIScale or 1
return aB>0 and aB or 1
end

local function GetVisibleContentHeight()
local aB=0
local aC=0
local aD=GetLayoutScale()
local aE=ar.UIElements.Menu.Frame.ScrollingFrame

for aF,aG in next,aE:GetChildren()do
if aG:IsA"GuiObject"and aG.Visible then
local aH=aG.AbsoluteSize.Y/aD
if aH<=0 then
aH=aG.Size.Y.Offset>0 and aG.Size.Y.Offset or ar.ItemHeight
end

aB+=aH
aC+=1
end
end

if aC>1 then
aB+=ar.UIElements.UIListLayout.Padding.Offset*(aC-1)
end

return aB
end

local function RecalculateCanvasSize()
ar.UIElements.Menu.Frame.ScrollingFrame.CanvasSize=UDim2.fromOffset(0,GetVisibleContentHeight())
end

local function GetDropdownButton()
return ar.UIElements.Dropdown or ar.DropdownFrame.UIElements.Main
end

local function GetViewportSize()
if ay and typeof(az)=="Instance"and az:IsA"GuiObject"then
return az.AbsoluteSize/GetLayoutScale()
end
if aq.WindUI.DropdownGui and aq.WindUI.DropdownGui.AbsoluteSize.X>0 then
return aq.WindUI.DropdownGui.AbsoluteSize
end
local aB=ai.CurrentCamera or aj
return aB and aB.ViewportSize or Vector2.new(1280,720)
end

local function GetInputPosition(aB)
if aB and typeof(aB.Position)=="Vector3"then
return Vector2.new(aB.Position.X,aB.Position.Y)
end
return Vector2.new(ah.X,ah.Y)
end

local function ContainsPoint(aB,aC)
if typeof(aB)~="Instance"or not aB.Visible then
return false
end

local aD=aB.AbsolutePosition
local aE=aB.AbsoluteSize

return aC.X>=aD.X
and aC.X<=aD.X+aE.X
and aC.Y>=aD.Y
and aC.Y<=aD.Y+aE.Y
end

local function NormalizeDirection(aB,aC)
local aD=tostring(aB or aC or"Auto")
aD=aD:sub(1,1):upper()..aD:sub(2):lower()
if
aD~="Auto"
and aD~="Down"
and aD~="Up"
and aD~="Left"
and aD~="Right"
then
return aC or"Auto"
end
return aD
end

local function NormalizeSide(aB,aC)
local aD=tostring(aB or aC or"Right")
aD=aD:sub(1,1):upper()..aD:sub(2):lower()
if aD~="Left"and aD~="Center"and aD~="Right"then
return aC or"Right"
end
return aD
end

local function IsMobileViewport()
local aB=GetViewportSize()
return aq.Window.IsPC==false
or(ag.TouchEnabled and not ag.KeyboardEnabled)
or aB.X<=640
end

local function GetCanvasWidth()
local aB=GetDropdownButton()
local aC=GetViewportSize()
local aD=math.max(as.MenuPadding*2,8)
local aE=math.max(
120,
math.min(ar.MenuMaxWidth or(IsMobileViewport()and 320 or 420),aC.X-(aD*2))
)
local aF=math.min(ar.Compact and 148 or 170,aE)
local aG=if aB.AbsoluteSize.X>0
then aB.AbsoluteSize.X/(ay and GetLayoutScale()or 1)
else ar.MenuWidth
local aH=ar.FullWidth and math.max(aG,ar.MenuWidth)or ar.MenuWidth

return math.floor(math.clamp(aH,aF,aE)+0.5)
end

local function ApplyCanvasWidth()
local aB=GetCanvasWidth()
ar.UIElements.MenuCanvas.Size=UDim2.new(
0,
aB,
ar.UIElements.MenuCanvas.Size.Y.Scale,
ar.UIElements.MenuCanvas.Size.Y.Offset
)
return aB
end

local function RecalculateListSize()
local aB=ApplyCanvasWidth()

local aC=GetViewportSize()
local aD=ar.SearchBarEnabled and(as.SearchBarHeight+44)or 44
local aE=math.max(
aD,
math.min(
ar.MenuMaxHeight or(IsMobileViewport()and 280 or 340),
aC.Y-(as.MenuPadding*4)
)
)

local aF=GetVisibleContentHeight()
local aG=ar.SearchBarEnabled and(as.SearchBarHeight+(as.MenuPadding*3))
or(as.MenuPadding*2)
local aH=aF+aG

if aH>aE then
ar.UIElements.MenuCanvas.Size=UDim2.fromOffset(aB,aE)
else
ar.UIElements.MenuCanvas.Size=UDim2.fromOffset(aB,aH)
end
end

function UpdatePosition()
local aB=GetDropdownButton()
local aC=ar.UIElements.MenuCanvas
local aD=GetViewportSize()
local aE=as.MenuPadding*2
local aF=IsMobileViewport()
local aG=NormalizeDirection(
aF and(ar.MobileDirection or ar.Direction)or ar.Direction,
"Auto"
)
local aH=
NormalizeSide(aF and(ar.MobileSide or"Center")or ar.Side,aF and"Center"or"Right")
local aI=aB.AbsolutePosition
local aJ=aB.AbsoluteSize
local aK=aC.AbsoluteSize/(ay and GetLayoutScale()or 1)

if aK.X<=0 or aK.Y<=0 then
aK=Vector2.new(aC.Size.X.Offset,aC.Size.Y.Offset)
end

if ar.Centered then
if ay then
local aL=ar.CenterOffset or Vector2.new(0,0)
local aM=aK.X/2
local aN=aK.Y/2
local aO=math.clamp((aD.X/2)+aL.X,aE+aM,aD.X-aE-aM)
local aP=
math.clamp((aD.Y/2)+aL.Y,aE+aN,aD.Y-aE-aN)

aC.AnchorPoint=Vector2.new(0.5,0.5)
aC.Position=UDim2.fromOffset(math.floor(aO+0.5),math.floor(aP+0.5))
ar.UIElements.Menu.AnchorPoint=Vector2.new(0.5,0.5)
ar.UIElements.Menu.Position=UDim2.fromScale(0.5,0.5)
return"Center"
end

local aL=Vector2.new(0,0)
local aM=aD
local aN=string.lower(tostring(ar.CenterTarget or"Window"))
local aO=aq.Window and aq.Window.UIElements and aq.Window.UIElements.Main

if
aN~="screen"
and aN~="viewport"
and typeof(aO)=="Instance"
and aO.Visible
and aO.AbsoluteSize.X>0
then
aL=aO.AbsolutePosition
aM=aO.AbsoluteSize
end

local aP=ar.CenterOffset or Vector2.new(0,0)
local aQ=aL.X+(aM.X/2)+aP.X
local aR=aL.Y+(aM.Y/2)+aP.Y
local aS=aK.X/2
local aT=aK.Y/2
aQ=math.clamp(aQ,aE+aS,aD.X-aE-aS)
aR=math.clamp(aR,aE+aT,aD.Y-aE-aT)

aC.AnchorPoint=Vector2.new(0.5,0.5)
aC.Position=UDim2.fromOffset(math.floor(aQ+0.5),math.floor(aR+0.5))
ar.UIElements.Menu.AnchorPoint=Vector2.new(0.5,0.5)
ar.UIElements.Menu.Position=UDim2.fromScale(0.5,0.5)
return"Center"
end

if aF and not ar.MobileDirection and(aG=="Left"or aG=="Right")then
aG="Auto"
end

if aG=="Left"and aI.X-aE<aK.X then
aG="Auto"
elseif aG=="Right"and aD.X-(aI.X+aJ.X)-aE<aK.X then
aG="Auto"
end

if aG=="Auto"then
local aL=aD.Y-(aI.Y+aJ.Y)-aE
local aM=aI.Y-aE
if aL>=aK.Y or aL>=aM then
aG="Down"
else
aG="Up"
end
end

if aG~="Up"and aG~="Left"and aG~="Right"then
aG="Down"
end

local aL
local aM
local aN=Vector2.new(1,0)

if aG=="Left"then
aL=aI.X-aE
aM=aI.Y
aN=Vector2.new(1,0)
elseif aG=="Right"then
aL=aI.X+aJ.X+aE
aM=aI.Y
aN=Vector2.new(0,0)
elseif aG=="Up"then
aM=aI.Y-aE
aN=Vector2.new(aH=="Left"and 0 or aH=="Center"and 0.5 or 1,1)
if aH=="Left"then
aL=aI.X
elseif aH=="Center"then
aL=aI.X+(aJ.X/2)
else
aL=aI.X+aJ.X
end
else
aM=aI.Y+aJ.Y+aE
aN=Vector2.new(aH=="Left"and 0 or aH=="Center"and 0.5 or 1,0)
if aH=="Left"then
aL=aI.X
elseif aH=="Center"then
aL=aI.X+(aJ.X/2)
else
aL=aI.X+aJ.X
end
end

local aO=aL-(aN.X*aK.X)
local aP=aM-(aN.Y*aK.Y)

if aO<aE then
aL+=aE-aO
elseif aO+aK.X>aD.X-aE then
aL-=(aO+aK.X)-(aD.X-aE)
end

if aP<aE then
aM+=aE-aP
elseif aP+aK.Y>aD.Y-aE then
aM-=(aP+aK.Y)-(aD.Y-aE)
end

aC.AnchorPoint=aN
aC.Position=UDim2.fromOffset(math.floor(aL+0.5),math.floor(aM+0.5))
ar.UIElements.Menu.AnchorPoint=aG=="Left"and Vector2.new(1,0)
or aG=="Right"and Vector2.new(0,0)
or aG=="Up"and Vector2.new(1,1)
or Vector2.new(1,0)
ar.UIElements.Menu.Position=aG=="Left"and UDim2.new(1,0,0,0)
or aG=="Right"and UDim2.new(0,0,0,0)
or aG=="Up"and UDim2.new(1,0,1,0)
or UDim2.new(1,0,0,0)

return aG
end

local aB
local aC=""
local aD
local aE

local function CreateSearchBar()
local aF=math.max(as.MenuCorner-as.MenuPadding,6)
local aG=al.Icon"search"

aD=an("TextBox",{
Name="TextBox",
BackgroundTransparency=1,
ClearTextOnFocus=false,
ClipsDescendants=true,
FontFace=Font.new(al.Font,Enum.FontWeight.Regular),
PlaceholderText=ar.SearchPlaceholder,
Text=aC,
TextColor3=Color3.new(1,1,1),
TextSize=16,
TextScaled=false,
TextTruncate=Enum.TextTruncate.AtEnd,
TextWrapped=false,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
PlaceholderColor3="PlaceholderText",
TextColor3="Text",
},
Size=UDim2.new(1,-31,1,0),
})

local aH=al.NewRoundFrame(aF,"Squircle",{
Name="SearchBar",
LayoutOrder=0,
Parent=ar.UIElements.Menu,
Size=UDim2.new(1,0,0,as.SearchBarHeight),
ImageTransparency=0,
ThemeTag={
ImageColor3="DropdownTabBackground",
},
},{
al.NewRoundFrame(aF,"Squircle",{
Name="Outline",
Size=UDim2.new(1,1,1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageTransparency=0.8,
ThemeTag={
ImageColor3="DropdownTabBorder",
},
}),
an("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
},{
an("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
an("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Left",
VerticalAlignment="Center",
Padding=UDim.new(0,8),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
an("ImageLabel",{
Name="Icon",
BackgroundTransparency=1,
Image=aG[1],
ImageRectOffset=aG[2].ImageRectPosition,
ImageRectSize=aG[2].ImageRectSize,
ImageTransparency=0.18,
Size=UDim2.new(0,19,0,19),
ThemeTag={
ImageColor3="Icon",
},
}),
aD,
}),
})

al.AddSignal(aD:GetPropertyChangedSignal"Text",function()
aE(aD.Text)
end)

al.AddSignal(aD.Focused,function()
ao(aH.Outline,0.12,{ImageTransparency=0.48}):Play()
end)

al.AddSignal(aD.FocusLost,function()
ao(aH.Outline,0.12,{ImageTransparency=0.8}):Play()
end)

return aH
end

local function GetSearchText(aF)
local aG={
aF.Name,
aF.Desc,
}

if typeof(aF.Original)=="table"then
table.insert(aG,aF.Original.Value)
table.insert(aG,aF.Original.Id)
table.insert(aG,aF.Original.Key)
end

local aH={}
for aI,aJ in next,aG do
if aJ~=nil then
table.insert(aH,tostring(aJ))
end
end

return string.lower(table.concat(aH," "))
end

function aE(aF)
aC=tostring(aF or"")
local aG=string.lower(aC)

for aH,aI in next,ar.Tabs do
if aI.UIElements and aI.UIElements.TabItem then
local aJ=aI.UIElements.TabItem
local aK=aG==""
or string.find(GetSearchText(aI),aG,1,true)~=nil
if aK then
if not aJ.Parent then
aJ.Parent=ar.UIElements.Menu.Frame.ScrollingFrame
end
aJ.Visible=true
aJ.Size=aI.Size
aJ.AutomaticSize=aI.AutomaticSize
else
aJ.Visible=false
end
end
end

RecalculateCanvasSize()
RecalculateListSize()

if ar.UIElements.MenuCanvas.Visible then
UpdatePosition()
end

task.defer(function()
if aq.Window.Destroyed then
return
end

RecalculateCanvasSize()
RecalculateListSize()

if ar.UIElements.MenuCanvas.Visible then
UpdatePosition()
end
end)
end

function au.Display(aF)
local aG=ar.Values
local aH=""

if ar.Multi then
local aI={}
if typeof(ar.Value)=="table"then
for aJ,aK in ipairs(ar.Value)do
local aL=typeof(aK)=="table"and aK.Title or aK
aI[aL]=true
end
end

for aJ,aK in ipairs(aG)do
local aL=typeof(aK)=="table"and aK.Title or aK
if aI[aL]then
aH=aH..aL..", "
end
end

if#aH>0 then
aH=aH:sub(1,#aH-2)
end
else
aH=typeof(ar.Value)=="table"and(ar.Value.Title or ar.Value[1])
or ar.Value
or""
end

if ar.UIElements.Dropdown then
ar.UIElements.Dropdown.Frame.Frame.TextLabel.Text=(aH==""and"--"or aH)
end
end

local function Callback(aF)
au:Display()
if ar.Locked then
return
end

if ar.Callback then
task.spawn(function()
if ar.Locked then
return
end
al.SafeCallback(ar.Callback,ar.Value)
end)
else
task.spawn(function()
if ar.Locked then
return
end
al.SafeCallback(aF)
end)
end
end

function au.LockValues(aF,aG)
if not aG then
return
end

for aH,aI in next,ar.Tabs do
if aI and aI.UIElements and aI.UIElements.TabItem then
local aJ=aI.Name
local aK=false

for aL,aM in next,aG do
if aJ==aM then
aK=true
break
end
end

if aK then
ao(aI.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

ao(aI.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0.6}):Play()
if aI.UIElements.TabIcon then
ao(aI.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.6}):Play()
end

aI.UIElements.TabItem.Active=false
aI.Locked=true
else
if aI.Selected then
ao(aI.UIElements.TabItem,0.1,{ImageTransparency=ap}):Play()

ao(aI.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if aI.UIElements.TabIcon then
ao(aI.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
else
ao(aI.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

ao(
aI.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=at=="Dropdown"and 0.4 or 0.05}
):Play()
if aI.UIElements.TabIcon then
ao(
aI.UIElements.TabIcon.ImageLabel,
0.1,
{ImageTransparency=at=="Dropdown"and 0.2 or 0}
):Play()
end
end

aI.UIElements.TabItem.Active=true
aI.Locked=false
end
end
end
end

function au.Refresh(aF,aG)
if aq.Window.Destroyed then
return
end

for aH,aI in next,ar.Tabs do
if aI.UIElements and aI.UIElements.TabItem then
aI.UIElements.TabItem:Destroy()
end
end

for aH,aI in next,ar.UIElements.Menu.Frame.ScrollingFrame:GetChildren()do
if not aI:IsA"UIListLayout"then
aI:Destroy()
end
end

ar.Tabs={}

if ar.SearchBarEnabled then
if not aB then
aB=CreateSearchBar()
elseif aD then
aD.PlaceholderText=ar.SearchPlaceholder
end
end

for aH,aI in next,aG do
if typeof(aI)~="table"or aI.Type~="Divider"then
local aJ={
Name=typeof(aI)=="table"and aI.Title or aI,
Desc=typeof(aI)=="table"and aI.Desc or nil,
Icon=typeof(aI)=="table"and aI.Icon or nil,
IconSize=typeof(aI)=="table"and aI.IconSize or nil,
Original=aI,
Selected=false,
Locked=typeof(aI)=="table"and aI.Locked or false,
UIElements={},
}
local aK
if aJ.Icon then
aK=al.Image(aJ.Icon,aJ.Icon,0,aq.Window.Folder,"Dropdown",true)
aK.Size=
UDim2.new(0,aJ.IconSize or as.TabIcon,0,aJ.IconSize or as.TabIcon)
aK.ImageLabel.ImageTransparency=at=="Dropdown"and 0.2 or 0
aJ.UIElements.TabIcon=aK
end
aJ.UIElements.TabItem=al.NewRoundFrame(
as.MenuCorner-as.MenuPadding,
"Squircle",
{
Size=UDim2.new(1,0,0,ar.ItemHeight),
AutomaticSize=aJ.Desc and"Y",
LayoutOrder=typeof(aH)=="number"and aH or 0,
ImageTransparency=1,
Parent=ar.UIElements.Menu.Frame.ScrollingFrame,

ThemeTag={
ImageColor3="DropdownTabBackground",
},
Active=not aJ.Locked,
},
{
al.NewRoundFrame(as.MenuCorner-as.MenuPadding,"Glass-1.4",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="DropdownTabBorder",
},
ImageTransparency=1,
Name="Highlight",
},{













}),
an("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
an("UIListLayout",{
Padding=UDim.new(0,as.TabPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
an("UIPadding",{
PaddingTop=UDim.new(0,as.TabPadding),
PaddingLeft=UDim.new(0,as.TabPadding),
PaddingRight=UDim.new(0,as.TabPadding),
PaddingBottom=UDim.new(0,as.TabPadding),
}),
an("UICorner",{
CornerRadius=UDim.new(0,as.MenuCorner-as.MenuPadding),
}),
aK,
an("Frame",{
Size=UDim2.new(1,aK and-as.TabPadding-as.TabIcon or 0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Name="Title",
},{
an("TextLabel",{
Text=aJ.Name,
TextXAlignment="Left",
FontFace=Font.new(al.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text",
},
TextSize=14,
BackgroundTransparency=1,
TextTransparency=at=="Dropdown"and 0.4 or 0.05,
LayoutOrder=999,
AutomaticSize="Y",
TextTruncate="AtEnd",
Size=UDim2.new(1,0,0,0),
}),
an("TextLabel",{
Text=aJ.Desc or"",
TextXAlignment="Left",
FontFace=Font.new(al.Font,Enum.FontWeight.Regular),
ThemeTag={
TextColor3="Text",
BackgroundColor3="Text",
},
TextSize=13,
BackgroundTransparency=1,
TextTransparency=at=="Dropdown"and 0.6 or 0.35,
LayoutOrder=999,
AutomaticSize="Y",
TextWrapped=true,
Size=UDim2.new(1,0,0,0),
Visible=aJ.Desc and true or false,
Name="Desc",
}),
an("UIListLayout",{
Padding=UDim.new(0,as.TabPadding/3),
FillDirection="Vertical",
}),
}),
}),
},
true
)
aJ.Size=aJ.UIElements.TabItem.Size
aJ.AutomaticSize=aJ.UIElements.TabItem.AutomaticSize

if aJ.Locked then
aJ.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0.6
if aJ.UIElements.TabIcon then
aJ.UIElements.TabIcon.ImageLabel.ImageTransparency=0.6
end
end

if ar.Multi and typeof(ar.Value)=="string"then
for aL,aM in next,ar.Values do
if typeof(aM)=="table"then
if aM.Title==ar.Value then
ar.Value={aM}
end
else
if aM==ar.Value then
ar.Value={ar.Value}
end
end
end
end

if ar.Multi then
local aL=false
if typeof(ar.Value)=="table"then
for aM,aN in ipairs(ar.Value)do
local aO=typeof(aN)=="table"and aN.Title or aN
if aO==aJ.Name then
aL=true
break
end
end
end
aJ.Selected=aL
else
local aL=typeof(ar.Value)=="table"and ar.Value.Title or ar.Value
aJ.Selected=aL==aJ.Name
end

if aJ.Selected and not aJ.Locked then
aJ.UIElements.TabItem.ImageTransparency=ap

aJ.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=0
if aJ.UIElements.TabIcon then
aJ.UIElements.TabIcon.ImageLabel.ImageTransparency=0
end
end

ar.Tabs[aH]=aJ

au:Display()

if at=="Dropdown"then
al.AddSignal(aJ.UIElements.TabItem.MouseButton1Click,function()
if ar.Locked or aJ.Locked then
return
end

if ar.Multi then
if not aJ.Selected then
aJ.Selected=true
ao(
aJ.UIElements.TabItem,
0.1,
{ImageTransparency=ap}
):Play()

ao(aJ.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if aJ.UIElements.TabIcon then
ao(aJ.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
table.insert(ar.Value,aJ.Original)
else
if not ar.AllowNone and#ar.Value==1 then
return
end
aJ.Selected=false
ao(aJ.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

ao(aJ.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0.4}):Play()
if aJ.UIElements.TabIcon then
ao(aJ.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.2}):Play()
end

for aL,aM in next,ar.Value do
if typeof(aM)=="table"and(aM.Title==aJ.Name)or(aM==aJ.Name)then
table.remove(ar.Value,aL)
break
end
end
end
else
for aL,aM in next,ar.Tabs do
ao(aM.UIElements.TabItem,0.1,{ImageTransparency=1}):Play()

ao(
aM.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=0.4}
):Play()
if aM.UIElements.TabIcon then
ao(aM.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0.2}):Play()
end
aM.Selected=false
end
aJ.Selected=true
ao(aJ.UIElements.TabItem,0.1,{ImageTransparency=ap}):Play()

ao(aJ.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=0}):Play()
if aJ.UIElements.TabIcon then
ao(aJ.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=0}):Play()
end
ar.Value=aJ.Original
end
Callback()
if not ar.Multi then
au:Close()
end
end)
elseif at=="Menu"then
if not aJ.Locked then
al.AddSignal(aJ.UIElements.TabItem.MouseEnter,function()
ao(aJ.UIElements.TabItem,0.08,{ImageTransparency=ap}):Play()
end)
al.AddSignal(aJ.UIElements.TabItem.InputEnded,function()
ao(aJ.UIElements.TabItem,0.08,{ImageTransparency=1}):Play()
end)
end
al.AddSignal(aJ.UIElements.TabItem.MouseButton1Click,function()
if ar.Locked or aJ.Locked then
return
end
Callback(aI.Callback or function()end)
au:Close()
end)
end

RecalculateCanvasSize()
RecalculateListSize()
else a.load'U'
:New{Parent=ar.UIElements.Menu.Frame.ScrollingFrame}
end
end










ApplyCanvasWidth()
aE(aC)
Callback()

ar.Values=aG
end

au:Refresh(ar.Values)

function au.Select(aF,aG)
if aG then
ar.Value=aG
else
if ar.Multi then
ar.Value={}
else
ar.Value=nil
end
end
au:Refresh(ar.Values)
end

RecalculateListSize()
RecalculateCanvasSize()

local aF=0
local aG="Down"

function au.Open(aH)
if not ar.Locked then
aF+=1
local aI=aF
ar.UIElements.Menu.Visible=true
ar.UIElements.MenuCanvas.Visible=true
ar.UIElements.MenuCanvas.Active=true
RecalculateListSize()
RecalculateCanvasSize()
aG=UpdatePosition()
local aJ=aG=="Left"or aG=="Right"
if ar.Centered then
ar.UIElements.Menu.Size=UDim2.fromScale(1,1)
ar.UIElements.MenuScale.Scale=0.9
am.Play(
ar.UIElements.MenuScale,
"DropdownOpen",
{Scale=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"CenterScale"
)
if ar.UIElements.Backdrop then
ar.UIElements.Backdrop.Visible=true
ar.UIElements.Backdrop.BackgroundTransparency=1
am.Play(ar.UIElements.Backdrop,"DropdownOpen",{
BackgroundTransparency=ar.BackdropTransparency,
},nil,nil,"Backdrop")
end
else
ar.UIElements.Menu.Size=aJ and UDim2.new(0,0,1,0)or UDim2.new(1,0,0,0)
end
am.Play(ar.UIElements.Menu,"DropdownOpen",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=ar.Glass and ar.GlassTransparency or 0,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out,"OpenClose")

task.spawn(function()
task.wait(am.GetDuration"DropdownOpen")
if ar.Locked or aF~=aI then
return
end
ar.Opened=true
end)

UpdatePosition()
end
end

function au.Close(aH)
aF+=1
local aI=aF
ar.Opened=false

local aJ=aG=="Left"or aG=="Right"
local aK=if ar.Centered
then UDim2.fromScale(1,1)
else aJ and UDim2.new(0,0,1,0)or UDim2.new(1,0,0,0)
am.Play(ar.UIElements.Menu,"DropdownClose",{
Size=aK,
ImageTransparency=1,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out,"OpenClose")
if ar.Centered then
am.Play(ar.UIElements.MenuScale,"DropdownClose",{Scale=0.92},nil,nil,"CenterScale")
if ar.UIElements.Backdrop then
am.Play(
ar.UIElements.Backdrop,
"DropdownClose",
{BackgroundTransparency=1},
nil,
nil,
"Backdrop"
)
end
end

task.spawn(function()
task.wait(am.GetDuration"DropdownClose")
if aF~=aI then
return
end
ar.UIElements.Menu.Visible=false
ar.UIElements.MenuCanvas.Visible=false
ar.UIElements.MenuCanvas.Active=false
if ar.UIElements.Backdrop then
ar.UIElements.Backdrop.Visible=false
end
end)
end

if ar.UIElements.Backdrop then
al.AddSignal(ar.UIElements.Backdrop.MouseButton1Click,function()
au:Close()
end)
end

al.AddSignal(
(
ar.UIElements.Dropdown and ar.UIElements.Dropdown.MouseButton1Click
or ar.DropdownFrame.UIElements.Main.MouseButton1Click
),
function()
if ar.Opened or ar.UIElements.MenuCanvas.Visible then
au:Close()
else
au:Open()
end
end
)

table.insert(
aA,
al.AddSignal(ag.InputBegan,function(aH)
if
aH.UserInputType==Enum.UserInputType.MouseButton1
or aH.UserInputType==Enum.UserInputType.Touch
then
local aI=ar.UIElements.MenuCanvas
local aJ=ar.UIElements.Dropdown or ar.DropdownFrame.UIElements.Main
local aK=GetInputPosition(aH)
local aL=ContainsPoint(aJ,aK)
local aM=ContainsPoint(aI,aK)

if
aq.Window.CanDropdown
and(ar.Opened or aI.Visible)
and not aL
and not aM
then
au:Close()
end
end
end)
)

table.insert(
aA,
al.AddSignal(
ar.UIElements.Dropdown and ar.UIElements.Dropdown:GetPropertyChangedSignal"AbsolutePosition"
or ar.DropdownFrame.UIElements.Main:GetPropertyChangedSignal"AbsolutePosition",
UpdatePosition
)
)

if typeof(az)=="Instance"and az:IsA"GuiObject"then
table.insert(
aA,
al.AddSignal(az:GetPropertyChangedSignal"AbsoluteSize",function()
if ar.UIElements.MenuCanvas.Visible then
RecalculateListSize()
UpdatePosition()
end
end)
)
end

function au.Destroy(aH)
aF+=1
ar.Opened=false

for aI,aJ in aA do
aJ:Disconnect()
end
table.clear(aA)

if ar.UIElements.Backdrop then
ar.UIElements.Backdrop:Destroy()
ar.UIElements.Backdrop=nil
end
if ar.UIElements.MenuCanvas then
ar.UIElements.MenuCanvas:Destroy()
end
end

return au
end

return aa end function a.W()

local aa=a.load'a'

aa(game:GetService"UserInputService")
aa(game:GetService"Players")

local af=a.load'e'
local ag=af.New local ah=
af.Tween

local ai=a.load'z'.New local aj=a.load'p'
.New
local ak=a.load'V'.New local al=

workspace.CurrentCamera

local am={
UICorner=10,
UIPadding=12,
MenuCorner=14,
MenuPadding=4,
TabPadding=8,
SearchBarHeight=36,
TabIcon=16,
ItemHeight=32,
}

function am.New(an,ao)
local ap=ao.Values or{}
local aq=ao.SearchBarEnabled
if aq==nil then
if ao.Search~=nil then
aq=ao.Search
elseif ao.EnableSearch~=nil then
aq=ao.EnableSearch
else
aq=#ap>=(ao.SearchThreshold or 7)
end
end

local ar=ao.Compact~=false
local as=string.lower(tostring(ao.Placement or ao.MenuPlacement or ao.Mode or""))
local at=string.lower(tostring(ao.Direction or ao.OpenDirection or""))
local au=ao.Centered==true
or ao.Modal==true
or as=="center"
or as=="middle"
or at=="center"
or at=="middle"

local av={
__type="Dropdown",
Title=ao.Title or"Dropdown",
Desc=ao.Desc or nil,
Locked=ao.Locked or false,
LockedTitle=ao.LockedTitle,
Values=ap,
MenuWidth=ao.MenuWidth or(au and 236 or(ar and 164 or 180)),
MenuMaxWidth=ao.MenuMaxWidth,
MenuMaxHeight=ao.MenuMaxHeight or(au and 240 or nil),
FullWidth=ao.FullWidth or ao.Full or ao.Mode=="Full"or ao.MenuMode=="Full",
Direction=au and"Center"or(ao.Direction or ao.OpenDirection or"Auto"),
Side=ao.Side or ao.Align or ao.Alignment or"Right",
MobileDirection=ao.MobileDirection or ao.MobileOpenDirection,
MobileSide=ao.MobileSide or ao.MobileAlign,
Centered=au,
CenterTarget=ao.CenterTarget or ao.CenterIn or"Window",
CenterOffset=typeof(ao.CenterOffset)=="Vector2"and ao.CenterOffset or Vector2.new(0,0),
Backdrop=au and ao.Backdrop~=false,
BackdropTransparency=af.ClampTransparency(ao.BackdropTransparency,0.84),
Value=ao.Value,
AllowNone=ao.AllowNone,
SearchBarEnabled=aq==true,
SearchPlaceholder=ao.SearchPlaceholder or"Search...",
Compact=ar,
Glass=ao.Glass==true,
GlassTransparency=ao.GlassTransparency or ao.MenuTransparency or 0,
ItemHeight=ao.ItemHeight or(ar and am.ItemHeight or 36),
Multi=ao.Multi,
Callback=ao.Callback or nil,

UIElements={},

Opened=false,
Tabs={},

Width=ao.Width or(ar and 136 or 150),
}

if av.Multi and not av.Value then
av.Value={}
end
if av.Values and typeof(av.Value)=="number"then
av.Value=av.Values[av.Value]
end

av.DropdownFrame=a.load'K'{
Title=av.Title,
Desc=av.Desc,
Parent=ao.Parent,
TextOffset=av.Callback and av.Width or 20,
Hover=not av.Callback and true or false,
Tab=ao.Tab,
Index=ao.Index,
Window=ao.Window,
ElementTable=av,
ParentConfig=ao,
Tags=ao.Tags,
}

if av.Callback then
av.UIElements.Dropdown=
ai("",nil,av.DropdownFrame.UIElements.Main,nil,ao.Window.NewElements and 12 or 10)

av.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate="AtEnd"
av.UIElements.Dropdown.Frame.Frame.TextLabel.Size=
UDim2.new(1,av.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset-18-12-12,0,0)

av.UIElements.Dropdown.Size=UDim2.new(0,av.Width,0,ar and 32 or 36)
av.UIElements.Dropdown.Position=UDim2.new(1,0,ao.Window.NewElements and 0 or 0.5,0)
av.UIElements.Dropdown.AnchorPoint=Vector2.new(1,ao.Window.NewElements and 0 or 0.5)





end

av.DropdownMenu=ak(ao,av,am,"Dropdown")

av.Display=av.DropdownMenu.Display
av.Refresh=av.DropdownMenu.Refresh
av.Select=av.DropdownMenu.Select
av.Open=av.DropdownMenu.Open
av.Close=av.DropdownMenu.Close
function av.Cleanup(aw)
av.DropdownMenu:Destroy()
end

ag("ImageLabel",{
Image=af.Icon"chevrons-up-down"[1],
ImageRectOffset=af.Icon"chevrons-up-down"[2].ImageRectPosition,
ImageRectSize=af.Icon"chevrons-up-down"[2].ImageRectSize,
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(1,av.UIElements.Dropdown and-12 or 0,0.5,0),
ThemeTag={
ImageColor3="Icon",
},
AnchorPoint=Vector2.new(1,0.5),
Parent=av.UIElements.Dropdown and av.UIElements.Dropdown.Frame
or av.DropdownFrame.UIElements.Main,
})

function av.Lock(aw)
av.Locked=true
if av.Opened or(av.UIElements.MenuCanvas and av.UIElements.MenuCanvas.Visible)then
av:Close()
end
return av.DropdownFrame:Lock(av.LockedTitle)
end
function av.Unlock(aw)
av.Locked=false
return av.DropdownFrame:Unlock()
end

if av.Locked then
av:Lock()
end

return av.__type,av
end

return am end function a.X()




local aa={}
local af={
lua={
"and",
"break",
"or",
"else",
"elseif",
"if",
"then",
"until",
"repeat",
"while",
"do",
"for",
"in",
"end",
"local",
"return",
"function",
"export",
},
rbx={
"game",
"workspace",
"script",
"math",
"string",
"table",
"task",
"wait",
"select",
"next",
"Enum",
"tick",
"assert",
"shared",
"loadstring",
"tonumber",
"tostring",
"type",
"typeof",
"unpack",
"Instance",
"CFrame",
"Vector3",
"Vector2",
"Color3",
"UDim",
"UDim2",
"Ray",
"BrickColor",
"OverlapParams",
"RaycastParams",
"Axes",
"Random",
"Region3",
"Rect",
"TweenInfo",
"collectgarbage",
"not",
"utf8",
"pcall",
"xpcall",
"_G",
"setmetatable",
"getmetatable",
"os",
"pairs",
"ipairs",
},
operators={
"#",
"+",
"-",
"*",
"%",
"/",
"^",
"=",
"~",
"=",
"<",
">",
},
}

local ag={
numbers=Color3.fromHex"#FAB387",
boolean=Color3.fromHex"#FAB387",
operator=Color3.fromHex"#94E2D5",
lua=Color3.fromHex"#CBA6F7",
rbx=Color3.fromHex"#F38BA8",
str=Color3.fromHex"#A6E3A1",
comment=Color3.fromHex"#9399B2",
null=Color3.fromHex"#F38BA8",
call=Color3.fromHex"#89B4FA",
self_call=Color3.fromHex"#89B4FA",
local_property=Color3.fromHex"#CBA6F7",
}

local function createKeywordSet(ai)
local ak={}
for al,am in ipairs(ai)do
ak[am]=true
end
return ak
end

local ai=createKeywordSet(af.lua)
local ak=createKeywordSet(af.rbx)
local al=createKeywordSet(af.operators)

local function getHighlight(am,an)
local ao=am[an]

if ag[ao.."_color"]then
return ag[ao.."_color"]
end

if tonumber(ao)then
return ag.numbers
elseif ao=="nil"then
return ag.null
elseif ao:sub(1,2)=="--"then
return ag.comment
elseif al[ao]then
return ag.operator
elseif ai[ao]then
return ag.lua
elseif ak[ao]then
return ag.rbx
elseif ao:sub(1,1)=='"'or ao:sub(1,1)=="'"then
return ag.str
elseif ao=="true"or ao=="false"then
return ag.boolean
end

if am[an+1]=="("then
if am[an-1]==":"then
return ag.self_call
end

return ag.call
end

if am[an-1]=="."then
if am[an-2]=="Enum"then
return ag.rbx
end

return ag.local_property
end
end

function aa.run(am,an)
if an~=nil then
for ao,ap in next,an do
ag[ao]=ap
end
end

local ao={}
local ap=""

local aq=false
local ar=false
local as=false

for at=1,#am do
local au=am:sub(at,at)

if ar then
if au=="\n"and not as then
table.insert(ao,ap)
table.insert(ao,au)
ap=""

ar=false
elseif am:sub(at-1,at)=="]]"and as then
ap=ap.."]"

table.insert(ao,ap)
ap=""

ar=false
as=false
else
ap=ap..au
end
elseif aq then
if au==aq and am:sub(at-1,at-1)~="\\"or au=="\n"then
ap=ap..au
aq=false
else
ap=ap..au
end
else
if am:sub(at,at+1)=="--"then
table.insert(ao,ap)
ap="-"
ar=true
as=am:sub(at+2,at+3)=="[["
elseif au=='"'or au=="'"then
table.insert(ao,ap)
ap=au
aq=au
elseif al[au]then
table.insert(ao,ap)
table.insert(ao,au)
ap=""
elseif au:match"[%w_]"then
ap=ap..au
else
table.insert(ao,ap)
table.insert(ao,au)
ap=""
end
end
end

table.insert(ao,ap)

local at={}

for au,av in ipairs(ao)do
local aw=getHighlight(ao,au)

if aw then
local ax=string.format(
'<font color = "#%s">%s</font>',
aw:ToHex(),
av:gsub("<","&lt;"):gsub(">","&gt;")
)

table.insert(at,ax)
else
table.insert(at,av)
end
end

return table.concat(at)
end

return aa end function a.Y()

local aa={}

local af=a.load'e'
local ag=af.New
local ai=af.Tween

local ak=a.load'X'

function aa.New(al,am,an,ao,ap)
local aq={
Radius=am.ElementConfig.UICorner,
Padding=am.NewElements and am.ElementConfig.UIPadding+4 or am.ElementConfig.UIPadding,

CodeFrame=nil,
}

local ar=ag("TextLabel",{
Text="",
TextColor3=Color3.fromHex"#CDD6F4",
TextTransparency=0,
TextSize=al.CodeSize,
TextWrapped=false,
LineHeight=1.15,
RichText=true,
TextXAlignment="Left",
Size=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
AutomaticSize="XY",
},{
ag("UIPadding",{
PaddingTop=UDim.new(0,aq.Padding+3),
PaddingLeft=UDim.new(0,aq.Padding+3),
PaddingRight=UDim.new(0,aq.Padding+3),
PaddingBottom=UDim.new(0,aq.Padding+3),
}),
})
ar.Font="Code"

local as=ag("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticCanvasSize=al.Height~=nil and"XY"or"X",
ScrollingDirection=al.Height~=nil and"XY"or"X",
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
ScrollBarThickness=0,
},{
ar,
})

local at=al.CanCopied
and ag("TextButton",{
BackgroundTransparency=1,
Size=UDim2.new(0,35,0,35),
Position=UDim2.new(1,-aq.Padding/2,0,aq.Padding/2),
AnchorPoint=Vector2.new(1,0),
Visible=ao and true or false,
},{
af.NewRoundFrame(aq.Radius-4,"Squircle",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Button",
},{
ag("UIScale",{
Scale=1,
}),
ag("ImageLabel",{
Image=af.Icon"copy"[1],
ImageRectSize=af.Icon"copy"[2].ImageRectSize,
ImageRectOffset=af.Icon"copy"[2].ImageRectPosition,
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Size=UDim2.new(0,12,0,12),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=0.1,
}),
}),
})
or nil

local au,av=af.NewRoundFrame(aq.Radius,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=0.955,
Visible=false,
})

local aw,ax=af.NewRoundFrame(aq.Radius,"Squircle-TL-TR",{



ImageColor3=Color3.fromHex"#ffffff",
ImageTransparency=0.96,
Size=UDim2.new(1,0,0,20+(aq.Padding*2)),
Visible=al.Title and true or false,
},{










ag("TextLabel",{
Text=al.Title,



TextColor3=Color3.fromHex"#ffffff",
TextTransparency=0.2,
TextSize=18,
AutomaticSize="Y",
FontFace=Font.new(af.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
BackgroundTransparency=1,
TextTruncate="AtEnd",
Size=UDim2.new(1,at and-20-(aq.Padding*2),0,0),
}),
ag("UIPadding",{

PaddingLeft=UDim.new(0,aq.Padding+3),
PaddingRight=UDim.new(0,aq.Padding+3),

}),
ag("UIListLayout",{
Padding=UDim.new(0,aq.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
})

local ay,az=af.NewRoundFrame(aq.Radius,"Squircle",{



ImageColor3=Color3.fromHex"#212121",
ImageTransparency=0.035,
Size=al.Height~=nil
and UDim2.new(1,0,al.Height.Scale,al.Height.Offset==0 and-40 or al.Height.Offset)
or UDim2.new(1,0,0,20+(aq.Padding*2)),
AutomaticSize=al.Height~=nil and"None"or"Y",
Parent=an,
},{
au,
ag("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,al.Height~=nil and 1 or 0,0),
AutomaticSize=al.Height~=nil and"None"or"Y",
},{
aw,
as,
ag("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
at,
},nil,true)

aq.CodeFrame=ay
aq.CodeFrameModule=az
aq.OutlineFrame=au
aq.OutlineFrameModule=av
aq.TopbarFrame=aw
aq.TopbarFrameModule=ax

af.AddSignal(ar:GetPropertyChangedSignal"TextBounds",function()
if al.Height~=nil then
as.Size=UDim2.new(1,0,1,al.Title~=nil and-(20+(aq.Padding*2))or nil)
else
as.Size=
UDim2.new(1,0,0,(ar.TextBounds.Y/(ap or 1))+((aq.Padding+3)*2))
end
end)

function aq.Set(aA)
ar.Text=ak.run(aA,al.CodeTheme)
end

function aq.Destroy()
ay:Destroy()
aq=nil
end

aq.Set(al.Code)

if at then
af.AddSignal(at.InputBegan,function(aA:InputObject)
if
aA.UserInputType==Enum.UserInputType.MouseButton1
or aA.UserInputType==Enum.UserInputType.Touch
then
ai(at.Button,0.05,{ImageTransparency=0.95}):Play()
ai(at.Button.UIScale,0.05,{Scale=0.9}):Play()
end
end)
af.AddSignal(at.InputEnded,function()
ai(at.Button,0.08,{ImageTransparency=1}):Play()
ai(at.Button.UIScale,0.08,{Scale=1}):Play()
end)
af.AddSignal(at.MouseButton1Click,function()
if ao then
ao()
local aA=af.Icon"check"
at.Button.ImageLabel.Image=aA[1]
at.Button.ImageLabel.ImageRectSize=aA[2].ImageRectSize
at.Button.ImageLabel.ImageRectOffset=aA[2].ImageRectPosition

task.delay(1,function()
local aB=af.Icon"copy"
at.Button.ImageLabel.Image=aB[1]
at.Button.ImageLabel.ImageRectSize=aB[2].ImageRectSize
at.Button.ImageLabel.ImageRectOffset=aB[2].ImageRectPosition
end)
end
end)
end

return aq
end

return aa end function a.Z()

local aa=a.load'e'local af=
aa.New


local ag=a.load'Y'

local ai={}

function ai.New(ak,al)
local am={
__type="Code",
Title=al.Title,
Code=al.Code,
CodeSize=al.CodeSize or 18,
Height=al.Height,
CodeTheme=al.CodeTheme,
Locked=false,
CanCopied=al.CanCopied~=false,
OnCopy=al.OnCopy,
LinkCorners=al.LinkCorners,
CornerGroup=al.CornerGroup or al.LinkCornerGroup,
CornerBreak=al.CornerBreak,
CornerBreakBefore=al.CornerBreakBefore,
CornerBreakAfter=al.CornerBreakAfter,

Index=al.Index,
}

local an=not am.Locked











local ao=ag.New(am,al.Window,al.Parent,function()
if an then
local ao=am.Title or"code"
local ap,aq=pcall(function()
if toclipboard then
toclipboard(am.Code)
end
if setclipboard then
setclipboard(am.Code)
end

if am.OnCopy then
am.OnCopy()
end
end)
if not ap then
al.WindUI:Notify{
Title="Error",
Content="The "..ao.." is not copied. Error: "..aq,
Icon="x",
Style="Error",
Duration=5,
}
end
end
end,al.WindUI.UIScale)

function am.SetCode(ap,aq)
ao.Set(aq)
am.Code=aq
end

function am.Set(ap,aq)
return am.SetCode(aq)
end

function am.Destroy(ap)
ao.Destroy()
am=nil
end

function am.UpdateShape(ap)
if al.Window.NewElements then
local aq=al.Window.ElementConfig.LinkCorners or al.LinkCorners==true
local ar="Squircle"

if aq then
ar=aa.GetLinkedCornerShape(
ap.Elements,
am.Index,
ap,
al.ParentType,
al.CornerLink
or(al.ParentConfig and al.ParentConfig.CornerLink)
or al.Window.ElementConfig.CornerLink
)
end

if ar and ao.CodeFrameModule then
local as=(ar=="Squircle-TL-BL"or ar=="Squircle-TR-BR")and"Squircle"
or ar

ao.CodeFrameModule:SetType(as)

ao.TopbarFrameModule:SetType(
table.find({"Squircle-BL-BR","SquircleH-BL-BR","Squircle-TR-BR"},ar)~=nil and"Square"
or as
)
end
end
end

am.UIElements={Main=ao.CodeFrame}
am.ElementFrame=ao.CodeFrame

return am.__type,am
end

return ai end function a._()

local aa=a.load'e'
local af=aa.New local ag=
aa.Tween

local ai=a.load'a'

local ak=ai(game:GetService"UserInputService")
local al=ai(game:GetService"RunService")
local am=ai(game:GetService"Players")local an=

al.RenderStepped
local ao=am.LocalPlayer
local ap=ao:GetMouse()

local aq=a.load'o'.New
local ar=a.load'p'.New

local as={
UICorner=9,

}

function as.Colorpicker(at,au,av,aw,ax)
local ay={
__type="Colorpicker",
Title=au.Title,
Desc=au.Desc,
Default=au.Value or au.Default,
Callback=au.Callback,
Transparency=au.Transparency,
UIElements=au.UIElements,

TextPadding=10,
}

local az={}
local aA
local aB
local aC=aw.GenerateGUID()
local aD=ay.Transparency~=nil

local function TrackConnection(aE,aF)
local aG=aa.AddSignal(aE,aF)
table.insert(az,aG)
return aG
end

local function DisconnectConnections()
for aE=#az,1,-1 do
aa.DisconnectSignal(az[aE])
az[aE]=nil
end

table.clear(az)
aA=nil
aB=nil
if aw.CurrentInput==aC then
aw.CurrentInput=nil
end
end

function ay.SetHSVFromRGB(aE,aF)
local aG,aH,aI=Color3.toHSV(aF)
ay.Hue=aG
ay.Sat=aH
ay.Vib=aI
end

ay:SetHSVFromRGB(ay.Default)

local aE=a.load'q'
local aF=aE.Create(nil,"Dialog",av,aw,av.UIElements.Main.Main)

ay.ColorpickerFrame=aF

aF.UIElements.Main.Size=UDim2.new(1,0,0,0)



local aG,aH,aI=ay.Hue,ay.Sat,ay.Vib

ay.UIElements.Title=af("TextLabel",{
Text=ay.Title,
TextSize=20,
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
Size=UDim2.new(0,0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=aF.UIElements.Main,
},{
af("UIPadding",{
PaddingTop=UDim.new(0,ay.TextPadding/2),
PaddingLeft=UDim.new(0,ay.TextPadding/2),
PaddingRight=UDim.new(0,ay.TextPadding/2),
PaddingBottom=UDim.new(0,ay.TextPadding/2),
}),
})





local aJ=af("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
})

local aK=af("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=aJ,
BackgroundColor3=ay.Default,
},{
af("UIStroke",{
Thickness=2,
Transparency=0.1,
ThemeTag={
Color="Text",
},
}),
af("UICorner",{
CornerRadius=UDim.new(1,0),
}),
})

ay.UIElements.SatVibMap=af("ImageLabel",{
Size=UDim2.fromOffset(160,158),
Position=UDim2.fromOffset(0,40+ay.TextPadding),
Image="rbxassetid://4155801252",
BackgroundColor3=Color3.fromHSV(aG,1,1),
BackgroundTransparency=0,
Parent=aF.UIElements.Main,
},{
af("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
ZIndex=99999,
},{
af("UIGradient",{
Rotation=45,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),

aK,
})

ay.UIElements.Inputs=af("Frame",{
AutomaticSize="XY",
Size=UDim2.new(0,0,0,0),
Position=UDim2.fromOffset(
aD and 240 or 210,
40+ay.TextPadding
),
BackgroundTransparency=1,
Parent=aF.UIElements.Main,
},{
af("UIListLayout",{
Padding=UDim.new(0,4),
FillDirection="Vertical",
}),
})





local aL=af("Frame",{
BackgroundColor3=ay.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=ay.Transparency,
},{
af("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

af("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(85,208+ay.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=aF.UIElements.Main,
},{
af("UICorner",{
CornerRadius=UDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
ZIndex=99999,
},{
af("UIGradient",{
Rotation=60,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),







aL,
})

local aM=af("Frame",{
BackgroundColor3=ay.Default,
Size=UDim2.fromScale(1,1),
BackgroundTransparency=0,
ZIndex=9,
},{
af("UICorner",{
CornerRadius=UDim.new(0,8),
}),
})

af("ImageLabel",{
Image="http://www.roblox.com/asset/?id=14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,208+ay.TextPadding),
Size=UDim2.fromOffset(75,24),
Parent=aF.UIElements.Main,
},{
af("UICorner",{
CornerRadius=UDim.new(0,8),
}),







aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag={
ImageColor3="Outline",
},
Size=UDim2.new(1,0,1,0),
ImageTransparency=0.85,
ZIndex=99999,
},{
af("UIGradient",{
Rotation=60,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),
aM,
})

local aN={}

for aO=0,1,0.1 do
table.insert(aN,ColorSequenceKeypoint.new(aO,Color3.fromHSV(aO,1,1)))
end

local aO=af("UIGradient",{
Color=ColorSequence.new(aN),
Rotation=90,
})

local aP=af("Frame",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
Parent=aJ,


BackgroundColor3=ay.Default,
},{
af("UIStroke",{
Thickness=2,
Transparency=0.1,
ThemeTag={
Color="Text",
},
}),
af("UICorner",{
CornerRadius=UDim.new(1,0),
}),
})

local aQ=af("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(180,40+ay.TextPadding),
Parent=aF.UIElements.Main,
},{
af("UICorner",{
CornerRadius=UDim.new(1,0),
}),
aO,
aJ,
})

local function CreateNewInput(aR,aS)
local aT=ar(aR,nil,ay.UIElements.Inputs,nil,nil,nil,nil,nil,true)

af("TextLabel",{
BackgroundTransparency=1,
TextTransparency=0.4,
TextSize=17,
FontFace=Font.new(aa.Font,Enum.FontWeight.Regular),
AutomaticSize="XY",
ThemeTag={
TextColor3="Placeholder",
},
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(1,-12,0.5,0),
Parent=aT.Frame,
Text=aR,
})

af("UIScale",{
Parent=aT,
Scale=0.85,
})

aT.Frame.Frame.TextBox.Text=aS
aT.Size=UDim2.new(0,150,0,42)

return aT
end

local function ToRGB(aR)
return{
R=math.floor(aR.R*255),
G=math.floor(aR.G*255),
B=math.floor(aR.B*255),
}
end

local aR=CreateNewInput("Hex","#"..ay.Default:ToHex())

local aS=CreateNewInput("Red",ToRGB(ay.Default).R)
local aT=CreateNewInput("Green",ToRGB(ay.Default).G)
local aU=CreateNewInput("Blue",ToRGB(ay.Default).B)
local aV
if aD then
aV=CreateNewInput("Alpha",((1-ay.Transparency)*100).."%")
end

local aW=af("Frame",{
Size=UDim2.new(0,0,0,40),
AutomaticSize="Y",
Position=UDim2.new(0,0,0,254+ay.TextPadding),
BackgroundTransparency=1,
Parent=aF.UIElements.Main,
LayoutOrder=4,
},{
af("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Right",
}),






})

TrackConnection(aF.UIElements.Main:GetPropertyChangedSignal"AbsoluteSize",function()
ay.UIElements.Title.Size=UDim2.new(
0,
aF.UIElements.Main.AbsoluteSize.X/au.UIScale-(aF.UIPadding*2),
0,
0
)
aW.Size=UDim2.new(
0,
aF.UIElements.Main.AbsoluteSize.X/au.UIScale-aF.UIPadding*2,
0,
40
)
end)

local aX={
{
Title="Cancel",
Variant="Secondary",
Callback=function()
au.IsShowed=false
DisconnectConnections()
end,
},
{
Title="Apply",

Variant="Primary",
Callback=function()
au.IsShowed=false
DisconnectConnections()

ax(Color3.fromHSV(ay.Hue,ay.Sat,ay.Vib),ay.Transparency)
end,
},
}

for aY,aZ in next,aX do
local a_=aq(
aZ.Title,
aZ.Icon,
aZ.Callback,
aZ.Variant,
aW,
aF,
true
)
a_.Size=UDim2.new(0.5,-3,0,40)
a_.AutomaticSize="None"
end

local aY,aZ,a_
if aD then
local a0=af("Frame",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.fromOffset(0,0),
BackgroundTransparency=1,
})

aZ=af("ImageLabel",{
Size=UDim2.new(0,14,0,14),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0,0),
ThemeTag={
BackgroundColor3="Text",
},
Parent=a0,
},{
af("UIStroke",{
Thickness=2,
Transparency=0.1,
ThemeTag={
Color="Text",
},
}),
af("UICorner",{
CornerRadius=UDim.new(1,0),
}),
})

a_=af("Frame",{
Size=UDim2.fromScale(1,1),
},{
af("UIGradient",{
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
},
Rotation=270,
}),
af("UICorner",{
CornerRadius=UDim.new(0,6),
}),
})

aY=af("Frame",{
Size=UDim2.fromOffset(6,192),
Position=UDim2.fromOffset(210,40+ay.TextPadding),
Parent=aF.UIElements.Main,
BackgroundTransparency=1,
},{
af("UICorner",{
CornerRadius=UDim.new(1,0),
}),
af("ImageLabel",{
Image="rbxassetid://14204231522",
ImageTransparency=0.45,
ScaleType=Enum.ScaleType.Tile,
TileSize=UDim2.fromOffset(40,40),
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
},{
af("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
a_,
a0,
})
end

function ay.Round(a0,a1,a2)
if a2==0 then
return math.floor(a1)
end
local a3=tostring(a1)
local a4=a3:find"%."
if a4 then
return tonumber(a3:sub(1,a4+a2))
end
return tonumber(a3)or 0
end

function ay.Update(a0,a1,a2)
if a1 then
aG,aH,aI=Color3.toHSV(a1)
else
aG,aH,aI=ay.Hue,ay.Sat,ay.Vib
end

ay.UIElements.SatVibMap.BackgroundColor3=Color3.fromHSV(aG,1,1)
aK.Position=UDim2.new(aH,0,1-aI,0)
aK.BackgroundColor3=Color3.fromHSV(aG,aH,aI)
aM.BackgroundColor3=Color3.fromHSV(aG,aH,aI)
aP.BackgroundColor3=Color3.fromHSV(aG,1,1)
aP.Position=UDim2.new(0.5,0,aG,0)

aR.Frame.Frame.TextBox.Text="#"..Color3.fromHSV(aG,aH,aI):ToHex()
aS.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aG,aH,aI)).R
aT.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aG,aH,aI)).G
aU.Frame.Frame.TextBox.Text=ToRGB(Color3.fromHSV(aG,aH,aI)).B

if a2 or aD then
local a3=ay.Transparency or a2
aM.BackgroundTransparency=a3
a_.BackgroundColor3=Color3.fromHSV(aG,aH,aI)
aZ.BackgroundColor3=Color3.fromHSV(aG,aH,aI)
aZ.BackgroundTransparency=a3
aZ.Position=UDim2.new(0.5,0,1-a3,0)
aV.Frame.Frame.TextBox.Text=ay:Round(
(1-a3)*100,
0
).."%"
end
end

ay:Update(ay.Default,ay.Transparency)

local function GetRGB()
local a0=Color3.fromHSV(ay.Hue,ay.Sat,ay.Vib)
return{R=math.floor(a0.r*255),G=math.floor(a0.g*255),B=math.floor(a0.b*255)}
end



local function clamp(a0,a1,a2)
return math.clamp(tonumber(a0)or 0,a1,a2)
end

TrackConnection(aR.Frame.Frame.TextBox.FocusLost,function(a0)
if a0 then
local a1=aR.Frame.Frame.TextBox.Text:gsub("#","")
local a2,a3=pcall(Color3.fromHex,a1)
if a2 and typeof(a3)=="Color3"then
ay.Hue,ay.Sat,ay.Vib=Color3.toHSV(a3)
ay:Update()
ay.Default=a3
end
end
end)

local function updateColorFromInput(a0,a1)
TrackConnection(a0.Frame.Frame.TextBox.FocusLost,function(a2)
if a2 then
local a3=a0.Frame.Frame.TextBox
local a4=GetRGB()
local a5=clamp(a3.Text,0,255)
a3.Text=tostring(a5)

a4[a1]=a5
local a6=Color3.fromRGB(a4.R,a4.G,a4.B)
ay.Hue,ay.Sat,ay.Vib=Color3.toHSV(a6)
ay:Update()
end
end)
end

updateColorFromInput(aS,"R")
updateColorFromInput(aT,"G")
updateColorFromInput(aU,"B")

if aD then
TrackConnection(aV.Frame.Frame.TextBox.FocusLost,function(a0)
if a0 then
local a1=aV.Frame.Frame.TextBox
local a2=clamp(a1.Text,0,100)
a1.Text=tostring(a2)

ay.Transparency=1-a2*0.01
ay:Update(nil,ay.Transparency)
end
end)
end



local function GetPointerPosition(a0)
if a0 and a0.UserInputType==Enum.UserInputType.Touch then
return a0.Position.X,a0.Position.Y
end

return ap.X,ap.Y
end

local function UpdateSatVib(a0,a1,a2)
local a3=a0.AbsolutePosition.X
local a4=a3+a0.AbsoluteSize.X
local a5=a0.AbsolutePosition.Y
local a6=a5+a0.AbsoluteSize.Y
local a7,a8=GetPointerPosition(a2)
local a9=a4-a3
local b=a6-a5
if a9<=0 or b<=0 then
return
end

local ba=math.clamp(a7,a3,a4)
local bb=math.clamp(a8,a5,a6)

a1.Sat=(ba-a3)/a9
a1.Vib=1-((bb-a5)/b)

a1:Update()
end

local function UpdateHue(a0,a1,a2)
local a3=a0.AbsolutePosition.Y
local a4=a3+a0.AbsoluteSize.Y local
a5, a6=GetPointerPosition(a2)
local a7=a4-a3
if a7<=0 then
return
end

local a8=math.clamp(a6,a3,a4)

a1.Hue=(a8-a3)/a7

a1:Update()
end

local function UpdateTransparency(a0,a1,a2)
local a3=a0.AbsolutePosition.Y
local a4=a3+a0.AbsoluteSize.Y local
a5, a6=GetPointerPosition(a2)
local a7=a4-a3
if a7<=0 then
return
end

local a8=math.clamp(a6,a3,a4)

a1.Transparency=1-((a8-a3)/a7)

a1:Update()
end

TrackConnection(ak.InputChanged,function(a0)
if
a0.UserInputType~=Enum.UserInputType.MouseMovement
and a0.UserInputType~=Enum.UserInputType.Touch
then
return
end

if aB and aB.UserInputType==Enum.UserInputType.Touch and a0~=aB then
return
end

if aA=="SatVib"then
UpdateSatVib(ay.UIElements.SatVibMap,ay,a0)
elseif aA=="Hue"then
UpdateHue(aQ,ay,a0)
elseif aA=="Transparency"then
UpdateTransparency(aY,ay,a0)
end
end)

TrackConnection(ay.UIElements.SatVibMap.InputBegan,function(a0)
if
a0.UserInputType~=Enum.UserInputType.MouseButton1
and a0.UserInputType~=Enum.UserInputType.Touch
then
return
end

if aw.CurrentInput and aw.CurrentInput~=aC then
return
end
if aA then
return
end

aw.CurrentInput=aC
aA="SatVib"
aB=a0

UpdateSatVib(ay.UIElements.SatVibMap,ay,a0)
end)

TrackConnection(aQ.InputBegan,function(a0)
if
a0.UserInputType~=Enum.UserInputType.MouseButton1
and a0.UserInputType~=Enum.UserInputType.Touch
then
return
end

if aw.CurrentInput and aw.CurrentInput~=aC then
return
end
if aA then
return
end

aw.CurrentInput=aC
aA="Hue"
aB=a0

UpdateHue(aQ,ay,a0)
end)

if aY then
TrackConnection(aY.InputBegan,function(a0)
if
a0.UserInputType~=Enum.UserInputType.MouseButton1
and a0.UserInputType~=Enum.UserInputType.Touch
then
return
end

if aw.CurrentInput and aw.CurrentInput~=aC then
return
end
if aA then
return
end

aw.CurrentInput=aC
aA="Transparency"
aB=a0

UpdateTransparency(aY,ay,a0)
end)
end

TrackConnection(ak.InputEnded,function(a0)
if not aB then
return
end

local a1=aB.UserInputType==Enum.UserInputType.Touch and a0==aB
local a2=aB.UserInputType==Enum.UserInputType.MouseButton1
and a0.UserInputType==Enum.UserInputType.MouseButton1
if not a1 and not a2 then
return
end

aA=nil
aB=nil
if aw.CurrentInput==aC then
aw.CurrentInput=nil
end
end)

return ay
end

function as.New(at,au)
local av={
__type="Colorpicker",
Title=au.Title or"Colorpicker",
Desc=au.Desc or nil,
Locked=au.Locked or false,
LockedTitle=au.LockedTitle,
Default=au.Default or Color3.new(1,1,1),
Callback=au.Callback or function()end,

UIScale=au.UIScale,
Transparency=au.Transparency,
UIElements={},

IsShowed=false,
}

local aw=true



av.ColorpickerFrame=a.load'K'{
Title=av.Title,
Desc=av.Desc,
Parent=au.Parent,
TextOffset=40,
Hover=false,
Tab=au.Tab,
Index=au.Index,
Window=au.Window,
ElementTable=av,
ParentConfig=au,
Tags=au.Tags,
}

av.UIElements.Colorpicker=aa.NewRoundFrame(as.UICorner,"Squircle",{
ImageTransparency=0,
Active=true,
ImageColor3=av.Default,
Parent=av.ColorpickerFrame.UIElements.Main,
Size=UDim2.new(0,26,0,26),
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,0,0,0),
ZIndex=2,
},{
aa.NewRoundFrame(as.UICorner,"SquircleGlass",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Outline",
},
ImageTransparency=0.55,
}),
},true)

function av.Lock(ax)
av.Locked=true
aw=false
return av.ColorpickerFrame:Lock(av.LockedTitle)
end
function av.Unlock(ax)
av.Locked=false
aw=true
return av.ColorpickerFrame:Unlock()
end

if av.Locked then
av:Lock()
end

function av.Update(ax,ay,az)
av.UIElements.Colorpicker.ImageTransparency=az or 0
av.UIElements.Colorpicker.ImageColor3=ay
av.Default=ay
if az then
av.Transparency=az
end
end

function av.Set(ax,ay,az)
return av:Update(ay,az)
end

aa.AddSignal(av.UIElements.Colorpicker.MouseButton1Click,function()
if aw and not av.IsShowed then
av.IsShowed=true

as:Colorpicker(av,au.Window,au.WindUI,function(ax,ay)
av:Update(ax,ay)
av.Default=ax
av.Transparency=ay
aa.SafeCallback(av.Callback,ax,ay)
end).ColorpickerFrame
:Open()
end
end)

return av.__type,av
end

return as end function a.aa()

local aa={}

function aa.ToFiniteNumber(af)
local ai=tonumber(af)
if ai==nil or ai~=ai or math.abs(ai)==math.huge then
return nil
end

return ai
end

function aa.FormatNumber(af)
if af%1==0 then
return tostring(af)
end

return tostring(tonumber(string.format("%.2f",af)))
end

function aa.NormalizeOptions(af)
local ai={}

for ak,al in next,af or{}do
local am
if typeof(al)=="table"then
local an=al.Value
if an==nil then
an=al.Id or al.Key or al.Title or al.Name or ak
end

am={
Title=tostring(al.Title or al.Name or an),
Desc=al.Desc,
Value=an,
Icon=al.Icon,
Disabled=al.Disabled==true,
}
else
am={
Title=tostring(al),
Value=al,
Disabled=false,
}
end

table.insert(ai,am)
end

return ai
end

function aa.FindOption(af,ai)
for ak,al in next,af or{}do
if al.Value==ai then
return al,ak
end
end

return nil,nil
end

function aa.ContainsValue(af,ai)
for ak,al in next,af or{}do
if al==ai then
return true
end
end

return false
end

function aa.CloneArray(af)
local ai={}
for ak,al in next,af or{}do
table.insert(ai,al)
end
return ai
end

function aa.NormalizeValues(af)
if af==nil then
return{}
end

if typeof(af)~="table"then
return{af}
end

return aa.CloneArray(af)
end

function aa.ToggleValue(af,ai)
local ak=aa.CloneArray(af)

for al,am in next,ak do
if am==ai then
table.remove(ak,al)
return ak,false
end
end

table.insert(ak,ai)
return ak,true
end

return aa end function a.ab()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'aa'

local al={}

local function GetControlWidth(am)
return math.max(ak.ToFiniteNumber(am.Width)or ak.ToFiniteNumber(am.ControlWidth)or 220,120)
end

function al.New(am,an)
local ao={
__type="RadioGroup",
Title=an.Title or"Radio Group",
Desc=an.Desc or nil,
Locked=an.Locked or false,
LockedTitle=an.LockedTitle,
Options=ak.NormalizeOptions(an.Options or an.Values or{}),
Value=an.Value,
AllowNone=an.AllowNone==true,
Callback=an.Callback or function()end,
UIElements={},
OptionFrames={},
Animation=an.Animation~=false,

Width=GetControlWidth(an),
}

if ao.Value==nil then
ao.Value=an.Default
end
if typeof(ao.Value)=="number"and ao.Options[ao.Value]then
ao.Value=ao.Options[ao.Value].Value
end
if ao.Value==nil and not ao.AllowNone and ao.Options[1]then
ao.Value=ao.Options[1].Value
end

local ap=true

ao.RadioGroupFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=ao.Width+14,
Hover=false,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.Options=ai("Frame",{
Name="RadioGroupOptions",
Size=UDim2.new(0,ao.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5),
BackgroundTransparency=1,
Parent=ao.RadioGroupFrame.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
HorizontalAlignment="Right",
SortOrder="LayoutOrder",
}),
})

local function UpdateOptionVisuals(aq)
for ar,as in next,ao.OptionFrames do
local at=as.Option.Value==ao.Value
local au=at and 0.84 or 0.94
local av=at and 0 or 1
local aw=as.Option.Disabled and 0.55 or(at and 0 or 0.18)

if aq and ao.Animation then
af.Play(as.Row,"Select",{ImageTransparency=au},nil,nil,"Select")
af.Play(as.Dot,"Select",{ImageTransparency=av},nil,nil,"Select")
af.Play(as.Title,"Select",{TextTransparency=aw},nil,nil,"Select")
else
as.Row.ImageTransparency=au
as.Dot.ImageTransparency=av
as.Title.TextTransparency=aw
end
end
end

local function CreateOption(aq,ar)
local as=aa.NewRoundFrame(99,"Circle",{
Name="Dot",
Size=UDim2.new(0,8,0,8),
ImageTransparency=1,
ThemeTag={
ImageColor3="RadioGroupActive",
},
})

local at=aa.NewRoundFrame(99,"CircleOutline",{
Name="Ring",
Size=UDim2.new(0,18,0,18),
ImageTransparency=aq.Disabled and 0.75 or 0.45,
ThemeTag={
ImageColor3="RadioGroupBorder",
},
},{
as,
})
as.Position=UDim2.new(0.5,0,0.5,0)
as.AnchorPoint=Vector2.new(0.5,0.5)

local au=ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,-28,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=aq.Title,
TextSize=14,
TextWrapped=true,
TextXAlignment="Left",
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="RadioGroupText",
},
})

local av=aa.NewRoundFrame(12,"Squircle",{
Name="Option",
Size=UDim2.new(1,0,0,36),
LayoutOrder=ar,
ImageTransparency=0.94,
Active=not aq.Disabled,
ThemeTag={
ImageColor3="RadioGroupBackground",
},
},{
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
at,
au,
},true)

av.Parent=ao.UIElements.Options

local aw={
Row=av,
Ring=at,
Dot=as,
Title=au,
Option=aq,
}
ao.OptionFrames[ar]=aw

af.AttachPress(av,aa,{
Enabled=function()
return ao.Animation and not ao.Locked and not aq.Disabled
end,
})

aa.AddSignal(av.MouseButton1Click,function()
if not aq.Disabled then
ao:Select(aq.Value)
end
end)
end

local function RenderOptions()
for aq,ar in next,ao.OptionFrames do
if ar.Row then
ar.Row:Destroy()
end
end

ao.OptionFrames={}

for aq,ar in next,ao.Options do
CreateOption(ar,aq)
end

UpdateOptionVisuals(false)
end

function ao.Lock(aq)
ao.Locked=true
ap=false
return ao.RadioGroupFrame:Lock(ao.LockedTitle)
end
function ao.Unlock(aq)
ao.Locked=false
ap=true
return ao.RadioGroupFrame:Unlock()
end

function ao.Get(aq)
return ao.Value
end

function ao.Select(aq,ar,as)
local at=ak.FindOption(ao.Options,ar)
if not at and not ao.AllowNone then
return ao.Value
end
if at and at.Disabled then
return ao.Value
end

ao.Value=ar
UpdateOptionVisuals(true)

if ap and as~=false then
aa.SafeCallback(ao.Callback,ar,at)
end

return ao.Value
end

function ao.SetOptions(aq,ar)
ao.Options=ak.NormalizeOptions(ar)

if not ak.FindOption(ao.Options,ao.Value)then
ao.Value=ao.AllowNone and nil or(ao.Options[1]and ao.Options[1].Value)
end

RenderOptions()
return ao.Options
end

RenderOptions()

if ao.Locked then
ao:Lock()
end

return ao.__type,ao
end

return al end function a.ac()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'aa'

local al={}

local function GetControlWidth(am)
return math.max(ak.ToFiniteNumber(am.Width)or ak.ToFiniteNumber(am.ControlWidth)or 220,120)
end

function al.New(am,an)
local ao={
__type="CheckboxGroup",
Title=an.Title or"Checkbox Group",
Desc=an.Desc or nil,
Locked=an.Locked or false,
LockedTitle=an.LockedTitle,
Options=ak.NormalizeOptions(an.Options or an.Values or{}),
Values=ak.NormalizeValues(an.ValuesSelected or an.SelectedValues or an.Value or an.ValuesDefault),
Callback=an.Callback or function()end,
UIElements={},
OptionFrames={},
Animation=an.Animation~=false,

Width=GetControlWidth(an),
}

local ap=true

ao.CheckboxGroupFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=ao.Width+14,
Hover=false,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.Options=ai("Frame",{
Name="CheckboxGroupOptions",
Size=UDim2.new(0,ao.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5),
BackgroundTransparency=1,
Parent=ao.CheckboxGroupFrame.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
HorizontalAlignment="Right",
SortOrder="LayoutOrder",
}),
})

local function SanitizeValues(aq)
local ar={}

for as,at in next,aq or{}do
local au=ak.FindOption(ao.Options,at)
if au and not au.Disabled and not ak.ContainsValue(ar,at)then
table.insert(ar,at)
end
end

return ar
end

local function UpdateOptionVisuals(aq)
for ar,as in next,ao.OptionFrames do
local at=ak.ContainsValue(ao.Values,as.Option.Value)
local au=at and 0.84 or 0.94
local av=at and 0 or 1
local aw=at and 0 or 1
local ax=as.Option.Disabled and 0.55 or(at and 0 or 0.18)

if aq and ao.Animation then
af.Play(as.Row,"Select",{ImageTransparency=au},nil,nil,"Select")
af.Play(as.Fill,"Select",{ImageTransparency=av},nil,nil,"Select")
af.Play(as.Icon,"Select",{ImageTransparency=aw},nil,nil,"Select")
af.Play(as.Title,"Select",{TextTransparency=ax},nil,nil,"Select")
else
as.Row.ImageTransparency=au
as.Fill.ImageTransparency=av
as.Icon.ImageTransparency=aw
as.Title.TextTransparency=ax
end
end
end

local function CreateOption(aq,ar)
local as=aa.Icon"check"
local at=ai("ImageLabel",{
Name="Check",
Size=UDim2.new(0,12,0,12),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Image=as[1],
ImageRectOffset=as[2].ImageRectPosition,
ImageRectSize=as[2].ImageRectSize,
ImageTransparency=1,
ThemeTag={
ImageColor3="CheckboxGroupIcon",
},
})

local au=aa.NewRoundFrame(5,"Squircle",{
Name="Fill",
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ThemeTag={
ImageColor3="CheckboxGroupActive",
},
},{
at,
})

local av=aa.NewRoundFrame(5,"SquircleOutline",{
Name="Box",
Size=UDim2.new(0,18,0,18),
ImageTransparency=aq.Disabled and 0.75 or 0.45,
ThemeTag={
ImageColor3="CheckboxGroupBorder",
},
},{
au,
})

local aw=ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,-28,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=aq.Title,
TextSize=14,
TextWrapped=true,
TextXAlignment="Left",
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="CheckboxGroupText",
},
})

local ax=aa.NewRoundFrame(12,"Squircle",{
Name="Option",
Size=UDim2.new(1,0,0,36),
LayoutOrder=ar,
ImageTransparency=0.94,
Active=not aq.Disabled,
ThemeTag={
ImageColor3="CheckboxGroupBackground",
},
},{
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
av,
aw,
},true)

ax.Parent=ao.UIElements.Options

local ay={
Row=ax,
Fill=au,
Icon=at,
Title=aw,
Option=aq,
}
ao.OptionFrames[ar]=ay

af.AttachPress(ax,aa,{
Enabled=function()
return ao.Animation and not ao.Locked and not aq.Disabled
end,
})

aa.AddSignal(ax.MouseButton1Click,function()
if not aq.Disabled then
ao:Toggle(aq.Value)
end
end)
end

local function RenderOptions()
for aq,ar in next,ao.OptionFrames do
if ar.Row then
ar.Row:Destroy()
end
end

ao.OptionFrames={}

for aq,ar in next,ao.Options do
CreateOption(ar,aq)
end

ao.Values=SanitizeValues(ao.Values)
UpdateOptionVisuals(false)
end

function ao.Lock(aq)
ao.Locked=true
ap=false
return ao.CheckboxGroupFrame:Lock(ao.LockedTitle)
end
function ao.Unlock(aq)
ao.Locked=false
ap=true
return ao.CheckboxGroupFrame:Unlock()
end

function ao.Get(aq)
return ak.CloneArray(ao.Values)
end

function ao.Set(aq,ar,as)
ao.Values=SanitizeValues(ak.NormalizeValues(ar))
UpdateOptionVisuals(true)

if ap and as~=false then
aa.SafeCallback(ao.Callback,ao:Get())
end

return ao:Get()
end

function ao.Toggle(aq,ar,as)
local at=ak.FindOption(ao.Options,ar)
if not at or at.Disabled then
return ao:Get()
end

ao.Values=ak.ToggleValue(ao.Values,ar)
return ao:Set(ao.Values,as)
end

function ao.SetOptions(aq,ar)
ao.Options=ak.NormalizeOptions(ar)
RenderOptions()
return ao.Options
end

RenderOptions()

if ao.Locked then
ao:Lock()
end

return ao.__type,ao
end

return al end function a.ad()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'aa'

local al={}

local function GetControlWidth(am)
return math.max(ak.ToFiniteNumber(am.Width)or ak.ToFiniteNumber(am.ControlWidth)or 220,120)
end

function al.New(am,an)
local ao={
__type="SegmentedControl",
Title=an.Title or"Segmented Control",
Desc=an.Desc or nil,
Locked=an.Locked or false,
LockedTitle=an.LockedTitle,
Options=ak.NormalizeOptions(an.Options or an.Values or{}),


Value=an.Value,
Callback=an.Callback or function()end,
UIElements={},
Segments={},
Animation=an.Animation~=false,

Width=GetControlWidth(an),
}

if ao.Value==nil then
ao.Value=an.Default
end
if typeof(ao.Value)=="number"and ao.Options[ao.Value]then
ao.Value=ao.Options[ao.Value].Value
end
if ao.Value==nil and ao.Options[1]then
ao.Value=ao.Options[1].Value
end

local ap=true

ao.SegmentedControlFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=ao.Width+14,
Hover=false,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.Container=aa.NewRoundFrame(13,"Squircle",{
Name="SegmentedControl",
Size=UDim2.new(0,ao.Width,0,36),
Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5),
ImageTransparency=0.93,
ThemeTag={
ImageColor3="SegmentedControlBackground",
},
Parent=ao.SegmentedControlFrame.UIElements.Main,
},{
ai("UIPadding",{
PaddingTop=UDim.new(0,4),
PaddingLeft=UDim.new(0,4),
PaddingRight=UDim.new(0,4),
PaddingBottom=UDim.new(0,4),
}),
})

local function UpdateSegmentVisuals(aq)
for ar,as in next,ao.Segments do
local at=as.Option.Value==ao.Value
local au=at and 0.82 or 1
local av=as.Option.Disabled and 0.55 or(at and 0 or 0.25)

if aq and ao.Animation then
af.Play(
as.Button,
"Select",
{ImageTransparency=au},
nil,
nil,
"Select"
)
af.Play(as.Title,"Select",{TextTransparency=av},nil,nil,"Select")
else
as.Button.ImageTransparency=au
as.Title.TextTransparency=av
end
end
end

local aq=24




local function SegmentWidthFor(ar,as)
local at=ao.Width-8-(as*math.max(ar-1,0))
local au=at/math.max(ar,1)
if au<aq then
return aq,true
end
return au,false
end

local function CreateSegment(ar,as,at)
local au=4
local av=SegmentWidthFor(at,au)

local aw=ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,-10,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Text=ar.Title,
TextSize=13,
TextTruncate="AtEnd",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="SegmentedControlText",
},
})

local ax=aa.NewRoundFrame(10,"Squircle",{
Name="Segment",
Size=UDim2.new(0,av,1,0),



Position=UDim2.new(0,(as-1)*(av+au),0,0),
ImageTransparency=1,
Active=not ar.Disabled,
ThemeTag={
ImageColor3="SegmentedControlActive",
},
},{
aw,
},true)

ax.Parent=ao.UIElements.Container

local ay={
Button=ax,
Title=aw,
Option=ar,
}
ao.Segments[as]=ay

af.AttachPress(ax,aa,{
Amount=0.96,
Enabled=function()
return ao.Animation and not ao.Locked and not ar.Disabled
end,
})

aa.AddSignal(ax.MouseButton1Click,function()
if not ar.Disabled then
ao:Select(ar.Value)
end
end)
end

local function RenderSegments()
for ar,as in next,ao.Segments do
if as.Button then
as.Button:Destroy()
end
end

ao.Segments={}

local ar=#ao.Options
for as,at in next,ao.Options do
CreateSegment(at,as,ar)
end local



as, at=SegmentWidthFor(ar,4)
ao.UIElements.Container.ClipsDescendants=at

UpdateSegmentVisuals(false)
end

function ao.Lock(ar)
ao.Locked=true
ap=false
return ao.SegmentedControlFrame:Lock(ao.LockedTitle)
end
function ao.Unlock(ar)
ao.Locked=false
ap=true
return ao.SegmentedControlFrame:Unlock()
end

function ao.Get(ar)
return ao.Value
end

function ao.Select(ar,as,at)
local au=ak.FindOption(ao.Options,as)
if not au or au.Disabled then
return ao.Value
end

ao.Value=as
UpdateSegmentVisuals(true)

if ap and at~=false then
aa.SafeCallback(ao.Callback,as,au)
end

return ao.Value
end

function ao.SetOptions(ar,as)
ao.Options=ak.NormalizeOptions(as)

if not ak.FindOption(ao.Options,ao.Value)then


local at=ao.Options[1]
ao.Value=if at then at.Value else nil
end

RenderSegments()
return ao.Options
end

RenderSegments()

if ao.Locked then
ao:Lock()
end

return ao.__type,ao
end

return al end function a.ae()

local aa=a.load'e'

local af=a.load'p'.New

local ai={}

function ai.New(ak,al)
local am={
__type="TextArea",
Title=al.Title or"Text Area",
Desc=al.Desc or nil,
Locked=al.Locked or false,
LockedTitle=al.LockedTitle,
InputIcon=al.InputIcon or false,
Placeholder=al.Placeholder or"Enter Text...",
Value=al.Value or"",
Callback=al.Callback or function()end,
ClearTextOnFocus=al.ClearTextOnFocus or false,
UIElements={},
}

local an=true

am.TextAreaFrame=a.load'K'{
Title=am.Title,
Desc=am.Desc,
Parent=al.Parent,
TextOffset=0,
Hover=false,
Tab=al.Tab,
Index=al.Index,
Window=al.Window,
ElementTable=am,
ParentConfig=al,
Tags=al.Tags,
}

local ao=af(
am.Placeholder,
am.InputIcon,
am.TextAreaFrame.UIElements.Container,
"Textarea",
function(ao)
am:Set(ao,true,true)
end,
nil,
al.Window.NewElements and 12 or 10,
am.ClearTextOnFocus
)
ao.Size=UDim2.new(1,0,0,al.Height or 148)
ao.LayoutOrder=99

local ap=ao.Frame.Frame.TextBox

function am.Lock(aq)
am.Locked=true
an=false
return am.TextAreaFrame:Lock(am.LockedTitle)
end
function am.Unlock(aq)
am.Locked=false
an=true
return am.TextAreaFrame:Unlock()
end

function am.Get(aq)
return am.Value
end

function am.Set(aq,ar,as,at)
if not an then
return am.Value
end

am.Value=tostring(ar or"")

if not at then
ap.Text=am.Value
end

if as~=false then
aa.SafeCallback(am.Callback,am.Value)
end

return am.Value
end

function am.SetPlaceholder(aq,ar)
am.Placeholder=tostring(ar or"")
ap.PlaceholderText=am.Placeholder
end

am:Set(am.Value,false)

if am.Locked then
am:Lock()
end

return am.__type,am
end

return ai end function a.af()

local aa=a.load'a'

local af=aa(game:GetService"UserInputService")

local ai=a.load'e'
local ak=a.load'f'
local al=ai.New

local am=a.load'aa'

local an={}

local function ReadValueConfig(ao)
local ap=typeof(ao.Value)=="table"and ao.Value or{}
local aq=am.ToFiniteNumber(ap.Min)or am.ToFiniteNumber(ao.Min)or 0
local ar=am.ToFiniteNumber(ap.Max)or am.ToFiniteNumber(ao.Max)or 100

if aq>ar then
aq,ar=ar,aq
end

local as=typeof(ao.Value)=="number"and ao.Value
or am.ToFiniteNumber(ap.Default)
or am.ToFiniteNumber(ao.Default)
or aq
local at=am.ToFiniteNumber(ap.Increment)or am.ToFiniteNumber(ao.Increment)or 1

return aq,ar,math.clamp(am.ToFiniteNumber(as)or aq,aq,ar),math.max(math.abs(at),0.0001)
end

function an.New(ao,ap)
local aq,ar,as,at=ReadValueConfig(ap)
local au=af.TouchEnabled and not af.KeyboardEnabled
local av=ap.Buttons~=false and ap.ShowButtons~=false
local aw=au and 38 or 34
local ax=au and 40 or 36
local ay=av and 164 or 128

local az={
__type="Stepper",
Title=ap.Title or"Stepper",
Desc=ap.Desc or nil,
Locked=ap.Locked or false,
LockedTitle=ap.LockedTitle,
Value={
Min=aq,
Max=ar,
Default=as,
Increment=at,
},
Callback=ap.Callback or function()end,
Format=ap.Format,
UIElements={},
Animation=ap.Animation~=false,
Draggable=ap.Draggable~=false,
ShowButtons=av,
Width=math.max(
am.ToFiniteNumber(ap.Width)or am.ToFiniteNumber(ap.ControlWidth)or(au and 188 or 176),
ay
),
}

local aA=true

az.StepperFrame=a.load'K'{
Title=az.Title,
Desc=az.Desc,
Parent=ap.Parent,
TextOffset=az.Width+14,
Hover=false,
Tab=ap.Tab,
Index=ap.Index,
Window=ap.Window,
ElementTable=az,
ParentConfig=ap,
Tags=ap.Tags,
}

local function FormatValue(aB)
if typeof(az.Format)=="function"then
local aC,aD=pcall(az.Format,aB,az.Value.Min,az.Value.Max)
if aC and aD~=nil then
return tostring(aD)
end
end

return am.FormatNumber(aB)
end

local function GetRange()
return math.max(az.Value.Max-az.Value.Min,az.Value.Increment)
end

local function SnapValue(aB)
local aC=am.ToFiniteNumber(aB)
if aC==nil then
return az.Value.Default
end

local aD=math.floor(((aC-az.Value.Min)/az.Value.Increment)+0.5)
local aE=az.Value.Min+(aD*az.Value.Increment)
return math.clamp(aE,az.Value.Min,az.Value.Max)
end

local function ValueToDelta(aB)
return math.clamp((aB-az.Value.Min)/GetRange(),0,1)
end

local function CreateIconButton(aB,aC)
local aD=ai.Icon(aC)
local aE=al("ImageLabel",{
Name="Icon",
Size=UDim2.new(0,16,0,16),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Image=aD[1],
ImageRectOffset=aD[2].ImageRectPosition,
ImageRectSize=aD[2].ImageRectSize,
ThemeTag={
ImageColor3="StepperIcon",
},
})

local aF=ai.NewRoundFrame(12,"Squircle",{
Name=aB,
Size=UDim2.fromOffset(aw,aw),
ImageTransparency=0.88,
ThemeTag={
ImageColor3="StepperButton",
},
},{
aE,
},true)

return aF,aE
end

local aB,aC
local aD,aE
if az.ShowButtons then
aB,aC=CreateIconButton("Minus","minus")
aD,aE=CreateIconButton("Plus","plus")

ak.AttachPress(aB,ai,{
Amount=0.94,
Enabled=function()
return az.Animation and not az.Locked and az.Value.Default>az.Value.Min
end,
})
ak.AttachPress(aD,ai,{
Amount=0.94,
Enabled=function()
return az.Animation and not az.Locked and az.Value.Default<az.Value.Max
end,
})
end

local aF=ai.NewRoundFrame(999,"Squircle",{
Name="Fill",
Size=UDim2.new(ValueToDelta(az.Value.Default),0,1,0),
ImageTransparency=0.12,
ThemeTag={
ImageColor3="Primary",
},
})

local aG=ai.NewRoundFrame(999,"Squircle",{
Name="Thumb",
Size=UDim2.fromOffset(9,9),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(ValueToDelta(az.Value.Default),0,0.5,0),
ImageTransparency=0,
ThemeTag={
ImageColor3="SliderThumb",
},
})

local aH=ai.NewRoundFrame(999,"Squircle",{
Name="Track",
Size=UDim2.new(1,-18,0,4),
Position=UDim2.new(0.5,0,1,-7),
AnchorPoint=Vector2.new(0.5,1),
ImageTransparency=0.88,
ThemeTag={
ImageColor3="Text",
},
},{
aF,
aG,
})

az.UIElements.ValueLabel=al("TextLabel",{
Name="Value",
Size=UDim2.new(1,-18,1,-10),
Position=UDim2.new(0.5,0,0,1),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=1,
Text=FormatValue(az.Value.Default),
TextSize=au and 15 or 14,
TextTruncate="AtEnd",
FontFace=Font.new(ai.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="StepperText",
},
})

local aI=az.ShowButtons and((aw*2)+10)or 0
local aJ=ai.NewRoundFrame(12,"Squircle",{
Name="ValueBackground",
Size=UDim2.new(1,-aI,0,ax),
ImageTransparency=0.92,
Active=true,
ClipsDescendants=true,
ThemeTag={
ImageColor3="StepperValueBackground",
},
},{
az.UIElements.ValueLabel,
aH,
},true)

az.UIElements.Track=aH
az.UIElements.TrackFill=aF
az.UIElements.TrackThumb=aG
az.UIElements.ValueBackground=aJ

az.UIElements.Container=al("Frame",{
Name="Stepper",
Size=UDim2.new(0,az.Width,0,ax),
Position=UDim2.new(1,0,ap.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,ap.Window.NewElements and 0 or 0.5),
BackgroundTransparency=1,
Parent=az.StepperFrame.UIElements.Main,
},{
al("UIListLayout",{
Padding=UDim.new(0,5),
FillDirection="Horizontal",
HorizontalAlignment="Right",
VerticalAlignment="Center",
}),
aB,
aJ,
aD,
})

local function SetProgressVisual(aK,aL)
local aM=ValueToDelta(aK)
local aN=UDim2.new(aM,0,1,0)
local aO=UDim2.new(aM,0,0.5,0)

if aL and az.Animation then
ak.Play(aF,"Fast",{Size=aN},nil,nil,"StepperFill")
ak.Play(aG,"Fast",{Position=aO},nil,nil,"StepperThumb")
else
aF.Size=aN
aG.Position=aO
end
end

local function UpdateButtonStates(aK)
if not az.ShowButtons then
return
end

local aL=az.Value.Default<=az.Value.Min
local aM=az.Value.Default>=az.Value.Max
local aN=aL and 0.62 or 0
local aO=aM and 0.62 or 0
local aP=aL and 0.94 or 0.88
local aQ=aM and 0.94 or 0.88

if aK and az.Animation then
ak.Play(aC,"Fast",{ImageTransparency=aN},nil,nil,"State")
ak.Play(aE,"Fast",{ImageTransparency=aO},nil,nil,"State")
ak.Play(aB,"Fast",{ImageTransparency=aP},nil,nil,"State")
ak.Play(aD,"Fast",{ImageTransparency=aQ},nil,nil,"State")
else
aC.ImageTransparency=aN
aE.ImageTransparency=aO
aB.ImageTransparency=aP
aD.ImageTransparency=aQ
end
end

local function UpdateValue(aK,aL,aM)
local aN=am.ToFiniteNumber(aK)
if aN==nil then
return az.Value.Default
end

local aO=az.Value.Default
az.Value.Default=aM==false and math.clamp(aN,az.Value.Min,az.Value.Max)
or SnapValue(aN)
az.UIElements.ValueLabel.Text=FormatValue(az.Value.Default)
SetProgressVisual(az.Value.Default,true)
UpdateButtonStates(true)

if az.Animation and aO~=az.Value.Default then
ak.Play(aJ,"Fast",{ImageTransparency=0.86},nil,nil,"Pulse")
task.delay(ak.GetDuration"Fast",function()
if aJ.Parent then
ak.Play(aJ,"Select",{ImageTransparency=0.92},nil,nil,"Pulse")
end
end)
end

if aA and aL~=false and aO~=az.Value.Default then
ai.SafeCallback(az.Callback,az.Value.Default)
end

return az.Value.Default
end

function az.Lock(aK)
az.Locked=true
aA=false
UpdateButtonStates(true)
return az.StepperFrame:Lock(az.LockedTitle)
end
function az.Unlock(aK)
az.Locked=false
aA=true
UpdateButtonStates(true)
return az.StepperFrame:Unlock()
end

function az.Get(aK)
return az.Value.Default
end

function az.Set(aK,aL,aM)
return UpdateValue(aL,aM)
end

function az.SetRange(aK,aL,aM)
aL=am.ToFiniteNumber(aL)
aM=am.ToFiniteNumber(aM)

if aL==nil or aM==nil then
return az.Value.Min,az.Value.Max
end

if aL>aM then
aL,aM=aM,aL
end

az.Value.Min=aL
az.Value.Max=aM
UpdateValue(az.Value.Default,false)

return az.Value.Min,az.Value.Max
end

function az.SetMin(aK,aL)
az:SetRange(aL,math.max(am.ToFiniteNumber(aL)or az.Value.Min,az.Value.Max))
return az.Value.Min
end

function az.SetMax(aK,aL)
az:SetRange(math.min(az.Value.Min,am.ToFiniteNumber(aL)or az.Value.Max),aL)
return az.Value.Max
end

local aK=ap.WindUI.GenerateGUID()
local aL
local aM
local aN
local aO=ap.Tab and ap.Tab.UIElements and ap.Tab.UIElements.ContainerFrame

local function DisconnectDrag()
local aP=aL~=nil
or aM~=nil
or aN~=nil
or ap.WindUI.CurrentInput==aK

if aM then
ai.DisconnectSignal(aM)
aM=nil
end
if aN then
ai.DisconnectSignal(aN)
aN=nil
end
if aP and aO then
aO.ScrollingEnabled=true
end
if ap.WindUI.CurrentInput==aK then
ap.WindUI.CurrentInput=nil
end
aL=nil
if aP and az.Animation then
ak.Play(aG,"Focus",{Size=UDim2.fromOffset(9,9)},nil,nil,"StepperDrag")
end
end

local function GetInputX(aP)
if aP.UserInputType==Enum.UserInputType.Touch then
return aP.Position.X
end
return af:GetMouseLocation().X
end

local function UpdateFromInput(aP)
if not aH or aH.AbsoluteSize.X<=0 then
return
end

local aQ=math.clamp((GetInputX(aP)-aH.AbsolutePosition.X)/aH.AbsoluteSize.X,0,1)
local aR=az.Value.Min+(aQ*GetRange())
UpdateValue(aR,true)
end

if az.ShowButtons then
ai.AddSignal(aB.MouseButton1Click,function()
if not az.Locked then
az:Set(az.Value.Default-az.Value.Increment)
end
end)
ai.AddSignal(aD.MouseButton1Click,function()
if not az.Locked then
az:Set(az.Value.Default+az.Value.Increment)
end
end)
end

ai.AddSignal(aJ.InputBegan,function(aP)
if az.Locked or not az.Draggable or aL then
return
end
if
aP.UserInputType~=Enum.UserInputType.MouseButton1
and aP.UserInputType~=Enum.UserInputType.Touch
then
return
end
if ap.WindUI.CurrentInput and ap.WindUI.CurrentInput~=aK then
return
end

ap.WindUI.CurrentInput=aK
aL=aP
if aO then
aO.ScrollingEnabled=false
end
if az.Animation then
ak.Play(aG,"Focus",{Size=UDim2.fromOffset(13,13)},nil,nil,"StepperDrag")
end
UpdateFromInput(aP)

aM=ai.AddSignal(af.InputChanged,function(aQ)
if not aL then
return
end
if aL.UserInputType==Enum.UserInputType.Touch and aQ~=aL then
return
end
if
aL.UserInputType==Enum.UserInputType.MouseButton1
and aQ.UserInputType~=Enum.UserInputType.MouseMovement
then
return
end
UpdateFromInput(aQ)
end)

aN=ai.AddSignal(af.InputEnded,function(aQ)
if not aL then
return
end
local aR=aL.UserInputType==Enum.UserInputType.Touch and aQ==aL
local aS=aL.UserInputType==Enum.UserInputType.MouseButton1
and aQ.UserInputType==Enum.UserInputType.MouseButton1
if aR or aS then
DisconnectDrag()
end
end)
end)

function az.Cleanup(aP)
DisconnectDrag()
end

UpdateButtonStates(false)
SetProgressVisual(az.Value.Default,false)

if az.Locked then
az:Lock()
end

return az.__type,az
end

return an end function a.ag()

local aa={}

local af={
Info={
Icon="info",
Color=Color3.fromHex"#2563eb",
},
Success={
Icon="circle-check",
Color=Color3.fromHex"#16a34a",
},
Warning={
Icon="triangle-alert",
Color=Color3.fromHex"#d97706",
},
Error={
Icon="circle-x",
Color=Color3.fromHex"#dc2626",
},
}

function aa.New(ai,ak)
local al=ak.Variant or"Info"
local am=af[al]or af.Info

local an={
__type="Callout",
Title=ak.Title or al,
Desc=ak.Desc or ak.Content,
Icon=ak.Icon or am.Icon,
Variant=al,
Color=ak.Color or am.Color,
UIElements={},
}

an.CalloutFrame=a.load'K'{
Title=an.Title,
Desc=an.Desc,
Image=an.Icon,
IconThemed=ak.IconThemed,
Color=an.Color,
Parent=ak.Parent,
TextOffset=0,
Hover=ak.Hover==true,
Tab=ak.Tab,
Index=ak.Index,
Window=ak.Window,
ElementTable=an,
ParentConfig=ak,
Tags=ak.Tags,
Size=ak.Size,
}

return an.__type,an
end

return aa end function a.ah()

local aa={}

aa.Variants={
Info={
Icon="info",
Color=Color3.fromHex"#2563eb",
},
Success={
Icon="circle-check",
Color=Color3.fromHex"#16a34a",
},
Warning={
Icon="triangle-alert",
Color=Color3.fromHex"#d97706",
},
Error={
Icon="circle-x",
Color=Color3.fromHex"#dc2626",
},
Neutral={
Icon="circle",
Color=Color3.fromHex"#71717a",
},
}

function aa.ToFiniteNumber(af)
local ai=tonumber(af)
if ai==nil or ai~=ai or math.abs(ai)==math.huge then
return nil
end

return ai
end

function aa.GetVariant(af)
return aa.Variants[af or"Info"]or aa.Variants.Info
end

function aa.GetColor(af,ai)
if typeof(af)=="Color3"then
return af
end
if typeof(af)=="string"and string.sub(af,1,1)=="#"then
return Color3.fromHex(af)
end
return ai
end

function aa.NormalizeItems(af,ai,ak)
local al={}

for am,an in next,af or{}do
if typeof(an)=="table"then
local ao=an[ak or"Value"]
if ao==nil then
ao=an.Id or an.Key or an.Title or an.Name or am
end

table.insert(al,{
Title=tostring(an[ai or"Title"]or an.Name or ao),
Desc=an.Desc or an.Content,
Value=ao,
Icon=an.Icon,
Color=an.Color,
Disabled=an.Disabled==true,
Items=an.Items,
})
else
table.insert(al,{
Title=tostring(an),
Value=an,
Disabled=false,
})
end
end

return al
end

function aa.CloneArray(af)
local ai={}
for ak,al in next,af or{}do
table.insert(ai,al)
end
return ai
end

function aa.NormalizeValues(af)
if af==nil then
return{}
end
if typeof(af)~="table"then
return{af}
end
return aa.CloneArray(af)
end

function aa.ContainsValue(af,ai)
for ak,al in next,af or{}do
if al==ai then
return true
end
end
return false
end

function aa.ToggleValue(af,ai)
local ak=aa.CloneArray(af)

for al,am in next,ak do
if am==ai then
table.remove(ak,al)
return ak,false
end
end

table.insert(ak,ai)
return ak,true
end

function aa.CreateIcon(af,ai,ak,al,am,an)
if not ai or ai==""then
return nil
end

local ao=af.Image(ai,ai,0,ak,al or"Element",am~=false,true,an)
ao.Size=UDim2.new(0,18,0,18)
return ao
end

function aa.GetImageTarget(af)
if typeof(af)~="Instance"then
return nil
end

if af:IsA"ImageLabel"or af:IsA"ImageButton"then
return af
end

return af:FindFirstChildWhichIsA"ImageLabel"or af:FindFirstChildWhichIsA"ImageButton"
end

function aa.CreateText(af,ai,ak,al,am,an)
return af("TextLabel",{
BackgroundTransparency=1,
Text=tostring(ak or""),
TextSize=al or 14,
TextTransparency=an or 0,
TextWrapped=true,
TextXAlignment="Left",
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(ai.Font,am or Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})
end

return aa end function a.ai()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

function al.New(am,an)
local ao=an.Variant or"Info"
local ap=ak.GetVariant(ao)
local aq={
__type="Badge",
Title=an.Title or"Badge",
Desc=an.Desc or nil,
Value=an.Value or an.Badge or ao,
Variant=ao,
Color=ak.GetColor(an.Color,ap.Color),
Icon=an.Icon or ap.Icon,
Callback=an.Callback,
UIElements={},

Width=math.max(ak.ToFiniteNumber(an.Width)or 96,72),
}

aq.BadgeFrame=a.load'K'{
Title=aq.Title,
Desc=aq.Desc,
Parent=an.Parent,
TextOffset=aq.Width+14,
Hover=an.Hover==true or aq.Callback~=nil,
Scalable=aq.Callback~=nil,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=aq,
ParentConfig=an,
Tags=an.Tags,
}

local ar=ak.CreateIcon(aa,aq.Icon,an.Window.Folder,"Badge",false,"BadgeIcon")
if ar then
ar.ImageLabel.ImageColor3=Color3.new(1,1,1)
ar.ImageLabel.ImageTransparency=0
ar.Size=UDim2.new(0,14,0,14)
end

aq.UIElements.Label=ai("TextLabel",{
Name="Label",
BackgroundTransparency=1,
Text=tostring(aq.Value),
TextSize=13,
TextTruncate="AtEnd",
TextXAlignment="Center",
Size=UDim2.new(1,ar and-20 or 0,1,0),
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
TextColor3=Color3.new(1,1,1),
})

aq.UIElements.Pill=aa.NewRoundFrame(999,"Squircle",{
Name="Badge",
Size=UDim2.new(0,aq.Width,0,28),
Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5),
ImageTransparency=0,
ImageColor3=aq.Color,
Parent=aq.BadgeFrame.UIElements.Main,
},{
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
ar,
aq.UIElements.Label,
})

function aq.SetValue(as,at)
aq.Value=at
aq.UIElements.Label.Text=tostring(at or"")
af.Play(aq.UIElements.Pill,"Fast",{ImageTransparency=0.08},nil,nil,"Pulse")
task.delay(af.GetDuration"Fast",function()
if aq.UIElements.Pill.Parent then
af.Play(aq.UIElements.Pill,"Select",{ImageTransparency=0},nil,nil,"Pulse")
end
end)
return aq.Value
end

function aq.SetVariant(as,at)
local au=ak.GetVariant(at)
aq.Variant=at
aq.Color=au.Color
af.Play(aq.UIElements.Pill,"Select",{ImageColor3=aq.Color},nil,nil,"Variant")
return aq.Variant
end

if aq.Callback then
aa.AddSignal(aq.BadgeFrame.UIElements.Main.MouseButton1Click,function()
aa.SafeCallback(aq.Callback,aq.Value)
end)
end

return aq.__type,aq
end

return al end function a.aj()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

function al.New(am,an)
local ao=an.Status or an.Variant or"Info"
local ap=ak.GetVariant(ao)
local aq={
__type="StatusCard",
Title=an.Title or"Status",
Desc=an.Desc or an.Content,
Value=an.Value or ao,
Status=ao,
Color=ak.GetColor(an.Color,ap.Color),
Callback=an.Callback,
UIElements={},

Width=math.max(ak.ToFiniteNumber(an.Width)or 136,96),
}

aq.StatusCardFrame=a.load'K'{
Title=aq.Title,
Desc=aq.Desc,
Parent=an.Parent,
TextOffset=aq.Width+14,
Hover=an.Hover==true or aq.Callback~=nil,
Scalable=aq.Callback~=nil,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=aq,
ParentConfig=an,
Tags=an.Tags,
}

aq.UIElements.Dot=aa.NewRoundFrame(999,"Circle",{
Name="Dot",
Size=UDim2.new(0,10,0,10),
ImageColor3=aq.Color,
})

aq.UIElements.Value=ai("TextLabel",{
Name="Value",
BackgroundTransparency=1,
Text=tostring(aq.Value),
TextSize=14,
TextTransparency=0.08,
TextTruncate="AtEnd",
AutomaticSize="Y",
Size=UDim2.new(1,-18,0,0),
TextXAlignment="Left",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
})

aq.UIElements.Status=ai("Frame",{
Name="StatusCard",
Size=UDim2.new(0,aq.Width,0,34),
Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5),
BackgroundTransparency=1,
Parent=aq.StatusCardFrame.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Right",
}),
aq.UIElements.Dot,
aq.UIElements.Value,
})

function aq.SetValue(ar,as)
aq.Value=as
aq.UIElements.Value.Text=tostring(as or"")
return aq.Value
end

function aq.SetStatus(ar,as,at)
local au=ak.GetVariant(as)
aq.Status=as
aq.Color=au.Color
if at~=nil then
aq:SetValue(at)
end
af.Play(aq.UIElements.Dot,"Select",{ImageColor3=aq.Color},nil,nil,"Status")
return aq.Status
end

if aq.Callback then
aa.AddSignal(aq.StatusCardFrame.UIElements.Main.MouseButton1Click,function()
aa.SafeCallback(aq.Callback,aq.Status,aq.Value)
end)
end

return aq.__type,aq
end

return al end function a.ak()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local function GetTrendColor(am)
if am=="Down"or am=="Negative"then
return Color3.fromHex"#dc2626"
end
if am=="Neutral"then
return Color3.fromHex"#71717a"
end
return Color3.fromHex"#16a34a"
end

function al.New(am,an)
local ao={
__type="StatCard",
Title=an.Title or"Stat",
Desc=an.Desc,
Value=an.Value or an.Default or"0",
SubValue=an.SubValue or an.TrendText,
Trend=an.Trend or"Up",
Icon=an.Icon,
UIElements={},
}

ao.StatCardFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Image=ao.Icon,
Parent=an.Parent,
TextOffset=0,
Hover=an.Hover==true,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.Value=ai("TextLabel",{
Name="Value",
LayoutOrder=-1,
BackgroundTransparency=1,
Text=tostring(ao.Value),
TextSize=ak.ToFiniteNumber(an.ValueTextSize)or 24,
TextWrapped=true,
TextXAlignment="Left",
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(aa.Font,Enum.FontWeight.Bold),
ThemeTag={
TextColor3="Text",
},
})

ao.UIElements.TrendDot=aa.NewRoundFrame(999,"Circle",{
Name="TrendDot",
Size=UDim2.new(0,8,0,8),
ImageColor3=ak.GetColor(an.TrendColor,GetTrendColor(ao.Trend)),
})

ao.UIElements.SubValue=ai("TextLabel",{
Name="SubValue",
BackgroundTransparency=1,
Text=tostring(ao.SubValue or""),
TextSize=13,
TextTransparency=0.35,
TextWrapped=true,
TextXAlignment="Left",
AutomaticSize="Y",
Size=UDim2.new(1,-16,0,0),
Visible=ao.SubValue~=nil,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})

ao.UIElements.Footer=ai("Frame",{
Name="Footer",
LayoutOrder=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.StatCardFrame.UIElements.Container,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ao.UIElements.TrendDot,
ao.UIElements.SubValue,
})
ao.UIElements.Value.Parent=ao.StatCardFrame.UIElements.Container

function ao.SetValue(ap,aq,ar)
ao.Value=aq
ao.UIElements.Value.Text=tostring(aq or"")
if ar~=nil then
ao.SubValue=ar
ao.UIElements.SubValue.Text=tostring(ar)
ao.UIElements.SubValue.Visible=true
end
af.Play(ao.UIElements.Value,"Fast",{TextTransparency=0.18},nil,nil,"Pulse")
task.delay(af.GetDuration"Fast",function()
if ao.UIElements.Value.Parent then
af.Play(ao.UIElements.Value,"Select",{TextTransparency=0},nil,nil,"Pulse")
end
end)
return ao.Value
end

function ao.SetTrend(ap,aq,ar)
ao.Trend=aq
local as=ak.GetColor(ar,GetTrendColor(aq))
af.Play(ao.UIElements.TrendDot,"Select",{ImageColor3=as},nil,nil,"Trend")
return ao.Trend
end

return ao.__type,ao
end

return al end function a.al()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

function al.New(am,an)
local ao={
__type="KeyValue",
Title=an.Title or"Details",
Desc=an.Desc,
Items=ak.NormalizeItems(an.Items or an.Rows or an.Values or{},"Key","Value"),
UIElements={},
Rows={},
}

ao.KeyValueFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=0,
Hover=an.Hover==true,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.List=ai("Frame",{
Name="KeyValueList",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.KeyValueFrame.UIElements.Container,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Vertical",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
})

local function Render()
for ap,aq in next,ao.Rows do
aq:Destroy()
end
ao.Rows={}

for ap,aq in next,ao.Items do
local ar=ak.CreateIcon(aa,aq.Icon,an.Window.Folder,"KeyValue",true,"KeyValueIcon")
if ar then
ar.Size=UDim2.new(0,16,0,16)
end

local as=ai("TextLabel",{
Name="Key",
BackgroundTransparency=1,
Text=tostring(aq.Title),
TextSize=14,
TextTransparency=0.35,
TextTruncate="AtEnd",
TextXAlignment="Left",
Size=UDim2.new(0.45,ar and-24 or 0,0,0),
AutomaticSize="Y",
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})

local at=ai("TextLabel",{
Name="Value",
BackgroundTransparency=1,
Text=tostring(aq.Value or""),
TextSize=14,
TextTransparency=0.05,
TextWrapped=true,
TextXAlignment="Right",
Size=UDim2.new(0.55,0,0,0),
AutomaticSize="Y",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
})

local au=ai("Frame",{
Name="Row",
LayoutOrder=ap,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.UIElements.List,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
ar,
as,
at,
})

table.insert(ao.Rows,au)
end
end

function ao.SetItems(ap,aq)
ao.Items=ak.NormalizeItems(aq or{},"Key","Value")
Render()
af.Play(ao.UIElements.List,"Reveal",{BackgroundTransparency=1},nil,nil,"Render")
return ao.Items
end

Render()

return ao.__type,ao
end

return al end function a.am()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local function GetWidth(am)
return math.max(ak.ToFiniteNumber(am.Width)or ak.ToFiniteNumber(am.ControlWidth)or 190,120)
end

function al.New(am,an)
local ao={
__type="ChipList",
Title=an.Title or"Chips",
Desc=an.Desc,
Options=ak.NormalizeItems(an.Options or an.Values or{}),
Values=ak.NormalizeValues(an.Value or an.ValuesSelected or an.SelectedValues),
Multi=an.Multi~=false,
Callback=an.Callback or function()end,
Locked=an.Locked or false,
LockedTitle=an.LockedTitle,
Animation=an.Animation~=false,
UIElements={},
Chips={},

Width=GetWidth(an),
}

local ap=true

ao.ChipListFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=ao.Width+14,
Hover=false,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.List=ai("Frame",{
Name="ChipList",
Size=UDim2.new(0,ao.Width,0,0),
AutomaticSize="Y",
Position=UDim2.new(1,0,an.Window.NewElements and 0 or 0.5,0),
AnchorPoint=Vector2.new(1,an.Window.NewElements and 0 or 0.5),
BackgroundTransparency=1,
Parent=ao.ChipListFrame.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
HorizontalAlignment="Right",
SortOrder="LayoutOrder",
}),
})

local function IsSelected(aq)
return ak.ContainsValue(ao.Values,aq)
end

local function UpdateVisuals(aq)
for ar,as in next,ao.Chips do
local at=IsSelected(as.Option.Value)
local au=at and 0.82 or 0.94
local av=as.Option.Disabled and 0.55 or(at and 0 or 0.2)

if aq and ao.Animation then
af.Play(as.Button,"Select",{ImageTransparency=au},nil,nil,"State")
af.Play(as.Title,"Select",{TextTransparency=av},nil,nil,"State")
else
as.Button.ImageTransparency=au
as.Title.TextTransparency=av
end
end
end

local function Sanitize(aq)
local ar={}
for as,at in next,aq or{}do
for au,av in next,ao.Options do
if av.Value==at and not av.Disabled and not ak.ContainsValue(ar,at)then
table.insert(ar,at)
break
end
end
end
return ar
end

local function CreateChip(aq,ar)
local as=ai("TextLabel",{
Name="Title",
BackgroundTransparency=1,
Text=aq.Title,
TextSize=13,
TextTruncate="AtEnd",
TextXAlignment="Center",
Size=UDim2.new(1,-16,1,0),
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
})

local at=aa.NewRoundFrame(999,"Squircle",{
Name="Chip",
Size=UDim2.new(1,0,0,30),
LayoutOrder=ar,
ImageTransparency=0.94,
Active=not aq.Disabled,
ThemeTag={
ImageColor3="ChipListBackground",
},
Parent=ao.UIElements.List,
},{
as,
},true)

local au={
Button=at,
Title=as,
Option=aq,
}
ao.Chips[ar]=au

af.AttachPress(at,aa,{
Amount=0.96,
Enabled=function()
return ao.Animation and not ao.Locked and not aq.Disabled
end,
})

aa.AddSignal(at.MouseButton1Click,function()
if not aq.Disabled then
ao:Toggle(aq.Value)
end
end)
end

local function Render()
for aq,ar in next,ao.Chips do
ar.Button:Destroy()
end
ao.Chips={}

for aq,ar in next,ao.Options do
CreateChip(ar,aq)
end

ao.Values=Sanitize(ao.Values)
UpdateVisuals(false)
end

function ao.Lock(aq)
ao.Locked=true
ap=false
return ao.ChipListFrame:Lock(ao.LockedTitle)
end

function ao.Unlock(aq)
ao.Locked=false
ap=true
return ao.ChipListFrame:Unlock()
end

function ao.Get(aq)
return ao.Multi and ak.CloneArray(ao.Values)or ao.Values[1]
end

function ao.Set(aq,ar,as)
local at=ak.NormalizeValues(ar)
if not ao.Multi and at[1]~=nil then
at={at[1]}
end

ao.Values=Sanitize(at)
UpdateVisuals(true)

if ap and as~=false then
aa.SafeCallback(ao.Callback,ao:Get())
end

return ao:Get()
end

function ao.Toggle(aq,ar,as)
if ao.Multi then
ao.Values=ak.ToggleValue(ao.Values,ar)
return ao:Set(ao.Values,as)
end

return ao:Set(ar,as)
end

function ao.SetOptions(aq,ar)
ao.Options=ak.NormalizeItems(ar or{})
Render()
return ao.Options
end

Render()

if ao.Locked then
ao:Lock()
end

return ao.__type,ao
end

return al end function a.an()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local function NormalizeActions(am)
local an={}

for ao,ap in next,am or{}do
if typeof(ap)=="table"then
table.insert(an,{
Title=tostring(ap.Title or ap.Name or ap.Value or("Action "..tostring(ao))),
Desc=ap.Desc or ap.Content,
Value=ap.Value or ap.Badge,
Icon=ap.Icon,
Color=ak.GetColor(ap.Color,nil),
Disabled=ap.Disabled==true,
Callback=ap.Callback,
})
else
table.insert(an,{
Title=tostring(ap),
Disabled=false,
})
end
end

return an
end

function al.New(am,an)
local ao={
__type="ActionList",
Title=an.Title or"Actions",
Desc=an.Desc,
Actions=NormalizeActions(an.Actions or an.Items or an.Values or{}),
Rows={},
UIElements={},
}

ao.ActionListFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=0,
Hover=an.Hover==true,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.List=ai("Frame",{
Name="ActionList",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.ActionListFrame.UIElements.Container,
},{
ai("UIListLayout",{
Padding=UDim.new(0,an.Window.NewElements and 6 or 8),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

local function Render()
for ap,aq in next,ao.Rows do
aq:Destroy()
end
ao.Rows={}

for ap,aq in next,ao.Actions do
local ar=ak.CreateIcon(aa,aq.Icon or"circle-dot",an.Window.Folder,"ActionList",true,"ActionListIcon")
if ar then
ar.Size=UDim2.fromOffset(17,17)
end
local as=ak.GetImageTarget(ar)
if as and aq.Color then
as.ImageColor3=aq.Color
end

local at=ai("Frame",{
Name="Texts",
Size=UDim2.new(1,aq.Value and-96 or-42,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ai("UIListLayout",{
Padding=UDim.new(0,2),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=aq.Title,
TextSize=14,
TextTransparency=aq.Disabled and 0.46 or 0.04,
TextXAlignment="Left",
TextTruncate="AtEnd",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
aq.Desc and ai("TextLabel",{
Name="Desc",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=tostring(aq.Desc),
TextSize=12,
TextTransparency=aq.Disabled and 0.62 or 0.38,
TextXAlignment="Left",
TextWrapped=true,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})or nil,
})

local au
if aq.Value~=nil then
au=aa.NewRoundFrame(999,"Squircle",{
Name="Value",
Size=UDim2.new(0,0,0,26),
AutomaticSize="X",
ImageTransparency=0.88,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
ai("TextLabel",{
Size=UDim2.new(0,0,1,0),
AutomaticSize="X",
BackgroundTransparency=1,
Text=tostring(aq.Value),
TextSize=12,
TextTransparency=0.12,
FontFace=Font.new(aa.Font,Enum.FontWeight.Bold),
ThemeTag={
TextColor3="Text",
},
}),
})
end

local av=aa.NewRoundFrame(14,"Squircle",{
Name="Action",
LayoutOrder=ap,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
ImageTransparency=aq.Disabled and 0.96 or 0.92,
Parent=ao.UIElements.List,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ai("UIPadding",{
PaddingTop=UDim.new(0,10),
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,10),
}),
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ar,
at,
au,
},not aq.Disabled)

if not aq.Disabled then
af.AttachPress(av,aa,{
Amount=0.985,
})
aa.AddSignal(av.MouseButton1Click,function()
if typeof(aq.Callback)=="function"then
aa.SafeCallback(aq.Callback,aq,ap)
elseif typeof(an.Callback)=="function"then
aa.SafeCallback(an.Callback,aq,ap)
end
end)
end

table.insert(ao.Rows,av)
end
end

function ao.SetActions(ap,aq)
ao.Actions=NormalizeActions(aq)
Render()
return ao.Actions
end

function ao.AddAction(ap,aq)
local ar=NormalizeActions{aq}[1]
if ar then
table.insert(ao.Actions,ar)
Render()
end
return ar
end

Render()

return ao.__type,ao
end

return al end function a.ao()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local function NormalizeMeters(am)
local an={}

for ao,ap in next,am or{}do
if typeof(ap)=="table"then



local aq=math.max(ak.ToFiniteNumber(ap.Max)or 100,0.0001)
local ar=ak.ToFiniteNumber(ap.Value or ap.Default)or 0
table.insert(an,{
Title=tostring(ap.Title or ap.Name or("Meter "..tostring(ao))),
Value=math.clamp(ar,0,aq),
Max=aq,
Desc=ap.Desc,
Color=ak.GetColor(ap.Color,nil),
Format=ap.Format,
})
else
table.insert(an,{
Title=tostring(ao),
Value=math.clamp(ak.ToFiniteNumber(ap)or 0,0,100),
Max=100,
})
end
end

return an
end

function al.New(am,an)
local ao={
__type="MeterGroup",
Title=an.Title or"Meters",
Desc=an.Desc,
Meters=NormalizeMeters(an.Meters or an.Items or an.Values or{}),
Rows={},
UIElements={},
}

ao.MeterGroupFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=0,
Hover=an.Hover==true,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.List=ai("Frame",{
Name="MeterGroup",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.MeterGroupFrame.UIElements.Container,
},{
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

local function FormatValue(ap)
local aq=math.clamp(ap.Value/ap.Max,0,1)
if typeof(ap.Format)=="function"then
local ar,as=pcall(ap.Format,ap.Value,ap.Max,aq)
if ar and as~=nil then
return tostring(as)
end
end
return tostring(math.floor((aq*100)+0.5)).."%"
end

local function Render()
for ap,aq in next,ao.Rows do
aq.Frame:Destroy()
end
ao.Rows={}

for ap,aq in next,ao.Meters do
local ar=math.clamp(aq.Value/aq.Max,0,1)
local as=aa.NewRoundFrame(999,"Squircle",{
Name="Fill",
Size=UDim2.new(ar,0,1,0),
ImageTransparency=0.08,
ImageColor3=aq.Color,
ThemeTag=not aq.Color and{
ImageColor3="Primary",
}or nil,
})

local at=ai("TextLabel",{
Name="Value",
Size=UDim2.new(0,52,0,18),
BackgroundTransparency=1,
Text=FormatValue(aq),
TextSize=12,
TextTransparency=0.22,
TextXAlignment="Right",
FontFace=Font.new(aa.Font,Enum.FontWeight.Bold),
ThemeTag={
TextColor3="Text",
},
})

local au=ai("Frame",{
Name="Meter",
LayoutOrder=ap,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.UIElements.List,
},{
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
ai("Frame",{
Name="Header",
Size=UDim2.new(1,0,0,18),
BackgroundTransparency=1,
},{
ai("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,-58,1,0),
BackgroundTransparency=1,
Text=aq.Title,
TextSize=13,
TextTransparency=0.1,
TextXAlignment="Left",
TextTruncate="AtEnd",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
at,
}),
aa.NewRoundFrame(999,"Squircle",{
Name="Track",
Size=UDim2.new(1,0,0,7),
ImageTransparency=0.9,
ClipsDescendants=true,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
as,
}),
aq.Desc and ai("TextLabel",{
Name="Desc",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=tostring(aq.Desc),
TextSize=12,
TextTransparency=0.42,
TextXAlignment="Left",
TextWrapped=true,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
ThemeTag={
TextColor3="Text",
},
})or nil,
})

ao.Rows[ap]={
Frame=au,
Fill=as,
ValueLabel=at,
}
end
end

function ao.SetValue(ap,aq,ar)
local as=ao.Meters[aq]
local at=ao.Rows[aq]
if not as or not at then
return nil
end

as.Value=math.clamp(ak.ToFiniteNumber(ar)or as.Value,0,as.Max)
local au=math.clamp(as.Value/as.Max,0,1)
at.ValueLabel.Text=FormatValue(as)
af.Play(at.Fill,"Fast",{
Size=UDim2.new(au,0,1,0),
},nil,nil,"Meter")
return as.Value
end

function ao.SetMeters(ap,aq)
ao.Meters=NormalizeMeters(aq)
Render()
return ao.Meters
end

Render()

return ao.__type,ao
end

return al end function a.ap()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

function al.New(am,an)
local ao={
__type="Timeline",
Title=an.Title or"Timeline",
Desc=an.Desc,
Items=ak.NormalizeItems(an.Items or an.Events or{}),
UIElements={},
Rows={},
}

ao.TimelineFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=0,
Hover=an.Hover==true,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.List=ai("Frame",{
Name="TimelineList",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.TimelineFrame.UIElements.Container,
},{
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
})

local function Render()
for ap,aq in next,ao.Rows do
aq:Destroy()
end
ao.Rows={}

for ap,aq in next,ao.Items do
local ar=ak.GetVariant(aq.Value)
local as=ak.GetColor(aq.Color,ar.Color)

local at=aa.NewRoundFrame(999,"Circle",{
Name="Dot",
Size=UDim2.new(0,10,0,10),
Position=UDim2.new(0.5,0,0,5),
AnchorPoint=Vector2.new(0.5,0),
ImageTransparency=1,
ImageColor3=as,
})

local au=ai("Frame",{
Name="Rail",
Size=UDim2.new(0,24,0,aq.Desc and 46 or 30),
BackgroundTransparency=1,
},{
ai("Frame",{
Name="Line",
Size=UDim2.new(0,1,1,ap==#ao.Items and-8 or 0),
Position=UDim2.new(0.5,0,0,16),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=0.86,
ThemeTag={
BackgroundColor3="TimelineLine",
},
}),
at,
})

local av=ai("Frame",{
Name="Text",
Size=UDim2.new(1,-32,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ai("UIListLayout",{
Padding=UDim.new(0,3),
FillDirection="Vertical",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
ak.CreateText(ai,aa,aq.Title,14,Enum.FontWeight.SemiBold,0),
aq.Desc and ak.CreateText(ai,aa,aq.Desc,13,Enum.FontWeight.Medium,0.4)or nil,
})

local aw=ai("Frame",{
Name="Item",
LayoutOrder=ap,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.UIElements.List,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
au,
av,
})

table.insert(ao.Rows,aw)
task.delay((ap-1)*0.025,function()
if at.Parent then
af.Play(at,"Reveal",{ImageTransparency=0},nil,nil,"Reveal")
end
end)
end
end

function ao.SetItems(ap,aq)
ao.Items=ak.NormalizeItems(aq or{})
Render()
return ao.Items
end

Render()

return ao.__type,ao
end

return al end function a.aq()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local am=34

function al.New(an,ao)
local ap={
__type="Accordion",
Title=ao.Title or"Accordion",
Desc=ao.Desc,
Items=ak.NormalizeItems(ao.Items or ao.Sections or{}),
OpenIndex=ak.ToFiniteNumber(ao.OpenIndex or ao.DefaultOpen),
Multiple=ao.Multiple==true,
UIElements={},
Rows={},
}

local aq={}
if ap.OpenIndex then
aq[ap.OpenIndex]=true
end

ap.AccordionFrame=a.load'K'{
Title=ap.Title,
Desc=ap.Desc,
Parent=ao.Parent,
TextOffset=0,
Hover=ao.Hover==true,
Tab=ao.Tab,
Index=ao.Index,
Window=ao.Window,
ElementTable=ap,
ParentConfig=ao,
Tags=ao.Tags,
}

ap.UIElements.List=ai("Frame",{
Name="AccordionList",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ap.AccordionFrame.UIElements.Container,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Vertical",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
})

local function GetOpenHeight(ar)
return am+(ar.Content.AbsoluteSize.Y/ao.UIScale)+10
end

local function SetRowOpen(ar,as,at)
local au=ap.Rows[ar]
if not au then
return
end

aq[ar]=as or nil
au.Open=as

local av=UDim2.new(1,0,0,as and GetOpenHeight(au)or am)
if at then
au.Frame.Size=av
au.Chevron.Rotation=as and 180 or 0
else
af.Play(au.Frame,"Expand",{Size=av},nil,nil,"Expand")
af.Play(au.Chevron,"Expand",{Rotation=as and 180 or 0},nil,nil,"Chevron")
end
end

local function Render()
for ar,as in next,ap.Rows do
as.Frame:Destroy()
end
ap.Rows={}

for ar,as in next,ap.Items do
local at=ak.CreateIcon(aa,as.Icon,ao.Window.Folder,"Accordion",true,"AccordionIcon")
if at then
at.Size=UDim2.new(0,16,0,16)
end

local au=aa.Icon"chevron-down"
local av=ai("ImageLabel",{
Name="Chevron",
Size=UDim2.new(0,16,0,16),
BackgroundTransparency=1,
Image=au[1],
ImageRectOffset=au[2].ImageRectPosition,
ImageRectSize=au[2].ImageRectSize,
ImageTransparency=0.4,
ThemeTag={
ImageColor3="Icon",
},
})

local aw=ai("TextButton",{
Name="Header",
Size=UDim2.new(1,0,0,am),
BackgroundTransparency=1,
Text="",
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
at,
ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,at and-48 or-24,1,0),
BackgroundTransparency=1,
Text=as.Title,
TextSize=14,
TextTruncate="AtEnd",
TextXAlignment="Left",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
}),
av,
})

local ax=ai("Frame",{
Name="Content",
Size=UDim2.new(1,-20,0,0),
Position=UDim2.new(0,10,0,am),
AutomaticSize="Y",
BackgroundTransparency=1,
},{
ak.CreateText(ai,aa,as.Desc or"",13,Enum.FontWeight.Medium,0.4),
})

local ay=aa.NewRoundFrame(12,"Squircle",{
Name="Item",
LayoutOrder=ar,
Size=UDim2.new(1,0,0,am),
ClipsDescendants=true,
ImageTransparency=0.94,
ThemeTag={
ImageColor3="AccordionBackground",
},
Parent=ap.UIElements.List,
},{
aw,
ax,
})

ap.Rows[ar]={
Frame=ay,
Header=aw,
Content=ax,
Chevron=av,
Open=false,
}

af.AttachPress(aw,aa,{
Amount=0.985,
})

aa.AddSignal(aw.MouseButton1Click,function()
ap:Toggle(ar)
end)

aa.AddSignal(ax:GetPropertyChangedSignal"AbsoluteSize",function()
if ap.Rows[ar]and ap.Rows[ar].Open then
SetRowOpen(ar,true,true)
end
end)
end

for ar in next,aq do
SetRowOpen(ar,true,true)
end
end

function ap.Open(ar,as)
if not ap.Multiple then
for at in next,aq do
if at~=as then
SetRowOpen(at,false)
end
end
end

SetRowOpen(as,true)
end

function ap.Close(ar,as)
SetRowOpen(as,false)
end

function ap.Toggle(ar,as)
local at=ap.Rows[as]
if not at then
return
end
if at.Open then
ap:Close(as)
else
ap:Open(as)
end
end

function ap.SetItems(ar,as)
ap.Items=ak.NormalizeItems(as or{})
aq={}
Render()
return ap.Items
end

Render()

return ap.__type,ap
end

return al end function a.ar()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'o'.New

local al={}

function al.New(am,an)
local ao={
__type="EmptyState",
Title=an.Title or"Nothing here",
Desc=an.Desc or an.Content,
Icon=an.Icon or"inbox",
Buttons=an.Buttons or{},
UIElements={},
}

local ap=math.max(tonumber(an.Height)or 138,96)

ao.UIElements.Main=aa.NewRoundFrame(an.Window.ElementConfig.UICorner,"Squircle",{
Name="EmptyState",
Size=UDim2.new(1,0,0,ap),
AutomaticSize=#ao.Buttons>0 and"Y"or"None",
ImageTransparency=0.94,
Parent=an.Parent,
ThemeTag={
ImageColor3="ElementBackground",
},
},{
ai("UIPadding",{
PaddingTop=UDim.new(0,16),
PaddingLeft=UDim.new(0,16),
PaddingRight=UDim.new(0,16),
PaddingBottom=UDim.new(0,16),
}),
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Vertical",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
})

local aq=aa.Image(ao.Icon,ao.Icon,0,an.Window.Folder,"EmptyState",true,true,"EmptyStateIcon")
aq.Size=UDim2.new(0,tonumber(an.IconSize)or 34,0,tonumber(an.IconSize)or 34)
aq.ImageLabel.ImageTransparency=0.2
aq.Parent=ao.UIElements.Main

ao.UIElements.Title=ai("TextLabel",{
Name="Title",
BackgroundTransparency=1,
Text=ao.Title,
TextSize=17,
TextWrapped=true,
TextXAlignment="Center",
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
Parent=ao.UIElements.Main,
ThemeTag={
TextColor3="Text",
},
})

ao.UIElements.Desc=ai("TextLabel",{
Name="Desc",
BackgroundTransparency=1,
Text=ao.Desc or"",
TextSize=14,
TextTransparency=0.4,
TextWrapped=true,
TextXAlignment="Center",
AutomaticSize="Y",
Visible=ao.Desc~=nil,
Size=UDim2.new(1,0,0,0),
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
Parent=ao.UIElements.Main,
ThemeTag={
TextColor3="Text",
},
})

if#ao.Buttons>0 then
local ar=ai("Frame",{
Name="Buttons",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ao.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Vertical",
HorizontalAlignment="Center",
}),
})

for as,at in next,ao.Buttons do
local au=ak(
at.Title,
at.Icon,
at.Callback,
at.Variant or"White",
ar,
nil,
nil,
an.Window.NewElements and 999 or 10
)
au.Size=UDim2.new(1,0,0,36)
end
end

function ao.SetTitle(ar,as)
ao.Title=as
ao.UIElements.Title.Text=as
end

function ao.SetDesc(ar,as)
ao.Desc=as
ao.UIElements.Desc.Text=as or""
ao.UIElements.Desc.Visible=as~=nil
end

function ao.Highlight(ar)
af.Play(ao.UIElements.Main,"Highlight",{ImageTransparency=0.9},nil,nil,"Highlight")
task.delay(af.GetDuration"Highlight",function()
if ao.UIElements.Main.Parent then
af.Play(ao.UIElements.Main,"Highlight",{ImageTransparency=0.94},nil,nil,"Highlight")
end
end)
end

function ao.Destroy(ar)
ao.UIElements.Main:Destroy()
end

return ao.__type,ao
end

return al end function a.as()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local am=Color3.fromHex"#5865F2"
local an=Color3.fromHex"#1E1F2A"

local function Trim(ao)
ao=tostring(ao or"")
ao=string.gsub(ao,"^%s+","")
ao=string.gsub(ao,"%s+$","")
return ao
end

local function GetInviteUrl(ao)
local ap=Trim(ao)
if ap==""then
return"https://discord.gg/"
end

if string.match(ap,"^https?://")then
return ap
end
if string.match(ap,"^discord%.gg/")or string.match(ap,"^discord%.com/invite/")then
return"https://"..ap
end

return"https://discord.gg/"..ap
end

local function CopyText(ao)
if typeof(setclipboard)=="function"then
local ap=pcall(function()
setclipboard(ao)
end)
return ap
end
if typeof(toclipboard)=="function"then
local ap=pcall(function()
toclipboard(ao)
end)
return ap
end
return false
end

local function Notify(ao,ap,aq,ar,as)
if ao and ao.Notify then
ao:Notify{
Title=ap,
Content=aq,
Icon=ar,
Style=as,
}
end
end

function al.New(ao,ap)
local aq=ap.Url or ap.Invite or ap.InviteCode or ap.Code
local ar=GetInviteUrl(aq)
local as={
__type="DiscordCard",
Title=ap.Title or ap.ServerName or"Discord Server",
Desc=ap.Desc or ap.Content or"Join the community and get updates.",
Invite=aq,
Url=ar,
Icon=ap.Icon or"message-circle",
Members=ap.Members or ap.MemberCount,
Online=ap.Online or ap.OnlineCount,
Callback=ap.Callback,
UIElements={},
}

local at=math.max(tonumber(ap.Height)or 152,126)

as.UIElements.Main=aa.NewRoundFrame(ap.Window.ElementConfig.UICorner,"Squircle",{
Name="DiscordCard",
Size=UDim2.new(1,0,0,at),
AutomaticSize="Y",
ImageColor3=an,
ImageTransparency=0,
Parent=ap.Parent,
},{
ai("UIGradient",{
Rotation=22,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,an),
ColorSequenceKeypoint.new(1,am),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.02),
NumberSequenceKeypoint.new(1,0.18),
},
}),
ai("UIPadding",{
PaddingTop=UDim.new(0,14),
PaddingLeft=UDim.new(0,14),
PaddingRight=UDim.new(0,14),
PaddingBottom=UDim.new(0,14),
}),
ai("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
})

local au=ai("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=as.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
})

local av=aa.NewRoundFrame(999,"Squircle",{
Size=UDim2.new(0,42,0,42),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0.9,
Parent=au,
},{
ak.CreateIcon(aa,as.Icon,ap.Window.Folder,"DiscordCard",false,nil),
})

local aw=av:FindFirstChildWhichIsA"Frame"or av:FindFirstChildWhichIsA"ImageLabel"
if aw then
aw.Size=UDim2.new(0,20,0,20)
aw.Position=UDim2.new(0.5,0,0.5,0)
aw.AnchorPoint=Vector2.new(0.5,0.5)
local ax=ak.GetImageTarget(aw)
if ax then
ax.ImageColor3=Color3.new(1,1,1)
ax.ImageTransparency=0
end
end

local ax=ai("Frame",{
Size=UDim2.new(1,-52,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=au,
},{
ai("UIListLayout",{
Padding=UDim.new(0,3),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
})

as.UIElements.Title=ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=as.Title,
TextSize=18,
TextWrapped=true,
TextXAlignment="Left",
TextColor3=Color3.new(1,1,1),
FontFace=Font.new(aa.Font,Enum.FontWeight.Bold),
Parent=ax,
})

as.UIElements.Desc=ai("TextLabel",{
Name="Desc",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=as.Desc,
TextSize=13,
TextWrapped=true,
TextXAlignment="Left",
TextColor3=Color3.new(1,1,1),
TextTransparency=0.26,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
Parent=ax,
})

local ay=ai("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=as.Members~=nil or as.Online~=nil,
Parent=as.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
HorizontalAlignment="Left",
VerticalAlignment="Center",
}),
})

local function CreateStat(az,aA,aB)
return aa.NewRoundFrame(999,"Squircle",{
Size=UDim2.new(0,0,0,28),
AutomaticSize="X",
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0.9,
Parent=ay,
},{
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
aa.NewRoundFrame(999,"Circle",{
Size=UDim2.new(0,7,0,7),
ImageColor3=aB,
}),
ai("TextLabel",{
BackgroundTransparency=1,
Text=tostring(aA).." "..az,
TextSize=12,
TextColor3=Color3.new(1,1,1),
TextTransparency=0.08,
AutomaticSize="XY",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
}),
})
end

if as.Members then
CreateStat("members",as.Members,Color3.fromHex"#B6C2FF")
end
if as.Online then
CreateStat("online",as.Online,Color3.fromHex"#23A55A")
end

local az=ai("Frame",{
Size=UDim2.new(1,0,0,36),
BackgroundTransparency=1,
Parent=as.UIElements.Main,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
HorizontalAlignment="Center",
}),
})

local function CreateButton(aA,aB,aC,aD)
local aE=aa.NewRoundFrame(999,"Squircle",{
Size=UDim2.new(0.5,-4,1,0),
ImageColor3=aC=="Primary"and Color3.new(1,1,1)or Color3.new(1,1,1),
ImageTransparency=aC=="Primary"and 0.08 or 0.9,
Parent=az,
},{
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
ai("UIListLayout",{
Padding=UDim.new(0,7),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
ak.CreateIcon(aa,aB,ap.Window.Folder,"DiscordCard",false,nil),
ai("TextLabel",{
BackgroundTransparency=1,
Text=aA,
TextSize=13,
TextColor3=aC=="Primary"and Color3.fromHex"#111827"or Color3.new(1,1,1),
TextTransparency=0,
FontFace=Font.new(aa.Font,Enum.FontWeight.Bold),
AutomaticSize="XY",
}),
},true)

local aF=aE:FindFirstChildWhichIsA"Frame"or aE:FindFirstChildWhichIsA"ImageLabel"
local aG=ak.GetImageTarget(aF)
if aG then
aG.ImageColor3=aC=="Primary"and Color3.fromHex"#111827"or Color3.new(1,1,1)
aG.ImageTransparency=0
end

af.AttachPress(aE,aa,{
Amount=0.97,
})

aa.AddSignal(aE.MouseButton1Click,function()
aa.SafeCallback(aD)
end)

return aE
end

local function CopyInvite(aA)
if CopyText(as.Url)then
Notify(ap.WindUI,aA or"Discord link copied",as.Url,"check","Success")
return true
else
Notify(ap.WindUI,"Discord invite",as.Url,"link","Warning")
return false
end
end

CreateButton(ap.CopyTitle or"Copy Link","link","Secondary",function()
CopyInvite"Discord link copied"
end)

CreateButton(ap.JoinTitle or"Join","external-link","Primary",function()
if as.Callback then
aa.SafeCallback(as.Callback,as.Url,as)
end

CopyInvite"Discord invite ready"
end)

function as.SetInvite(aA,aB)
as.Invite=aB
as.Url=GetInviteUrl(aB)
return as.Url
end

function as.GetUrl(aA)
return as.Url
end

function as.Copy(aA)
return CopyInvite"Discord link copied"
end

function as.Open(aA)
if as.Callback then
aa.SafeCallback(as.Callback,as.Url,as)
end
return CopyInvite"Discord invite ready"
end

function as.SetTitle(aA,aB)
as.Title=aB
as.UIElements.Title.Text=aB
end

function as.SetDesc(aA,aB)
as.Desc=aB
as.UIElements.Desc.Text=aB or""
end

function as.Highlight(aA)
af.Play(as.UIElements.Main,"Highlight",{ImageTransparency=0.08},nil,nil,"Highlight")
task.delay(af.GetDuration"Highlight",function()
if as.UIElements.Main.Parent then
af.Play(as.UIElements.Main,"Highlight",{ImageTransparency=0},nil,nil,"Highlight")
end
end)
end

function as.Destroy(aA)
as.UIElements.Main:Destroy()
end

return as.__type,as
end

return al end function a.at()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

function al.New(am,an)
local ao={
__type="TabBox",
Title=an.Title or"Tabs",
Desc=an.Desc,
Tabs={},
Selected=nil,
SelectedValue=nil,
UIElements={},
}

ao.TabBoxFrame=a.load'K'{
Title=ao.Title,
Desc=ao.Desc,
Parent=an.Parent,
TextOffset=0,
Hover=an.Hover==true,
Tab=an.Tab,
Index=an.Index,
Window=an.Window,
ElementTable=ao,
ParentConfig=an,
Tags=an.Tags,
}

ao.UIElements.Tabs=ai("ScrollingFrame",{
Name="Tabs",
Size=UDim2.new(1,0,0,an.TabHeight or 36),
BackgroundTransparency=1,
ScrollBarThickness=0,
ScrollingDirection="X",
ScrollingEnabled=true,
AutomaticCanvasSize="X",
CanvasSize=UDim2.new(0,0,0,0),
ElasticBehavior="Never",
Active=true,
Parent=ao.TabBoxFrame.UIElements.Container,
},{
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

ao.UIElements.Pages=ai("Frame",{
Name="Pages",
Size=UDim2.new(1,0,0,1),
BackgroundTransparency=1,
ClipsDescendants=false,
Parent=ao.TabBoxFrame.UIElements.Container,
})

local function UpdateTabVisuals()
for ap,aq in next,ao.Tabs do
local ar=ao.Selected==ap
af.Play(aq.Button,"Switch",{ImageTransparency=ar and 0.82 or 0.94},nil,nil,"State")
af.Play(aq.TitleLabel,"Switch",{TextTransparency=ar and 0 or 0.25},nil,nil,"State")
if aq.IconTarget then
af.Play(aq.IconTarget,"Switch",{ImageTransparency=ar and 0 or 0.35},nil,nil,"State")
end
end
end

local function GetPageHeight(ap)
local aq=ap.UIElements.Container.UIListLayout
local ar=an.Window.ElementConfig.UIPadding/2
local as=aq.AbsoluteContentSize.Y/an.UIScale+ar
return math.max(as,ar)
end

local function UpdatePageHeight(ap)
if not ap or not ap.UIElements.Container then
return
end

local aq=GetPageHeight(ap)
ap.UIElements.Container.Size=UDim2.new(1,0,0,aq)
ao.UIElements.Pages.Size=UDim2.new(1,0,0,aq)
return aq
end

local function ScrollTabIntoView(ap)
task.defer(function()
if not ap or not ap.Button or not ap.Button.Parent then
return
end

local aq=ao.UIElements.Tabs
local ar=aq.AbsoluteSize.X
local as=ap.Button.AbsolutePosition.X-aq.AbsolutePosition.X+aq.CanvasPosition.X
local at=as+ap.Button.AbsoluteSize.X
local au=aq.CanvasPosition.X
local av=au+ar
local aw=au

if as<au then
aw=as
elseif at>av then
aw=at-ar
end

if math.abs(aw-au)>1 then
aq.CanvasPosition=Vector2.new(math.max(aw,0),0)
end
end)
end

local function QueuePageHeightUpdate(ap,aq)
task.defer(function()
if ao.Selected==aq and ap and ap.UIElements.Container.Parent then
UpdatePageHeight(ap)
end
end)
end

function ao.Select(ap,aq)
local ar=ao.Tabs[aq]
if not ar then
return nil
end

ao.Selected=aq
ao.SelectedValue=ar.Value
for as,at in next,ao.Tabs do
local au=as==aq
at.UIElements.Container.Visible=au
at.UIElements.Container.Active=au
at.UIElements.Container.GroupTransparency=1
if au then
at.UIElements.Container.Position=UDim2.new(0,0,0,8)
end
end

UpdatePageHeight(ar)
af.Play(ar.UIElements.Container,"Switch",{GroupTransparency=0},nil,nil,"Page")
af.Play(ar.UIElements.Container,"Switch",{Position=UDim2.new(0,0,0,0)},nil,nil,"PageSlide")
QueuePageHeightUpdate(ar,aq)
UpdateTabVisuals()
ScrollTabIntoView(ar)
return ar
end

function ao.GetSelected(ap)
return ao.Selected and ao.Tabs[ao.Selected]or nil
end

function ao.Get(ap)
return ao.SelectedValue
end

function ao.SelectValue(ap,aq)
for ar,as in next,ao.Tabs do
if as.Value==aq then
return ao:Select(ar)
end
end
return nil
end

function ao.Set(ap,aq)
return ao:SelectValue(aq)
end

function ao.Tab(ap,aq)
aq=aq or{}
local ar=#ao.Tabs+1
local as={
__type="TabBoxPage",
Title=aq.Title or("Tab "..tostring(ar)),
Value=aq.Value or aq.Id or ar,
Icon=aq.Icon,
Elements={},
UIElements={},
Gap=an.Tab and an.Tab.Gap or 6,
}

local at=ak.CreateIcon(aa,as.Icon,an.Window.Folder,"TabBox",true,"TabBoxIcon")
if at then
at.Size=UDim2.new(0,15,0,15)
end
local au=ak.GetImageTarget(at)
local av=string.len(as.Title)*(an.Window.IsPC==false and 6 or 7)
local aw=math.clamp(av+(at and 40 or 26),an.MinTabWidth or 68,an.MaxTabWidth or 154)

local ax=ai("TextLabel",{
Name="Title",
BackgroundTransparency=1,
Text=as.Title,
TextSize=an.Window.IsPC==false and 12 or 13,
TextTruncate="AtEnd",
Size=UDim2.new(0,math.max(aw-(at and 42 or 20),24),1,0),
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
ThemeTag={
TextColor3="Text",
},
})

local ay=aa.NewRoundFrame(999,"Squircle",{
Name="Tab",
LayoutOrder=ar,
Size=UDim2.new(0,aw,0,an.TabButtonHeight or 30),
ImageTransparency=0.94,
ClipsDescendants=true,
ThemeTag={
ImageColor3="TabBoxTabBackground",
},
Parent=ao.UIElements.Tabs,
},{
ai("UIPadding",{
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
}),
ai("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Center",
}),
at,
ax,
},true)

local az=ai("CanvasGroup",{
Name="Page",
LayoutOrder=ar,
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
GroupTransparency=1,
Visible=false,
Active=false,
Parent=ao.UIElements.Pages,
},{
ai("UIPadding",{
PaddingTop=UDim.new(0,an.Window.ElementConfig.UIPadding/2),
}),
ai("UIListLayout",{
Padding=UDim.new(0,as.Gap),
FillDirection="Vertical",
VerticalAlignment="Top",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

as.Button=ay
as.TitleLabel=ax
as.Icon=at
as.IconTarget=au
as.ElementFrame=az
as.UIElements.Container=az
as.UIElements.Title=ax

an.ElementsModule.Load(
as,
az,
an.ElementsModule.Elements,
an.Window,
an.WindUI,
function()
QueuePageHeightUpdate(as,ar)
end,
an.ElementsModule,
an.UIScale,
an.Tab
)

function as.Select(aA)
return ao:Select(ar)
end

function as.Destroy(aA)
ay:Destroy()
az:Destroy()
table.remove(ao.Tabs,ar)
if ao.Selected==ar then
ao.Selected=nil
if ao.Tabs[1]then
ao:Select(1)
end
end
end

ao.Tabs[ar]=as

af.AttachPress(ay,aa,{
Amount=0.97,
})

aa.AddSignal(ay.MouseButton1Click,function()
ao:Select(ar)
end)

aa.AddSignal(az.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
QueuePageHeightUpdate(as,ar)
end)

if not ao.Selected or aq.Selected==true or aq.Value==an.Value then
ao:Select(ar)
else
UpdateTabVisuals()
end

if typeof(aq.Elements)=="function"then
task.defer(function()
aa.SafeCallback(aq.Elements,as)
end)
end

return as
end

function ao.CreateTab(ap,aq)
return ao:Tab(aq)
end

for ap,aq in next,an.Tabs or{}do
ao:Tab(aq)
end

return ao.__type,ao
end

return al end function a.au()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local am={
Vector2.new(0.08,0.72),
Vector2.new(0.28,0.38),
Vector2.new(0.52,0.56),
Vector2.new(0.72,0.24),
Vector2.new(0.92,0.42),
}

local an=92
local ao=22

local function NormalizePoint(ap)
if typeof(ap)=="Vector2"then
return Vector2.new(math.clamp(ap.X,0,1),math.clamp(ap.Y,0,1))
end

if typeof(ap)=="table"then
local aq=ak.ToFiniteNumber(ap.X or ap.x or ap[1])or 0
local ar=ak.ToFiniteNumber(ap.Y or ap.y or ap[2])or 0
return Vector2.new(math.clamp(aq,0,1),math.clamp(ar,0,1))
end

return Vector2.new(0,0)
end

local function NormalizePoints(ap)
local aq={}
local ar=typeof(ap)=="table"and ap or am

if#ar>0 then
for as=1,#ar do
table.insert(aq,NormalizePoint(ar[as]))
end
else
for as,at in next,ar do
table.insert(aq,NormalizePoint(at))
end
end

if#aq<2 then
aq=am
end

return aq
end

local function PointToUDim2(ap)
return UDim2.new(ap.X,0,ap.Y,0)
end

local function PixelToUDim2(ap)
return UDim2.fromOffset(ap.X,ap.Y)
end

local function GetTweenPoint(ap,aq,ar)
return ap:Lerp(aq,math.clamp(ar,0,1))
end

local function GetAngle(ap,aq)
if math.atan2 then
return math.atan2(ap,aq)
end

if aq==0 then
return ap>=0 and math.pi/2 or-math.pi/2
end

local ar=math.atan(ap/aq)
if aq<0 then
ar+=math.pi
end
return ar
end

function al.New(ap,aq)
local ar={
__type="Path2D",
Title=aq.Title or"Path 2D",
Desc=aq.Desc,
Points=NormalizePoints(aq.Points or aq.Path),
Labels=aq.Labels or{},
Height=math.max(ak.ToFiniteNumber(aq.Height)or 156,96),
Thickness=math.max(ak.ToFiniteNumber(aq.Thickness)or 4,2),
Padding=math.max(ak.ToFiniteNumber(aq.PathPadding or aq.Padding)or 20,0),
DotSize=math.max(ak.ToFiniteNumber(aq.DotSize)or 9,5),
MarkerSize=math.max(ak.ToFiniteNumber(aq.MarkerSize)or 16,10),
Duration=math.max(ak.ToFiniteNumber(aq.Duration)or 1.2,0.18),
StepDelay=math.max(ak.ToFiniteNumber(aq.StepDelay)or 0.055,0),
Loop=aq.Loop==true,
AutoPlay=aq.AutoPlay~=false,
Glow=aq.Glow~=false,
UIElements={},
Segments={},
Dots={},
LabelObjects={},
PlayToken=0,
HasRendered=false,
Destroyed=false,
}

ar.Path2DFrame=a.load'K'{
Title=ar.Title,
Desc=ar.Desc,
Parent=aq.Parent,
TextOffset=0,
Hover=aq.Hover==true,
Tab=aq.Tab,
Index=aq.Index,
Window=aq.Window,
ElementTable=ar,
ParentConfig=aq,
Tags=aq.Tags,
}

ar.UIElements.Canvas=aa.NewRoundFrame(aq.Window.ElementConfig.UICorner,"Squircle",{
Name="Path2DCanvas",
Size=UDim2.new(1,0,0,ar.Height),
ClipsDescendants=true,
ImageTransparency=aa.ClampTransparency(aq.BackgroundTransparency,0.92),
Parent=ar.Path2DFrame.UIElements.Container,
ThemeTag={
ImageColor3="Path2DBackground",
},
},{
ai("UIGradient",{
Rotation=25,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.08),
NumberSequenceKeypoint.new(1,0.28),
},
}),
})

local function ClearObjects()
for as,at in next,ar.Segments do
at.Track:Destroy()
end
for as,at in next,ar.Dots do
at:Destroy()
end
for as,at in next,ar.LabelObjects do
at:Destroy()
end
if ar.UIElements.Marker then
ar.UIElements.Marker:Destroy()
ar.UIElements.Marker=nil
end

ar.Segments={}
ar.Dots={}
ar.LabelObjects={}
end

local function GetCanvasSize()
local as=ar.UIElements.Canvas.AbsoluteSize
return Vector2.new(as.X/aq.UIScale,as.Y/aq.UIScale)
end

local function GetPixelPoint(as,at)
local au=math.min(ar.Padding,math.max(at.X,at.Y)/3)
local av=Vector2.new(
math.max(at.X-(au*2),1),
math.max(at.Y-(au*2),1)
)

return Vector2.new(
au+(as.X*av.X),
au+(as.Y*av.Y)
)
end

local function GetLabelPosition(as,at,au)
local av=math.max(ak.ToFiniteNumber(au.Width)or an,54)
local aw=math.max(ak.ToFiniteNumber(au.Height)or ao,18)
local ax=ak.ToFiniteNumber(au.OffsetX)or 0
local ay=ak.ToFiniteNumber(au.OffsetY)
if ay==nil then
ay=au.Above==false and 18 or-18
end

return Vector2.new(
math.clamp(as.X+ax,(av/2)+6,math.max((av/2)+6,at.X-(av/2)-6)),
math.clamp(as.Y+ay,(aw/2)+6,math.max((aw/2)+6,at.Y-(aw/2)-6))
),av,aw
end

function ar.Render(as,at)
local au=GetCanvasSize()
if au.X<=0 or au.Y<=0 then
return
end

local av=at~=false and ar.AutoPlay
ar.PlayToken=ar.PlayToken+1
ar.HasRendered=true
ClearObjects()

for aw=1,#ar.Points-1 do
local ax=GetPixelPoint(ar.Points[aw],au)
local ay=GetPixelPoint(ar.Points[aw+1],au)
local az=ay-ax
local aA=az.Magnitude
local aB=math.deg(GetAngle(az.Y,az.X))
local aC=(ax+ay)/2

local aD=aa.NewRoundFrame(999,"Squircle",{
Name="Segment"..tostring(aw),
Size=UDim2.new(0,aA,0,ar.Thickness),
Position=PixelToUDim2(aC),
AnchorPoint=Vector2.new(0.5,0.5),
Rotation=aB,
ImageTransparency=0.84,
Parent=ar.UIElements.Canvas,
ZIndex=2,
ThemeTag={
ImageColor3="Path2DTrack",
},
})

local aE=ar.Glow and aa.NewRoundFrame(999,"Squircle",{
Name="Glow",
Size=UDim2.new(0,av and 0 or aA,0,ar.Thickness+8),
Position=UDim2.new(0,0,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
ImageTransparency=0.84,
ZIndex=2,
Parent=aD,
ThemeTag={
ImageColor3="Path2DLine",
},
})or nil

local aF=aa.NewRoundFrame(999,"Squircle",{
Name="Fill",
Size=UDim2.new(0,av and 0 or aA,1,0),
ImageTransparency=0,
ZIndex=3,
Parent=aD,
ThemeTag={
ImageColor3="Path2DLine",
},
})

table.insert(ar.Segments,{
Track=aD,
Glow=aE,
Fill=aF,
Length=aA,
From=ar.Points[aw],
To=ar.Points[aw+1],
FromPixel=ax,
ToPixel=ay,
FromPosition=PixelToUDim2(ax),
ToPosition=PixelToUDim2(ay),
})
end

for aw=1,#ar.Points do
local ax=ar.Points[aw]
local ay=GetPixelPoint(ax,au)
local az=aw==1 and ar.DotSize+3 or ar.DotSize
local aA=aa.NewRoundFrame(999,"Circle",{
Name="Point"..tostring(aw),
Size=UDim2.new(0,az,0,az),
Position=PixelToUDim2(ay),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=av and 0.54 or 0.12,
Parent=ar.UIElements.Canvas,
ZIndex=4,
ThemeTag={
ImageColor3=aw==#ar.Points and"Path2DMarker"or"Path2DLine",
},
},{
aa.NewRoundFrame(999,"Circle",{
Name="DotCore",
Size=UDim2.new(0,math.max(az-5,3),0,math.max(az-5,3)),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageColor3=Color3.new(1,1,1),
ImageTransparency=0.22,
ZIndex=5,
}),
})
table.insert(ar.Dots,aA)
end

for aw,ax in next,ar.Labels do
if typeof(ax)~="table"then
ax={
Text=tostring(ax),
}
end
local ay=math.clamp(math.floor(ak.ToFiniteNumber(ax.Point or ax.Index)or 1),1,#ar.Points)
local az=GetPixelPoint(ar.Points[ay],au)
local aA,aB,aC=GetLabelPosition(az,au,ax)
local aD=ai("TextLabel",{
Name="PathLabel",
Size=UDim2.new(0,aB,0,aC),
Position=PixelToUDim2(aA),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Text=tostring(ax.Text or ax.Title or ay),
TextSize=12,
TextTransparency=0.22,
TextXAlignment="Center",
FontFace=Font.new(aa.Font,Enum.FontWeight.SemiBold),
Parent=ar.UIElements.Canvas,
ZIndex=6,
ThemeTag={
TextColor3="Path2DLabel",
},
})
table.insert(ar.LabelObjects,aD)
end

local aw=aa.NewRoundFrame(999,"Circle",{
Name="Marker",
Size=UDim2.new(0,ar.MarkerSize,0,ar.MarkerSize),
Position=av and ar.Segments[1]and ar.Segments[1].FromPosition
or PixelToUDim2(GetPixelPoint(ar.Points[#ar.Points],au)),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=0,
Parent=ar.UIElements.Canvas,
ZIndex=8,
ThemeTag={
ImageColor3="Path2DMarker",
},
},{
aa.NewRoundFrame(999,"Circle",{
Name="Halo",
Size=UDim2.new(1,12,1,12),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=0.78,
ZIndex=7,
ThemeTag={
ImageColor3="Path2DMarker",
},
}),
aa.NewRoundFrame(999,"Circle",{
Name="Core",
Size=UDim2.new(0,6,0,6),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageColor3=Color3.new(1,1,1),
ZIndex=9,
}),
})
ar.UIElements.Marker=aw

if av then
ar:Play()
end
end

function ar.Play(as)
ar.PlayToken=ar.PlayToken+1
local at=ar.PlayToken
local au=ar.Duration/math.max(#ar.Segments,1)

if ar.UIElements.Marker then
ar.UIElements.Marker.Position=ar.Segments[1]and ar.Segments[1].FromPosition
or PointToUDim2(ar.Points[1])
end
for av,aw in next,ar.Dots do
aw.ImageTransparency=0.72
end
for av,aw in next,ar.Segments do
aw.Fill.Size=UDim2.new(0,0,1,0)
if aw.Glow then
aw.Glow.Size=UDim2.new(0,0,0,ar.Thickness+8)
end
end

for av=1,#ar.Segments do
local aw=ar.Segments[av]
local ax=(av-1)*(au+ar.StepDelay)
task.delay(ax,function()
if at~=ar.PlayToken or ar.Destroyed then
return
end

if ar.Dots[av]then
af.Play(ar.Dots[av],"Reveal",{ImageTransparency=0.12},nil,nil,"Point")
end
af.Play(
aw.Fill,
au,
{Size=UDim2.new(0,aw.Length,1,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Draw"
)
if aw.Glow then
af.Play(
aw.Glow,
au,
{Size=UDim2.new(0,aw.Length,0,ar.Thickness+8)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Glow"
)
end
if ar.UIElements.Marker then
af.Play(
ar.UIElements.Marker,
au,
{Position=aw.ToPosition},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Path"
)
end
end)
end

local av=#ar.Segments*(au+ar.StepDelay)
task.delay(av,function()
if at~=ar.PlayToken or ar.Destroyed then
return
end
if ar.Dots[#ar.Dots]then
af.Play(ar.Dots[#ar.Dots],"Reveal",{ImageTransparency=0},nil,nil,"Point")
end
if ar.Loop then
task.delay(0.4,function()
if at==ar.PlayToken and not ar.Destroyed then
ar:Play()
end
end)
end
end)
end

function ar.Stop(as)
ar.PlayToken=ar.PlayToken+1
if ar.UIElements.Marker then
af.Cancel(ar.UIElements.Marker,"Path")
end
for at,au in next,ar.Segments do
af.Cancel(au.Fill,"Draw")
if au.Glow then
af.Cancel(au.Glow,"Glow")
end
end
end

function ar.SetProgress(as,at)
ar:Stop()
local au=math.clamp(ak.ToFiniteNumber(at)or 0,0,1)
if#ar.Segments==0 then
return au
end

local av=math.max(#ar.Segments,1)
local aw=au*av

for ax=1,#ar.Segments do
local ay=ar.Segments[ax]
local az=math.clamp(aw-(ax-1),0,1)
ay.Fill.Size=UDim2.new(0,ay.Length*az,1,0)
if ay.Glow then
ay.Glow.Size=UDim2.new(0,ay.Length*az,0,ar.Thickness+8)
end
end

local ax=math.clamp(math.ceil(aw),1,#ar.Segments)
local ay=ar.Segments[ax]
if ay and ar.UIElements.Marker then
local az=math.clamp(aw-(ax-1),0,1)
ar.UIElements.Marker.Position=PixelToUDim2(
GetTweenPoint(ay.FromPixel,ay.ToPixel,az)
)
end

for az=1,#ar.Dots do
local aA=ar.Dots[az]
aA.ImageTransparency=az<=math.floor(aw)+1 and 0.12 or 0.54
end

return au
end

function ar.SetPoints(as,at)
ar.Points=NormalizePoints(at)
ar:Render(true)
return ar.Points
end

function ar.Destroy(as)
ar.Destroyed=true
ar:Stop()
ar.Path2DFrame:Destroy()
end

aa.AddSignal(ar.UIElements.Canvas:GetPropertyChangedSignal"AbsoluteSize",function()
ar:Render(not ar.HasRendered)
end)

task.defer(function()
ar:Render(true)
end)

return ar.__type,ar
end

return al end function a.av()

local aa=a.load'e'
local af=a.load'f'
local ai=aa.New

local ak=a.load'ah'

local al={}

local function GetText(am,an)
if am==nil then
return an
end
return tostring(am)
end

local function GetCardColor(am,an)
return ak.GetColor(am,an)
end

function al.New(am,an)
local ao={
__type="Card",
Title=GetText(an.Title,"Card"),
Desc=an.Desc or an.Content,
Icon=an.Icon,
Image=an.Image or an.Background or an.BackgroundImage,
Callback=an.Callback,
OpenTab=an.OpenTab==true or an.CardTab==true or typeof(an.Build)=="function",
Elements={},
UIElements={},
ElementFrame=nil,
LinkCorners=an.LinkCorners,
CornerGroup=an.CornerGroup or an.LinkCornerGroup,
CornerBreak=an.CornerBreak,
CornerBreakBefore=an.CornerBreakBefore,
CornerBreakAfter=an.CornerBreakAfter,
}

local ap=an.Radius or an.Window.ElementConfig.UICorner
local aq=GetCardColor(an.Color or an.Accent,nil)
local ar=tonumber(an.Height)or 0
local as=typeof(ao.Callback)=="function"or ao.OpenTab
local at
local au
local av

ao.UIElements.Main,at=aa.NewRoundFrame(ap,"Squircle",{
Name="Card",
Size=UDim2.new(1,0,0,ar),
AutomaticSize="Y",
ImageTransparency=1,
Parent=an.Parent,
ClipsDescendants=true,
},{},as)
ao.ElementFrame=ao.UIElements.Main

ao.UIElements.Background=ai("Frame",{
Name="Background",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=aa.ClampTransparency(
an.Transparency,
an.Window.LiquidGlass and 0.84 or 0.9
),
BackgroundColor3=aq or nil,
ZIndex=0,
Parent=ao.UIElements.Main,
ThemeTag=aq and nil or{
BackgroundColor3="ElementBackground",
},
},{
ai("UICorner",{
CornerRadius=UDim.new(0,ap),
}),
})
au=ao.UIElements.Background.UICorner

ao.UIElements.Content=ai("Frame",{
Name="Content",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
ZIndex=2,
Parent=ao.UIElements.Main,
},{
ai("UIPadding",{
PaddingTop=UDim.new(0,an.Padding or 14),
PaddingLeft=UDim.new(0,an.Padding or 14),
PaddingRight=UDim.new(0,an.Padding or 14),
PaddingBottom=UDim.new(0,an.Padding or 14),
}),
ai("UIListLayout",{
Padding=UDim.new(0,an.Gap or 12),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

if ao.Image then
ao.UIElements.Image=
aa.Image(ao.Image,ao.Title.."-card-image",0,an.Window.Folder,"Card",false,false)
ao.UIElements.Image.Size=UDim2.new(1,0,1,0)
ao.UIElements.Image.Position=UDim2.new(0.5,0,0.5,0)
ao.UIElements.Image.AnchorPoint=Vector2.new(0.5,0.5)
ao.UIElements.Image.Parent=ao.UIElements.Main
ao.UIElements.Image.ZIndex=0

local aw=ak.GetImageTarget(ao.UIElements.Image)
if aw then
aw.ZIndex=0
aw.ImageTransparency=an.ImageTransparency or 0.32
aw.ScaleType=an.ScaleType or Enum.ScaleType.Crop
av=ai("UICorner",{
CornerRadius=UDim.new(0,ap),
Parent=aw,
})
end
end

local aw=ai("Frame",{
Name="Header",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
LayoutOrder=1,
Parent=ao.UIElements.Content,
},{
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Top",
HorizontalAlignment="Left",
}),
})

if ao.Icon then
local ax=ak.CreateIcon(aa,ao.Icon,an.Window.Folder,"Card",true,"CardIcon")
if ax then
ax.Size=UDim2.new(0,22,0,22)
ax.Parent=aw
local ay=ak.GetImageTarget(ax)
if ay and aq then
ay.ImageColor3=aq
ay.ImageTransparency=0
end
end
end

local ax=ai("Frame",{
Name="Texts",
Size=UDim2.new(1,ao.Icon and-32 or 0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=aw,
},{
ai("UIListLayout",{
Padding=UDim.new(0,3),
FillDirection="Vertical",
HorizontalAlignment="Left",
}),
})

ao.UIElements.Title=ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=ao.Title,
TextSize=an.TitleSize or 17,
TextTransparency=0.02,
TextXAlignment="Left",
TextWrapped=true,
FontFace=Font.new(aa.Font,Enum.FontWeight.Bold),
Parent=ax,
ThemeTag={
TextColor3="Text",
},
})

ao.UIElements.Desc=ai("TextLabel",{
Name="Desc",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Text=ao.Desc or"",
TextSize=an.DescSize or 13,
TextTransparency=0.34,
TextXAlignment="Left",
TextWrapped=true,
Visible=ao.Desc~=nil,
FontFace=Font.new(aa.Font,Enum.FontWeight.Medium),
Parent=ax,
ThemeTag={
TextColor3="Text",
},
})

ao.UIElements.Body=ai("Frame",{
Name="Body",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
LayoutOrder=2,
Parent=ao.UIElements.Content,
},{
ai("UIListLayout",{
Padding=UDim.new(0,an.BodyGap or(an.Window.NewElements and 6 or 8)),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

local function EnsureActions()
if ao.UIElements.Actions then
return ao.UIElements.Actions
end

ao.UIElements.Actions=ai("Frame",{
Name="Actions",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
LayoutOrder=3,
Parent=ao.UIElements.Content,
},{
ai("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Vertical",
HorizontalAlignment="Left",
SortOrder="LayoutOrder",
}),
})

return ao.UIElements.Actions
end

local function CreateActionButton(ay,az)
ay=ay or{}
local aA=GetCardColor(ay.Color,aq)
local aB=aa.NewRoundFrame(ay.Radius or 14,"Squircle",{
Name=ay.Name or"CardButton",
Size=UDim2.new(1,0,0,ay.Height or 44),
ImageColor3=aA or nil,
ImageTransparency=ay.Transparency or(aA and 0.18 or 0.9),
Parent=EnsureActions(),
ThemeTag=aA and nil or{
ImageColor3="ElementBackground",
},
},{
ai("UIPadding",{
PaddingLeft=UDim.new(0,12),
PaddingRight=UDim.new(0,12),
}),
ai("UIListLayout",{
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ak.CreateIcon(
aa,
ay.Icon or"arrow-right",
an.Window.Folder,
"Card",
not aA,
"CardButtonIcon"
),
ai("TextLabel",{
Name="Title",
Size=UDim2.new(1,-34,1,0),
BackgroundTransparency=1,
Text=GetText(ay.Title or ay.Name,"Open"),
TextSize=ay.TextSize or 14,
TextTransparency=0.04,
TextXAlignment="Left",
TextTruncate="AtEnd",
FontFace=Font.new(aa.Font,Enum.FontWeight.Bold),
ThemeTag={
TextColor3="Text",
},
}),
},true)

local aC=aB:FindFirstChildWhichIsA"Frame"or aB:FindFirstChildWhichIsA"ImageLabel"
local aD=ak.GetImageTarget(aC)
if aD and aA then
aD.ImageColor3=aA
aD.ImageTransparency=0
end

af.AttachPress(aB,aa,{
Amount=0.975,
})
aa.AddSignal(aB.MouseButton1Click,function()
if az then
az()
end
if typeof(ay.Callback)=="function"then
aa.SafeCallback(ay.Callback,ao)
end
end)

return aB
end

local ay
local function CreateCardTab(az)
az=az or{}
local aA=az.Tab

if typeof(aA)~="table"and az.CreateTab~=false and an.Window and an.Window.Tab then
aA=an.Window:Tab{
Title=az.TabTitle or az.Title or ao.Title,
Desc=az.TabDesc or az.Desc,
Icon=az.TabIcon or az.Icon or ao.Icon or"panels-top-left",
ShowTabTitle=az.ShowTabTitle,
Golden=az.Golden,
Premium=az.Premium,
LinkCorners=az.LinkCorners,
Gap=az.Gap,
}

if typeof(az.Build)=="function"then
aa.SafeCallback(az.Build,aA,ao)
end
end

return{
Tab=aA,
Select=function()
if aA and aA.Select then
return aA:Select()
end
end,
}
end

function ao.CardButton(az,aA)
return CreateActionButton(aA)
end

function ao.CardTab(az,aA)
aA=aA or{}
local aB=CreateCardTab(aA)

local aC=CreateActionButton({
Title=aA.Title or"Open Card Tab",
Icon=aA.Icon or"panels-top-left",
Color=aA.Color,
Callback=aA.Callback,
},function()
aB.Select()
end)

aB.Button=aC
return aB
end

if ao.OpenTab then
local az=typeof(an.CardTab)=="table"and an.CardTab or{}
ay=CreateCardTab{
Tab=an.TabTarget or an.Page or az.Tab,
CreateTab=an.CreateTab~=false and az.CreateTab~=false,
Title=an.TabTitle or an.PageTitle or az.Title or ao.Title,
TabTitle=an.TabTitle or an.PageTitle or az.TabTitle or ao.Title,
TabDesc=an.TabDesc or an.PageDesc or az.TabDesc or ao.Desc,
Icon=an.TabIcon or an.PageIcon or az.Icon or ao.Icon,
TabIcon=an.TabIcon or an.PageIcon or az.TabIcon or ao.Icon,
ShowTabTitle=an.ShowTabTitle or az.ShowTabTitle,
Golden=an.Golden or az.Golden,
Premium=an.Premium or az.Premium,
LinkCorners=an.PageLinkCorners or az.LinkCorners,
Gap=an.PageGap or az.Gap,
Build=an.Build or az.Build,
}

ao.Page=ay.Tab
ao.PageController=ay
end

function ao.Open(az)
if ay then
return ay.Select()
end
if typeof(ao.Callback)=="function"then
return aa.SafeCallback(ao.Callback,ao)
end
end

function ao.GetPage(az)
return ay and ay.Tab
end

function ao.SetPage(az,aA)
ay={
Tab=aA,
Select=function()
if aA and aA.Select then
return aA:Select()
end
end,
}
ao.Page=aA
ao.PageController=ay
return{
Tab=aA,
Select=ay.Select,
}
end

if as then
af.AttachPress(ao.UIElements.Main,aa,{
Amount=0.985,
})
aa.AddSignal(ao.UIElements.Main.MouseButton1Click,function()
if ay then
ay.Select()
end
if typeof(ao.Callback)=="function"then
aa.SafeCallback(ao.Callback,ao)
end
end)
end

local az=an.ElementsModule
az.Load(
ao,
ao.UIElements.Body,
az.Elements,
an.Window,
an.WindUI,
nil,
az,
an.UIScale,
an.Tab
)

function ao.SetTitle(aA,aB)
ao.Title=tostring(aB or"")
ao.UIElements.Title.Text=ao.Title
end

function ao.SetDesc(aA,aB)
ao.Desc=aB
ao.UIElements.Desc.Text=tostring(aB or"")
ao.UIElements.Desc.Visible=aB~=nil
end

function ao.Highlight(aA)
af.Play(
ao.UIElements.Background,
"Highlight",
{BackgroundTransparency=0.78},
nil,
nil,
"CardHighlight"
)
task.delay(af.GetDuration"Highlight",function()
if ao.UIElements.Main.Parent then
af.Play(ao.UIElements.Background,"Highlight",{
BackgroundTransparency=aa.ClampTransparency(
an.Transparency,
an.Window.LiquidGlass and 0.84 or 0.9
),
},nil,nil,"CardHighlight")
end
end)
end

function ao.UpdateShape(aA)
local aB=ao.LinkCorners~=false
and(
ao.LinkCorners==true
or an.Window.ElementConfig.LinkCorners
or(an.ParentTable and an.ParentTable.LinkCorners==true)
)

local aC={
TopLeft=true,
TopRight=true,
BottomLeft=true,
BottomRight=true,
}
local aD="Squircle"
local aE={Position="Single",Count=1}

if aB and aA and aA.Elements then
local aF=an.ParentConfig
and an.ParentConfig.ParentTable
and an.ParentConfig.ParentTable.__type
or an.ParentType
or(an.ParentTable and an.ParentTable.__type)
aD,aC,aE=aa.GetLinkedCornerShape(
aA.Elements,
ao.Index,
aA,
aF,
an.CornerLink
or(an.ParentConfig and an.ParentConfig.CornerLink)
or an.Window.ElementConfig.CornerLink
)
end

if aD and at then
local aF=if aE.Count>1
then"Square"
else(aD=="Squircle-TL-BL"or aD=="Squircle-TR-BR")and"Squircle"or aD
at:SetType(aF)
end

aa.ApplyCornerRadii(au,UDim.new(0,ap),aC)
aa.ApplyCornerRadii(av,UDim.new(0,ap),aC)
end

ao.UpdateShape(an.Tab or an.ParentTable)

function ao.Destroy(aA)
ao.UIElements.Main:Destroy()
end

return ao.__type,ao
end

return al end function a.aw()

local aa=a.load'e'
local af=aa.New
local ai=aa.Tween

local ak={}

function ak.New(al,am)
local an={
__type="Section",
Title=am.Title or"Section",
Desc=am.Desc,
Icon=am.Icon,
IconThemed=am.IconThemed,
TextXAlignment=am.TextXAlignment or"Left",
TextSize=am.TextSize or 19,
DescTextSize=am.DescTextSize or 16,
Box=am.Box or false,
BoxBorder=am.BoxBorder or false,
FontWeight=am.FontWeight or Enum.FontWeight.SemiBold,
DescFontWeight=am.DescFontWeight or Enum.FontWeight.Medium,
TextTransparency=am.TextTransparency or 0.05,
DescTextTransparency=am.DescTextTransparency or 0.4,
Opened=am.Opened or false,
UIElements={},

HeaderSize=48,
IconSize=20,
Padding=10,

Elements={},

Expandable=false,
}

local ao

function an.SetIcon(ap,aq)
an.Icon=aq or nil
if ao then
ao:Destroy()
end
if aq then
ao=aa.Image(
aq,
aq..":"..an.Title,
0,
am.Window.Folder,
an.__type,
true,
an.IconThemed,
"SectionIcon"
)
ao.Size=UDim2.new(0,an.IconSize,0,an.IconSize)
end
end

local ap=af("Frame",{
Size=UDim2.new(0,an.IconSize,0,an.IconSize),
BackgroundTransparency=1,
Visible=false,
},{
af("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=aa.Icon"chevron-down"[1],
ImageRectSize=aa.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=aa.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageTransparency="SectionExpandIconTransparency",
ImageColor3="SectionExpandIcon",
},
}),
})

if an.Icon then
an:SetIcon(an.Icon)
end

local aq=af("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
af("UIListLayout",{
FillDirection="Vertical",
HorizontalAlignment=an.TextXAlignment,
VerticalAlignment="Center",
Padding=UDim.new(0,4),
}),
})

local ar,as

local function createTitle(at,au)
return af("TextLabel",{
BackgroundTransparency=1,
TextXAlignment=an.TextXAlignment,
AutomaticSize="Y",
TextSize=au=="Title"and an.TextSize or an.DescTextSize,
TextTransparency=au=="Title"and an.TextTransparency or an.DescTextTransparency,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(aa.Font,au=="Title"and an.FontWeight or an.DescFontWeight),


Text=at,
Size=UDim2.new(1,0,0,0),
TextWrapped=true,
Parent=aq,
})
end

ar=createTitle(an.Title,"Title")
if an.Desc then
as=createTitle(an.Desc,"Desc")
end

local function UpdateTitleSize()
local at=0
if ao then
at=at-(an.IconSize+8)
end
if ap.Visible then
at=at-(an.IconSize+8)
end
aq.Size=UDim2.new(1,at,0,0)
end

local at=aa.NewRoundFrame(am.Window.ElementConfig.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
Parent=am.Parent,

AutomaticSize="Y",
ThemeTag=an.Box and{
ImageTransparency="SectionBoxBackgroundTransparency",
ImageColor3="SectionBoxBackground",
}or nil,
ImageTransparency=not an.Box and 1 or nil,
},{
aa.NewRoundFrame(am.Window.ElementConfig.UICorner-1,"SquircleOutline",{
Size=UDim2.new(1,0,1,0),



ThemeTag={

ImageColor3="SectionBoxBorder",
},
ImageTransparency=an.Box and an.BoxBorder and 0.92 or 1,
Name="Outline",
ClipsDescendants=true,
},{
af("TextButton",{
Size=UDim2.new(1,0,0,an.Expandable and 0 or(not as and an.HeaderSize or 0)),
BackgroundTransparency=1,
AutomaticSize=(not an.Expandable or as)and"Y"or nil,
Text="",
Name="Top",
},{
an.Box and af("UIPadding",{
PaddingTop=UDim.new(
0,
am.Window.ElementConfig.UIPadding+(am.Window.NewElements and 4 or 0)
),
PaddingLeft=UDim.new(
0,
am.Window.ElementConfig.UIPadding+(am.Window.NewElements and 4 or 0)
),
PaddingRight=UDim.new(
0,
am.Window.ElementConfig.UIPadding+(am.Window.NewElements and 4 or 0)
),
PaddingBottom=UDim.new(
0,
am.Window.ElementConfig.UIPadding+(am.Window.NewElements and 4 or 0)
),
})or nil,
ao,
aq,
af("UIListLayout",{
Padding=UDim.new(0,8),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
}),
ap,
}),
af("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=false,
Position=UDim2.new(0,0,0,an.HeaderSize+10),
},{
an.Box and af("UIPadding",{
PaddingLeft=UDim.new(0,am.Window.ElementConfig.UIPadding/1.5),
PaddingRight=UDim.new(0,am.Window.ElementConfig.UIPadding/1.5),
PaddingBottom=UDim.new(0,am.Window.ElementConfig.UIPadding/1.5),
})or nil,
af("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,am.Tab.Gap),
VerticalAlignment="Top",
}),
}),
}),
})





an.ElementFrame=at

aa.AddSignal(at.Outline.Top:GetPropertyChangedSignal"AbsoluteSize",function()
at.Outline.Content.Position=UDim2.new(0,0,0,(at.Outline.Top.AbsoluteSize.Y/am.UIScale)+10)

if an.Opened then
an:Open(true)
else
an:Close(true)
end
end)

local au=am.ElementsModule

au.Load(an,at.Outline.Content,au.Elements,am.Window,am.WindUI,function()
if not an.Expandable then
an.Expandable=true
ap.Visible=true
UpdateTitleSize()
end
end,au,am.UIScale,am.Tab)

UpdateTitleSize()

function an.SetTitle(av,aw)
an.Title=aw
ar.Text=aw
end

function an.SetDesc(av,aw)
an.Desc=aw
if not as then
as=createTitle(aw,"Desc")
end
as.Text=aw
end

function an.Destroy(av)
for aw,ax in next,an.Elements do
ax:Destroy()
end








at:Destroy()
end

function an.Open(av,aw)
if an.Expandable then
an.Opened=true
if aw then
at.Size=UDim2.new(
at.Size.X.Scale,
at.Size.X.Offset,
0,
at.Outline.Top.AbsoluteSize.Y/am.UIScale
+(at.Outline.Content.AbsoluteSize.Y/am.UIScale)
+10
)
ap.ImageLabel.Rotation=180
else
ai(at,0.33,{
Size=UDim2.new(
at.Size.X.Scale,
at.Size.X.Offset,
0,
at.Outline.Top.AbsoluteSize.Y/am.UIScale
+(at.Outline.Content.AbsoluteSize.Y/am.UIScale)
+10
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ai(
ap.ImageLabel,
0.2,
{Rotation=180},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end
end
function an.Close(av,aw)
if an.Expandable then
an.Opened=false
if aw then
at.Size=UDim2.new(
at.Size.X.Scale,
at.Size.X.Offset,
0,
(at.Outline.Top.AbsoluteSize.Y/am.UIScale)
)
ap.ImageLabel.Rotation=0
else
ai(at,0.26,{
Size=UDim2.new(
at.Size.X.Scale,
at.Size.X.Offset,
0,
(at.Outline.Top.AbsoluteSize.Y/am.UIScale)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ai(
ap.ImageLabel,
0.2,
{Rotation=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end
end

aa.AddSignal(at.Outline.Top.MouseButton1Click,function()
if an.Expandable then
if an.Opened then
an:Close()
else
an:Open()
end
end
end)

aa.AddSignal(at.Outline.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if an.Opened then
an:Open(true)
else
an:Close(true)
end
end)

task.defer(function()
if an.Expandable then








at.Size=
UDim2.new(at.Size.X.Scale,at.Size.X.Offset,0,at.Outline.Top.AbsoluteSize.Y/am.UIScale)
at.AutomaticSize="None"
at.Outline.Top.Size=UDim2.new(1,0,0,(not as and an.HeaderSize or 0))
at.Outline.Top.AutomaticSize=(not an.Expandable or as)and"Y"or"None"
at.Outline.Content.Visible=true
end
if an.Opened then
an:Open()
else
an:Close(true)
end
end)

return an.__type,an
end

return ak end function a.ax()

local aa=a.load'e'
local af=aa.New

local ai={}

function ai.New(ak,al)
local am=af("Frame",{
Parent=al.Parent,
Size=not table.find({"Group","HStack"},al.ParentType)and UDim2.new(1,-7,0,7*(al.Columns or 1))or UDim2.new(0,7*(al.Columns or 1),0,0),
BackgroundTransparency=1,
})

return"Space",{__type="Space",ElementFrame=am}
end

return ai end function a.ay()
local aa=a.load'e'
local af=aa.New

local ai={}

local function ParseAspectRatio(ak)
if type(ak)=="string"then
local al,am=ak:match"(%d+):(%d+)"
if al and am then
return tonumber(al)/tonumber(am)
end
elseif type(ak)=="number"then
return ak
end
return nil
end

function ai.New(ak,al)
local am={
__type="Image",
Image=al.Image or"",
AspectRatio=al.AspectRatio or"16:9",
Radius=al.Radius or al.Window.ElementConfig.UICorner,
}
local an=aa.Image(
am.Image,
am.Image,
am.Radius,
al.Window.Folder,
"Image",
false
)
if an and an.Parent then
an.Parent=al.Parent
an.Size=UDim2.new(1,0,0,0)
an.BackgroundTransparency=1












local ao=ParseAspectRatio(am.AspectRatio)
local ap

if ao then
ap=af("UIAspectRatioConstraint",{
Parent=an,
AspectRatio=ao,
AspectType="ScaleWithParentSize",
DominantAxis="Width"
})
end

function am.Destroy(aq)
an:Destroy()
end
end

return am.__type,am
end

return ai end function a.az()
local aa=a.load'e'
local af=aa.New

local ai={}

function ai.New(ak,al)
local am=al.LinkCorners==true or typeof(al.LinkCorners)=="table"
local an=al.CornerLink or(typeof(al.LinkCorners)=="table"and al.LinkCorners)
local ao=typeof(an)=="table"and(an.Gap or an.Spacing)or nil
local ap=al.Gap
or al.ElementGap
or(am and(tonumber(ao)or 1))
or(al.Tab and al.Tab.Gap)
or(al.Window.NewElements and 1 or 6)
local aq={
__type="Group",
Elements={},
ElementFrame=nil,
LinkCorners=am,
CornerLink=an,
}

local ar=af("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=al.Parent,
},{
af("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Center",

Padding=UDim.new(0,ap),
}),
})

aq.ElementFrame=ar

local as=al.ElementsModule
as.Load(
aq,
ar,
as.Elements,
al.Window,
al.WindUI,
function(at,au)
local av={}
local aw=0

for ax,ay in next,au do
if ay.__type=="Space"then
aw=aw+(ay.ElementFrame.Size.X.Offset or 6)
elseif ay.__type=="Divider"then
aw=aw+(ay.ElementFrame.Size.X.Offset or 1)
else
table.insert(av,ay)
end
end

local ax=#av
if ax==0 then
return
end

local ay=1/ax

local az=ap*(ax-1)

local aA=-(az+aw)

local aB=math.floor(aA/ax)
local aC=aA-(aB*ax)

for aD,aE in next,av do
local aF=aB
if aD<=math.abs(aC)then
aF=aF-1
end

if aE.ElementFrame then
aE.ElementFrame.Size=UDim2.new(ay,aF,1,0)
end
end
end,
as,
al.UIScale,
al.Tab
)

return aq.__type,aq
end

return ai end function a.aA()

local aa=a.load'e'
local af=aa.New

local ai={}

function ai.New(ak,al)
local am=al.LinkCorners==true or typeof(al.LinkCorners)=="table"
local an=al.CornerLink or(typeof(al.LinkCorners)=="table"and al.LinkCorners)
local ao=typeof(an)=="table"and(an.Gap or an.Spacing)or nil
local ap=al.Gap
or al.ElementGap
or(am and(tonumber(ao)or 1))
or(al.Tab and al.Tab.Gap)
or(al.Window.NewElements and 1 or 6)
local aq={
__type="HStack",
AutoSpace=al.AutoSpace or false,
Elements={},
ElementFrame=nil,
LinkCorners=am,
CornerLink=an,
MinChildWidth=math.max(tonumber(al.MinChildWidth)or 128,40),
IsStacked=false,
}

local ar=af("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=al.Parent,
},{
af("UIListLayout",{
FillDirection="Horizontal",
HorizontalAlignment="Center",

Padding=UDim.new(0,ap),
}),
})

aq.ElementFrame=ar

local as=al.ElementsModule
local function UpdateLayout(at)
at=at or aq.Elements
local au={}
local av=0
local aw=ar.AbsoluteSize.X/al.UIScale

for ax,ay in next,at do
if ay.__type=="Space"then
av=av+(ay.ElementFrame.Size.X.Offset or 6)
elseif ay.__type=="Divider"then
av=av+(ay.ElementFrame.Size.X.Offset or 1)
else
table.insert(au,ay)
end
end

local ax=#au
if ax==0 then
return
end

local ay=ap*(ax-1)
local az=aw-ay-av
local aA=aw>0 and az/ax<aq.MinChildWidth
local aB=aq.IsStacked~=aA
aq.IsStacked=aA
local aC=aA and 1 or(1/ax)
local aD=aA and 0 or-(ay+av)
local aE=math.floor(aD/ax)
local aF=aD-(aE*ax)

ar.UIListLayout.FillDirection=aA and Enum.FillDirection.Vertical
or Enum.FillDirection.Horizontal
ar.UIListLayout.HorizontalAlignment=aA and Enum.HorizontalAlignment.Left
or Enum.HorizontalAlignment.Center

for aG,aH in next,au do
local aI=aA and 0 or aE
if not aA and aG<=math.abs(aF)then
aI=aI-1
end

if aH.ElementFrame then
local aJ=aH.ElementFrame.Size
aH.ElementFrame.Size=UDim2.new(
aC,
aI,
aJ.Y.Scale==1 and 0 or aJ.Y.Scale,
aJ.Y.Scale==1 and 0 or aJ.Y.Offset
)
end
end

if aB and aq.UpdateAllElementShapes then
aq:UpdateAllElementShapes(aq)
end
end

as.Load(
aq,
ar,
as.Elements,
al.Window,
al.WindUI,
function(at,au)
UpdateLayout(au)
end,
as,
al.UIScale,
al.Tab
)

aa.AddSignal(ar:GetPropertyChangedSignal"AbsoluteSize",function()
UpdateLayout()
end)

if aq.AutoSpace then
for at in next,as.Elements do
if at~="Space"and at~="Divider"then
local au=aq[at]
aq[at]=function(av,aw)
if#aq.Elements>0 then
aq:Space()
end
return au(av,aw)
end
end
end
end

return aq.__type,aq
end

return ai end function a.aB()

local aa=a.load'e'
local af=aa.New

local ai={}

function ai.New(ak,al)
local am=al.LinkCorners==true or typeof(al.LinkCorners)=="table"
local an=al.CornerLink or(typeof(al.LinkCorners)=="table"and al.LinkCorners)
local ao=typeof(an)=="table"and(an.Gap or an.Spacing)or nil
local ap=al.Gap
or al.ElementGap
or(am and(tonumber(ao)or 1))
or(al.Tab and al.Tab.Gap)
or(al.Window.NewElements and 1 or 6)
local aq={
__type="VStack",
Elements={},
ElementFrame=nil,
LinkCorners=am,
CornerLink=an,
}

local ar=af("Frame",{
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
AutomaticSize="Y",
Parent=al.Parent,
},{
af("UIListLayout",{
FillDirection="Vertical",
HorizontalAlignment="Center",

Padding=UDim.new(0,ap),
}),
})

aq.ElementFrame=ar

local as=al.ElementsModule
as.Load(
aq,
ar,
as.Elements,
al.Window,
al.WindUI,







































nil,
as,
al.UIScale,
al.Tab
)

return aq.__type,aq
end

return ai end function a.aC()

local aa=a.load'a'

local af=aa(game:GetService"UserInputService")

local ai=a.load'e'
local ak=ai.New

local al={}














function al.New(am,an:ConfigType__DARKLUA_TYPE_a)
local ao={
__type="Viewport",
Object=an.Object,
Camera=an.Camera or Instance.new"Camera",
Interactive=an.Interactive or false,
Height=an.Height or 200,
Focused=an.Focused~=false,
}

local ap=false
local aq=false
local ar,as=0

local at=ai.NewRoundFrame(an.Window.ElementConfig.UICorner,"Squircle",{
Size=UDim2.new(1,0,0,ao.Height),
Parent=an.Parent,
ThemeTag={
ImageColor3="ViewportBackground",
ImageTransparency="ViewportBackgroundTransparency",
},
},{
ak("CanvasGroup",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ak("UICorner",{
CornerRadius=UDim.new(0,an.Window.ElementConfig.UICorner),
}),
ak("ViewportFrame",{
Name="Viewport",
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
CurrentCamera=ao.Camera,
Active=ao.Interactive,
},{
ao.Object,
}),
}),
})

local function IsTouchInsideViewport(au)
local av=at.CanvasGroup.Viewport.AbsolutePosition
local aw=at.CanvasGroup.Viewport.AbsoluteSize

return au.X>=av.X
and au.X<=av.X+aw.X
and au.Y>=av.Y
and au.Y<=av.Y+aw.Y
end

local au=an.WindUI.GenerateGUID()

ai.AddSignal(at.CanvasGroup.Viewport.MouseEnter,function()
if ao.Interactive then
an.Tab.UIElements.ContainerFrame.ScrollingEnabled=false
end
end)

ai.AddSignal(at.CanvasGroup.Viewport.InputEnded,function(av)
if
av.UserInputType==Enum.UserInputType.MouseMovement
or av.UserInputType==Enum.UserInputType.Touch
then
an.Tab.UIElements.ContainerFrame.ScrollingEnabled=true
end
end)

ai.AddSignal(at.CanvasGroup.Viewport.InputBegan,function(av)
if ao.Interactive then
if
(av.UserInputType==Enum.UserInputType.MouseButton1)
or(av.UserInputType==Enum.UserInputType.Touch and not aq)
then
if an.WindUI.CurrentInput and an.WindUI.CurrentInput~=au then
return
end

an.WindUI.CurrentInput=au

ap=true
as=av.Position
end
end
end)

ai.AddSignal(af.InputEnded,function(av)
if ao.Interactive then
if
av.UserInputType==Enum.UserInputType.MouseButton1
or av.UserInputType==Enum.UserInputType.Touch
then
if an.WindUI.CurrentInput and an.WindUI.CurrentInput~=au then
return
end

an.WindUI.CurrentInput=nil

ap=false
end
end
end)

ai.AddSignal(af.InputChanged,function(av)
if ao.Interactive and ap and not aq then
if
av.UserInputType==Enum.UserInputType.MouseMovement
or av.UserInputType==Enum.UserInputType.Touch
then
local aw=av.Position-as
as=av.Position

local ax=ao.Object:GetPivot().Position
local ay=ao.Camera

local az=CFrame.fromAxisAngle(Vector3.new(0,1,0),-aw.X*0.02)
ay.CFrame=CFrame.new(ax)*az*CFrame.new(-ax)*ay.CFrame

local aA=CFrame.fromAxisAngle(ay.CFrame.RightVector,-aw.Y*0.02)
local aB=CFrame.new(ax)*aA*CFrame.new(-ax)*ay.CFrame

if aB.UpVector.Y>0.1 then
ay.CFrame=aB
end
end
end
end)

ai.AddSignal(at.CanvasGroup.Viewport.InputChanged,function(av)
if ao.Interactive then
if av.UserInputType==Enum.UserInputType.MouseWheel then
local aw=av.Position.Z*2
ao.Camera.CFrame+=ao.Camera.CFrame.LookVector*aw
end
end
end)

ai.AddSignal(af.TouchPinch,function(av,aw,ax,ay)
if ay==Enum.UserInputState.End or ay==Enum.UserInputState.Cancel then
aq=false
return
end

if not IsTouchInsideViewport(av[1])or not IsTouchInsideViewport(av[2])then
return
end

if ao.Interactive then
if ay==Enum.UserInputState.Begin then
aq=true
ap=false
ar=(av[1]-av[2]).Magnitude
elseif ay==Enum.UserInputState.Change then
if aq then
local az=(av[1]-av[2]).Magnitude
local aA=(az-ar)*0.03
ar=az
ao.Camera.CFrame+=ao.Camera.CFrame.LookVector*aA
end
end
end
end)

local function FocusCamera()
local av=ao.Object:IsA"BasePart"and ao.Object.Size
or select(2,ao.Object:GetBoundingBox(0))
local aw=math.max(av.X,av.Y,av.Z)
local ax=aw*2
local ay=ao.Object:GetPivot().Position

ao.Camera.CFrame=
CFrame.new(ay+Vector3.new(0,aw/2,ax),ay)
end

if ao.Focused then
FocusCamera()
end

function ao.SetObject(av,aw,ax)
if ax then
aw=aw:Clone()
end
if ao.Object then
ao.Object:Destroy()
end

ao.Object=aw
ao.Object.Parent=at.CanvasGroup.Viewport
end

function ao.SetHeight(av,aw)
at.Size=UDim2.new(1,0,0,aw)
end

function ao.Focus(av)
if ao.Object then
FocusCamera()
end
end

function ao.SetCamera(av,aw)
ao.Camera=aw
at.CanvasGroup.Viewport.CurrentCamera=aw
end

function ao.SetInteractive(av,aw)
ao.Interactive=aw
at.CanvasGroup.Viewport.Active=aw
end

ao.Main=at

return ao.__type,ao
end

return al end function a.aD()



local aa=a.load'e'
local af=aa.New

local ai={}

local function ParseAspectRatio(ak)
if type(ak)=="string"then
local al,am=ak:match"(%d+):(%d+)"
if al and am then
return tonumber(al)/tonumber(am)
end
elseif type(ak)=="number"then
return ak
end
return nil
end


function ai.New(ak,al)
local am={
__type="Video",
Video=al.Video or"",
AspectRatio=al.AspectRatio or"16:9",
Radius=al.Radius or al.Window.ElementConfig.UICorner,
ElementFrame=nil,
}

local an

if am.Video then
local ao
if string.find(am.Video,"http")then
local ap=al.Window.Folder or"Temp"
if makefolder and isfolder then
if not isfolder(ap)then
makefolder(ap)
end
if not isfolder(ap.."/assets")then
makefolder(ap.."/assets")
end
end
local aq=ap.."/assets/."..aa.SanitizeFilename(am.Video)..".webm"
if not isfile or not isfile(aq)then
local ar,as=pcall(function()
local ar=game.HttpGet and game:HttpGet(am.Video)or nil
if not ar and aa.Request then
local as=aa.Request{
Url=am.Video,
Method="GET",
Headers={["User-Agent"]="Roblox/Exploit"},
}
ar=as and as.Body
end
if ar and writefile then
writefile(aq,ar)
end
end)
if not ar then
warn("[ Window.Background ] Failed to download video: "..tostring(as))
return
end
end

local ar,as=pcall(function()
return typeof(getcustomasset)=="function"and getcustomasset(aq)or aq
end)
if not ar then
warn("[ WindUI.Video ] Failed to load custom asset: "..tostring(as))
end
ao=as
else
ao=am.Video
end

an=af("VideoFrame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Video=ao,
Looped=false,
Volume=0,
Parent=al.Parent
},{
af("UICorner",{
CornerRadius=UDim.new(0,am.Radius)
}),
})
am.ElementFrame=an
an:Play()


local ap=ParseAspectRatio(am.AspectRatio)
local aq

if ap then
aq=af("UIAspectRatioConstraint",{
Parent=an,
AspectRatio=ap,
AspectType="ScaleWithParentSize",
DominantAxis="Width"
})
end
end


function am.Destroy(ao)
if an then an:Destroy()end
end

return am.__type,am
end

return ai end function a.aE()

local aa=a.load'e'

return{
Elements={
Paragraph=a.load'L',
Button=a.load'M',
Toggle=a.load'P',
Slider=a.load'Q',
ProgressBar=a.load'R',
Keybind=a.load'S',
Input=a.load'T',
Dropdown=a.load'W',
Code=a.load'Z',
Colorpicker=a.load'_',
RadioGroup=a.load'ab',
CheckboxGroup=a.load'ac',
SegmentedControl=a.load'ad',
TextArea=a.load'ae',
Stepper=a.load'af',
Callout=a.load'ag',
Badge=a.load'ai',
StatusCard=a.load'aj',
StatCard=a.load'ak',
KeyValue=a.load'al',
ChipList=a.load'am',
ActionList=a.load'an',
MeterGroup=a.load'ao',
Timeline=a.load'ap',
Accordion=a.load'aq',
EmptyState=a.load'ar',
DiscordCard=a.load'as',
TabBox=a.load'at',
Path2D=a.load'au',
Card=a.load'av',
Section=a.load'aw',
Divider=a.load'U',
Space=a.load'ax',
Image=a.load'ay',
Group=a.load'az',
HStack=a.load'aA',
VStack=a.load'aB',
Viewport=a.load'aC',
Video=a.load'aD',
},
Load=function(af,ai,ak,al,am,an,ao,ap,aq)
for ar,as in next,ak do
af[ar]=function(at,au)
au=au or{}
au.Tab=aq or af
au.ParentType=af.__type
au.ParentTable=af
au.Index=#af.Elements+1
au.GlobalIndex=#al.AllElements+1
if au.LinkCorners==nil then
au.LinkCorners=af.LinkCorners==true
or typeof(af.LinkCorners)=="table"
or(aq and(aq.LinkCorners==true or typeof(aq.LinkCorners)=="table"))
end
if au.CornerLink==nil then
au.CornerLink=af.CornerLink or(aq and aq.CornerLink)or al.ElementConfig.CornerLink
end
au.Parent=ai
au.Window=al
au.WindUI=am
au.UIScale=ap
au.ElementsModule=ao local

av, aw=as:New(au)

aw.Index=au.Index
aw.LinkCorners=au.LinkCorners
aw.CornerGroup=au.CornerGroup or au.LinkCornerGroup
aw.CornerBreak=au.CornerBreak
aw.CornerBreakBefore=au.CornerBreakBefore
aw.CornerBreakAfter=au.CornerBreakAfter

if au.Flag and typeof(au.Flag)=="string"then
if al.CurrentConfig then
al.CurrentConfig:Register(au.Flag,aw)

if al.PendingConfigData and al.PendingConfigData[au.Flag]then
local ax=al.PendingConfigData[au.Flag]

local ay=al.ConfigManager
if typeof(ax)=="table"and ay.Parser[ax.__type]then
task.defer(function()
local az,aA=pcall(function()
ay.Parser[ax.__type].Load(aw,ax)
end)

if az then
al.PendingConfigData[au.Flag]=nil
else
warn(
"[ WindUI ] Failed to apply pending config for '"
..au.Flag
.."': "
..tostring(aA)
)
end
end)
end
end
else
al.PendingFlags=al.PendingFlags or{}
al.PendingFlags[au.Flag]=aw
end
end

local ax
for ay,az in next,aw do
if typeof(az)=="table"and ay~="ElementFrame"and ay:match"Frame$"then
ax=az
break
end
end

if ax then
aw.ElementFrame=ax.UIElements.Main
function aw.SetTitle(ay,az)
return ax.SetTitle and ax:SetTitle(az)
end
function aw.SetDesc(ay,az)
return ax.SetDesc and ax:SetDesc(az)
end
function aw.SetImage(ay,az,aA)
return ax.SetImage and ax:SetImage(az,aA)
end
function aw.SetThumbnail(ay,az,aA)
return ax.SetThumbnail and ax:SetThumbnail(az,aA)
end
function aw.SetTransparency(ay,az)
return ax.SetTransparency and ax:SetTransparency(az)
end
function aw.SetLiquidGlass(ay,az)
return ax.SetLiquidGlass and ax:SetLiquidGlass(az)
end
function aw.Highlight(ay)
ax:Highlight()
end
function aw.Destroy(ay)
if aw.Cleanup then
aw:Cleanup()
end
ax:Destroy()

table.remove(al.AllElements,au.GlobalIndex)
table.remove(af.Elements,au.Index)
table.remove(aq.Elements,au.Index)
af:UpdateAllElementShapes(af)
end
end

if not aw.ElementFrame and aw.UIElements and aw.UIElements.Main then
aw.ElementFrame=aw.UIElements.Main
end

if not aw.UpdateShape and aw.ElementFrame then
function aw.UpdateShape(ay)
local az=aw.LinkCorners~=false
and(
aw.LinkCorners==true
or al.ElementConfig.LinkCorners
or(ay and ay.LinkCorners==true)
)
local aA=aa.DefaultCornerMap()
local aB={Count=1}

if az and ay and ay.Elements then
_,aA,aB=aa.GetLinkedCornerShape(
ay.Elements,
aw.Index,
ay,
ay.__type,
au.CornerLink or al.ElementConfig.CornerLink
)
end

aa.ApplyLinkedCornerSurface(
aw.ElementFrame,
UDim.new(0,al.ElementConfig.UICorner),
aA,
az and aB.Count>1
)
end
end

al.AllElements[au.GlobalIndex]=aw
af.Elements[au.Index]=aw
if aq then
aq.Elements[au.Index]=aw
end

if al.NewElements then
af:UpdateAllElementShapes(af)
end

if an then
an(aw,af.Elements)
end
return aw
end
end
function af.UpdateAllElementShapes(ar,as)
for at,au in next,as.Elements do
local av
for aw,ax in pairs(au)do
if typeof(ax)=="table"and aw:match"Frame$"then
av=ax
break
end
end

if not av and au.UpdateShape then
av=au
end

if av then

av.Index=at
if av.UpdateShape then

av.UpdateShape(as)
end
end
end
end
end,
}end function a.aF()

local aa=a.load'a'

local af=game:GetService"Players"
local ai=game:GetService"TweenService"

aa(game:GetService"UserInputService")
local ak=af.LocalPlayer:GetMouse()

local al=a.load'e'
local am=a.load'f'
local an=al.New

local ao=a.load'I'.New
local ap=a.load'A'.New



local aq={


Tabs={},
Containers={},
SelectedTab=nil,
TabCount=0,
ToolTipParent=nil,
TabHighlight=nil,

OnChangeFunc=function(aq)end,
}

local function GetImageTarget(ar)
if typeof(ar)~="Instance"then
return nil
end

if ar:IsA"ImageLabel"or ar:IsA"ImageButton"then
return ar
end

return ar:FindFirstChildWhichIsA("ImageLabel",true)or ar:FindFirstChildWhichIsA("ImageButton",true)
end

function aq.Init(ar,as,at,au)
Window=ar
WindUI=as
aq.ToolTipParent=at
aq.TabHighlight=au
return aq
end

function aq.New(ar,as)
local at=Window.TabHolderType=="top"
local au=Window.TabHolderType=="sidebar"and Window.SidebarCompact==true
local av=au
local aw=if ar.LinkCorners~=nil
then ar.LinkCorners==true or typeof(ar.LinkCorners)=="table"
else Window.LinkElementCorners==true
local ax=ar.CornerLink
or(typeof(ar.LinkCorners)=="table"and ar.LinkCorners)
or Window.ElementCornerLink
local ay=ar.Gap or ar.ElementGap
local az=typeof(ax)=="table"and(ax.Gap or ax.Spacing)or nil

local aA={
__type="Tab",
Title=ar.Title or"Tab",
Desc=ar.Desc,
Icon=ar.Icon or(av and"circle"or nil),
Golden=ar.Golden==true or ar.Premium==true,
Premium=ar.Premium==true or ar.Golden==true,
IconColor=ar.IconColor
or((ar.Golden==true or ar.Premium==true)and Color3.fromRGB(255,222,105)or nil),
IconShape=ar.IconShape,
IconThemed=ar.IconThemed,
Locked=ar.Locked,
ShowTabTitle=ar.ShowTabTitle,
TabTitleAlign=ar.TabTitleAlign or"Left",
CustomEmptyPage=(ar.CustomEmptyPage and next(ar.CustomEmptyPage)~=nil)and ar.CustomEmptyPage
or{Icon="lucide:frown",IconSize=48,Title="This tab is Empty",Desc=nil},
Border=ar.Border,
Selected=false,
Index=nil,
Parent=ar.Parent,
UIElements={},
Elements={},
ContainerFrame=nil,
UICorner=if at then 12 else Window.UICorner-(Window.UIPadding/2),
HolderType=Window.TabHolderType,
IconOnly=av,
LinkCorners=aw,
CornerLink=ax,

Gap=ay
or(aw and(tonumber(az)or 1))
or Window.ElementGap
or(Window.NewElements and(Window.LiquidGlass and 6 or 1)or 6),

TabPaddingX=if at then 12 elseif av then 8 else 4+(Window.UIPadding/2),
TabPaddingY=if at then 7 elseif av then 8 else 3+(Window.UIPadding/2),
TitlePaddingY=0,
}









if aA.IconShape then
aA.TabPaddingX=2+(Window.UIPadding/4)
aA.TabPaddingY=2+(Window.UIPadding/4)
aA.TitlePaddingY=2+(Window.UIPadding/4)
end

aq.TabCount=aq.TabCount+1

local aB=aq.TabCount
aA.Index=aB

aA.UIElements.Main=al.NewRoundFrame(aA.UICorner,"Squircle",{
BackgroundTransparency=1,
Size=if at
then UDim2.new(0,0,0,36)
elseif av then UDim2.new(1,-8,0,44)
else UDim2.new(1,-7,0,0),
AutomaticSize=if at
then Enum.AutomaticSize.X
elseif av then Enum.AutomaticSize.None
else Enum.AutomaticSize.Y,
Parent=ar.Parent,
ThemeTag={
ImageColor3="TabBackground",
},
ImageTransparency=1,
},{
al.NewRoundFrame(aA.UICorner-1,"Glass-1.4",{
Size=UDim2.new(1,1,1,1),
ThemeTag={
ImageColor3="TabBorder",
},
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageTransparency=1,
Name="Outline",
},{













}),
al.NewRoundFrame(999,"Squircle",{
Name="ActiveRail",
Size=if at then UDim2.new(0,0,0,3)else UDim2.new(0,3,0,0),
AnchorPoint=if at then Vector2.new(0.5,1)else Vector2.new(0,0.5),
Position=if at then UDim2.new(0.5,0,1,-1)else UDim2.new(0,2,0.5,0),
ImageTransparency=1,
ThemeTag={
ImageColor3="Primary",
},
}),
al.NewRoundFrame(aA.UICorner,"Squircle",{
Size=if at
then UDim2.new(0,0,1,0)
elseif av then UDim2.fromScale(1,1)
else UDim2.new(1,0,0,0),
AutomaticSize=if at
then Enum.AutomaticSize.X
elseif av then Enum.AutomaticSize.None
else Enum.AutomaticSize.Y,
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Frame",
},{
an("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,2+(Window.UIPadding/2)),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=if av
then Enum.HorizontalAlignment.Center
else Enum.HorizontalAlignment.Left,
}),
an("TextLabel",{
Text=aA.Title,
ThemeTag=not aA.Golden and{
TextColor3="TabTitle",
}or nil,
TextColor3=aA.Golden and Color3.fromRGB(255,232,144)or nil,
TextTransparency=not aA.Locked and(aA.Golden and 0.12 or 0.4)or 0.7,
TextSize=15,
Size=if at then UDim2.new(0,0,1,0)else UDim2.new(1,0,0,0),
FontFace=Font.new(al.Font,Enum.FontWeight.Medium),
TextWrapped=true,
RichText=true,
AutomaticSize=if at then Enum.AutomaticSize.X else Enum.AutomaticSize.Y,
Visible=not av,
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
},{
an("UIPadding",{
PaddingTop=UDim.new(0,aA.TitlePaddingY),


PaddingBottom=UDim.new(0,aA.TitlePaddingY),
}),
}),
an("UIPadding",{
PaddingTop=UDim.new(0,aA.TabPaddingY),
PaddingLeft=UDim.new(0,aA.TabPaddingX),
PaddingRight=UDim.new(0,aA.TabPaddingX),
PaddingBottom=UDim.new(0,aA.TabPaddingY),
}),
}),
},true)

if aA.Golden then
aA.UIElements.Main.Frame.ImageColor3=Color3.fromRGB(64,49,18)
aA.UIElements.Main.Frame.ImageTransparency=0.88
aA.UIElements.Main.Outline.ImageColor3=Color3.fromRGB(255,214,92)
aA.UIElements.Main.Outline.ImageTransparency=0.78
aA.UIElements.GoldenShine=an("UIGradient",{
Rotation=18,
Offset=Vector2.new(-1,0),
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,185,56)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,244,184)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(154,94,18)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0,0.88),
NumberSequenceKeypoint.new(0.48,0.72),
NumberSequenceKeypoint.new(0.55,0.18),
NumberSequenceKeypoint.new(0.64,0.74),
NumberSequenceKeypoint.new(1,0.9),
},
Parent=aA.UIElements.Main.Frame,
})

if am:IsEnabled()and not am.Reduced then
task.spawn(function()
while aA.UIElements.Main and aA.UIElements.Main.Parent and aA.UIElements.GoldenShine do
aA.UIElements.GoldenShine.Offset=Vector2.new(-1,0)
local aC=ai:Create(
aA.UIElements.GoldenShine,
TweenInfo.new(1.4,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
{Offset=Vector2.new(1,0)}
)
aC:Play()
aC.Completed:Wait()
task.wait(1.1)
end
end)
end
end

local aC=0
local aD
local aE

if aA.Icon then
local aF=tostring(aA.Icon)..":"..aA.Title
aD=al.Image(
aA.Icon,
aF,
0,
Window.Folder,
aA.__type,
aA.IconColor and false or true,
aA.IconThemed,
"TabIcon"
)
aD.Size=UDim2.fromOffset(av and 20 or 16,av and 20 or 16)
local aG=GetImageTarget(aD)
if aA.IconColor and aG then
aG.ImageColor3=aA.IconColor
end
if not aA.IconShape or av then
aD.Parent=aA.UIElements.Main.Frame
aA.UIElements.Icon=aD
if aG then
aG.ImageTransparency=not aA.Locked and 0 or 0.7
end
aC=-18-(Window.UIPadding/2)
if not at and not av then
aA.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,aC,0,0)
end
elseif aA.IconColor then
al.NewRoundFrame(
aA.IconShape~="Circle"and(aA.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Squircle",
{
Size=UDim2.new(0,26,0,26),
ImageColor3=aA.IconColor,
Parent=aA.UIElements.Main.Frame,
},
{
aD,
al.NewRoundFrame(
aA.IconShape~="Circle"and(aA.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Glass-1.4",
{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=0,
Name="Outline",
},
{













}
),
}
)
aD.AnchorPoint=Vector2.new(0.5,0.5)
aD.Position=UDim2.new(0.5,0,0.5,0)
if aG then
aG.ImageTransparency=0
aG.ImageColor3=al.GetTextColorForHSB(aA.IconColor,0.68)
end
aC=-28-(Window.UIPadding/2)
aA.UIElements.Main.Frame.TextLabel.Size=UDim2.new(1,aC,0,0)
end

aE=al.Image(aA.Icon,aF,0,Window.Folder,aA.__type,true,aA.IconThemed)
aE.Size=UDim2.new(0,16,0,16)
local aH=GetImageTarget(aE)
if aH then
aH.ImageTransparency=not aA.Locked and 0 or 0.7
end
aC=-30




end

aA.UIElements.ContainerFrame=an("ScrollingFrame",{
Size=UDim2.new(1,0,1,aA.ShowTabTitle and-((Window.UIPadding*2.4)+12)or 0),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,0,1,0),
AutomaticCanvasSize="Y",

ScrollingDirection="Y",
},{
an("UIPadding",{
PaddingTop=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingLeft=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingRight=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingBottom=UDim.new(0,not Window.HidePanelBackground and 20 or 10),
}),
an("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,aA.Gap),
HorizontalAlignment="Center",
}),
})





aA.UIElements.ContainerFrameCanvas=an("CanvasGroup",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
GroupTransparency=1,
Visible=false,
Parent=Window.UIElements.MainBar,
ZIndex=5,
},{
aA.UIElements.ContainerFrame,
an("Frame",{
Size=UDim2.new(1,-14,1,-14),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Name="ScrollSliderHolder",
}),
an("Frame",{
Size=UDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
BackgroundTransparency=1,
Visible=aA.ShowTabTitle or false,
Name="TabTitle",
},{
aE,
an("TextLabel",{
Text=aA.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=20,
TextTransparency=0.1,
Size=UDim2.new(0,0,1,0),
FontFace=Font.new(al.Font,Enum.FontWeight.SemiBold),

RichText=true,
LayoutOrder=2,
TextXAlignment="Left",
BackgroundTransparency=1,
AutomaticSize="X",
}),
an("UIPadding",{
PaddingTop=UDim.new(0,20),
PaddingLeft=UDim.new(0,20),
PaddingRight=UDim.new(0,20),
PaddingBottom=UDim.new(0,20),
}),
an("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,10),
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment=aA.TabTitleAlign,
}),
}),
an("Frame",{
Size=UDim2.new(1,0,0,1),
BackgroundTransparency=0.9,
ThemeTag={
BackgroundColor3="Text",
},
Position=UDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
Visible=aA.ShowTabTitle or false,
}),
})

aq.Containers[aB]=aA.UIElements.ContainerFrameCanvas
aq.Tabs[aB]=aA

aA.ContainerFrame=aA.UIElements.ContainerFrameCanvas

al.AddSignal(aA.UIElements.Main.MouseButton1Click,function()
if not aA.Locked then
aq:SelectTab(aB)
end
end)

am.AttachPress(aA.UIElements.Main,al,{
Amount=0.985,
})

if Window.ScrollBarEnabled then
ap(
aA.UIElements.ContainerFrame,
aA.UIElements.ContainerFrameCanvas.ScrollSliderHolder,
Window,
4,
WindUI
)
end

local aF
local aG=if av then aA.Desc or aA.Title else aA.Desc
local aH
local aI
local aJ=false


if aG then
al.AddSignal(aA.UIElements.Main.InputBegan,function()
aJ=true
aH=task.spawn(function()
task.wait(0.35)
if aJ and not aF then
aF=ao(aG,aq.ToolTipParent,true)
aF.Container.AnchorPoint=Vector2.new(0.5,0.5)

local function updatePosition()
if aF then
aF.Container.Position=UDim2.new(0,ak.X,0,ak.Y-4)
end
end

updatePosition()
aI=ak.Move:Connect(updatePosition)
aF:Open()
end
end)
end)
end

al.AddSignal(aA.UIElements.Main.MouseEnter,function()
if not aA.Locked and not aA.Selected then
al.SetThemeTag(aA.UIElements.Main.Frame,{
ImageTransparency="TabBackgroundHoverTransparency",
ImageColor3="TabBackgroundHover",
},0.1)
end
end)
al.AddSignal(aA.UIElements.Main.MouseLeave,function()
if not aA.Locked and not aA.Selected then
am.Play(aA.UIElements.Main.Frame,"Hover",{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"TabHover")
end
end)
al.AddSignal(aA.UIElements.Main.InputEnded,function()
if aG then
aJ=false
if aH then
task.cancel(aH)
aH=nil
end
if aI then
aI:Disconnect()
aI=nil
end
if aF then
aF:Close()
aF=nil
end
end

if not aA.Locked and not aA.Selected then
am.Play(aA.UIElements.Main.Frame,"Hover",{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"TabHover")
end
end)

function aA.ScrollToTheElement(aK,aL)
aA.UIElements.ContainerFrame.ScrollingEnabled=false

am.Play(aA.UIElements.ContainerFrame,"Resize",{
CanvasPosition=Vector2.new(
0,
aA.Elements[aL].ElementFrame.AbsolutePosition.Y
-aA.UIElements.ContainerFrame.AbsolutePosition.Y
-aA.UIElements.ContainerFrame.UIPadding.PaddingTop.Offset
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"ScrollToElement")

task.spawn(function()
task.wait(am.GetDuration"Resize"+0.03)

if aA.Elements[aL].Highlight then
aA.Elements[aL]:Highlight()
end
aA.UIElements.ContainerFrame.ScrollingEnabled=true
end)

return aA
end



local aK=a.load'aE'

aK.Load(
aA,
aA.UIElements.ContainerFrame,
aK.Elements,
Window,
WindUI,
nil,
aK,
as,
aA
)

function aA.LockAll(aL)

for aM,aN in next,Window.AllElements do
if aN.Tab and aN.Tab.Index and aN.Tab.Index==aA.Index and aN.Lock then
aN:Lock()
end
end
end
function aA.UnlockAll(aL)
for aM,aN in next,Window.AllElements do
if aN.Tab and aN.Tab.Index and aN.Tab.Index==aA.Index and aN.Unlock then
aN:Unlock()
end
end
end
function aA.GetLocked(aL)
local aM={}

for aN,aO in next,Window.AllElements do
if aO.Tab and aO.Tab.Index and aO.Tab.Index==aA.Index and aO.Locked==true then
table.insert(aM,aO)
end
end

return aM
end
function aA.GetUnlocked(aL)
local aM={}

for aN,aO in next,Window.AllElements do
if aO.Tab and aO.Tab.Index and aO.Tab.Index==aA.Index and aO.Locked==false then
table.insert(aM,aO)
end
end

return aM
end

function aA.Select(aL)
return aq:SelectTab(aA.Index)
end

task.spawn(function()
local aL
if aA.CustomEmptyPage.Icon then
aL=
al.Image(aA.CustomEmptyPage.Icon,aA.CustomEmptyPage.Icon,0,"Temp","EmptyPage",true)
aL.Size=
UDim2.fromOffset(aA.CustomEmptyPage.IconSize or 48,aA.CustomEmptyPage.IconSize or 48)
end

local aM=an("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
Parent=aA.UIElements.ContainerFrame,
},{
an("UIListLayout",{
Padding=UDim.new(0,8),
SortOrder="LayoutOrder",
VerticalAlignment="Center",
HorizontalAlignment="Center",
FillDirection="Vertical",
}),











aL,
aA.CustomEmptyPage.Title
and an("TextLabel",{
AutomaticSize="XY",
Text=aA.CustomEmptyPage.Title,
ThemeTag={
TextColor3="Text",
},
TextSize=18,
TextTransparency=0.5,
BackgroundTransparency=1,
FontFace=Font.new(al.Font,Enum.FontWeight.Medium),
})
or nil,
aA.CustomEmptyPage.Desc
and an("TextLabel",{
AutomaticSize="XY",
Text=aA.CustomEmptyPage.Desc,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=0.65,
BackgroundTransparency=1,
FontFace=Font.new(al.Font,Enum.FontWeight.Regular),
})
or nil,
})





local aN
aN=al.AddSignal(aA.UIElements.ContainerFrame.ChildAdded,function()
aM.Visible=false
aN:Disconnect()
end)
end)

return aA
end

function aq.OnChange(ar,as)
aq.OnChangeFunc=as
end

local function ApplyGoldenTabVisual(ar,as)
if not ar or not ar.Golden then
return
end

local at=ar.UIElements
and ar.UIElements.Main
and ar.UIElements.Main.Frame
and ar.UIElements.Main.Frame.TextLabel
if at then
at.TextColor3=as and Color3.fromRGB(255,244,184)or Color3.fromRGB(255,224,120)
at.TextTransparency=as and 0 or 0.12
end

local au=ar.UIElements and ar.UIElements.Icon and GetImageTarget(ar.UIElements.Icon)
if au then
au.ImageColor3=ar.IconColor or Color3.fromRGB(255,222,105)
au.ImageTransparency=as and 0 or 0.08
end

local av=ar.UIElements and ar.UIElements.Main and ar.UIElements.Main.Outline
if av then
av.ImageColor3=as and Color3.fromRGB(255,232,132)or Color3.fromRGB(255,214,92)
av.ImageTransparency=as and 0.58 or 0.78
end
end

local function ApplyTabMotionVisual(ar,as)
if not ar or not ar.UIElements or not ar.UIElements.Main then
return
end

local at=ar.UIElements.Main.ActiveRail
if at then
if ar.Golden then
at.ImageColor3=as and Color3.fromRGB(255,232,132)or Color3.fromRGB(255,214,92)
end

local au
if ar.HolderType=="top"then
au=as and UDim2.new(1,-16,0,3)or UDim2.new(0,0,0,3)
else
au=as and UDim2.new(0,3,1,-12)or UDim2.new(0,3,0,0)
end

am.Play(at,"Switch",{
Size=au,
ImageTransparency=as and 0.08 or 1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"TabRail")
end

if not as and ar.UIElements.Main.Frame then
am.Play(ar.UIElements.Main.Frame,"Hover",{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"TabHover")
end
end

function aq.SelectTab(ar,as)
local at=aq.Tabs[as]
if at and not at.Locked and aq.SelectedTab~=as then
aq.SelectedTab=as

for au,av in next,aq.Tabs do
if not av.Locked then
al.SetThemeTag(av.UIElements.Main,{
ImageTransparency="TabBorderTransparency",
},0.15)
if av.Border then
al.SetThemeTag(av.UIElements.Main.Outline,{
ImageTransparency="TabBorderTransparency",
},0.15)
end
al.SetThemeTag(av.UIElements.Main.Frame.TextLabel,{
TextTransparency="TabTextTransparency",
},0.15)
local aw=av.UIElements.Icon and GetImageTarget(av.UIElements.Icon)
if aw and not av.IconColor then
al.SetThemeTag(aw,{
ImageTransparency="TabIconTransparency",
},0.15)
end
av.Selected=false
ApplyGoldenTabVisual(av,false)
ApplyTabMotionVisual(av,false)
end
end
al.SetThemeTag(at.UIElements.Main,{
ImageColor3="TabBackgroundActive",
ImageTransparency="TabBackgroundActiveTransparency",
},0.15)
if at.Border then
al.SetThemeTag(at.UIElements.Main.Outline,{
ImageTransparency="TabBorderTransparencyActive",
},0.15)
end
al.SetThemeTag(at.UIElements.Main.Frame.TextLabel,{
TextTransparency="TabTextTransparencyActive",
},0.15)
local au=at.UIElements.Icon and GetImageTarget(at.UIElements.Icon)
if au and not at.IconColor then
al.SetThemeTag(au,{
ImageTransparency="TabIconTransparencyActive",
},0.15)
end
at.Selected=true
ApplyGoldenTabVisual(at,true)
ApplyTabMotionVisual(at,true)

task.spawn(function()
local av=aq.Containers[as]
for aw,ax in next,aq.Containers do
if ax~=av then
ax.AnchorPoint=Vector2.new(0,0.035)
ax.GroupTransparency=1
ax.Visible=false
end
end
av.AnchorPoint=Vector2.new(0,0.035)
av.GroupTransparency=1
av.Visible=true
am.Play(av,"Switch",{
AnchorPoint=Vector2.new(0,0),
GroupTransparency=0,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out,"Select")
end)

aq.OnChangeFunc(as)
end
end

return aq end function a.aG()

local aa={}


local af=a.load'e'
local ai=af.New
local ak=af.Tween

local al=a.load'aF'

function aa.New(am,an,ao,ap,aq)
local ar={
Title=am.Title or"Section",
Icon=am.Icon,
IconThemed=am.IconThemed,
Opened=am.Opened or false,

HeaderSize=42,
IconSize=18,

Expandable=false,
}

local as
if ar.Icon then
as=af.Image(
ar.Icon,
ar.Icon,
0,
ao,
"Section",
true,
ar.IconThemed,
"TabSectionIcon"
)

as.Size=UDim2.new(0,ar.IconSize,0,ar.IconSize)
as.ImageLabel.ImageTransparency=.25
end

local at=ai("Frame",{
Size=UDim2.new(0,ar.IconSize,0,ar.IconSize),
BackgroundTransparency=1,
Visible=false
},{
ai("ImageLabel",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Image=af.Icon"chevron-down"[1],
ImageRectSize=af.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=af.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=.7,
})
})

local au=ai("Frame",{
Size=UDim2.new(1,0,0,ar.HeaderSize),
BackgroundTransparency=1,
Parent=an,
ClipsDescendants=true,
},{
ai("TextButton",{
Size=UDim2.new(1,0,0,ar.HeaderSize),
BackgroundTransparency=1,
Text="",
},{
as,
ai("TextLabel",{
Text=ar.Title,
TextXAlignment="Left",
Size=UDim2.new(
1,
as and(-ar.IconSize-10)*2
or(-ar.IconSize-10),

1,
0
),
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(af.Font,Enum.FontWeight.SemiBold),
TextSize=14,
BackgroundTransparency=1,
TextTransparency=.7,

TextWrapped=true
}),
ai("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
Padding=UDim.new(0,10)
}),
at,
ai("UIPadding",{
PaddingLeft=UDim.new(0,11),
PaddingRight=UDim.new(0,11),
})
}),
ai("Frame",{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
Name="Content",
Visible=true,
Position=UDim2.new(0,0,0,ar.HeaderSize)
},{
ai("UIListLayout",{
FillDirection="Vertical",
Padding=UDim.new(0,aq.Gap),
VerticalAlignment="Bottom",
}),
})
})


function ar.Tab(av,aw)
if not ar.Expandable then
ar.Expandable=true
at.Visible=true
end
aw.Parent=au.Content
return al.New(aw,ap)
end

function ar.Open(av)
if ar.Expandable then
ar.Opened=true
ak(au,0.33,{
Size=UDim2.new(1,0,0,ar.HeaderSize+(au.Content.AbsoluteSize.Y/ap))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ak(at.ImageLabel,0.1,{Rotation=180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
function ar.Close(av)
if ar.Expandable then
ar.Opened=false
ak(au,0.26,{
Size=UDim2.new(1,0,0,ar.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ak(at.ImageLabel,0.1,{Rotation=0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

af.AddSignal(au.TextButton.MouseButton1Click,function()
if ar.Expandable then
if ar.Opened then
ar:Close()
else
ar:Open()
end
end
end)

af.AddSignal(au.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()
if ar.Opened then
ar:Open()
end
end)

if ar.Opened then
task.spawn(function()
task.wait()
ar:Open()
end)
end



return ar
end


return aa end function a.aH()
return{
Tab="table-of-contents",
Paragraph="type",
Button="square-mouse-pointer",
Toggle="toggle-right",
Slider="sliders-horizontal",
Keybind="command",
Input="text-cursor-input",
Dropdown="chevrons-up-down",
Code="terminal",
Colorpicker="palette",
}end function a.aI()
local aa=a.load'a'

aa(game:GetService"UserInputService")

local af={
Margin=8,
Padding=9,
}

local ai=a.load'e'
local ak=ai.New
local al=ai.Tween

function af.new(am,an,ao)
local ap={
IconSize=18,
Padding=14,
Radius=22,
Width=400,
MaxHeight=380,

Icons=a.load'aH',
}

local aq=ak("TextBox",{
Text="",
PlaceholderText="Search...",
ThemeTag={
PlaceholderColor3="Placeholder",
TextColor3="Text",
},
Size=UDim2.new(1,-((ap.IconSize*2)+(ap.Padding*2)),0,0),
AutomaticSize="Y",
ClipsDescendants=true,
ClearTextOnFocus=false,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ai.Font,Enum.FontWeight.Regular),
TextSize=18,
})

local ar=ak("ImageLabel",{
Image=ai.Icon"x"[1],
ImageRectSize=ai.Icon"x"[2].ImageRectSize,
ImageRectOffset=ai.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,ap.IconSize,0,ap.IconSize),
},{
ak("TextButton",{
Size=UDim2.new(1,8,1,8),
BackgroundTransparency=1,
Active=true,
ZIndex=999999999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Text="",
}),
})

local as=ak("ScrollingFrame",{
Size=UDim2.new(1,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ElasticBehavior="Never",
ScrollBarThickness=0,
CanvasSize=UDim2.new(0,0,0,0),
BackgroundTransparency=1,
Visible=false,
},{
ak("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
ak("UIPadding",{
PaddingTop=UDim.new(0,ap.Padding),
PaddingLeft=UDim.new(0,ap.Padding),
PaddingRight=UDim.new(0,ap.Padding),
PaddingBottom=UDim.new(0,ap.Padding),
}),
})

local at=ai.NewRoundFrame(ap.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="WindowSearchBarBackground",
},
ImageTransparency=0,
},{
ai.NewRoundFrame(ap.Radius,"Squircle",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,

Visible=false,
ThemeTag={
ImageColor3="White",
},
ImageTransparency=1,
Name="Frame",
},{
ak("Frame",{
Size=UDim2.new(1,0,0,46),
BackgroundTransparency=1,
},{








ak("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
},{
ak("ImageLabel",{
Image=ai.Icon"search"[1],
ImageRectSize=ai.Icon"search"[2].ImageRectSize,
ImageRectOffset=ai.Icon"search"[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,ap.IconSize,0,ap.IconSize),
}),
aq,
ar,
ak("UIListLayout",{
Padding=UDim.new(0,ap.Padding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ak("UIPadding",{
PaddingLeft=UDim.new(0,ap.Padding),
PaddingRight=UDim.new(0,ap.Padding),
}),
}),
}),
ak("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Results",
},{
ak("Frame",{
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Outline",
},
BackgroundTransparency=0.9,
Visible=false,
}),
as,
ak("UISizeConstraint",{
MaxSize=Vector2.new(ap.Width,ap.MaxHeight),
}),
}),
ak("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
})

local au=ak("Frame",{
Size=UDim2.new(0,ap.Width,0,0),
AutomaticSize="Y",
Parent=an,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Visible=false,

ZIndex=99999999,
},{
ak("UIScale",{
Scale=0.9,
}),
at,















})

local function CreateSearchTab(av,aw,ax,ay,az,aA)
local aB=ak("TextButton",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=ay or nil,
},{
ai.NewRoundFrame(ap.Radius-11,"Squircle",{
Size=UDim2.new(1,0,0,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),

ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Main",
},{
ai.NewRoundFrame(ap.Radius-11,"Glass-1",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
ImageColor3="White",
},
ImageTransparency=1,
Name="Outline",
},{








ak("UIPadding",{
PaddingTop=UDim.new(0,ap.Padding-2),
PaddingLeft=UDim.new(0,ap.Padding),
PaddingRight=UDim.new(0,ap.Padding),
PaddingBottom=UDim.new(0,ap.Padding-2),
}),
ak("ImageLabel",{
Image=ai.Icon(ax)[1],
ImageRectSize=ai.Icon(ax)[2].ImageRectSize,
ImageRectOffset=ai.Icon(ax)[2].ImageRectPosition,
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Icon",
},
ImageTransparency=0.1,
Size=UDim2.new(0,ap.IconSize,0,ap.IconSize),
}),
ak("Frame",{
Size=UDim2.new(1,-ap.IconSize-ap.Padding,0,0),
BackgroundTransparency=1,
},{
ak("TextLabel",{
Text=av,
ThemeTag={
TextColor3="Text",
},
TextSize=17,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ai.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Title",
}),
ak("TextLabel",{
Text=aw or"",
Visible=aw and true or false,
ThemeTag={
TextColor3="Text",
},
TextSize=15,
TextTransparency=0.3,
BackgroundTransparency=1,
TextXAlignment="Left",
FontFace=Font.new(ai.Font,Enum.FontWeight.Medium),
Size=UDim2.new(1,0,0,0),
TextTruncate="AtEnd",
AutomaticSize="Y",
Name="Desc",
})or nil,
ak("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Vertical",
}),
}),
ak("UIListLayout",{
Padding=UDim.new(0,ap.Padding),
FillDirection="Horizontal",
}),
}),
},true),
ak("Frame",{
Name="ParentContainer",
Size=UDim2.new(1,-ap.Padding,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Visible=az,

},{
ai.NewRoundFrame(99,"Squircle",{
Size=UDim2.new(0,2,1,0),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=0.9,
}),
ak("Frame",{
Size=UDim2.new(1,-ap.Padding-2,0,0),
Position=UDim2.new(0,ap.Padding+2,0,0),
BackgroundTransparency=1,
},{
ak("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
}),
}),
}),
ak("UIListLayout",{
Padding=UDim.new(0,0),
FillDirection="Vertical",
HorizontalAlignment="Right",
}),
})



aB.Main.Size=UDim2.new(
1,
0,
0,
aB.Main.Outline.Frame.Desc.Visible
and(((ap.Padding-2)*2)+aB.Main.Outline.Frame.Title.TextBounds.Y+6+aB.Main.Outline.Frame.Desc.TextBounds.Y)
or(((ap.Padding-2)*2)+aB.Main.Outline.Frame.Title.TextBounds.Y)
)

ai.AddSignal(aB.Main.MouseEnter,function()
al(aB.Main,0.04,{ImageTransparency=0.95}):Play()

end)
ai.AddSignal(aB.Main.InputEnded,function()
al(aB.Main,0.08,{ImageTransparency=1}):Play()

end)
ai.AddSignal(aB.Main.MouseButton1Click,function()
if aA then
aA()
end
end)

return aB
end

local function ContainsText(av,aw)
if not aw or aw==""then
return false
end

if not av or av==""then
return false
end

local ax=string.lower(av)
local ay=string.lower(aw)

return string.find(ax,ay,1,true)~=nil
end

local function Search(av)
if not av or av==""then
return{}
end

local aw={}
for ax,ay in next,am.Tabs do
local az=ContainsText(ay.Title or"",av)
local aA={}

for aB,aC in next,ay.Elements do
if aC.__type~="Section"then
local aD=ContainsText(aC.Title or"",av)
local aE=ContainsText(aC.Desc or"",av)

if aD or aE then
aA[aB]={
Title=aC.Title,
Desc=aC.Desc,
Original=aC,
__type=aC.__type,
Index=aB,
}
end
end
end

if az or next(aA)~=nil then
aw[ax]={
Tab=ay,
Title=ay.Title,
Icon=ay.Icon,
Elements=aA,
}
end
end
return aw
end

ai.AddSignal(as.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",function()

al(as,0.06,{
Size=UDim2.new(
1,
0,
0,
math.clamp(
as.UIListLayout.AbsoluteContentSize.Y+(ap.Padding*2),
0,
ap.MaxHeight
)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()






end)

function ap.Open(av)
task.spawn(function()
at.Frame.Visible=true
au.Visible=true
al(au.UIScale,0.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end

function ap.Close(av,aw)
task.spawn(function()
ao()
at.Frame.Visible=false
al(au.UIScale,0.12,{Scale=1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.wait(0.12)
au.Visible=false
if aw then
au:Destroy()
end
end)
end

ai.AddSignal(ar.TextButton.MouseButton1Click,function()
ap:Close(true)
end)

ap:Open()

function ap.Search(av,aw)
aw=aw or""

local ax=Search(aw)

as.Visible=true
at.Frame.Results.Frame.Visible=true
for ay,az in next,as:GetChildren()do
if az.ClassName~="UIListLayout"and az.ClassName~="UIPadding"then
az:Destroy()
end
end

if ax and next(ax)~=nil then
for ay,az in next,ax do
local aA=ap.Icons.Tab
local aB=CreateSearchTab(az.Title,nil,aA,as,true,function()
ap:Close()
am:SelectTab(ay)
end)
if az.Elements and next(az.Elements)~=nil then
for aC,aD in next,az.Elements do
local aE=ap.Icons[aD.__type]
CreateSearchTab(
aD.Title,
aD.Desc,
aE,
aB:FindFirstChild"ParentContainer"and aB.ParentContainer.Frame
or nil,
false,
function()
ap:Close()
am:SelectTab(ay)
if az.Tab.ScrollToTheElement then

az.Tab:ScrollToTheElement(aD.Index)
end

end
)

end
end
end
elseif aw~=""then
ak("TextLabel",{
Size=UDim2.new(1,0,0,70),
Text="No results found",
TextSize=16,
ThemeTag={
TextColor3="Text",
},
TextTransparency=0.2,
BackgroundTransparency=1,
FontFace=Font.new(ai.Font,Enum.FontWeight.Medium),
Parent=as,
Name="NotFound",
})
else
as.Visible=false
at.Frame.Results.Frame.Visible=false
end
end

ai.AddSignal(aq:GetPropertyChangedSignal"Text",function()
ap:Search(aq.Text)
end)

return ap
end

return af end function a.aJ()



local aa=a.load'a'

local af=aa(game:GetService"UserInputService")
local ai=aa(game:GetService"RunService")
local ak=aa(game:GetService"Players")

local al=workspace.CurrentCamera

local am=a.load'w'

local an=a.load'e'
local ao=a.load'f'
local ap=an.New
local aq=an.Tween


local ar=a.load'z'.New
local as=a.load'o'.New
local at=a.load'A'.New
local au=a.load'B'

local av=a.load'C'



return function(aw)
local ax=aw.Default==true or aw.Preset=="Default"or aw.Preset=="Obsidian"
local ay=aw.SideBarWidth~=nil
local function Pick(az,aA)
if az~=nil then
return az
end
return aA
end
local function PickAlias(az,aA,aB)
if az~=nil then
return az
end
if aA~=nil then
return aA
end
return aB
end a.load'D'


.Apply(aw)

if ax then
aw.NewElements=Pick(aw.NewElements,true)
aw.LiquidGlass=PickAlias(aw.LiquidGlass,aw.GlassLiquid,true)
aw.HideSearchBar=Pick(aw.HideSearchBar,false)
aw.LinkElementCorners=PickAlias(aw.LinkElementCorners,aw.ElementsLinkCorners,true)
aw.CornerLink=aw.CornerLink
or aw.LinkedCornerOptions
or(typeof(aw.LinkElementCorners)=="table"and aw.LinkElementCorners)
or(typeof(aw.ElementsLinkCorners)=="table"and aw.ElementsLinkCorners)
or{
InnerRadius=0,
BridgeHidden=true,
}
local az=typeof(aw.CornerLink)=="table"and(aw.CornerLink.Gap or aw.CornerLink.Spacing)
aw.ElementGap=PickAlias(
aw.ElementGap,
aw.ElementsGap,
aw.LinkElementCorners and(tonumber(az)or 1)or 8
)
aw.ElementTransparency=PickAlias(aw.ElementTransparency,aw.ElementsTransparency,0.18)
aw.BackgroundOverlayTransparency=Pick(aw.BackgroundOverlayTransparency,0.5)
aw.BackgroundColor=Pick(aw.BackgroundColor,Color3.fromHex"#101821")
aw.Radius=Pick(aw.Radius,20)
aw.SideBarWidth=Pick(aw.SideBarWidth,210)
aw.Topbar=aw.Topbar or{
Height=48,
ButtonsType="Mac",
}
end

local az=
tostring(aw.TabHolderType or aw.TabHolder or"sidebar"):lower():gsub("[%s_%-]","")
local aA=az=="compact"
or az=="sidebarcompact"
or az=="icon"
or az=="icononly"
local aB=if az=="top"or az=="horizontal"
then"top"
else"sidebar"
local aC=aB=="sidebar"
and(
aA
or aw.SidebarCompact==true
or aw.SideBarCompact==true
or aw.CompactSidebar==true
)
local aD=if aC
then(aw.CompactSideBarWidth or(ay and aw.SideBarWidth or 68))
else(aw.SideBarWidth or 200)

local aE={
Title=aw.Title or"UI Library",
Author=aw.Author,
Icon=aw.Icon,
IconSize=aw.IconSize or 22,
IconThemed=aw.IconThemed,
IconRadius=aw.IconRadius or 0,
Folder=aw.Folder,
Resizable=aw.Resizable~=false,
Background=aw.Background or aw.BackgroundImage,
BackgroundColor=aw.BackgroundColor,
BackgroundGradient=aw.BackgroundGradient,
BackgroundImageTransparency=aw.BackgroundImageTransparency or 0,
BackgroundOverlayTransparency=aw.BackgroundOverlayTransparency or 0.62,
BackgroundScaleType=aw.BackgroundScaleType or"Crop",
ShadowTransparency=aw.ShadowTransparency or 0.6,
User=aw.User or{},
Footer=aw.Footer or{},
Topbar=aw.Topbar or{Height=52,ButtonsType="Default"},

Size=aw.Size,

MinSize=aw.MinSize or Vector2.new(560,350),
MaxSize=aw.MaxSize or Vector2.new(850,560),

TopBarButtonIconSize=aw.TopBarButtonIconSize,

ToggleKey=aw.ToggleKey,
ElementsRadius=aw.ElementsRadius,
Radius=aw.Radius or 16,
Transparent=aw.Transparent or false,
ElementTransparency=aw.ElementTransparency or aw.ElementsTransparency,
ElementGlassTransparency=aw.ElementGlassTransparency or aw.GlassTransparency,
LiquidGlass=aw.LiquidGlass or aw.GlassLiquid or aw.ElementGlass or false,
ElementCornerStyle=aw.ElementCornerStyle or aw.ElementsCornerStyle or aw.CornerStyle,
ElementGap=aw.ElementGap or aw.ElementsGap,
LinkElementCorners=aw.LinkElementCorners==true or aw.ElementsLinkCorners==true or typeof(
aw.LinkElementCorners
)=="table"or typeof(aw.ElementsLinkCorners)=="table",
ElementCornerLink=aw.CornerLink
or aw.LinkedCornerOptions
or(typeof(aw.LinkElementCorners)=="table"and aw.LinkElementCorners)
or(typeof(aw.ElementsLinkCorners)=="table"and aw.ElementsLinkCorners),
Watermark=aw.Watermark~=nil and aw.Watermark or aw.WaterMark,
KeyBindMenu=aw.KeyBindMenu==false and false or(aw.KeyBindMenu or{}),
TypeWindow=aw.TypeWindow,
HideSearchBar=aw.HideSearchBar~=false or aC,
ScrollBarEnabled=aw.ScrollBarEnabled or false,
SideBarWidth=aD,
TabHolderType=aB,
SidebarCompact=aC,
TopTabHeight=math.max(tonumber(aw.TopTabHeight or aw.TabHolderHeight)or 48,38),
Acrylic=aw.Acrylic or false,
NewElements=aw.NewElements or false,
Motion=aw.Motion,
Settings=aw.Settings==false and false or(aw.Settings or{}),
IgnoreAlerts=aw.IgnoreAlerts or false,
HidePanelBackground=aw.HidePanelBackground or false,
AutoScale=aw.AutoScale~=false,
OpenButton=aw.OpenButton,
DragFrameSize=160,

Position=UDim2.new(0.5,0,0.5,0),
UICorner=16,
UIPadding=14,
UIElements={},
CanDropdown=true,
Closed=false,
Parent=aw.Parent,
Destroyed=false,
IsFullscreen=false,
CanResize=aw.Resizable~=false,
IsOpenButtonEnabled=true,

CurrentConfig=nil,
ConfigManager=nil,
AcrylicPaint=nil,
CurrentTab=nil,
TabModule=nil,

OnOpenCallback=nil,
OnCloseCallback=nil,
OnDestroyCallback=nil,

IsPC=false,

Gap=5,

TopBarButtons={},
AllElements={},

ElementConfig={},

PendingFlags={},

IsToggleDragging=false,
}

aE.UICorner=aE.Radius

aE.TopBarButtonIconSize=aE.TopBarButtonIconSize or(aE.Topbar.ButtonsType=="Mac"and 11 or 16)

aE.ElementConfig={
UIPadding=(aE.NewElements and 10 or 13),
UICorner=aE.ElementsRadius or(aE.NewElements and 23 or 16),
Transparency=aE.ElementTransparency,
GlassTransparency=aE.ElementGlassTransparency or 0.24,
LiquidGlass=aE.LiquidGlass,
CornerStyle=aE.ElementCornerStyle or(aE.NewElements and"Native"or"Shape"),
LinkCorners=aE.LinkElementCorners,
CornerLink=aE.ElementCornerLink,
}

local aF=aE.Size or UDim2.new(0,580,0,460)
aE.Size=UDim2.new(
aF.X.Scale,
math.clamp(aF.X.Offset,aE.MinSize.X,aE.MaxSize.X),
aF.Y.Scale,
math.clamp(aF.Y.Offset,aE.MinSize.Y,aE.MaxSize.Y)
)

if aE.Topbar=={}then
aE.Topbar={Height=52,ButtonsType="Default"}
end

if not ai:IsStudio()and aE.Folder and writefile then
if not isfolder("WindUI/"..aE.Folder)then
makefolder("WindUI/"..aE.Folder)
end
if not isfolder("WindUI/"..aE.Folder.."/assets")then
makefolder("WindUI/"..aE.Folder.."/assets")
end
if not isfolder(aE.Folder)then
makefolder(aE.Folder)
end
if not isfolder(aE.Folder.."/assets")then
makefolder(aE.Folder.."/assets")
end
end

local aG=ap("UICorner",{
CornerRadius=UDim.new(0,aE.UICorner),
})

if aE.Folder then
aE.ConfigManager=av:Init(aE)
end

if aE.Acrylic then local
aH=am.AcrylicPaint{UseAcrylic=aE.Acrylic}

aE.AcrylicPaint=aH
end

local aH=ap("Frame",{
Size=UDim2.new(0,32,0,32),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
ZIndex=99,
Active=true,
},{
ap("ImageLabel",{
Size=UDim2.new(0,96,0,96),
BackgroundTransparency=1,
Image="rbxassetid://120997033468887",
Position=UDim2.new(0.5,-16,0.5,-16),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})
local aI=an.NewRoundFrame(aE.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=98,
Active=false,
},{
ap("ImageLabel",{
Size=UDim2.new(0,70,0,70),
Image=an.Icon"expand"[1],
ImageRectOffset=an.Icon"expand"[2].ImageRectPosition,
ImageRectSize=an.Icon"expand"[2].ImageRectSize,
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
ImageTransparency=1,
}),
})

local aJ=an.NewRoundFrame(aE.UICorner,"Squircle",{
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ImageColor3=Color3.new(0,0,0),
ZIndex=999,
Active=false,
})









aE.UIElements.SideBar=ap("ScrollingFrame",{
Size=UDim2.new(
1,
aE.ScrollBarEnabled and-3-(aE.UIPadding/2)or 0,
1,
not aE.HideSearchBar and-45 or 0
),
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
ScrollBarThickness=0,
ElasticBehavior="Never",
CanvasSize=UDim2.new(0,0,0,0),
AutomaticCanvasSize="Y",
ScrollingDirection="Y",
ClipsDescendants=true,
VerticalScrollBarPosition="Left",
},{
ap("Frame",{
BackgroundTransparency=1,
AutomaticSize="Y",
Size=UDim2.new(1,0,0,0),
Name="Frame",
},{
ap("UIPadding",{



PaddingBottom=UDim.new(0,aE.UIPadding/2),
}),
ap("UIListLayout",{
SortOrder="LayoutOrder",
Padding=UDim.new(0,aE.Gap),
}),
}),
ap("UIPadding",{

PaddingLeft=UDim.new(0,aE.UIPadding/2),
PaddingRight=UDim.new(0,aE.UIPadding/2),
PaddingBottom=UDim.new(0,aE.UIPadding/2),
}),

})

aE.UIElements.SideBarContainer=ap("Frame",{
Size=UDim2.new(
0,
aE.SideBarWidth,
1,
aE.User.Enabled and-aE.Topbar.Height-42-(aE.UIPadding*2)or-aE.Topbar.Height
),
Position=UDim2.new(0,0,0,aE.Topbar.Height),
BackgroundTransparency=1,
Visible=aE.TabHolderType=="sidebar",
},{
ap("Frame",{
Name="Content",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,not aE.HideSearchBar and-45-aE.UIPadding or-aE.UIPadding/2),
Position=UDim2.new(0,0,1,-aE.UIPadding/2),
AnchorPoint=Vector2.new(0,1),
}),
aE.UIElements.SideBar,
})

aE.UIElements.TopTabHolder=ap("ScrollingFrame",{
Name="TopTabHolder",
Size=UDim2.new(1,-aE.UIPadding,0,aE.TopTabHeight),
Position=UDim2.new(0,aE.UIPadding/2,0,aE.Topbar.Height),
BackgroundTransparency=1,
BorderSizePixel=0,
ScrollBarThickness=0,
ScrollingDirection=Enum.ScrollingDirection.X,
AutomaticCanvasSize=Enum.AutomaticSize.X,
CanvasSize=UDim2.new(0,0,0,0),
Visible=aE.TabHolderType=="top",
ClipsDescendants=true,
},{
ap("Frame",{
Name="Frame",
AutomaticSize=Enum.AutomaticSize.X,
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
},{
ap("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,6),
}),
ap("UIPadding",{
PaddingLeft=UDim.new(0,aE.UIPadding/2),
PaddingRight=UDim.new(0,aE.UIPadding/2),
}),
}),
})
aE.UIElements.TabHolder=if aE.TabHolderType=="top"
then aE.UIElements.TopTabHolder.Frame
else aE.UIElements.SideBar.Frame

if aE.TabHolderType=="sidebar"and aE.ScrollBarEnabled then
at(
aE.UIElements.SideBar,
aE.UIElements.SideBarContainer.Content,
aE,
3,
aw.WindUI
)
end

aE.UIElements.MainBar=ap("Frame",{
Size=if aE.TabHolderType=="top"
then UDim2.new(1,0,1,-(aE.Topbar.Height+aE.TopTabHeight))
else UDim2.new(1,-aE.SideBarWidth,1,-aE.Topbar.Height),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
BackgroundTransparency=1,
},{
an.NewRoundFrame(aE.UICorner-(aE.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="PanelBackground",
ImageTransparency="PanelBackgroundTransparency",
},


ZIndex=3,
Name="Background",
Visible=not aE.HidePanelBackground,
}),
ap("UIPadding",{

PaddingLeft=UDim.new(0,aE.UIPadding/2),
PaddingRight=UDim.new(0,aE.UIPadding/2),
PaddingBottom=UDim.new(0,aE.UIPadding/2),
}),
})

local aK=ap("ImageLabel",{
Image="rbxassetid://8992230677",
ThemeTag={
ImageColor3="WindowShadow",

},
ImageTransparency=1,
Size=UDim2.new(1,100,1,100),
Position=UDim2.new(0,-50,0,-50),
ScaleType="Slice",
SliceCenter=Rect.new(99,99,99,99),
BackgroundTransparency=1,
ZIndex=-999999999999999,
Name="Blur",
})

if af.TouchEnabled and not af.KeyboardEnabled then
aE.IsPC=false
elseif af.KeyboardEnabled then
aE.IsPC=true
else
aE.IsPC=nil
end







local aL
if aE.User then
local function GetUserThumb()local
aM=ak:GetUserThumbnailAsync(
aE.User.Anonymous and 1 or ak.LocalPlayer.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)
return aM
end

aL=ap("TextButton",{
Size=UDim2.new(
0,
aE.UIElements.SideBarContainer.AbsoluteSize.X-(aE.UIPadding/2),
0,
42+aE.UIPadding
),
Position=UDim2.new(0,aE.UIPadding/2,1,-(aE.UIPadding/2)),
AnchorPoint=Vector2.new(0,1),
BackgroundTransparency=1,
Visible=aE.TabHolderType=="sidebar"and(aE.User.Enabled or false),
},{
an.NewRoundFrame(aE.UICorner-(aE.UIPadding/2),"SquircleOutline",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="Outline",
},{
ap("UIGradient",{
Rotation=78,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),
an.NewRoundFrame(aE.UICorner-(aE.UIPadding/2),"Squircle",{
Size=UDim2.new(1,0,1,0),
ThemeTag={
ImageColor3="Text",
},
ImageTransparency=1,
Name="UserIcon",
},{
ap("ImageLabel",{
Image=GetUserThumb(),
BackgroundTransparency=1,
Size=UDim2.new(0,42,0,42),
ThemeTag={
BackgroundColor3="Text",
},
BackgroundTransparency=0.93,
},{
ap("UICorner",{
CornerRadius=UDim.new(1,0),
}),
}),
ap("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
},{
ap("TextLabel",{
Text=aE.User.Anonymous and"Anonymous"or ak.LocalPlayer.DisplayName,
TextSize=17,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(an.Font,Enum.FontWeight.SemiBold),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="DisplayName",
}),
ap("TextLabel",{
Text=aE.User.Anonymous and"anonymous"or ak.LocalPlayer.Name,
TextSize=15,
TextTransparency=0.6,
ThemeTag={
TextColor3="Text",
},
FontFace=Font.new(an.Font,Enum.FontWeight.Medium),
AutomaticSize="Y",
BackgroundTransparency=1,
Size=UDim2.new(1,-27,0,0),
TextTruncate="AtEnd",
TextXAlignment="Left",
Name="UserName",
}),
ap("UIListLayout",{
Padding=UDim.new(0,4),
HorizontalAlignment="Left",
}),
}),
ap("UIListLayout",{
Padding=UDim.new(0,aE.UIPadding),
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ap("UIPadding",{
PaddingLeft=UDim.new(0,aE.UIPadding/2),
PaddingRight=UDim.new(0,aE.UIPadding/2),
}),
}),
})

function aE.User.Enable(aM)
aE.User.Enabled=true
aq(
aE.UIElements.SideBarContainer,
0.25,
{Size=UDim2.new(0,aE.SideBarWidth,1,-aE.Topbar.Height-42-(aE.UIPadding*2))},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
aL.Visible=aE.TabHolderType=="sidebar"
end
function aE.User.Disable(aM)
aE.User.Enabled=false
aq(
aE.UIElements.SideBarContainer,
0.25,
{Size=UDim2.new(0,aE.SideBarWidth,1,-aE.Topbar.Height)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
aL.Visible=false
end
function aE.User.SetAnonymous(aM,aN)
if aN~=false then
aN=true
end
aE.User.Anonymous=aN
aL.UserIcon.ImageLabel.Image=GetUserThumb()
aL.UserIcon.Frame.DisplayName.Text=aN and"Anonymous"or ak.LocalPlayer.DisplayName
aL.UserIcon.Frame.UserName.Text=aN and"anonymous"or ak.LocalPlayer.Name
end

if aE.User.Enabled then
aE.User:Enable()
else
aE.User:Disable()
end

if aE.User.Callback then
an.AddSignal(aL.MouseButton1Click,function()
aE.User.Callback()
end)
an.AddSignal(aL.MouseEnter,function()
aq(aL.UserIcon,0.04,{ImageTransparency=0.95}):Play()
aq(aL.Outline,0.04,{ImageTransparency=0.85}):Play()
end)
an.AddSignal(aL.InputEnded,function()
aq(aL.UserIcon,0.04,{ImageTransparency=1}):Play()
aq(aL.Outline,0.04,{ImageTransparency=1}):Play()
end)
end
end

local aM
local aN

local aO=false
local aP

local function GetTransparencyValue(aQ,aR)
local aS=tonumber(aQ)
if aS==nil then
return aR
end
return math.clamp(math.floor(aS*100+0.5)/100,0,1)
end

local function ParseColorValue(aQ)
if typeof(aQ)=="Color3"then
return aQ
end
if typeof(aQ)=="string"and string.sub(aQ,1,1)=="#"then
local aR,aS=pcall(function()
return Color3.fromHex(aQ)
end)
return aR and aS or nil
end
return nil
end

local function GetUrlExtension(aQ,aR)
if not aQ or typeof(aQ)~="string"then
return aR or".png"
end
local aS=aQ:match"^([^?#]+)"or aQ
local aT=aS:match"%.(%w+)$"
if aT then
aT=aT:lower()
if
aT=="jpg"
or aT=="jpeg"
or aT=="png"
or aT=="webp"
or aT=="webm"
then
return"."..aT
end
end
return aR or".png"
end

local function EnsureAssetFolder()
if ai:IsStudio()or not makefolder or not isfolder then
return
end

local aQ=aE.Folder or"Temp"
if not isfolder(aQ)then
makefolder(aQ)
end
if not isfolder(aQ.."/assets")then
makefolder(aQ.."/assets")
end
end

local function ReadHttp(aQ)
if game.HttpGet then
return game:HttpGet(aQ)
end
if an.Request then
local aR=an.Request{
Url=aQ,
Method="GET",
Headers={["User-Agent"]="Roblox/Exploit"},
}
return aR and aR.Body
end
return nil
end

local function GetCustomAsset(aQ)
if typeof(getcustomasset)~="function"then
return aQ
end

local aR,aS=pcall(function()
return getcustomasset(aQ)
end)
if aR then
return aS
end

warn("[ WindUI.Window.Background ] Failed to load custom asset: "..tostring(aS))
return aQ
end

local function CacheHttpAsset(aQ,aR)
if not writefile then
return aQ
end

EnsureAssetFolder()
local aS=(aE.Folder or"Temp")
.."/assets/."
..an.SanitizeFilename(aQ)
..GetUrlExtension(aQ,aR)

if not isfile or not isfile(aS)then
local aT,aU=pcall(function()
local aT=ReadHttp(aQ)
if aT then
writefile(aS,aT)
end
end)

if not aT then
warn("[ WindUI.Window.Background ] Failed to download asset: "..tostring(aU))
return aQ
end
end

return GetCustomAsset(aS)
end

local function ResolveBackgroundAsset(aQ,aR)
if typeof(aQ)~="string"then
return""
end

local aS=string.match(aQ,"^video:(.+)")
if aS then
aQ=aS
aR="Video"
end

local aT=string.match(aQ,"^customasset:(.+)")
or string.match(aQ,"^getcustomasset:(.+)")
or string.match(aQ,"^file:(.+)")
if aT then
return GetCustomAsset(aT)
end

if isfile and isfile(aQ)then
return GetCustomAsset(aQ)
end

if string.match(aQ,"^https?://")then
return CacheHttpAsset(aQ,aR=="Video"and".webm"or".png")
end

return aQ
end

local function GetBackgroundKind(aQ)
if aQ==nil or aQ==false then
return nil,nil,{}
end

if typeof(aQ)=="table"then
local aR=aQ.Type or aQ.Kind or aQ.Mode
if aQ.Video or aR=="Video"or aR=="video"then
return"Video",
aQ.Video or aQ.Url or aQ.URL or aQ.Source or aQ.Asset or aQ.Path,
aQ
end
if
aQ.Image
or aQ.Url
or aQ.URL
or aQ.Asset
or aQ.Path
or aR=="Image"
or aR=="image"
then
return"Image",
aQ.Image or aQ.Url or aQ.URL or aQ.Asset or aQ.Path or aQ.Source,
aQ
end
if aQ.Color or aR=="Color"or aR=="color"then
return"Color",aQ.Color or aQ.Value,aQ
end
return"Gradient",aQ.Gradient or aQ,aQ
end

local aR=ParseColorValue(aQ)
if aR then
return"Color",aR,{}
end

if typeof(aQ)=="string"then
local aS=string.match(aQ,"^video:(.+)")
local aT=aQ:match"^([^?#]+)"or aQ
if aS or string.match(aT:lower(),"%.webm$")then
return"Video",aS or aQ,{}
end
return"Image",aQ,{}
end

return nil,nil,{}
end

local function CreateDetachedMediaBackground(aQ,aR,aS)
if aQ=="Image"then
aE.BackgroundScaleType=aS.ScaleType or aE.BackgroundScaleType
aE.BackgroundImageTransparency=GetTransparencyValue(
aS.Transparency or aS.ImageTransparency,
aE.BackgroundImageTransparency
)
return ap("ImageLabel",{
Name="BackgroundImage",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Image=ResolveBackgroundAsset(aR,"Image"),
ImageTransparency=aE.BackgroundImageTransparency,
ScaleType=aE.BackgroundScaleType,
ZIndex=-10,
},{
ap("UICorner",{
CornerRadius=UDim.new(0,aE.UICorner),
}),
})
end

if aQ=="Video"then
local aT=ap("VideoFrame",{
Name="BackgroundVideo",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Video=ResolveBackgroundAsset(aR,"Video"),
Looped=aS.Looped~=false,
Volume=math.clamp(tonumber(aS.Volume)or 0,0,1),
ZIndex=-10,
},{
ap("UICorner",{
CornerRadius=UDim.new(0,aE.UICorner),
}),
})
aT:Play()
return aT
end

return nil
end

local aQ,aR,aS=
GetBackgroundKind(aE.Background)
aO=aQ=="Video"
aP=CreateDetachedMediaBackground(aQ,aR,aS)

local aT=an.NewRoundFrame(99,"Squircle",{
ImageTransparency=0.8,
ImageColor3=Color3.new(1,1,1),
Size=UDim2.new(0,0,0,4),
Position=UDim2.new(0.5,0,1,4),
AnchorPoint=Vector2.new(0.5,0),
},{
ap("TextButton",{
Size=UDim2.new(1,12,1,12),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
ZIndex=99,
Name="Frame",
}),
})

function createAuthor(aU)
return ap("TextLabel",{
Text=aU,
FontFace=Font.new(an.Font,Enum.FontWeight.Medium),
BackgroundTransparency=1,
TextTransparency=0.35,
AutomaticSize="XY",
Parent=aE.UIElements.Main and aE.UIElements.Main.Main.Topbar.Left.Title,
TextXAlignment="Left",
TextSize=13,
LayoutOrder=2,
ThemeTag={
TextColor3="WindowTopbarAuthor",
},
Name="Author",
})
end

local aU
local aV

if aE.Author then
aU=createAuthor(aE.Author)
end

local aW=ap("TextLabel",{
Text=aE.Title,
FontFace=Font.new(an.Font,Enum.FontWeight.SemiBold),
BackgroundTransparency=1,
AutomaticSize="XY",
Name="Title",
TextXAlignment="Left",
TextSize=16,
ThemeTag={
TextColor3="WindowTopbarTitle",
},
})

aE.UIElements.Main=ap("Frame",{
Size=UDim2.new(aE.Size.X.Scale,aE.Size.X.Offset,0,0),
Position=aE.Position,
BackgroundTransparency=1,
Parent=aw.Parent,
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,

},{
aw.WindUI.UIScaleObj,
aE.AcrylicPaint and aE.AcrylicPaint.Frame or nil,
aK,
an.NewRoundFrame(aE.UICorner,"Squircle",{
ImageTransparency=1,
Size=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
Name="Background",
ThemeTag={
ImageColor3="WindowBackground",
},

},{
aP,
aT,
aH,
}),




aG,
aI,
aJ,
ap("Frame",{
Size=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
Name="Main",

Visible=false,
ZIndex=97,
},{
ap("UICorner",{
CornerRadius=UDim.new(0,aE.UICorner),
}),
aE.UIElements.SideBarContainer,
aE.UIElements.TopTabHolder,
aE.UIElements.MainBar,

aL,

aN,
ap("Frame",{
Size=UDim2.new(1,0,0,aE.Topbar.Height),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(50,50,50),
Name="Topbar",
},{
aM,






ap("Frame",{
AutomaticSize="X",
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Left",
},{
ap("UIListLayout",{
Padding=UDim.new(0,aE.UIPadding+4),
SortOrder="LayoutOrder",
FillDirection="Horizontal",
VerticalAlignment="Center",
}),
ap("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Name="Title",
Size=UDim2.new(0,0,1,0),
LayoutOrder=2,
},{
ap("UIListLayout",{
Padding=UDim.new(0,0),
SortOrder="LayoutOrder",
FillDirection="Vertical",
VerticalAlignment="Center",
}),
aW,
aU,
}),
ap("UIPadding",{
PaddingLeft=UDim.new(0,4),
}),
}),
ap("CanvasGroup",{
Size=UDim2.new(0,0,1,0),
BackgroundTransparency=1,
Name="Center",
AnchorPoint=Vector2.new(0,0.5),
Position=UDim2.new(0,0,0.5,0),
AutomaticSize="Y",
Visible=false,
},{



ap("ScrollingFrame",{
Name="Holder",
BackgroundTransparency=1,
AutomaticSize="Y",
ScrollBarThickness=0,
ScrollingDirection="X",
AutomaticCanvasSize="X",
CanvasSize=UDim2.new(0,0,0,0),
Size=UDim2.new(1,0,1,0),


},{

ap("UIListLayout",{
FillDirection="Horizontal",
VerticalAlignment="Center",
HorizontalAlignment="Left",
Padding=UDim.new(0,aE.UIPadding/2),
}),
}),
}),
ap("Frame",{
AutomaticSize="XY",
BackgroundTransparency=1,
Position=UDim2.new(aE.Topbar.ButtonsType=="Default"and 1 or 0,0,0.5,0),
AnchorPoint=Vector2.new(aE.Topbar.ButtonsType=="Default"and 1 or 0,0.5),
Name="Right",
},{
ap("UIListLayout",{
Padding=UDim.new(0,aE.Topbar.ButtonsType=="Default"and 9 or 0),
FillDirection="Horizontal",
SortOrder="LayoutOrder",
}),
}),
ap("UIPadding",{
PaddingTop=UDim.new(0,aE.UIPadding),
PaddingLeft=UDim.new(
0,
aE.Topbar.ButtonsType=="Default"and aE.UIPadding or aE.UIPadding-2
),
PaddingRight=UDim.new(0,8),
PaddingBottom=UDim.new(0,aE.UIPadding),
}),
}),
}),
})

an.AddSignal(aE.UIElements.Main.Main.Topbar.Left:GetPropertyChangedSignal"AbsoluteSize",function()
local aX=0
local aY=aE.UIElements.Main.Main.Topbar.Right.UIListLayout.AbsoluteContentSize.X
/aw.WindUI.UIScale

aX=aE.UIElements.Main.Main.Topbar.Left.AbsoluteSize.X/aw.WindUI.UIScale
if aE.Topbar.ButtonsType~="Default"then
aX=aX+aY+aE.UIPadding-4
end

aE.UIElements.Main.Main.Topbar.Center.Position=
UDim2.new(0,aX+(aE.UIPadding/aw.WindUI.UIScale),0.5,0)
aE.UIElements.Main.Main.Topbar.Center.Size=UDim2.new(
1,
-aX
-(aE.UIPadding/aw.WindUI.UIScale)
-(aE.Topbar.ButtonsType=="Default"and aY+aE.UIPadding or 0),
1,
0
)
end)

if aE.Topbar.ButtonsType~="Default"then
an.AddSignal(aE.UIElements.Main.Main.Topbar.Right:GetPropertyChangedSignal"AbsoluteSize",function()
aE.UIElements.Main.Main.Topbar.Left.Position=UDim2.new(
0,
(aE.UIElements.Main.Main.Topbar.Right.AbsoluteSize.X/aw.WindUI.UIScale)+aE.UIPadding-4,
0,
0
)
end)
end

local function GetImageTarget(aX)
if typeof(aX)~="Instance"then
return nil
end

if aX:IsA"ImageLabel"or aX:IsA"ImageButton"then
return aX
end

return aX:FindFirstChildWhichIsA"ImageLabel"or aX:FindFirstChildWhichIsA"ImageButton"
end

function aE.CreateTopbarButton(aX,aY,aZ,a_,a0,a1,a2,a3,a4)
local a5=a0 or 999
a4=a4 or{}
local a6=a4.ForceIcon==true
local a7=aE.Topbar.ButtonsType=="Mac"and a4.MacAccent==true
local a8=aE.Topbar.ButtonsType=="Default"or a6
local a9=aE.Topbar.ButtonsType~="Default"and not a6
local b=math.max(tonumber(a4.Size)or aE.Topbar.Height-18,20)
local ba=an.Image(
aZ,
aZ,
0,
aE.Folder,
"WindowTopbarIcon",
a8 and not a7,
a1,
"WindowTopbarButtonIcon"
)
ba.Size=a8
and UDim2.new(0,a3 or aE.TopBarButtonIconSize,0,a3 or aE.TopBarButtonIconSize)
or UDim2.new(0,0,0,0)
ba.AnchorPoint=Vector2.new(0.5,0.5)
ba.Position=UDim2.new(0.5,0,0.5,0)
local bb=GetImageTarget(ba)
if bb then
bb.ImageTransparency=a8 and 0 or 1
end
if a7 and bb then
bb.ImageColor3=an.GetTextColorForHSB(a2 or Color3.fromHex"#A78BFA",0.72)
bb.ImageTransparency=0
end

if a9 and bb then
bb.ImageColor3=an.GetTextColorForHSB(a2 or Color3.fromHex"#ff3030")
end

local bc=an.NewRoundFrame(
a8 and(a7 and 999 or aE.UICorner-(aE.UIPadding/2))or 999,
"Squircle",
{
Size=a8 and UDim2.fromOffset(
a7 and b or aE.Topbar.Height-16,
a7 and b or aE.Topbar.Height-16
)or UDim2.new(0,14,0,14),
LayoutOrder=a5,


ZIndex=9999,
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
ImageColor3=(a9 or a7)and(a2 or Color3.fromHex"#ff3030")or nil,
ThemeTag=a8 and not a7 and{
ImageColor3="Text",
}or nil,
ImageTransparency=a8 and(a7 and 0.08 or 1)or 0,
},
{












ba,
ap("UIScale",{
Scale=1,
}),
},
true
)

local bd=ap("Frame",{
Size=a9 and UDim2.new(0,24,0,24)
or a7 and UDim2.fromOffset(b+4,b+4)
or UDim2.new(0,aE.Topbar.Height-16,0,aE.Topbar.Height-16),
BackgroundTransparency=1,
Parent=aE.UIElements.Main.Main.Topbar.Right,
LayoutOrder=a5,
},{
bc,
})



aE.TopBarButtons[100-a5]={
Name=aY,
Object=bd,
}

an.AddSignal(bc.MouseButton1Click,function()
if a_ then
a_()
end
end)
an.AddSignal(bc.MouseEnter,function()
if a8 then
ao.Play(bc,"Hover",{ImageTransparency=if a7 then 0 else 0.93},nil,nil,"Hover")


else

ao.Play(
bb,
"Hover",
{ImageTransparency=0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
ao.Play(ba,"Hover",{
Size=UDim2.new(
0,
a3 or aE.TopBarButtonIconSize,
0,
a3 or aE.TopBarButtonIconSize
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Hover")
end
end)

an.AddSignal(bc.MouseButton1Down,function()
ao.Play(
bc.UIScale,
"Press",
{Scale=0.9},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Press"
)
end)

an.AddSignal(bc.MouseLeave,function()
if a8 then
ao.Play(bc,"Hover",{ImageTransparency=if a7 then 0.08 else 1},nil,nil,"Hover")


else

ao.Play(
bb,
"Hover",
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
ao.Play(
ba,
"Hover",
{Size=UDim2.new(0,0,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Hover"
)
end
end)

an.AddSignal(bc.InputEnded,function()
ao.Play(
bc.UIScale,
"Press",
{Scale=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Press"
)
end)

return bc
end

function aE.Topbar.Button(aX,aY:{
Name:string,
Icon:string,
Callback:any,
LayoutOrder:number,
IconThemed:boolean,
Color:Color3,
IconSize:number,
Options:table,
})
return aE:CreateTopbarButton(
aY.Name,
aY.Icon,
aY.Callback,
aY.LayoutOrder or 0,
aY.IconThemed,
aY.Color,
aY.IconSize,
aY.Options
)
end



local aX=an.Drag(
aE.UIElements.Main,
{aE.UIElements.Main.Main.Topbar,aT.Frame},
function(aX,aY)
if not aE.Closed then
if aX and aY==aT.Frame then
aq(aT,0.1,{ImageTransparency=0.35}):Play()
else
aq(aT,0.2,{ImageTransparency=0.8}):Play()
end
aE.Position=aE.UIElements.Main.Position
aE.Dragging=aX
end
end
)

local function ParseBackgroundColor(aY)
return ParseColorValue(aY)
end

local function ApplyBackgroundColor(aY)
local aZ=ParseBackgroundColor(aY)
if aZ then
aE.BackgroundColor=aY
ao.Play(
aE.UIElements.Main.Background,
"Background",
{ImageColor3=aZ},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"BackgroundColor"
)
end
return aZ
end

local function SetBackgroundGradientObject(aY,aZ)
if aE.UIElements.BackgroundGradient then
aE.UIElements.BackgroundGradient:Destroy()
aE.UIElements.BackgroundGradient=nil
end

if typeof(aY)~="table"then
return nil
end

local a_=aY.Color~=nil
or aY.Transparency~=nil
or aY.Rotation~=nil
or aY.Offset~=nil
if not a_ then
return nil
end

local a0=ap"UIGradient"
for a1,a2 in next,aY do
if a1=="Transparency"and typeof(a2)=="number"then
continue
end
pcall(function()
a0[a1]=a2
end)
end

local a1=an.NewRoundFrame(aE.UICorner,"Squircle",{
Name="BackgroundGradient",
Size=UDim2.new(1,0,1,0),
Parent=aE.UIElements.Main.Background,
ImageTransparency=aZ or aE.BackgroundOverlayTransparency,
ZIndex=-9,
},{
a0,
})

aE.UIElements.BackgroundGradient=a1
return a1
end

local function ClearDetachedBackgroundMedia(aY)
if aY~="Image"and aP and aP:IsA"ImageLabel"then
aP:Destroy()
aP=nil
elseif aY~="Video"and aP and aP:IsA"VideoFrame"then
aP:Destroy()
aP=nil
end

if aY~="Gradient"and aE.UIElements.BackgroundGradient then
aE.UIElements.BackgroundGradient:Destroy()
aE.UIElements.BackgroundGradient=nil
end
end

local function CreateImageBackground()
ClearDetachedBackgroundMedia"Image"

if aP and aP:IsA"ImageLabel"then
return aP
end

if aP then
aP:Destroy()
end

aP=ap("ImageLabel",{
Name="BackgroundImage",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
ImageTransparency=1,
ScaleType=aE.BackgroundScaleType,
ZIndex=-10,
Parent=aE.UIElements.Main.Background,
},{
ap("UICorner",{
CornerRadius=UDim.new(0,aE.UICorner),
}),
})

return aP
end

local function CreateVideoBackground()
ClearDetachedBackgroundMedia"Video"

if aP then
aP:Destroy()
end

aP=ap("VideoFrame",{
Name="BackgroundVideo",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Looped=true,
Volume=0,
ZIndex=-10,
Parent=aE.UIElements.Main.Background,
},{
ap("UICorner",{
CornerRadius=UDim.new(0,aE.UICorner),
}),
})

return aP
end

if aE.BackgroundColor then
ApplyBackgroundColor(aE.BackgroundColor)
elseif aQ=="Color"then
ApplyBackgroundColor(aR)
end

local aY=aE.BackgroundGradient
or(aQ=="Gradient"and aR or nil)
if aY then
local aZ=aE.BackgroundGradient and aE.BackgroundOverlayTransparency
or(aE.Transparent and aw.WindUI.TransparencyValue or 0)
SetBackgroundGradientObject(aY,aZ)
end














aE.OpenButtonMain=a.load'E'.New(aE)
aE.OpenButtonController=aE.OpenButtonMain
aE.WatermarkMain=a.load'F'.New(aE,aw.WindUI)

function aE.SetWatermark(aZ,a_)
aE.Watermark=a_
return aE.WatermarkMain:Edit(a_)
end

function aE.ToggleWatermark(aZ,a_)
if aE.WatermarkMain then
aE.WatermarkMain:Visible(a_)
end
end

if aE.Watermark~=nil and aE.Watermark~=false then
aE:SetWatermark(aE.Watermark)
end

task.spawn(function()
if aE.Icon then
local aZ=ap("Frame",{
Size=UDim2.new(0,22,0,22),
BackgroundTransparency=1,
Parent=aE.UIElements.Main.Main.Topbar.Left,
})

aV=an.Image(
aE.Icon,
aE.Title,
aE.IconRadius,
aE.Folder,
"Window",
true,
aE.IconThemed,
"WindowTopbarIcon"
)
aV.Parent=aZ
aV.Size=UDim2.new(0,aE.IconSize,0,aE.IconSize)
aV.Position=UDim2.new(0.5,0,0.5,0)
aV.AnchorPoint=Vector2.new(0.5,0.5)

aE.OpenButtonMain:SetIcon(aE.Icon)











else
aE.OpenButtonMain:SetIcon(aE.Icon)

end
end)

function aE.SetToggleKey(aZ,a_)
aE.ToggleKey=a_
end

function aE.SetTitle(aZ,a_)
aE.Title=a_
aW.Text=a_
end

function aE.SetAuthor(aZ,a_)
aE.Author=a_
if not aU then
aU=createAuthor(aE.Author)
end

aU.Text=a_
end

function aE.SetSize(aZ,a_)
if typeof(a_)=="UDim2"then
aE.Size=a_

aq(aE.UIElements.Main,0.08,{Size=a_},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

local function GetBackgroundTransparency(aZ,a_)
return GetTransparencyValue(aZ,a_)
end

function aE.SetBackgroundImage(aZ,a_,a0)
a0=typeof(a0)=="table"and a0 or{Transparency=a0}
ClearDetachedBackgroundMedia"Image"
local a1=CreateImageBackground()
aE.Background=a_
aE.BackgroundGradient=nil
aE.BackgroundScaleType=a0.ScaleType or aE.BackgroundScaleType
aE.BackgroundImageTransparency=GetBackgroundTransparency(
a0.Transparency or a0.ImageTransparency,
aE.BackgroundImageTransparency
)
a1.ScaleType=aE.BackgroundScaleType
a1.Image=ResolveBackgroundAsset(a_,"Image")
a1.ImageTransparency=1
ao.Play(
a1,
"Background",
{ImageTransparency=aE.BackgroundImageTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"BackgroundImage"
)
return a1
end

function aE.SetBackgroundVideo(aZ,a_,a0)
a0=typeof(a0)=="table"and a0 or{}
ClearDetachedBackgroundMedia"Video"
local a1=CreateVideoBackground()
aE.Background="video:"..tostring(a_ or"")
aE.BackgroundGradient=nil
a1.Video=ResolveBackgroundAsset(a_,"Video")
a1.Visible=true
a1.Looped=a0.Looped~=false
a1.Volume=math.clamp(tonumber(a0.Volume)or a1.Volume or 0,0,1)
a1:Play()
return a1
end

function aE.SetBackgroundGradient(aZ,a_,a0)
ClearDetachedBackgroundMedia"Gradient"
aE.BackgroundGradient=a_
aE.Background=nil
aE.BackgroundOverlayTransparency=
GetBackgroundTransparency(a0,aE.BackgroundOverlayTransparency)
local a1=SetBackgroundGradientObject(a_,1)
if a1 then
ao.Play(
a1,
"Background",
{ImageTransparency=aE.BackgroundOverlayTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"BackgroundGradient"
)
end
return a1
end

function aE.SetBackgroundColor(aZ,a_)
return ApplyBackgroundColor(a_)
end

function aE.SetBackgroundOverlayTransparency(aZ,a_)
aE.BackgroundOverlayTransparency=GetBackgroundTransparency(a_,aE.BackgroundOverlayTransparency)
if aE.UIElements.BackgroundGradient then
ao.Play(
aE.UIElements.BackgroundGradient,
"Background",
{ImageTransparency=aE.BackgroundOverlayTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"BackgroundGradient"
)
end
return aE.BackgroundOverlayTransparency
end

function aE.SetBackground(aZ,a_,a0)
if a_==nil or a_==false then
aE.Background=nil
aE.BackgroundGradient=nil
if aP then
aP:Destroy()
aP=nil
end
if aE.UIElements.BackgroundGradient then
aE.UIElements.BackgroundGradient:Destroy()
aE.UIElements.BackgroundGradient=nil
end
return nil
end

local a1,a2,a3=GetBackgroundKind(a_)
local a4={}
if typeof(a3)=="table"then
for a5,a6 in next,a3 do
a4[a5]=a6
end
end
if typeof(a0)=="table"then
for a5,a6 in next,a0 do
a4[a5]=a6
end
elseif a0~=nil then
a4.Transparency=a0
end

if a1=="Gradient"then
return aE:SetBackgroundGradient(a2,a4.Transparency or a4.OverlayTransparency)
elseif a1=="Color"then
return aE:SetBackgroundColor(a2)
elseif a1=="Video"then
return aE:SetBackgroundVideo(a2,a4)
elseif a1=="Image"then
return aE:SetBackgroundImage(a2,a4)
end

return nil
end

function aE.SetBackgroundImageTransparency(aZ,a_)
aE.BackgroundImageTransparency=GetBackgroundTransparency(a_,aE.BackgroundImageTransparency)
if aP and aP:IsA"ImageLabel"then
ao.Play(
aP,
"Background",
{ImageTransparency=aE.BackgroundImageTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"BackgroundImage"
)
end
end

function aE.SetBackgroundTransparency(aZ,a_)
local a0=math.floor(tonumber(a_)*10+0.5)/10
aw.WindUI.TransparencyValue=a0
aE:ToggleTransparency(a0>0)
end

function aE.SetElementTransparency(aZ,a_)
local a0=math.floor(an.ClampTransparency(a_,aE.ElementConfig.Transparency or 0)*100+0.5)
/100

aE.ElementTransparency=a0
aE.ElementConfig.Transparency=a0

for a1,a2 in next,aE.AllElements do
if a2 and a2.SetTransparency then
a2:SetTransparency(a0)
end
end

return a0
end

function aE.SetLiquidGlass(aZ,a_)
aE.LiquidGlass=a_==true
aE.ElementConfig.LiquidGlass=aE.LiquidGlass

for a0,a1 in next,aE.AllElements do
if a1 and a1.SetLiquidGlass then
a1:SetLiquidGlass(aE.LiquidGlass)
end
end
end

local aZ
local a_
an.Icon"minimize"
an.Icon"maximize"

if aE.Settings~=false and aE.Topbar.Settings~=false then
local a0=a.load'G'.New(aE,aw.WindUI,aw)
local a1=aE:CreateTopbarButton(
"Settings",
"settings",
function()
a0:Toggle()
end,
aE.Topbar.ButtonsType=="Default"and 997 or 1000,
true,
Color3.fromHex"#9B87F5",
nil,
{
ForceIcon=true,
MacAccent=true,
}
)
a0:SetButton(a1)
aE.SettingsMenu=a0
end

if aE.KeyBindMenu~=false and aE.Topbar.KeyBindMenu~=false then
local a0=a.load'H'.New(aE,aw.WindUI,aw)
local a1=aE:CreateTopbarButton(
"KeyBind",
"keyboard",
function()
a0:Toggle()
end,
aE.Topbar.ButtonsType=="Default"and 996 or 1001,
true,
Color3.fromHex"#F472B6",
nil,
{
ForceIcon=true,
MacAccent=true,
}
)
a0:SetButton(a1)
aE.KeyBindMenuMain=a0

function aE.ToggleKeyBindMenu(a2)
return a0:Toggle()
end

function aE.OpenKeyBindMenu(a2)
return a0:OpenMenu()
end
end

aE:CreateTopbarButton(
"Fullscreen",
aE.Topbar.ButtonsType=="Mac"and"rbxassetid://127426072704909"or"maximize",
function()
aE:ToggleFullscreen()
end,
(aE.Topbar.ButtonsType=="Default"and 998 or 999),
true,
Color3.fromHex"#60C762",
aE.Topbar.ButtonsType=="Mac"and 9 or nil
)

local function SetSize(a0)
ao.Play(aE.UIElements.Main,"Resize",{
Size=not aE.IsFullscreen and a_ or UDim2.new(
0,
(aw.WindUI.ScreenGui.AbsoluteSize.X-20)/aw.WindUI.UIScale,
0,
(aw.WindUI.ScreenGui.AbsoluteSize.Y-20-52)/aw.WindUI.UIScale
),
Position=not aE.IsFullscreen and aZ or UDim2.new(0.5,0,0.5,26),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Fullscreen")
end

function aE.ToggleFullscreen(a0)
local a1=aE.IsFullscreen

aX:Set(a1)

if not a1 then
aZ=aE.UIElements.Main.Position
a_=aE.UIElements.Main.Size

aE.CanResize=false
else
if aE.Resizable then
aE.CanResize=true
end
end

aE.IsFullscreen=not a1

SetSize(true)
end

an.AddSignal(aw.WindUI.ScreenGui:GetPropertyChangedSignal"AbsoluteSize",function()
if aE.IsFullscreen then
SetSize()
end
end)

aE:CreateTopbarButton("Minimize","minus",function()
if aE.Close then
aE:Close()
end






















end,(aE.Topbar.ButtonsType=="Default"and 997 or 998),nil,Color3.fromHex"#F4C948")

function aE.OnOpen(a0,a1)
aE.OnOpenCallback=a1
end
function aE.OnClose(a0,a1)
aE.OnCloseCallback=a1
end
function aE.OnDestroy(a0,a1)
aE.OnDestroyCallback=a1
end

if aw.WindUI.UseAcrylic then
aE.AcrylicPaint.AddParent(aE.UIElements.Main)
end

function aE.SetIconSize(a0,a1)
local a2
if typeof(a1)=="number"then
a2=UDim2.new(0,a1,0,a1)
aE.IconSize=a1
elseif typeof(a1)=="UDim2"then
a2=a1
aE.IconSize=a1.X.Offset
end

if aV then
aV.Size=a2
end
end

local a0={
Active=false,
RestorePosition=aE.UIElements.Main.Position,
TargetScale=nil,
}

local function GetWindowMorphTarget()
local a1=aE.OpenButtonMain
if not a1 or not aE.IsOpenButtonEnabled or aE.IsPC or not a1.GetMorphTarget then
return nil
end

local a2=a1:GetMorphTarget()
if not a2.Enabled or a2.Size.X<=0 or a2.Size.Y<=0 then
return nil
end

local a3=Vector2.new(0,0)
local a4=aE.UIElements.Main.Parent
if typeof(a4)=="Instance"and a4:IsA"GuiObject"then
a3=a4.AbsolutePosition
end

local a5=math.max(tonumber(aw.WindUI.UIScale)or 1,0.01)
local a6=aE.UIElements.Main.AbsoluteSize
local a7=math.max(aE.Size.X.Offset,a6.X/a5,1)
local a8=math.max(aE.Size.Y.Offset,a6.Y/a5,1)
local a9=
math.clamp(math.min(a2.Size.X/a7,a2.Size.Y/a8),0.035,a5)

return{
Position=UDim2.fromOffset(a2.Position.X-a3.X,a2.Position.Y-a3.Y),
Scale=a9,
Duration=a2.Duration>0 and a2.Duration or ao.GetDuration"WindowMorph",
}
end

function aE.Open(a1)
if aE.Destroyed then
return
end
task.spawn(function()
if aE.OnOpenCallback then
task.spawn(function()
an.SafeCallback(aE.OnOpenCallback)
end)
end

task.wait(0.06)
aE.Closed=false
local a2=a0.Active
local a3=a2 and GetWindowMorphTarget()or nil

if a3 then
aE.UIElements.Main.Size=aE.Size
aE.UIElements.Main.Position=a3.Position
aw.WindUI.UIScaleObj.Scale=a0.TargetScale or a3.Scale
aE.UIElements.Main.Visible=true
aE.UIElements.Main:WaitForChild"Main".Visible=true
ao.Play(aE.UIElements.Main,a3.Duration,{
Position=a0.RestorePosition,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"WindowMorphPosition")
ao.Play(aw.WindUI.UIScaleObj,a3.Duration,{
Scale=aw.WindUI.UIScale,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"WindowMorphScale")
else
aE.UIElements.Main.Size=UDim2.new(aE.Size.X.Scale,aE.Size.X.Offset,0,100)
ao.Play(aE.UIElements.Main,"WindowOpen",{
Size=aE.Size,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Window")
end

if aE.UIElements.BackgroundGradient then
ao.Play(aE.UIElements.BackgroundGradient,"Focus",{
ImageTransparency=aE.BackgroundGradient and aE.BackgroundOverlayTransparency or 0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Window")
end

if not a3 then
aE.UIElements.Main.Background.ImageTransparency=1
end
ao.Play(aE.UIElements.Main.Background,"WindowOpen",{

ImageTransparency=aE.Transparent and aw.WindUI.TransparencyValue or 0,
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out,"WindowBackground")

if aP then
if aP:IsA"VideoFrame"then
aP.Visible=true
else
ao.Play(aP,"Focus",{
ImageTransparency=aE.BackgroundImageTransparency,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Window")
end
end

if aE.OpenButtonMain and aE.IsOpenButtonEnabled and not a3 then
aE.OpenButtonMain:Visible(false)
elseif a3 then
task.delay(math.min(a3.Duration*0.22,0.1),function()
if not aE.Closed and aE.OpenButtonMain then
aE.OpenButtonMain:Visible(false)
end
end)
end









ao.Play(
aK,
"WindowOpen",
{ImageTransparency=aE.ShadowTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Window"
)




ao.Play(
aT,
"WindowOpen",
{Size=UDim2.new(0,aE.DragFrameSize,0,4),ImageTransparency=0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out,
"Window"
)
aX:Set(true)

if aE.Resizable then
ao.Play(
aH.ImageLabel,
"WindowOpen",
{ImageTransparency=0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out,
"Window"
)
aE.CanResize=true
end

aE.CanDropdown=true
aE.UIElements.Main.Visible=true



aE.UIElements.Main:WaitForChild"Main".Visible=true

aw.WindUI:ToggleAcrylic(true)
a0.Active=false

end)
end
function aE.Close(a1)
if aE.Destroyed then
return
end

local a2={}
local a3
if aE.OpenButtonMain and aE.IsOpenButtonEnabled and not aE.IsPC then
aE.OpenButtonMain:SetState("Compact",nil,false)
aE.OpenButtonMain:Visible(true)
a3=GetWindowMorphTarget()
end
local a4=a3~=nil
local a5=a4 and a3.Duration or ao.GetDuration"WindowClose"
a0.Active=a4
a0.RestorePosition=aE.UIElements.Main.Position
a0.TargetScale=a4 and a3.Scale or nil

if aE.OnCloseCallback then
task.spawn(function()
an.SafeCallback(aE.OnCloseCallback)
end)
end

if not a4 then
aw.WindUI:ToggleAcrylic(false)
end

if not a4 and aE.UIElements.Main and aE.UIElements.Main:WaitForChild"Main"then
aE.UIElements.Main.Main.Visible=false
end

aE.CanDropdown=false
aE.Closed=true

if a4 then
ao.Play(aE.UIElements.Main,a3.Duration,{
Position=a3.Position,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"WindowMorphPosition")
ao.Play(aw.WindUI.UIScaleObj,a3.Duration,{
Scale=a3.Scale,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"WindowMorphScale")
else
ao.Play(aE.UIElements.Main,"WindowClose",{
Size=UDim2.new(aE.Size.X.Scale,aE.Size.X.Offset,0,0),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Window")
end
if not a4 and aE.UIElements.BackgroundGradient then
ao.Play(aE.UIElements.BackgroundGradient,"Fast",{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Window")
end

if not a4 then
ao.Play(aE.UIElements.Main.Background,"WindowClose",{

ImageTransparency=1,
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out,"WindowBackground")
end








if aP and not a4 then
if aP:IsA"VideoFrame"then
aP.Visible=false
else
ao.Play(aP,"WindowClose",{
ImageTransparency=1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out,"Window")
end
end
if not a4 then
ao.Play(
aK,
"WindowClose",
{ImageTransparency=1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out,
"Window"
)
end




ao.Play(
aT,
"WindowClose",
{Size=UDim2.new(0,0,0,4),ImageTransparency=1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out,
"Window"
)
ao.Play(
aH.ImageLabel,
"WindowClose",
{ImageTransparency=1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out,
"Window"
)
aX:Set(false)
aE.CanResize=false

task.spawn(function()
task.wait(a5+0.05)

if not aE.Closed then
return
end

aE.UIElements.Main.Visible=false
aE.UIElements.Main.Main.Visible=false
if a4 then
aw.WindUI:ToggleAcrylic(false)
if aP and aP:IsA"VideoFrame"then
aP.Visible=false
end
end

if aE.OpenButtonMain and not aE.Destroyed and not aE.IsPC and aE.IsOpenButtonEnabled then
aE.OpenButtonMain:Visible(true)
end
end)

function a2.Destroy(a6)
task.spawn(function()
if aE.OnDestroyCallback then
task.spawn(function()
an.SafeCallback(aE.OnDestroyCallback)
end)
end

if aE.AcrylicPaint and aE.AcrylicPaint.Model then
aE.AcrylicPaint.Model:Destroy()
end

aE.Destroyed=true

task.wait(0.4)

aw.WindUI.ScreenGui:Destroy()
aw.WindUI.NotificationGui:Destroy()
aw.WindUI.DropdownGui:Destroy()
aw.WindUI.TooltipGui:Destroy()

an.DisconnectAll()

return
end)
end

return a2
end
function aE.Destroy(a1)
return aE:Close():Destroy()
end
function aE.Toggle(a1)
if aE.Closed then
aE:Open()
else
aE:Close()
end
end

function aE.ToggleTransparency(a1,a2)

aE.Transparent=a2
aw.WindUI.Transparent=a2

aE.UIElements.Main.Background.ImageTransparency=a2 and aw.WindUI.TransparencyValue or 0
if aE.UIElements.BackgroundGradient then
aE.UIElements.BackgroundGradient.ImageTransparency=a2 and aw.WindUI.TransparencyValue
or aE.BackgroundOverlayTransparency
end


end

function aE.LockAll(a1)
for a2,a3 in next,aE.AllElements do
if a3.Lock then
a3:Lock()
end
end
end
function aE.UnlockAll(a1)
for a2,a3 in next,aE.AllElements do
if a3.Unlock then
a3:Unlock()
end
end
end
function aE.GetLocked(a1)
local a2={}

for a3,a4 in next,aE.AllElements do
if a4.Locked then
table.insert(a2,a4)
end
end

return a2
end
function aE.GetUnlocked(a1)
local a2={}

for a3,a4 in next,aE.AllElements do
if a4.Locked==false then
table.insert(a2,a4)
end
end

return a2
end

function aE.GetUIScale(a1,a2)
return aw.WindUI.UIScale
end

function aE.SetUIScale(a1,a2)
aw.WindUI.UIScale=a2
aq(aw.WindUI.UIScaleObj,0.2,{Scale=a2},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
return aE
end

function aE.SetToTheCenter(a1)
aq(
aE.UIElements.Main,
0.45,
{Position=UDim2.new(0.5,0,0.5,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
return aE
end

function aE.SetCurrentConfig(a1,a2)
aE.CurrentConfig=a2
end

do
local a1=40
local a2=al.ViewportSize
local a3=Vector2.new(aE.Size.X.Offset,aE.Size.Y.Offset)

if not aE.IsFullscreen and aE.AutoScale then
local a4=a2.X-(a1*2)
local a5=a2.Y-(a1*2)

local a6=a4/a3.X
local a7=a5/a3.Y

local a8=math.min(a6,a7)

local a9=0.3
local b=1.0

local ba=math.clamp(a8,a9,b)

local bb=aE:GetUIScale()or 1
local bc=0.05

if math.abs(ba-bb)>bc then
aE:SetUIScale(ba)
end
end
end

if aE.OpenButtonMain and aE.OpenButtonMain.Button then
an.AddSignal(aE.OpenButtonMain.Button.TextButton.MouseButton1Click,function()


aE:Open()
end)
end

an.AddSignal(af.InputBegan,function(a1,a2)
if a2 then
return
end

if aE.ToggleKey then
if a1.KeyCode==aE.ToggleKey then
aE:Toggle()
end
end
end)

task.spawn(function()

aE:Open()
end)

function aE.EditOpenButton(a1,a2)
return aE.OpenButtonMain:Edit(a2)
end

function aE.GetOpenButton(a1)
return aE.OpenButtonMain
end

function aE.SetOpenButtonState(a1,a2,a3,a4)
return aE.OpenButtonMain:SetState(a2,a3,a4)
end

function aE.ExpandOpenButton(a1,a2,a3)
return aE.OpenButtonMain:Expand(a2,a3)
end

function aE.CollapseOpenButton(a1,a2)
return aE.OpenButtonMain:Collapse(a2)
end

function aE.CompactOpenButton(a1,a2)
return aE.OpenButtonMain:Compact(a2)
end

function aE.HideOpenButton(a1,a2)
return aE.OpenButtonMain:Idle(a2)
end

function aE.WakeOpenButton(a1,a2)
return aE.OpenButtonMain:Wake(a2)
end

function aE.PushOpenButton(a1,a2,a3)
return aE.OpenButtonMain:Push(a2,a3)
end

if aE.OpenButton and typeof(aE.OpenButton)=="table"then
aE:EditOpenButton(aE.OpenButton)
end

local a1=a.load'aF'
local a2=a.load'aG'
local a3=a1.Init(aE,aw.WindUI,aw.WindUI.TooltipGui)
a3:OnChange(function(a4)
aE.CurrentTab=a4
end)

aE.TabModule=a3

function aE.Tab(a4,a5)
a5.Parent=aE.UIElements.TabHolder
return a3.New(a5,aw.WindUI.UIScale)
end

function aE.SelectTab(a4,a5)
a3:SelectTab(a5)
end

function aE.Section(a4,a5)
return a2.New(
a5,
aE.UIElements.TabHolder,
aE.Folder,
aw.WindUI.UIScale,
aE
)
end

function aE.IsResizable(a4,a5)
aE.Resizable=a5
aE.CanResize=a5
end

function aE.SetPanelBackground(a4,a5)
if typeof(a5)=="boolean"then
aE.HidePanelBackground=a5

aE.UIElements.MainBar.Background.Visible=a5

if a3 then
for a6,a7 in next,a3.Containers do
a7.ScrollingFrame.UIPadding.PaddingTop=UDim.new(0,aE.HidePanelBackground and 20 or 10)
a7.ScrollingFrame.UIPadding.PaddingLeft=
UDim.new(0,aE.HidePanelBackground and 20 or 10)
a7.ScrollingFrame.UIPadding.PaddingRight=
UDim.new(0,aE.HidePanelBackground and 20 or 10)
a7.ScrollingFrame.UIPadding.PaddingBottom=
UDim.new(0,aE.HidePanelBackground and 20 or 10)
end
end
end
end

function aE.Divider(a4)
local a5=ap("Frame",{
Size=UDim2.new(1,0,0,1),
Position=UDim2.new(0.5,0,0,0),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=0.9,
ThemeTag={
BackgroundColor3="Text",
},
})
local a6=ap("Frame",{
Parent=aE.UIElements.SideBar.Frame,

Size=UDim2.new(1,-7,0,5),
BackgroundTransparency=1,
},{
a5,
})

return a6
end

local a4=a.load'q'
function aE.Dialog(a5,a6)
local a7={
Title=a6.Title or"Dialog",
Width=a6.Width or 320,
Content=a6.Content,
Buttons=a6.Buttons or{},

TextPadding=14,
}
local a8=a4.Create(false,"Dialog",aE,aw.WindUI,aE.UIElements.Main.Main)

a8.UIElements.Main.Size=UDim2.new(0,a7.Width,0,0)

local a9=ap("Frame",{
Size=UDim2.new(1,0,1,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=a8.UIElements.Main,
},{
ap("UIListLayout",{
FillDirection="Vertical",

Padding=UDim.new(0,a8.UIPadding),
}),
})

local b=ap("Frame",{
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
BackgroundTransparency=1,
Parent=a9,
},{
ap("UIListLayout",{
FillDirection="Horizontal",
Padding=UDim.new(0,a8.UIPadding),
VerticalAlignment="Center",
}),
ap("UIPadding",{
PaddingTop=UDim.new(0,a7.TextPadding/2),
PaddingLeft=UDim.new(0,a7.TextPadding/2),
PaddingRight=UDim.new(0,a7.TextPadding/2),
}),
})

local ba
if a6.Icon then
ba=an.Image(
a6.Icon,
a7.Title..":"..a6.Icon,
0,
aE,
"Dialog",
true,
a6.IconThemed
)
ba.Size=UDim2.new(0,22,0,22)
ba.Parent=b
end

a8.UIElements.UIListLayout=ap("UIListLayout",{
Padding=UDim.new(0,12),
FillDirection="Vertical",
HorizontalAlignment="Left",
VerticalFlex="SpaceBetween",
Parent=a8.UIElements.Main,
})

ap("UISizeConstraint",{
MinSize=Vector2.new(180,20),
MaxSize=Vector2.new(400,math.huge),
Parent=a8.UIElements.Main,
})

a8.UIElements.Title=ap("TextLabel",{
Text=a7.Title,
TextSize=20,
FontFace=Font.new(an.Font,Enum.FontWeight.SemiBold),
TextXAlignment="Left",
TextWrapped=true,
RichText=true,
Size=UDim2.new(1,ba and-26-a8.UIPadding or 0,0,0),
AutomaticSize="Y",
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=b,
})
if a7.Content then
ap("TextLabel",{
Text=a7.Content,
TextSize=18,
TextTransparency=0.4,
TextWrapped=true,
RichText=true,
FontFace=Font.new(an.Font,Enum.FontWeight.Medium),
TextXAlignment="Left",
Size=UDim2.new(1,0,0,0),
AutomaticSize="Y",
LayoutOrder=2,
ThemeTag={
TextColor3="Text",
},
BackgroundTransparency=1,
Parent=a9,
},{
ap("UIPadding",{
PaddingLeft=UDim.new(0,a7.TextPadding/2),
PaddingRight=UDim.new(0,a7.TextPadding/2),
PaddingBottom=UDim.new(0,a7.TextPadding/2),
}),
})
end

local bb=ap("UIListLayout",{
Padding=UDim.new(0,6),
FillDirection="Horizontal",
HorizontalAlignment="Center",
HorizontalFlex="Fill",
})

local bc=ap("Frame",{
Size=UDim2.new(1,0,0,36),
AutomaticSize="None",
BackgroundTransparency=1,
Parent=a8.UIElements.Main,
LayoutOrder=4,
},{
bb,






})

local bd={}

for be,bf in next,a7.Buttons do
local bg=
as(bf.Title,bf.Icon,bf.Callback,bf.Variant,bc,a8,true)
table.insert(bd,bg)
bg.Size=UDim2.new(1,0,1,0)
end





















































a8:Open()

return a8
end

local a5=false

aE:CreateTopbarButton("Close","x",function()
if not a5 then
if not aE.IgnoreAlerts then
a5=true

aE:Dialog{

Title="Close Window",
Content="Do you want to close this window? You will not be able to open it again.",
Buttons={
{
Title="Cancel",

Callback=function()
a5=false
end,
Variant="Secondary",
},
{
Title="Close Window",

Callback=function()
a5=false
aE:Destroy()
end,
Variant="Primary",
},
},
}
else
aE:Destroy()
end
end
end,(aE.Topbar.ButtonsType=="Default"and 999 or 997),nil,Color3.fromHex"#F4695F")

function aE.Tag(a6,a7)
if aE.UIElements.Main.Main.Topbar.Center.Visible==false then
aE.UIElements.Main.Main.Topbar.Center.Visible=true
end
a7.Window=aE
return au:New(a7,aE.UIElements.Main.Main.Topbar.Center.Holder)
end

local a6=aw.WindUI.GenerateGUID()

local function startResizing(a7)
if aE.CanResize then
isResizing=true
aI.Active=true
initialSize=aE.UIElements.Main.Size
initialInputPosition=a7.Position


aq(aH.ImageLabel,0.1,{ImageTransparency=0.35}):Play()

an.AddSignal(a7.Changed,function()
if a7.UserInputState==Enum.UserInputState.End then
if aw.WindUI.CurrentInput and aw.WindUI.CurrentInput~=a6 then
return
end

aw.WindUI.CurrentInput=nil

isResizing=false
aI.Active=false


aq(aH.ImageLabel,0.17,{ImageTransparency=0.8}):Play()
end
end)
end
end

an.AddSignal(aH.InputBegan,function(a7)
if
a7.UserInputType==Enum.UserInputType.MouseButton1
or a7.UserInputType==Enum.UserInputType.Touch
then
if aw.WindUI.CurrentInput and aw.WindUI.CurrentInput~=a6 then
return
end
aw.WindUI.CurrentInput=a6

if aE.CanResize then
startResizing(a7)
end
end
end)

an.AddSignal(af.InputChanged,function(a7)
if
a7.UserInputType==Enum.UserInputType.MouseMovement
or a7.UserInputType==Enum.UserInputType.Touch
then
if isResizing and aE.CanResize then
local a8=a7.Position-initialInputPosition
local a9=UDim2.new(0,initialSize.X.Offset+a8.X*2,0,initialSize.Y.Offset+a8.Y*2)

a9=UDim2.new(
a9.X.Scale,
math.clamp(a9.X.Offset,aE.MinSize.X,aE.MaxSize.X),
a9.Y.Scale,
math.clamp(a9.Y.Offset,aE.MinSize.Y,aE.MaxSize.Y)
)

aq(aE.UIElements.Main,0.08,{
Size=a9,
},Enum.EasingStyle.Quad,Enum.EasingDirection.Out):Play()

aE.Size=a9
end
end
end)

an.AddSignal(aH.MouseEnter,function()
if aw.WindUI.CurrentInput and aw.WindUI.CurrentInput~=a6 then
return
end
if not isResizing then
aq(aH.ImageLabel,0.1,{ImageTransparency=0.35}):Play()
end
end)
an.AddSignal(aH.MouseLeave,function()
if aw.WindUI.CurrentInput and aw.WindUI.CurrentInput~=a6 then
return
end
if not isResizing then
aq(aH.ImageLabel,0.17,{ImageTransparency=0.8}):Play()
end
end)



local a7=0
local a8=0.4
local a9
local b=0

function onDoubleClick()
aE:SetToTheCenter()
end

an.AddSignal(aT.Frame.MouseButton1Up,function()
local ba=tick()
local bb=aE.Position

b=b+1

if b==1 then
a7=ba
a9=bb

task.spawn(function()
task.wait(a8)
if b==1 then
b=0
a9=nil
end
end)
elseif b==2 then
if ba-a7<=a8 and bb==a9 then
onDoubleClick()
end

b=0
a9=nil
a7=0
else
b=1
a7=ba
a9=bb
end
end)



if aE.TabHolderType=="sidebar"and not aE.HideSearchBar then
local ba=a.load'aI'
local bb=false





















local bc=ar("Search","search",aE.UIElements.SideBarContainer,true)
bc.Size=UDim2.new(1,-aE.UIPadding/2,0,39)
bc.Position=UDim2.new(0,aE.UIPadding/2,0,0)

an.AddSignal(bc.MouseButton1Click,function()
if bb then
return
end

ba.new(aE.TabModule,aE.UIElements.Main,function()

bb=false
if aE.Resizable then
aE.CanResize=true
end

aq(aJ,0.1,{ImageTransparency=1}):Play()
aJ.Active=false
end)
aq(aJ,0.1,{ImageTransparency=0.65}):Play()
aJ.Active=true

bb=true
aE.CanResize=false
end)
end



function aE.DisableTopbarButtons(ba,bb)
for bc,bd in next,bb do
for be,bf in next,aE.TopBarButtons do
if bf.Name==bd then
bf.Object.Visible=false
end
end
end
end



























return aE
end end end

local aa={
Window=nil,
Theme=nil,
Creator=a.load'e',
Motion=a.load'f',
LocalizationModule=a.load'g',
NotificationModule=a.load'h',
Themes=nil,
Transparent=false,

TransparencyValue=0.15,

UIScale=1,

ConfigManager=nil,
Version="0.0.0",

Services=a.load'm',

OnThemeChangeFunction=nil,

cloneref=nil,
UIScaleObj=nil,

CreateWindow=nil,

CurrentInput=nil,
}

aa.IconAdapterVersion=aa.Creator.IconAdapterVersion

local af=aa.Creator

local ai=a.load'a'

aa.cloneref=ai

local ak=ai(game:GetService"HttpService")
local al=ai(game:GetService"Players")
local am=ai(game:GetService"CoreGui")
local an=ai(game:GetService"RunService")
local ao=ai(game:GetService"UserInputService")

function aa.GenerateGUID()
return ak:GenerateGUID(false)
end

local ap=aa.GenerateGUID()

af.AddSignal(ao.InputBegan,function(aq,ar)




task.defer(function()
if
aq.UserInputType==Enum.UserInputType.MouseButton1
or aq.UserInputType==Enum.UserInputType.Touch
then
if aa.CurrentInput and aa.CurrentInput~=ap then
return
end

aa.CurrentInput=ap


end
end)
end)
af.AddSignal(ao.InputEnded,function(aq,ar)
if aq.UserInputType==Enum.UserInputType.MouseButton1 or aq.UserInputType==Enum.UserInputType.Touch then
if aa.CurrentInput and aa.CurrentInput~=ap then
return
end

aa.CurrentInput=nil
end
end)

local aq=al.LocalPlayer or nil

local ar=ak:JSONDecode(a.load'n')
if ar then
aa.Version=ar.version
end

local as=a.load'r'
local at=a.load's'

local au=af.New




local av=a.load'w'

local aw=protectgui or(syn and syn.protect_gui)or function()end

local ax=gethui and gethui()or(am or aq:WaitForChild"PlayerGui")

local ay=au("UIScale",{
Scale=aa.UIScale,
})

aa.UIScaleObj=ay

aa.ScreenGui=au("ScreenGui",{
Name="WindUI",
Parent=ax,
IgnoreGuiInset=true,
ScreenInsets="None",
DisplayOrder=-99999,
},{

au("Folder",{
Name="Window",
}),






au("Folder",{
Name="KeySystem",
}),
au("Folder",{
Name="Popups",
}),
au("Folder",{
Name="ToolTips",
}),
})

aa.NotificationGui=au("ScreenGui",{
Name="WindUI/Notifications",
Parent=ax,
IgnoreGuiInset=true,
ScreenInsets="None",
ResetOnSpawn=false,
DisplayOrder=999999,
ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
})
aa.DropdownGui=au("ScreenGui",{
Name="WindUI/Dropdowns",
Parent=ax,
IgnoreGuiInset=true,
})
aa.TooltipGui=au("ScreenGui",{
Name="WindUI/Tooltips",
Parent=ax,
IgnoreGuiInset=true,
})
aw(aa.ScreenGui)
aw(aa.NotificationGui)
aw(aa.DropdownGui)
aw(aa.TooltipGui)

af.Init(aa)

function aa.SetParent(az,aA)
if aa.ScreenGui then
aa.ScreenGui.Parent=aA
end
if aa.NotificationGui then
aa.NotificationGui.Parent=aA
end
if aa.DropdownGui then
aa.DropdownGui.Parent=aA
end
if aa.TooltipGui then
aa.TooltipGui.Parent=aA
end
end
math.clamp(aa.TransparencyValue,0,1)

local az=aa.NotificationModule.Init(aa.NotificationGui)

function aa.Notify(aA,aB)
aB.Holder=az.Frame
aB.Window=aa.Window

return aa.NotificationModule.New(aB)
end

function aa.SetNotificationLower(aA,aB)
az.SetLower(aB)
end

function aa.RegisterIconSource(aA,aB,aC,aD)
return af.RegisterIconSource(aB,aC,aD)
end

function aa.RegisterIconPack(aA,aB,aC)
return af.RegisterIconPack(aB,aC)
end

aa.AddIconSource=aa.RegisterIconSource
aa.AddIcons=aa.RegisterIconPack

function aa.AddIcon(aA,aB,aC,aD)
return af.AddIcon(aB,aC,aD)
end

function aa.AddIconSourceAlias(aA,aB,aC)
return af.AddIconSourceAlias(aB,aC)
end

function aa.SetIconSource(aA,aB)
return af.SetIconSource(aB)
end

function aa.GetIconSources(aA)
return af.GetIconSources()
end

function aa.HasIcon(aA,aB,aC)
return af.HasIcon(aB,aC)
end

function aa.LoadingScreen(aA,aB)
return at.new(aa,aB)
end

function aa.LoadingCreate(aA,aB)
if aa.ActiveLoading and not aa.ActiveLoading.Closed then
aa.ActiveLoading:Close(0)
end

aa.ActiveLoading=at.new(aa,aB)
return aa.ActiveLoading
end

function aa.LoadingSet(aA,aB,aC)
local aD=aa.ActiveLoading
if not aD or aD.Closed then
aD=aa:LoadingCreate{}
end

if typeof(aB)=="table"then
if aB.Status or aB.Text or aB.Title then
aD:SetStatus(aB.Status or aB.Text or aB.Title)
end
if aB.Progress~=nil or aB.Value~=nil then
aD:SetProgress(aB.Progress~=nil and aB.Progress or aB.Value)
end
if aB.Step then
aD:Step(aB.Step,aB.Status or aB.Text)
end
if aB.Close then
aD:Close(aB.Delay or aB.CloseDelay or 0)
end
return aD
end

if typeof(aB)=="number"then
aD:SetProgress(aB)
if aC then
aD:SetStatus(aC)
end
elseif aB~=nil then
aD:SetStatus(aB)
if typeof(aC)=="number"then
aD:SetProgress(aC)
end
end

return aD
end

function aa.SetFont(aA,aB)
af.UpdateFont(aB)
end

function aa.SetMotionPreset(aA,aB)
return aa.Motion:SetPreset(aB)
end

function aa.SetReducedMotion(aA,aB)
return aa.Motion:SetReducedMotion(aB)
end

function aa.OnThemeChange(aA,aB)
aa.OnThemeChangeFunction=aB
end

function aa.AddTheme(aA,aB)
aa.Themes[aB.Name]=aB
return aB
end

function aa.SetTheme(aA,aB)
if aa.Themes[aB]then
aa.Theme=aa.Themes[aB]
af.SetTheme(aa.Themes[aB])

if aa.OnThemeChangeFunction then
aa.OnThemeChangeFunction(aB)
end

return aa.Themes[aB]
end
return nil
end

function aa.GetThemes(aA)
return aa.Themes
end
function aa.GetCurrentTheme(aA)
return aa.Theme.Name
end
function aa.GetTransparency(aA)
return aa.Transparent or false
end
function aa.GetWindowSize(aA)
return aa.Window.UIElements.Main.Size
end
function aa.Localization(aA,aB)
return aa.LocalizationModule:New(aB,af)
end

function aa.SetLanguage(aA,aB)
if af.Localization then
return af.SetLanguage(aB)
end
return false
end

function aa.ToggleAcrylic(aA,aB)
if aa.Window and aa.Window.AcrylicPaint and aa.Window.AcrylicPaint.Model then
aa.Window.Acrylic=aB
aa.Window.AcrylicPaint.Model.Transparency=aB and 0.98 or 1
if aB then
av.Enable()
else
av.Disable()
end
end
end

function aa.Gradient(aA,aB,aC)
local aD={}
local aE={}

for aF,aG in next,aB do
local aH=tonumber(aF)
if aH then
aH=math.clamp(aH/100,0,1)

local aI=aG.Color
if typeof(aI)=="string"and string.sub(aI,1,1)=="#"then
aI=Color3.fromHex(aI)
end

local aJ=aG.Transparency or 0

table.insert(aD,ColorSequenceKeypoint.new(aH,aI))
table.insert(aE,NumberSequenceKeypoint.new(aH,aJ))
end
end

table.sort(aD,function(aF,aG)
return aF.Time<aG.Time
end)
table.sort(aE,function(aF,aG)
return aF.Time<aG.Time
end)

if#aD<2 then
table.insert(aD,ColorSequenceKeypoint.new(1,aD[1].Value))
table.insert(aE,NumberSequenceKeypoint.new(1,aE[1].Value))
end

local aF={
Color=ColorSequence.new(aD),
Transparency=NumberSequence.new(aE),
}

if aC then
for aG,aH in pairs(aC)do
aF[aG]=aH
end
end

return aF
end

function aa.Popup(aA,aB)
aB.WindUI=aa
return a.load'x'.new(aB,aa.ScreenGui.Popups)
end

aa.Themes=a.load'y'(aa,af)

af.Themes=aa.Themes

aa:SetTheme"Dark"
aa:SetLanguage(af.Language)

function aa.CreateWindow(aA,aB)
local aC=a.load'aJ'

if not an:IsStudio()and writefile then
if not isfolder"WindUI"then
makefolder"WindUI"
end
if aB.Folder then
makefolder(aB.Folder)
else
makefolder(aB.Title)
end
end

aB.WindUI=aa
aB.Window=aa.Window
aB.Parent=aa.ScreenGui.Window

if aa.Window then
warn"You cannot create more than one window"
return
end

aa.Motion:Configure(aB.Motion)

local aD=true
local aE=aB.LoadingScreen or aB.Loader or aB.Loading
local aF

local function OpenLoader(aG,aH)
if aE==nil or aE==false then
return nil
end

if not aF then
local aI={}
if typeof(aE)=="table"then
for aJ,aK in next,aE do
aI[aJ]=aK
end
end

aI.Title=aI.Title or aB.Title or"WindUI"
aI.Desc=aI.Desc or"Loading interface"
aI.Icon=aI.Icon or aB.Icon or"sparkles"
aI.Folder=aI.Folder or aB.Folder
aF=at.new(aa,aI)
end

if aG then
aF:SetStatus(aG)
end
if aH then
aF:SetProgress(aH)
end

return aF
end

if not aB.KeySystem then
OpenLoader("Preparing interface",0.16)
end



local aG=a.load'D'.GetTheme(aB.TypeWindow)

local aH=aB.Theme or aG or"Dark"
local aI
if typeof(aH)=="table"then
aI=aH
elseif typeof(aH)=="string"then
aI=aa.Themes[aH]
end

aI=aI or aa.Theme or aa.Themes.Dark
aa.Theme=aI
af.SetTheme(aI)

local aJ=gethwid or function()
return al.LocalPlayer.UserId
end

local aK=aJ()

local function PickField(aL,aM)
for aN,aO in next,aM do
if aL[aO]~=nil then
return aL[aO]
end
end
return nil
end

local function NormalizeServiceType(aL)
local aM=string.lower(tostring(aL or""))
aM=string.gsub(aM,"%s+","")
aM=string.gsub(aM,"[_%-%./]","")

local aN={
luarmor="luarmor",
platoboost="platoboost",
plato="platoboost",
panda="pandadevelopment",
pandadev="pandadevelopment",
pandadevelopment="pandadevelopment",
junkie="junkiedevelopment",
junkiedev="junkiedevelopment",
junkiedevelopment="junkiedevelopment",
}

return aN[aM]or aM
end

local function NormalizeKeySystemAPI()
if not aB.KeySystem or typeof(aB.KeySystem.API)~="table"then
return
end

local aL=aB.KeySystem.API
local aM=aL
if aL.Type or aL.type or aL.Service or aL.service then
aM={aL}
end

local aN={}
for aO,aP in next,aM do
if typeof(aP)=="table"then
local aQ={}
for aR,aS in next,aP do
aQ[aR]=aS
end

aQ.Type=NormalizeServiceType(PickField(aP,{
"Type",
"type",
"Service",
"service",
"Provider",
"provider",
}))

aQ.ScriptId=PickField(aP,{
"ScriptId",
"ScriptID",
"scriptId",
"scriptID",
"script_id",
"Script",
"script",
"Id",
"ID",
"id",
})or aQ.ScriptId

aQ.ServiceId=PickField(aP,{
"ServiceId",
"ServiceID",
"serviceId",
"serviceID",
"service_id",
"Service",
"service",
"Id",
"ID",
"id",
})or aQ.ServiceId

aQ.Discord=PickField(aP,{
"Discord",
"discord",
"DiscordURL",
"DiscordUrl",
"discordUrl",
"discord_url",
"Invite",
"invite",
"URL",
"Url",
"url",
})or aQ.Discord

aQ.Secret=PickField(aP,{
"Secret",
"secret",
"ApiSecret",
"APISecret",
"apiSecret",
"api_secret",
})or aQ.Secret

aQ.ApiKey=PickField(aP,{
"ApiKey",
"APIKey",
"apiKey",
"api_key",
"Key",
"key",
})or aQ.ApiKey

if aQ.Type and aQ.Type~=""then
table.insert(aN,aQ)
end
end
end

aB.KeySystem.API=aN
end

NormalizeKeySystemAPI()

if aB.KeySystem then
aD=false

local function loadKeysystem()
as.new(aB,aK,function(aL)
aD=aL
end)
end

local aL=(aB.Folder or"Temp").."/"..aK..".key"

if aB.KeySystem.KeyValidator then
if aB.KeySystem.SaveKey and isfile(aL)then
local aM=readfile(aL)
local aN,aO=pcall(aB.KeySystem.KeyValidator,aM)

if aN and aO then
aD=true
else
loadKeysystem()
end
else
loadKeysystem()
end
elseif not aB.KeySystem.API then
if aB.KeySystem.SaveKey and isfile(aL)then
local aM=readfile(aL)
local aN=(type(aB.KeySystem.Key)=="table")and table.find(aB.KeySystem.Key,aM)
or tostring(aB.KeySystem.Key)==tostring(aM)

if aN then
aD=true
else
loadKeysystem()
end
else
loadKeysystem()
end
else
if isfile(aL)then
local aM=readfile(aL)
local aN=false

for aO,aP in next,aB.KeySystem.API do
local aQ=aa.Services[aP.Type]
if aQ then
local aR={}
for aS,aT in next,aQ.Args do
table.insert(aR,aP[aT])
end

local aS,aT=pcall(function()
return aQ.New(table.unpack(aR))
end)
local aU,aV=false,false
if aS and aT and type(aT.Verify)=="function"then
aU,aV=pcall(aT.Verify,aM)
end
if aU and aV then
aN=true
break
end
end
end

aD=aN
if not aN then
loadKeysystem()
end
else
loadKeysystem()
end
end

repeat
task.wait()
until aD

OpenLoader("Access granted",0.42)
end

OpenLoader("Building window",0.72)
local aL=aC(aB)

aa.Transparent=aB.Transparent
aa.Window=aL

if aB.Acrylic then
av.init()
end

if aF then
aF:SetStatus"Ready"
aF:SetProgress(1)
aF:Close((typeof(aE)=="table"and aE.CloseDelay)or 0.18)
end













return aL
end

return aa