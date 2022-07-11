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
		
    loadstring(game:HttpGet('https://raw.githubusercontent.com/SpaceYes/Lua/Main/DaHood.Lua'))()

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
local lplayer = game.Players.LocalPlayer
local mouse = lplayer:GetMouse()
local Current = game.Workspace.CurrentCamera
local GuiService = game:GetService("StarterGui")
local enabled = false
local aimbot = true
local aimat = 'Torso'
local Track = false
local User = game:GetService("UserInputService")

GuiService:SetCore("SendNotification", {Title = "Aimlock", Text = "Script Loaded";})

function GetNearestPlayerToMouse()
local Users = {}
local lplayer_hold = {}
local Distances = {}
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= lplayer then
table.insert(Users, v)
end
end
for i, v in pairs(Users) do
if aimbot == false then
if v and (v.Character) ~= nil and v.TeamColor ~= lplayer.TeamColor then
local aim = v.Character:FindFirstChild(aimat)
if aim ~= nil then
local Distance = (aim.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local ray = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (mouse.Hit.p - Current.CoordinateFrame.p).unit * Distance)
local hit,pos = game.Workspace:FindPartOnRay(ray, game.Workspace)
local diff = math.floor((pos - aim.Position).magnitude)
lplayer_hold[v.Name .. i] = {}
lplayer_hold[v.Name .. i].dist = Distance
lplayer_hold[v.Name .. i].plr = v
lplayer_hold[v.Name .. i].diff = diff
table.insert(Distances, diff)
end
end
elseif aimbot == true then
local aim = v.Character:FindFirstChild(aimat)
if aim ~= nil then
local Distance = (aim.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local ray = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (mouse.Hit.p - Current.CoordinateFrame.p).unit * Distance)
local hit,pos = game.Workspace:FindPartOnRay(ray, game.Workspace)
local diff = math.floor((pos - aim.Position).magnitude)
lplayer_hold[v.Name .. i] = {}
lplayer_hold[v.Name .. i].dist = Distance
lplayer_hold[v.Name .. i].plr = v
lplayer_hold[v.Name .. i].diff = diff
table.insert(Distances, diff)
end
end
end

if unpack(Distances) == nil then
return false
end

local L_Distance = math.floor(math.min(unpack(Distances)))
if L_Distance > 20 then
return false
end

for i, v in pairs(lplayer_hold) do
if v.diff == L_Distance then
return v.plr
end
end
return false
end

function Find()
Clear()
Track = true
spawn(function()
while wait() do
if Track then
Clear()
for i,v in pairs(game.Players:GetChildren()) do
if v.Character and v.Character:FindFirstChild('Head') then
if aimbot == false then
if v.TeamColor ~= lplayer.TeamColor then
if v.Character:FindFirstChild('Head') then
create(v.Character.Head, true)
end
end
else
if v.Character:FindFirstChild('Head') then
create(v.Character.Head, true)
end
end
end
end
end
end
wait(1)
end)
end

game:GetService('RunService').RenderStepped:connect(function()
if enabled then
local target = GetNearestPlayerToMouse()
if (target ~= false) then
local aim = target.Character:FindFirstChild(aimat)
if aim then
Current.CoordinateFrame = CFrame.new(Current.CoordinateFrame.p, aim.CFrame.p)
end

else

end
end
end)

mouse.KeyDown:connect(function(key)
if key == "q" then
if aimat == 'Head' then
aimat = 'Torso'
           GuiService:SetCore("SendNotification", {Title = "Aimlock", Text = "Aimlock now set to Torso";})
elseif aimat == 'Torso' then
aimat = 'Head'
           GuiService:SetCore("SendNotification", {Title = "Aimlock", Text = "Aimlock now set to Head";})
end
end
end)

User.InputBegan:Connect(function(inputObject)
   if(inputObject.KeyCode==Enum.KeyCode.LeftControl) then
       enabled = true
   end
end)

User.InputEnded:Connect(function(inputObject)
   if(inputObject.KeyCode==Enum.KeyCode.LeftControl) then
       enabled = false
   end
end)
