local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- [[ AUTO CHAT ON JOIN ]]
local function SendJoinMessage()
    task.wait(3) -- Menunggu loading game selesai agar chat terkirim
    local chatService = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    local message = "USEPALWAYSONTOP"
    
    if chatService then
        chatService.SayMessageRequest:FireServer(message, "All")
    else
        -- Untuk sistem chat Roblox baru (TextChatService)
        local textChatService = game:GetService("TextChatService")
        if textChatService.ChatInputBarConfiguration.TargetTextChannel then
            textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(message)
        end
    end
end
task.spawn(SendJoinMessage)

-- [[ WATERMARK GEDE & BOLD ]]
local ScreenGui = Instance.new("ScreenGui")
local Label = Instance.new("TextLabel")
ScreenGui.Parent = game:GetService("CoreGui")
Label.Parent = ScreenGui
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0, 20, 0.83, 0) 
Label.Size = UDim2.new(0, 400, 0, 40)
Label.Font = Enum.Font.Code
Label.Text = "usep v1 || by slh usep"
Label.TextColor3 = Color3.fromRGB(255, 0, 0)
Label.TextSize = 26 -- Lebih gede lagi
Label.RichText = true -- Agar bisa manipulasi teks lebih lanjut
Label.Text = "<b>usep v1 || by slh usep</b>" -- Efek BOLD
Label.TextStrokeTransparency = 0.3
Label.TextXAlignment = Enum.TextXAlignment.Left

-- [[ WINDOW ]]
local Window = OrionLib:MakeWindow({Name = "Usep Hub | Muscle Legends", HidePremium = false, SaveConfig = true, ConfigFolder = "UsepHubConfig"})

-- [[ TABS ]]
local MainTab = Window:MakeTab({Name = "Home", Icon = "rbxassetid://4483362458", PremiumOnly = false})
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483362458", PremiumOnly = false})
local ServerTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483362458", PremiumOnly = false})

-- [[ MAIN FEATURES ]]
MainTab:AddTextbox({
	Name = "Set WalkSpeed",
	Default = "200",
	TextDisappear = false,
	Callback = function(Value)
		_G.WSValue = tonumber(Value)
	end	  
})

MainTab:AddToggle({
	Name = "Enable WalkSpeed",
	Default = false,
	Callback = function(Value)
		_G.SpeedEnabled = Value
        task.spawn(function()
            while _G.SpeedEnabled do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WSValue or 200
                end
                task.wait(0.1)
            end
        end)
	end    
})

-- [[ COMBAT SECTION ]]
CombatTab:AddToggle({
	Name = "Kill Aura (Slot 1)",
	Default = false,
	Callback = function(Value)
		_G.KillAura = Value
	end    
})

CombatTab:AddSlider({
	Name = "Jarak Serangan",
	Min = 10,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,0,0),
	Increment = 10,
	ValueName = "Range",
	Callback = function(Value)
		_G.KillDistance = Value
	end    
})

-- Loop Kill Aura & Auto Equip
task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.KillAura then
            pcall(function()
                local p = game.Players.LocalPlayer
                local char = p.Character
                local tool = char:FindFirstChildOfClass("Tool") or p.Backpack:GetChildren()[1]
                
                if tool and not char:FindFirstChildOfClass("Tool") then
                    char.Humanoid:EquipTool(tool)
                end

                if tool then
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (char.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                            if dist <= (_G.KillDistance or 50) then
                                tool:Activate()
                                firetouchinterest(v.Character.HumanoidRootPart, tool.Handle, 0)
                                firetouchinterest(v.Character.HumanoidRootPart, tool.Handle, 1)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ SETTINGS ]]
ServerTab:AddButton({
	Name = "Server Hop",
	Callback = function()
        OrionLib:MakeNotification({Name = "Usep Hub", Content = "Mencari server baru...", Time = 2})
        task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId)
	end
})

OrionLib:Init()
