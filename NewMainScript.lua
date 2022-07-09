local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Universal Hub (Beta)", "Sentinel")
local Tab = Window:NewTab("Main")

local MainSection = Tab:NewSection("Main")

MainSection:NewButton("E to fly!", "Press E to fly!", function()
    local Speed = 100


loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/CFrame-Fly/main/RootAnchor"))()
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

MainSection:NewButton("ShiftClickTP", "Press Shift+Click to TP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Ctrl-click-TP/main/ShiftClickTP"))()
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
