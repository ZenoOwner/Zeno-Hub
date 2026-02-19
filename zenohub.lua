-- ZenoHub | Made by VexKairo
pcall(function() game:GetService("CoreGui"):FindFirstChild("ZenoHub"):Destroy() end)
pcall(function() game:GetService("CoreGui"):FindFirstChild("ZenoLoader"):Destroy() end)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local enabled = false
local antilagEnabled = false
local clicks = 0
local spamThread = nil
local stopPending = false

local cachedRemotes = {}
task.spawn(function()
    task.wait(3)
    for _, obj in pairs(RS:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local n = obj.Name:lower()
            if n:find("clash") or n:find("click") or n:find("sword")
            or n:find("swing") or n:find("hit") or n:find("deflect")
            or n:find("attack") or n:find("input") then
                table.insert(cachedRemotes, obj)
            end
        end
    end
end)

local savedLighting = {}

local function applyAntiLag()
    savedLighting.GlobalShadows = Lighting.GlobalShadows
    savedLighting.Brightness = Lighting.Brightness
    savedLighting.FogEnd = Lighting.FogEnd
    pcall(function() settings().Rendering.QualityLevel = 1 end)
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("ParticleEmitter") or obj:IsA("Beam")
            or obj:IsA("Trail") or obj:IsA("Smoke")
            or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end)
    end
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = false end
        end
    end)
end

local function removeAntiLag()
    pcall(function() settings().Rendering.QualityLevel = 10 end)
    pcall(function()
        Lighting.GlobalShadows = savedLighting.GlobalShadows or true
        Lighting.FogEnd = savedLighting.FogEnd or 100000
        Lighting.Brightness = savedLighting.Brightness or 2
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = true end
        end
    end)
    pcall(function()
        local char = LP.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end
    end)
end

local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "ZenoLoader"
LoadGui.ResetOnSpawn = false
LoadGui.IgnoreGuiInset = true
LoadGui.Parent = game:GetService("CoreGui")

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 260, 0, 220)
LoadFrame.Position = UDim2.new(0.5, -130, 0.5, -110)
LoadFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadFrame.BorderSizePixel = 0
LoadFrame.Parent = LoadGui
Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 12)

local LoadStroke = Instance.new("UIStroke", LoadFrame)
LoadStroke.Color = Color3.fromRGB(255, 0, 80)
LoadStroke.Thickness = 1.5

local TopBar = Instance.new("Frame", LoadFrame)
TopBar.Size = UDim2.new(0, 0, 0, 3)
TopBar.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 2

local Lightning = Instance.new("TextLabel", LoadFrame)
Lightning.Size = UDim2.new(1, 0, 0, 50)
Lightning.Position = UDim2.new(0, 0, 0, 20)
Lightning.BackgroundTransparency = 1
Lightning.Text = "⚡"
Lightning.TextSize = 40
Lightning.Font = Enum.Font.GothamBold
Lightning.TextXAlignment = Enum.TextXAlignment.Center

local LoadTitle = Instance.new("TextLabel", LoadFrame)
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Position = UDim2.new(0, 0, 0, 72)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "ZenoHub"
LoadTitle.TextColor3 = Color3.fromRGB(255, 0, 80)
LoadTitle.TextSize = 26
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center

local SubTitle = Instance.new("TextLabel", LoadFrame)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 103)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Blade Ball Edition"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Center

local LoadDiv = Instance.new("Frame", LoadFrame)
LoadDiv.Size = UDim2.new(0.7, 0, 0, 1)
LoadDiv.Position = UDim2.new(0.15, 0, 0, 130)
LoadDiv.BackgroundColor3 = Color3.fromRGB(60, 0, 20)
LoadDiv.BorderSizePixel = 0

local MadeByLoad = Instance.new("TextLabel", LoadFrame)
MadeByLoad.Size = UDim2.new(1, 0, 0, 18)
MadeByLoad.Position = UDim2.new(0, 0, 0, 138)
MadeByLoad.BackgroundTransparency = 1
MadeByLoad.Text = "Made by VexKairo"
MadeByLoad.TextColor3 = Color3.fromRGB(255, 0, 80)
MadeByLoad.TextSize = 12
MadeByLoad.Font = Enum.Font.GothamBold
MadeByLoad.TextXAlignment = Enum.TextXAlignment.Center

local TikTokLoader = Instance.new("TextLabel", LoadFrame)
TikTokLoader.Size = UDim2.new(1, 0, 0, 16)
TikTokLoader.Position = UDim2.new(0, 0, 0, 157)
TikTokLoader.BackgroundTransparency = 1
TikTokLoader.Text = "🎵 TikTok: zenoxxxgod"
TikTokLoader.TextColor3 = Color3.fromRGB(150, 150, 255)
TikTokLoader.TextSize = 11
TikTokLoader.Font = Enum.Font.Gotham
TikTokLoader.TextXAlignment = Enum.TextXAlignment.Center

local DiscordLoader = Instance.new("TextLabel", LoadFrame)
DiscordLoader.Size = UDim2.new(1, 0, 0, 16)
DiscordLoader.Position = UDim2.new(0, 0, 0, 174)
DiscordLoader.BackgroundTransparency = 1
DiscordLoader.Text = "💬 Discord: eye_1gowge"
DiscordLoader.TextColor3 = Color3.fromRGB(100, 150, 255)
DiscordLoader.TextSize = 11
DiscordLoader.Font = Enum.Font.Gotham
DiscordLoader.TextXAlignment = Enum.TextXAlignment.Center

local LoadingText = Instance.new("TextLabel", LoadFrame)
LoadingText.Size = UDim2.new(1, 0, 0, 16)
LoadingText.Position = UDim2.new(0, 0, 0, 196)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading..."
LoadingText.TextColor3 = Color3.fromRGB(80, 80, 80)
LoadingText.TextSize = 10
LoadingText.Font = Enum.Font.Gotham
LoadingText.TextXAlignment = Enum.TextXAlignment.Center

TweenService:Create(TopBar, TweenInfo.new(5, Enum.EasingStyle.Quad), {
    Size = UDim2.new(1, 0, 0, 3)
}):Play()

task.spawn(function()
    local dots = {"Loading.", "Loading..", "Loading...", "Loading...."}
    local i = 1
    while LoadGui.Parent ~= nil do
        LoadingText.Text = dots[i]
        i = (i % #dots) + 1
        task.wait(0.4)
    end
end)

task.wait(5)
TweenService:Create(LoadFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
    BackgroundTransparency = 1
}):Play()
task.wait(0.6)
LoadGui:Destroy()

local sg = Instance.new("ScreenGui")
sg.Name = "ZenoHub"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 155, 0, 220)
Main.Position = UDim2.new(0, 8, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = sg
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(255, 0, 80)
MainStroke.Thickness = 1.5

local GlowBar = Instance.new("Frame", Main)
GlowBar.Size = UDim2.new(1, 0, 0, 3)
GlowBar.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
GlowBar.BorderSizePixel = 0

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.Position = UDim2.new(0, 0, 0, 3)
TitleBar.BackgroundColor3 = Color3.fromRGB(5, 0, 0)
TitleBar.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, -30, 1, 0)
TitleLabel.Position = UDim2.new(0, 8, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ ZenoHub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 0, 80)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(1, -26, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 10
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)
CloseBtn.MouseButton1Click:Connect(function()
    enabled = false
    stopPending = false
    antilagEnabled = false
    if spamThread then task.cancel(spamThread) spamThread = nil end
    sg:Destroy()
end)

local StatusLabel = Instance.new("TextLabel", Main)
StatusLabel.Size = UDim2.new(1, -10, 0, 18)
StatusLabel.Position = UDim2.new(0, 5, 0, 38)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "● INACTIVE"
StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(1, -14, 0, 36)
ToggleBtn.Position = UDim2.new(0, 7, 0, 60)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
ToggleBtn.Text = "START SPAMMING"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
ToggleBtn.TextSize = 11
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.BorderSizePixel = 0
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
local TStroke = Instance.new("UIStroke", ToggleBtn)
TStroke.Color = Color3.fromRGB(255, 0, 80)
TStroke.Thickness = 1.2

local CPSLabel = Instance.new("TextLabel", Main)
CPSLabel.Size = UDim2.new(1, -10, 0, 16)
CPSLabel.Position = UDim2.new(0, 5, 0, 102)
CPSLabel.BackgroundTransparency = 1
CPSLabel.Text = "CPS: 0"
CPSLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
CPSLabel.TextSize = 10
CPSLabel.Font = Enum.Font.Gotham
CPSLabel.TextXAlignment = Enum.TextXAlignment.Center

local Div1 = Instance.new("Frame", Main)
Div1.Size = UDim2.new(1, -20, 0, 1)
Div1.Position = UDim2.new(0, 10, 0, 124)
Div1.BackgroundColor3 = Color3.fromRGB(60, 0, 20)
Div1.BorderSizePixel = 0

local AntiLagBtn = Instance.new("TextButton", Main)
AntiLagBtn.Size = UDim2.new(1, -14, 0, 30)
AntiLagBtn.Position = UDim2.new(0, 7, 0, 130)
AntiLagBtn.BackgroundColor3 = Color3.fromRGB(0, 10, 25)
AntiLagBtn.Text = "⚙️ Anti-Lag: OFF"
AntiLagBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
AntiLagBtn.TextSize = 11
AntiLagBtn.Font = Enum.Font.GothamBold
AntiLagBtn.BorderSizePixel = 0
Instance.new("UICorner", AntiLagBtn).CornerRadius = UDim.new(0, 6)
local ALStroke = Instance.new("UIStroke", AntiLagBtn)
ALStroke.Color = Color3.fromRGB(0, 120, 255)
ALStroke.Thickness = 1.2

local Div2 = Instance.new("Frame", Main)
Div2.Size = UDim2.new(1, -20, 0, 1)
Div2.Position = UDim2.new(0, 10, 0, 167)
Div2.BackgroundColor3 = Color3.fromRGB(60, 0, 20)
Div2.BorderSizePixel = 0

local MadeBy = Instance.new("TextLabel", Main)
MadeBy.Size = UDim2.new(1, -10, 0, 14)
MadeBy.Position = UDim2.new(0, 5, 0, 172)
MadeBy.BackgroundTransparency = 1
MadeBy.Text = "Made by VexKairo"
MadeBy.TextColor3 = Color3.fromRGB(255, 0, 80)
MadeBy.TextSize = 9
MadeBy.Font = Enum.Font.GothamBold
MadeBy.TextXAlignment = Enum.TextXAlignment.Center

local TikTokMain = Instance.new("TextLabel", Main)
TikTokMain.Size = UDim2.new(1, -10, 0, 13)
TikTokMain.Position = UDim2.new(0, 5, 0, 187)
TikTokMain.BackgroundTransparency = 1
TikTokMain.Text = "🎵 TikTok: zenoxxxgod"
TikTokMain.TextColor3 = Color3.fromRGB(150, 150, 255)
TikTokMain.TextSize = 9
TikTokMain.Font = Enum.Font.Gotham
TikTokMain.TextXAlignment = Enum.TextXAlignment.Center

local KeyHint = Instance.new("TextLabel", Main)
KeyHint.Size = UDim2.new(1, -10, 0, 13)
KeyHint.Position = UDim2.new(0, 5, 0, 202)
KeyHint.BackgroundTransparency = 1
KeyHint.Text = "keybind: Z"
KeyHint.TextColor3 = Color3.fromRGB(60, 60, 60)
KeyHint.TextSize = 9
KeyHint.Font = Enum.Font.Gotham
KeyHint.TextXAlignment = Enum.TextXAlignment.Center

local function startSpam()
    spamThread = task.spawn(function()
        while enabled do
            clicks = clicks + 1
            pcall(function()
                local cam = workspace.CurrentCamera
                local viewSize = cam.ViewportSize
                mousemoveabs(viewSize.X / 2, viewSize.Y / 2)
                mouse1click()
            end)
            pcall(function()
                local char = LP.Character
                if char then
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool then
                        local activate = tool:FindFirstChild("Activated")
                        if activate then activate:Fire() end
                    end
                end
            end)
            for _, remote in pairs(cachedRemotes) do
                pcall(function() remote:FireServer() end)
            end
            task.wait(0.03)
        end
    end)
end

local function toggle()
    if not enabled and not stopPending then
        enabled = true
        ToggleBtn.Text = "STOP SPAMMING"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 20, 0)
        TStroke.Color = Color3.fromRGB(0, 255, 80)
        ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 80)
        StatusLabel.Text = "● ACTIVE"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 80)
        startSpam()
    elseif enabled and not stopPending then
        enabled = false
        stopPending = true
        if spamThread then
            task.cancel(spamThread)
            spamThread = nil
        end
        ToggleBtn.Text = "TAP AGAIN TO RESET"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 0)
        TStroke.Color = Color3.fromRGB(255, 180, 0)
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 180, 0)
        StatusLabel.Text = "● STOPPED"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 180, 0)
        CPSLabel.Text = "CPS: 0"
        clicks = 0
    elseif stopPending then
        stopPending = false
        enabled = false
        ToggleBtn.Text = "START SPAMMING"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
        TStroke.Color = Color3.fromRGB(255, 0, 80)
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "● INACTIVE"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        CPSLabel.Text = "CPS: 0"
        clicks = 0
    end
end

ToggleBtn.MouseButton1Click:Connect(toggle)

pcall(function()
    UIS.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == Enum.KeyCode.Z then toggle() end
    end)
end)

AntiLagBtn.MouseButton1Click:Connect(function()
    antilagEnabled = not antilagEnabled
    if antilagEnabled then
        applyAntiLag()
        AntiLagBtn.Text = "⚙️ Anti-Lag: ON"
        AntiLagBtn.BackgroundColor3 = Color3.fromRGB(0, 25, 10)
        ALStroke.Color = Color3.fromRGB(0, 255, 120)
        AntiLagBtn.TextColor3 = Color3.fromRGB(0, 255, 120)
    else
        removeAntiLag()
        AntiLagBtn.Text = "⚙️ Anti-Lag: OFF"
        AntiLagBtn.BackgroundColor3 = Color3.fromRGB(0, 10, 25)
        ALStroke.Color = Color3.fromRGB(0, 120, 255)
        AntiLagBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if enabled then
            CPSLabel.Text = "CPS: " .. clicks * 4
        end
        clicks = 0
    end
end)
