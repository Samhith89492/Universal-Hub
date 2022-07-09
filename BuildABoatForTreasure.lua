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

MainSection:NewButton("AutoFarm", "Automatically farms gold for you", function()
    loadstring(game:HttpGet("https://https://raw.githubusercontent.com/Samhith89492/BABFTAutoFarm/main/AutoFarm"))()
end)

