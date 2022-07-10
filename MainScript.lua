local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Universal Hub (Beta)", "Sentinel")

local Tab = Window:NewTab("Main")

local MainSection = Tab:NewSection("Main")

MainSection:NewButton("E to fly!", "Press E to fly!", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/CFrame-Fly/main/Cframe-fly"))()
end)

MainSection:NewSlider("Speed", "Increases your movement", 500, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

MainSection:NewSlider("JumpPower", "Increases your jumppower", 500, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

MainSection:NewKeybind("Toggle UI", "Press a key to toggle the UI", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)

MainSection:NewButton("CtrlClickTP", "Press Ctrl+Click to TP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Ctrl-click-TP/main/CtrlClickTP"))()
end)

local Tab = Window:NewTab("Other Scripts")

local ScriptsSection = Tab:NewSection("OtherScripts")

ScriptsSection:NewButton("Hydroxide", "Loads Hydroxide", function()
    local owner = "Upbolt"
local branch = "revision"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init")
webImport("ui/main")
end)

ScriptsSection:NewButton("EngoSpy", "Loads EngoSpy", function()
    local settings = {
        saveCalls = false,
        maxCallsSaved = 1000,
        saveOnlyLastCall = true,
        maxTableDepth = 100,
        minimizeBind = Enum.KeyCode.RightAlt,
        blacklistedNames = {}
     }
     loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/engospy/main/source.lua"))(settings)
end)

MainSection:NewSlider("FOVChanger", "Changes your FOV", 120, 80, function(v)
    workspace.CurrentCamera.FieldOfView = v
end)

local Tab = Window:NewTab("Misc")

local MiscSection = Tab:NewSection("Misc")

MiscSection:NewButton("Force Respawn", "Allows you to respawn forcefully", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

MainSection:NewSlider("Gravity", "Changes your Gravity", 196, 0, function(v)
    game.Workspace.Gravity = v
end)

local ESPTab = Window:NewTab("ESP")
local ESPSection = ESPTab:NewSection("ESP")

ESPSection:NewButton("Chams", "Enables chams", function()
    _G.FriendColor = Color3.fromRGB(0, 0, 255)
_G.EnemyColor = Color3.fromRGB(255, 0, 0)
_G.UseTeamColor = false

--------------------------------------------------------------------

if _G.Reantheajfdfjdgse then
    return
end

_G.Reantheajfdfjdgse = "susan"

local coregui = game:GetService("CoreGui")
local players = game:GetService("Players")
local plr = players.LocalPlayer

local highlights = {}

function esp(target, color)
    pcall(function()
        if target.Character then
            if not highlights[target] then
                local highlight = Instance.new("Highlight", coregui)
                highlight.Name = target.Name
                highlight.Adornee = target.Character
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.FillColor = color
                highlights[target] = highlight
            else
                highlights[target].FillColor = color
            end
        end
    end)
end

players.PlayerAdded:Connect(function(v)
    v.CharacterAdded:Connect(function()
        esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
    end)
end)

players.PlayerRemoving:Connect(function(v)
    if highlights[v] then
        highlights[v]:Destroy()
        highlights[v] = nil
    end
end)

for i, v in pairs(players:GetPlayers()) do
    if v ~= plr then
        local color = _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor)
        v.CharacterAdded:Connect(function()
            local color = _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor)
            esp(v, color)
        end)
        
        esp(v, color)
    end
end

while task.wait() do
    for i, v in pairs(highlights) do
        local color = _G.UseTeamColor and i.TeamColor.Color or ((plr.TeamColor == i.TeamColor) and _G.FriendColor or _G.EnemyColor)
        v.FillColor = color
    end
end
end)

local CreditsTab = Window:NewTab("Credits")

local CreditsSection = CreditsTab:NewSection("Credits")

CreditsSection:NewButton("SamhithWasTaken#1874 aka myself lol", "credits to my self lol", function()
    setclipboard(tostring("SamhithWasTaken#1874"))
end)

CreditsSection:NewButton("Randomguy#6407", "credits to him for chams", function()
    setclipboard(tostring("Randomguy#6407"))
end)


MiscSection:NewButton("Infinite Jump", "Allows you to jump in the air", function()
    game:GetService("UserInputService").JumpRequest:connect(function()
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end)
end)

MiscSection:NewButton("Anti-Afk", "Prevents you from being kicked for afk!", function()
    local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
		
ScriptsSection:NewButton("DarkDex v3", "Loads DarkDex V3", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
end)

ScriptsSection:NewButton("Vape V4", "Loads Vape V4", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)
		
ScriptsSection:NewButton("FutureClient", "Loads FutureClient", function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/joeengo/Future/main/loadstring.lua', true))()
end)				
