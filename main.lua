-- Load Elerium Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/6Xm_mX6/Elerium-Lib/main/lib.lua"))()

-- Membuat Window Utama
local window = library:AddWindow("Usep Premium Hub", {
    main_color = Color3.fromRGB(255, 215, 0), -- Warna Kuning Premium
    min_size = Vector2.new(500, 400),
    can_resize = false
})

-- TAB 1: INFO
local infoTab = window:AddTab("I N F O")

infoTab:AddLabel("WELCOME TO USEP PREMIUM HUB")
infoTab:AddLabel("OWNER: USEP")

local creditLabel = infoTab:AddLabel("Script Made By: USEP PREMIUM")

-- Rainbow Effect untuk Label Credit
task.spawn(function()
    while task.wait(0.05) do
        creditLabel.TextColor3 = Color3.fromHSV(tick() * 0.2 % 1, 0.8, 1)
    end
end)

infoTab:AddButton("Copy Discord Invite", function()
    setclipboard("https://discord.gg/useppremium")
    print("Link Copied!")
end)

-- TAB 2: MAIN (FITUR)
local mainTab = window:AddTab("MAIN")

_G.AutoPunch = false
mainTab:AddSwitch("Auto Punch", function(bool)
    _G.AutoPunch = bool
    if bool then
        task.spawn(function()
            local player = game.Players.LocalPlayer
            while _G.AutoPunch do
                local punch = player.Backpack:FindFirstChild("Punch") or (player.Character and player.Character:FindFirstChild("Punch"))
                if punch then
                    if punch.Parent ~= player.Character then
                        punch.Parent = player.Character
                    end
                    punch:Activate()
                end
                task.wait(0.1)
            end
        end)
    end
end)

mainTab:AddSwitch("Fast Punch", function(bool)
    -- Logika Fast Punch di sini
    print("Fast Punch status: " .. tostring(bool))
end)

-- TAB 3: STATS
local statsTab = window:AddTab("STATS")

local timeLabel = statsTab:AddLabel("Time Spent: 0d 0h 0m 0s")
local startTime = os.time()

-- Update Waktu
task.spawn(function()
    while task.wait(1) do
        local diff = os.time() - startTime
        local d = math.floor(diff / 86400)
        local h = math.floor((diff % 86400) / 3600)
        local m = math.floor((diff % 3600) / 60)
        local s = diff % 60
        timeLabel.Text = string.format("Time Spent: %dd %dh %dm %ds", d, h, m, s)
    end
end)

statsTab:AddLabel("--- Player Stats ---")
-- Kamu bisa menambahkan stats lainnya di sini menggunakan statsTab:AddLabel()
