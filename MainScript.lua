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
    local coreGui = game:GetService("CoreGui")
local runService = game:GetService("RunService")

-- create viewport frame and gui
local viewportGui = Instance.new("ScreenGui", coreGui)
viewportGui.IgnoreGuiInset = true

local viewportFrame = Instance.new("ViewportFrame")
viewportFrame.Parent = viewportGui
viewportFrame.CurrentCamera = workspace.CurrentCamera
viewportFrame.BackgroundTransparency = 1
viewportFrame.Size = UDim2.new(1, 0, 1, 0)
viewportFrame.Position = UDim2.new(0, 0, 0, 0)

-- clone part function
function clonePart(part, model, character)
	-- check if part is a BasePart
    if part:IsA("BasePart") then
		local head = character:WaitForChild("Head")

		-- clone part
		local clone = part:Clone() 

		-- loop through cloned part
		for _, obj in next, clone:GetChildren() do
			-- destroy anything that isnt a SpecialMesh
			if not obj:IsA("SpecialMesh") then
				obj:Destroy()
				continue
			end

			-- change SpecialMesh texture id to nothing
			obj.TextureId = ""
		end

		-- change clone color and parent clone
		clone.Color = Color3.fromRGB(0, 255, 0)
		clone.Parent = model

		-- loop clone
		runService.RenderStepped:connect(function()
			-- check if head exists
			if head:IsDescendantOf(workspace) then
				-- object on screen
				local _, visible = workspace.CurrentCamera:WorldToViewportPoint(part.Position)

				-- if object is on screen
				if visible then
					-- change CFrame and Size and Transparency of clone
					clone.CFrame = part.CFrame
					clone.Size = part.Size
					clone.Transparency = part.Transparency < 1 and 0 or 1
				else
					-- if not visible then stop rendering
					clone.Transparency = 1
				end
			else
				-- if object doesnt exist delete it and move on
				model:Destroy()
				return
			end
		end)
	end
end

function chams(character)
	-- create model for cloned parts to be in
    local model = Instance.new("Model")
    model.Name = character.Name
    model.Parent = viewportFrame

	-- loop through character
    for _, obj in next, character:GetChildren() do
		-- if character has a head then
        if character:FindFirstChild("Head") then
			-- clone parts
            clonePart(obj, model, character)
        end
    end
end

-- loop players
for _, plr in next, game:GetService("Players"):GetChildren() do
	-- get character
    local character = plr.Character or plr.CharacterAdded:Wait()
    character:WaitForChild("Head")

	-- add chams to character
    chams(character)

	-- on character created
    plr.CharacterAdded:connect(function(char)
		-- create chams
        char:WaitForChild("Head")
        chams(char)
    end)
end

-- on player join
game:GetService("Players").PlayerAdded:connect(function(plr)
	-- get character
    local character = plr.Character or plr.CharacterAdded:Wait()
    character:WaitForChild("Head")
    chams(character)
    
	-- on character created
    plr.CharacterAdded:connect(function(char)
		-- create chams
        char:WaitForChild("Head")
        chams(char)
    end)
end)  
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

MiscSection:NewButton("Chat Spammmer", "Spams toxic messages", function(v)
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
  end)
    

