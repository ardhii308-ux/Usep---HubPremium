--==================================================
-- Usep Hub | Muscle Legends (Mobile Safe)
-- Password: UsepXJoyBoy
--==================================================

---------------- CONFIG ----------------
local SCRIPT_NAME = "Usep Hub"
local SCRIPT_PASSWORD = "UsepXJoyBoy"
local LOW_HP_PERCENT = 25
local LAG_THRESHOLD = 1.2
local DEFAULT_ISLAND = "Frost" -- Starter/Frost/Inferno/Mythical

---------------- SERVICES ----------------
local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local run = game:GetService("RunService")
local vu = game:GetService("VirtualUser")
local stats = plr:WaitForChild("leaderstats")

---------------- ANTI AFK ----------------
plr.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

---------------- ANTI LAG ----------------
pcall(function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    settings().Rendering.QualityLevel = 1
end)

---------------- TOGGLES (DEFAULT ON) ----------------
local T = {
    SafeMode = true,
    FastPunch = true,
    AutoKill = true,      -- PLAYER
    RockKing = true,
    WhiteRock = true,
    Weight = true,
    Rebirth = true,
    GachaDark = true,
    GachaNeon = true,
    GachaAura = true,
    IslandFarm = true,
    CharLock = true,
    PetPush = true,
    AutoOff = true
}

---------------- ISLAND ----------------
local IslandTP = {
    Starter  = CFrame.new(-30,5,180),
    Frost    = CFrame.new(-2600,5,-400),
    Inferno  = CFrame.new(-5200,5,-350),
    Mythical = CFrame.new(-7500,5,-200)
}
local SelectedIsland = DEFAULT_ISLAND

---------------- SAFE WAIT ----------------
local function SafeWait()
    if T.SafeMode then
        task.wait(math.random(40,70)/100)
    else
        task.wait(0.12)
    end
end

---------------- UI ROOT ----------------
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "UsepHubUI"

---------------- PASSWORD UI ----------------
local passF = Instance.new("Frame", gui)
passF.Size = UDim2.new(0,260,0,140)
passF.Position = UDim2.new(0.5,-130,0.5,-70)
passF.BackgroundColor3 = Color3.fromRGB(18,18,18)

local passBox = Instance.new("TextBox", passF)
passBox.Size = UDim2.new(1,-20,0,36)
passBox.Position = UDim2.new(0,10,0,40)
passBox.PlaceholderText = "Enter Password"
passBox.Text = ""
passBox.TextColor3 = Color3.new(1,1,1)
passBox.BackgroundColor3 = Color3.fromRGB(35,35,35)

local passBtn = Instance.new("TextButton", passF)
passBtn.Size = UDim2.new(1,-20,0,30)
passBtn.Position = UDim2.new(0,10,0,90)
passBtn.Text = "LOGIN"
passBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
passBtn.TextColor3 = Color3.new(1,1,1)

---------------- MAIN UI ----------------
local main = Instance.new("Frame", gui)
main.Visible = false
main.Size = UDim2.new(0,300,0,470)
main.Position = UDim2.new(0.5,-150,0.5,-235)
main.BackgroundColor3 = Color3.fromRGB(16,16,16)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,36)
title.Text = SCRIPT_NAME.." • PREMIUM"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(30,30,30)

---------------- LOGIN LOGIC ----------------
passBtn.MouseButton1Click:Connect(function()
    if passBox.Text == SCRIPT_PASSWORD then
        passF.Visible = false
        main.Visible = true
        bubble.Visible = true
    else
        passBtn.Text = "WRONG PASSWORD!"
        task.wait(1)
        passBtn.Text = "LOGIN"
    end
end)

---------------- MINIMIZE BUBBLE ----------------
local bubble = Instance.new("TextButton", gui)
bubble.Size = UDim2.new(0,46,0,46)
bubble.Position = UDim2.new(0,10,0.5,0)
bubble.Text = "UH"
bubble.Visible = false
bubble.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
bubble.TextColor3 = Color3.new(1,1,1)
bubble.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

---------------- TOGGLE BUTTONS ----------------
local y = 40
local function Toggle(text,key)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(1,-20,0,28)
    b.Position = UDim2.new(0,10,0,y)
    y += 30
    b.Text = text.." : ON"
    b.BackgroundColor3 = Color3.fromRGB(38,38,38)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(function()
        T[key] = not T[key]
        b.Text = text.." : "..(T[key] and "ON" or "OFF")
        b.BackgroundColor3 = T[key] and Color3.fromRGB(38,38,38) or Color3.fromRGB(60,20,20)
    end)
end

Toggle("Safe Mode","SafeMode")
Toggle("Fast Punch","FastPunch")
Toggle("Auto Kill PLAYER","AutoKill")
Toggle("Punch Rock King","RockKing")
Toggle("Punch White Rock","WhiteRock")
Toggle("Auto Weight","Weight")
Toggle("Auto Rebirth (Detect)","Rebirth")
Toggle("Gacha Darkstar","GachaDark")
Toggle("Gacha Neon","GachaNeon")
Toggle("Gacha Aura","GachaAura")
Toggle("Farm Per Island","IslandFarm")
Toggle("Character Lock","CharLock")
Toggle("Pet Push (Safe)","PetPush")
Toggle("Auto OFF Lag/Low HP","AutoOff")

---------------- WHITELIST PLAYER ----------------
local wlLabel = Instance.new("TextLabel", main)
wlLabel.Size = UDim2.new(1,-20,0,22)
wlLabel.Position = UDim2.new(0,10,0,y)
wlLabel.Text = "Whitelist Player: None"
wlLabel.TextColor3 = Color3.new(0.7,0.7,0.7)
wlLabel.BackgroundTransparency = 1
