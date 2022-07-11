local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Universal Hub (Beta)", "Sentinel")

local Tab = Window:NewTab("Main")

local MainSection = Tab:NewSection("Main")

MainSection:NewButton("E to fly!", "Press E to fly!", function()
    local Speed = 75


    if not RootAnchorBypassed then
        getgenv().RootAnchorBypassed = true
        local Player = game:GetService("Players").LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Root = Character:FindFirstChild("HumanoidRootPart")
        Player.CharacterAdded:Connect(function(C)
            Root = C:WaitForChild("HumanoidRootPart")
            wait(0.5)
            for _, C in pairs(getconnections(Root:GetPropertyChangedSignal("Anchored"))) do C:Disable() end
        end)
        
        local GameMT = getrawmetatable(game)
        local __oldindex = GameMT.__index
        setreadonly(GameMT, false)
        GameMT.__index = newcclosure(function(self, Key)
            if self == Root and Key == "Anchored" then return false end
            return __oldindex(self, Key)
        end)
        setreadonly(GameMT, true)
    end
    local UIS = game:GetService("UserInputService")
    local OnRender = game:GetService("RunService").RenderStepped
    
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    
    local Camera = workspace.CurrentCamera
    local Root = Character:WaitForChild("HumanoidRootPart")
    
    local C1, C2, C3;
    local Nav = {Flying = false, Forward = false, Backward = false, Left = false, Right = false}
    C1 = UIS.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Keyboard then
            if Input.KeyCode == Enum.KeyCode.E then
                Nav.Flying = not Nav.Flying
                Root.Anchored = Nav.Flying
            elseif Input.KeyCode == Enum.KeyCode.W then
                Nav.Forward = true
            elseif Input.KeyCode == Enum.KeyCode.S then
                Nav.Backward = true
            elseif Input.KeyCode == Enum.KeyCode.A then
                Nav.Left = true
            elseif Input.KeyCode == Enum.KeyCode.D then
                Nav.Right = true
            end
        end
    end)
    
    C2 = UIS.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Keyboard then
            if Input.KeyCode == Enum.KeyCode.W then
                Nav.Forward = false
            elseif Input.KeyCode == Enum.KeyCode.S then
                Nav.Backward = false
            elseif Input.KeyCode == Enum.KeyCode.A then
                Nav.Left = false
            elseif Input.KeyCode == Enum.KeyCode.D then
                Nav.Right = false
            end
        end
    end)
    
    C3 = Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
        if Nav.Flying then
            Root.CFrame = CFrame.new(Root.CFrame.Position, Root.CFrame.Position + Camera.CFrame.LookVector)
        end
    end)
    
    while true do -- not EndAll
        local Delta = OnRender:Wait()
        if Nav.Flying then
            if Nav.Forward then
                Root.CFrame = Root.CFrame + (Camera.CFrame.LookVector * (Delta * Speed))
            end
            if Nav.Backward then
                Root.CFrame = Root.CFrame + (-Camera.CFrame.LookVector * (Delta * Speed))
            end
            if Nav.Left then
                Root.CFrame = Root.CFrame + (-Camera.CFrame.RightVector * (Delta * Speed))
            end
            if Nav.Right then
                Root.CFrame = Root.CFrame + (Camera.CFrame.RightVector * (Delta * Speed))
            end
        end
    end
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
    local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

Mouse.Button1Down:connect(function()
if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
if not Mouse.Target then return end
Plr.Character:MoveTo(Mouse.Hit.p)
end)
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

ScriptsSection:NewButton("Mad city autofarm", "Loads Mad city autofarm", function()
		
    loadstring(game:HttpGet("https://system-exodus.com/scripts/madcity/MadLadsAR.lua",true))()
end)

ScriptsSection:NewButton("Rayx", "Loads Dahood Rayx", function()  --modded with no key--
		
    game:GetService("Players").LocalPlayer.IsInGroup hookfunction(game:GetService("Players").LocalPlayer.IsInGroup, newcclosure(function(self, id) if id == 12271076 then return true end return old(self, id) end)) loadstring(game:HttpGet('https://raw.githubusercontent.com/SpaceYes/Lua/Main/DaHood.Lua'))()

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

MiscSection:NewButton("AutoToxic Spam", "Spams toxic messages", function(v)
  repeat
    local args = {
        [1] = "Bad? Just give up and use universal hub!,",
        [2] = "All"
    }
    wait(1)
    local args = {
        [1] = "Why not use universal hub, Why? Because your bad,",
        [2] = "All"
    }
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
    wait(1)
    local args = {
        [1] = "Just stay mad, Stay mad, No one cares, Just use universal hub, It isnt that hard,",
        [2] = "All"
    }
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
until v == false
end)

MiscSection:NewButton("AutoToxic Spam", "Spams toxic messages", function(v)
    repeat
      local args = {
          [1] = "Bad? Just give up and use universal hub!,",
          [2] = "All"
      }
      wait(1)
      local args = {
          [1] = "Why not use universal hub, Why? Because your bad,",
          [2] = "All"
      }
      wait(1)
      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
      wait(1)
      local args = {
          [1] = "Just stay mad, Stay mad, No one cares, Just use universal hub, It isnt that hard,",
          [2] = "All"
      }
      wait(1)
      game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
  until v == false
  end)

MiscSection:NewButton("Aimbot", "Locks onto a player when you right click on someone", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Universal-Aimbot/main/aimbot"))()
