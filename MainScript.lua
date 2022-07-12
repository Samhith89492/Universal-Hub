local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Universal Hub (Beta)", "Sentinel")

local Tab = Window:NewTab("Movement")

local MovementSection = Tab:NewSection("Movement")

MovementSection:NewButton("E to fly!", "Press E to fly!", function()
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
    
    while true do
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

MovementSection:NewSlider("Speed", "Increases your movement", 500, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
 end)

MovementSection:NewSlider("JumpPower", "Increases your jumppower", 500, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
 end)

MovementSection:NewKeybind("Toggle UI", "Press a key to toggle the UI", Enum.KeyCode.F, function()
	Library:ToggleUI()
 end)

MovementSection:NewButton("CtrlClickTP", "Press Ctrl+Click to TP", function()
    local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

Mouse.Button1Down:connect(function()
if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
if not Mouse.Target then return end
Plr.Character:MoveTo(Mouse.Hit.p)
end)
 end)

local Tab = Window:NewTab("Other Scripts")

local ScriptsSection = Tab:NewSection("Scripts")

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

MovementSection:NewSlider("FOVChanger", "Changes your FOV", 120, 80, function(v)
    workspace.CurrentCamera.FieldOfView = v
 end)

local Tab = Window:NewTab("Misc")

local MiscSection = Tab:NewSection("Misc")

MiscSection:NewButton("Force Respawn", "Allows you to respawn forcefully", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
 end)

MovementSection:NewSlider("Gravity", "Changes your Gravity", 196, 0, function(v)
    game.Workspace.Gravity = v
 end)

local ESPTab = Window:NewTab("ESP")
local ESPSection = ESPTab:NewSection("ESP")

ESPSection:NewButton("Chams", "Enables chams", function()
    local dwEntities = game:GetService("Players")
local dwLocalPlayer = dwEntities.LocalPlayer 
local dwRunService = game:GetService("RunService")

local settings_tbl = {
    ESP_Enabled = true,
    ESP_TeamCheck = false,
    Chams = true,
    Chams_Color = Color3.fromRGB(13,105,172),
    Chams_Transparency = 0.1,
    Chams_Glow_Color = Color3.fromRGB(13,105,172)
}

function destroy_chams(char)

    for k,v in next, char:GetChildren() do 

        if v:IsA("BasePart") and v.Transparency ~= 1 then

            if v:FindFirstChild("Glow") and 
            v:FindFirstChild("Chams") then

                v.Glow:Destroy()
                v.Chams:Destroy() 

            end 

        end 

    end 

end

dwRunService.Heartbeat:Connect(function()

    if settings_tbl.ESP_Enabled then

        for k,v in next, dwEntities:GetPlayers() do 

            if v ~= dwLocalPlayer then

                if v.Character and
                v.Character:FindFirstChild("HumanoidRootPart") and 
                v.Character:FindFirstChild("Humanoid") and 
                v.Character:FindFirstChild("Humanoid").Health ~= 0 then

                    if settings_tbl.ESP_TeamCheck == false then

                        local char = v.Character 

                        for k,b in next, char:GetChildren() do 

                            if b:IsA("BasePart") and 
                            b.Transparency ~= 1 then
                                
                                if settings_tbl.Chams then

                                    if not b:FindFirstChild("Glow") and
                                    not b:FindFirstChild("Chams") then

                                        local chams_box = Instance.new("BoxHandleAdornment", b)
                                        chams_box.Name = "Chams"
                                        chams_box.AlwaysOnTop = true 
                                        chams_box.ZIndex = 4 
                                        chams_box.Adornee = b 
                                        chams_box.Color3 = settings_tbl.Chams_Color
                                        chams_box.Transparency = settings_tbl.Chams_Transparency
                                        chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

                                        local glow_box = Instance.new("BoxHandleAdornment", b)
                                        glow_box.Name = "Glow"
                                        glow_box.AlwaysOnTop = false 
                                        glow_box.ZIndex = 3 
                                        glow_box.Adornee = b 
                                        glow_box.Color3 = settings_tbl.Chams_Glow_Color
                                        glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)

                                    end

                                else

                                    destroy_chams(char)

                                end
                            
                            end

                        end

                    else

                        if v.Team == dwLocalPlayer.Team then
                            destroy_chams(v.Character)
                        end

                    end

                else

                    destroy_chams(v.Character)

                end

            end

        end

    else 

        for k,v in next, dwEntities:GetPlayers() do 

            if v ~= dwLocalPlayer and 
            v.Character and 
            v.Character:FindFirstChild("HumanoidRootPart") and 
            v.Character:FindFirstChild("Humanoid") and 
            v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                
                destroy_chams(v.Character)

            end

        end

    end

end)
 end)

local CreditsTab = Window:NewTab("Credits")

local CreditsSection = CreditsTab:NewSection("Credits")

CreditsSection:NewButton("SamhithWasTaken#1874 aka myself lol", "credits to my self lol", function()
    setclipboard(tostring("SamhithWasTaken#1874"))
 end)

CreditsSection:NewButton("Randomguy#6407", "Credits to him for helping me with the script", function()
    setclipboard(tostring("Randomguy#6407"))
 end)


MiscSection:NewButton("Infinite Jump", "Allows you to jump in the air", function()
    game:GetService("UserInputService").JumpRequest:connect(function()
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end)
 end)

MiscSection:NewButton("Chat Spammmer", "Spams toxic messages", function(v)
  repeat
    local args = {
        [1] = "Admit that you have a skill issue, Get universal hub now!",
        [2] = "All"
    }
    wait(1)
    local args = {
        [1] = "Just because your bad dosent mean you will always stay bad, Get universal hub now!",
        [2] = "All"
    }
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
    wait(1)
    local args = {
        [1] = "Mad because bad? Get universal hub now!",
        [2] = "All"
    }
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
until v == false
 end)

MiscSection:NewButton("Aimbot", "Locks onto a player when you right click on someone", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Universal-Aimbot/main/aimbot"))()
 end)

MiscSection:NewButton("ScriptHub", "Place for most scripts (extension)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Randomguy24356/Scripthub/main/go2hub"))()
 end)

ESPSection:NewButton("NameTags", "Shows nametags of people from a far distance away", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Universal-Aimbot/main/nametags.lua"))()
 end)

MiscSection:NewButton("Gamepasses (might not work on some games)", "Gives you gamepasses for free", function()
    if game.CreatorType == Enum.CreatorType.User then
        game.Players.LocalPlayer.UserId = game.CreatorId
    end
    if game.CreatorType == Enum.CreatorType.Group then
        game.Players.LocalPlayer.UserId = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
    end
 end)

MiscSection:NewButton("Hitboxes (might not work on some games)", "Extends your hitboxes", function(v)
    _G.HeadSize = 20
	_G.Enabled = true

	game:GetService('RunService').RenderStepped:connect(function()
		if _G.Enabled then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
						v.Character.HumanoidRootPart.Transparency = 0.7
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
						v.Character.HumanoidRootPart.Material = "Neon"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		end
	end)
 end)




    
