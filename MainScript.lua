local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Universal Hub (Beta)", "Sentinel")

local Tab = Window:NewTab("Main")

local MainSection = Tab:NewSection("Main")

MainSection:NewButton("E to fly!", "Press E to fly!", function()
    local Speed = 200


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
    --// Cache

local select = select
local pcall, getgenv, next, continue, Vector2 = select(1, pcall, getgenv, next, continue, Vector2.new)

--// Preventing Multiple Processes

pcall(function()
    getgenv().Aimbot.Functions:Exit()
end)

--// Environment

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Variables

local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

--// Script Settings

Environment.Settings = {
    Enabled = true,
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = false, -- Laggy
    Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
    TriggerKey = "MouseButton2",
    Toggle = false,
    LockPart = "Head" -- Body part to lock on
}

Environment.FOVSettings = {
    Enabled = true,
    Visible = true,
    Amount = 90,
    Color = Color3.fromRGB(255, 255, 255),
    LockedColor = Color3.fromRGB(255, 70, 70),
    Transparency = 0.5,
    Sides = 60,
    Thickness = 1,
    Filled = false
}

Environment.FOVCircle = Drawing.new("Circle")

--// Functions

local function CancelLock()
    Environment.Locked = nil
    Animation:Cancel()
    Environment.FOVCircle.Color = Environment.FOVSettings.Color
end

local function GetClosestPlayer()
    if not Environment.Locked then
        RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)

        for _, v in next, Players:GetPlayers() do
            if v ~= LocalPlayer then
                if v.Character and v.Character[Environment.Settings.LockPart] then
                    if Environment.Settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
                    if Environment.Settings.AliveCheck and v.Character.Humanoid.Health <= 0 then continue end
                    if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end

                    local Vector, OnScreen = Camera:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
                    local Distance = (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude

                    if Distance < RequiredDistance and OnScreen then
                        RequiredDistance = Distance
                        Environment.Locked = v
                    end
                end
            end
        end
    elseif (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
        CancelLock()
    end
end

--// Typing Check

ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

--// Main

local function Load()
    ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
        if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
            Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
            Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
            Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
            Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
            Environment.FOVCircle.Color = Environment.FOVSettings.Color
            Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
            Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
            Environment.FOVCircle.Position = Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        else
            Environment.FOVCircle.Visible = false
        end

        if Running and Environment.Settings.Enabled then
            GetClosestPlayer()

            if Environment.Locked then
                if Environment.Settings.Sensitivity > 0 then
                    Animation = TweenService:Create(Camera, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
                    Animation:Play()
                else
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
                end

                Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor
            end
        end
    end)

    ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
        if not Typing then
            pcall(function()
                if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running

                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)

            pcall(function()
                if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running

                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)
        end
    end)

    ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
        if not Typing then
            if not Environment.Settings.Toggle then
                pcall(function()
                    if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                        Running = false; CancelLock()
                    end
                end)

                pcall(function()
                    if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                        Running = false; CancelLock()
                    end
                end)
            end
        end
    end)
end

--// Functions

Environment.Functions = {}

function Environment.Functions:Exit()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end

    Environment.FOVCircle:Remove()

    getgenv().Aimbot.Functions = nil
    getgenv().Aimbot = nil
end

function Environment.Functions:Restart()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end

    Environment.FOVCircle:Remove()

    Load()
end

function Environment.Functions:ResetSettings()
    Environment.Settings = {
        Enabled = true,
        TeamCheck = false,
        AliveCheck = true,
        WallCheck = false,
        Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
        TriggerKey = "MouseButton2",
        Toggle = false,
        LockPart = "Head" -- Body part to lock on
    }

    Environment.FOVSettings = {
        Enabled = false,
        Visible = false,
        Amount = 90,
        Color = Color3.fromRGB(255, 255, 255),
        LockedColor = Color3.fromRGB(255, 70, 70),
        Transparency = 0.5,
        Sides = 60,
        Thickness = 1,
        Filled = false
    }

    for _, v in next, ServiceConnections do
        v:Disconnect()
    end

    Load()
end

--// Load

Load()

