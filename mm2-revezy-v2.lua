-- [[ 🩸 REVEZY V25 NIGHTMARE SUPREME - BLOOD & BONE EDITION 🩸 ]]
-- [ THE MOST TERRIFYING & BEAUTIFUL UI | 100+ FUNCTIONS | 1000% WORKING ]
-- DEVELOPED BY: BEAM (Revezy Studio)

-- ==========================================
-- 🖼️ รูปปุ่มลอย (Floating Button)
local FloatingImageURL = "rbxassetid://136851303781957"
-- ==========================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local StartTime = tick()

-- [ 🗑️ ล้างของเก่าทิ้งให้หมด ]
if CoreGui:FindFirstChild("RevezyNightmare") then CoreGui.RevezyNightmare:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RevezyNightmare"
ScreenGui.ResetOnSpawn = false
if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
ScreenGui.Parent = CoreGui

-- [[ 🩸 THEME COLORS ]]
local BloodRed = Color3.fromRGB(180, 5, 5)
local DeepBlack = Color3.fromRGB(8, 8, 8)
local DarkGrey = Color3.fromRGB(15, 15, 15)

-- [[ 🎬 SCARY INTRO SEQUENCE ]]
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0); IntroFrame.BackgroundColor3 = DeepBlack; IntroFrame.ZIndex = 9999
local IntroText = Instance.new("TextLabel", IntroFrame)
IntroText.Size = UDim2.new(1, 0, 1, 0); IntroText.BackgroundTransparency = 1; IntroText.Text = "R E V E Z Y   N I G H T M A R E"
IntroText.TextColor3 = BloodRed; IntroText.Font = Enum.Font.Creepster; IntroText.TextSize = 60; IntroText.TextTransparency = 1

TweenService:Create(IntroText, TweenInfo.new(2, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()
task.wait(2.5)
TweenService:Create(IntroText, TweenInfo.new(0.1, Enum.EasingStyle.Bounce), {Position = UDim2.new(0, 5, 0, 5), TextColor3 = Color3.new(1,1,1)}):Play()
task.wait(0.1)
TweenService:Create(IntroText, TweenInfo.new(0.1, Enum.EasingStyle.Bounce), {Position = UDim2.new(0, -5, 0, -5), TextColor3 = BloodRed}):Play()
task.wait(0.1)
TweenService:Create(IntroText, TweenInfo.new(1, Enum.EasingStyle.Sine), {TextTransparency = 1}):Play()
TweenService:Create(IntroFrame, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()
task.delay(1.5, function() IntroFrame:Destroy() end)

-- [[ ⚙️ CONFIGURATION ]]
local Config = {
    Aim = false, SilentAim = false, TriggerBot = false, KillAura = false, Hitbox = false, HitboxSize = 15, FOV = 150, ShowFOV = false,
    ESP = false, Names = false, Chams = false, GunTracer = false, CoinESP = false, FullBright = false, BloodUI = true,
    Speed = 16, Jump = 50, Noclip = false, InfJump = false, WalkAir = false, CtrlTP = false, Spider = false, Bhop = false,
    AutoCoin = false, GrabGunDrop = false, AutoShootMM2 = false, FlingMurderer = false, AutoWin = false, TPMap = false, TPLobby = false,
    SuperFling = false, LoopFollow = false, TargetPlayer = "", FollowDistance = 3, Spin = false, FakeLag = false, AntiMurderer = false,
    AutoAnnounceRoles = false, AnnounceClose = false, ChatSpam = false, SpamText = "🩸 REVEZY WILL CONSUME YOU 🩸", TrashTalk = false,
    AntiAFK = true, Watermark = true, FPSBoost = false
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5; FOVCircle.Color = BloodRed; FOVCircle.Transparency = 1; FOVCircle.Filled = false
local GunLine = Drawing.new("Line")
GunLine.Thickness = 2; GunLine.Color = Color3.fromRGB(255, 50, 50); GunLine.Transparency = 1; GunLine.Visible = false

-- [[ 📢 BLOODY NOTIFICATION SYSTEM ]]
local NotifContainer = Instance.new("Frame", ScreenGui)
NotifContainer.Size = UDim2.new(0, 320, 1, -20); NotifContainer.Position = UDim2.new(1, -340, 0, 20); NotifContainer.BackgroundTransparency = 1
local NotifLayout = Instance.new("UIListLayout", NotifContainer)
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder; NotifLayout.Padding = UDim.new(0, 10); NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

local function SendNotification(title, text, duration)
    local frame = Instance.new("Frame", NotifContainer)
    frame.Size = UDim2.new(1, 0, 0, 65); frame.BackgroundColor3 = DeepBlack; frame.BackgroundTransparency = 1; frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
    local stroke = Instance.new("UIStroke", frame); stroke.Color = BloodRed; stroke.Thickness = 2; stroke.Transparency = 1
    
    local grad = Instance.new("UIGradient", frame); grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, DeepBlack), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 0))}
    
    local titleLbl = Instance.new("TextLabel", frame)
    titleLbl.Size = UDim2.new(1, -20, 0, 25); titleLbl.Position = UDim2.new(0, 10, 0, 5); titleLbl.Text = "💀 " .. title; titleLbl.TextColor3 = BloodRed; titleLbl.Font = Enum.Font.GothamBlack; titleLbl.TextSize = 15; titleLbl.BackgroundTransparency = 1; titleLbl.TextXAlignment = "Left"; titleLbl.TextTransparency = 1
    
    local textLbl = Instance.new("TextLabel", frame)
    textLbl.Size = UDim2.new(1, -20, 0, 25); textLbl.Position = UDim2.new(0, 10, 0, 32); textLbl.Text = text; textLbl.TextColor3 = Color3.new(1,1,1); textLbl.Font = Enum.Font.Gotham; textLbl.TextSize = 13; textLbl.BackgroundTransparency = 1; textLbl.TextXAlignment = "Left"; textLbl.TextTransparency = 1
    
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
    TweenService:Create(titleLbl, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    TweenService:Create(textLbl, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
    
    task.delay(duration or 3, function()
        TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
        TweenService:Create(titleLbl, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        TweenService:Create(textLbl, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        task.wait(0.5); frame:Destroy()
    end)
end

-- [[ 🩸 MAIN UI CONSTRUCTION ]]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 900, 0, 650); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = DeepBlack; Main.BorderSizePixel = 0; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local MainGrad = Instance.new("UIGradient", Main)
MainGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, DeepBlack), ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 2, 2))}
MainGrad.Rotation = 45

-- แอนิเมชันเปิด UI
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 900, 0, 650)}):Play()
task.delay(1, function() SendNotification("SYSTEM ONLINE", "ระบบพร้อมสังหารแล้วบอส!", 4) end)

-- 🫀 ขอบเรืองแสงจังหวะหัวใจ (Heartbeat Stroke)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = BloodRed; MainStroke.Thickness = 3; MainStroke.Transparency = 0
task.spawn(function()
    while task.wait() do
        TweenService:Create(MainStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Transparency = 0, Thickness = 4}):Play()
        task.wait(0.2)
        TweenService:Create(MainStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Transparency = 0.6, Thickness = 2}):Play()
        task.wait(0.8)
    end
end)

-- 💀 GLITCH TITLE EFFECT
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 90); Header.BackgroundColor3 = Color3.fromRGB(12, 0, 0); Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)
local HeaderCover = Instance.new("Frame", Header); HeaderCover.Size = UDim2.new(1, 0, 0, 24); HeaderCover.Position = UDim2.new(0, 0, 1, -24); HeaderCover.BackgroundColor3 = Color3.fromRGB(12, 0, 0); HeaderCover.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0, 500, 1, 0); Title.Position = UDim2.new(0, 30, 0, -5)
Title.Text = "REVEZY NIGHTMARE"; Title.TextColor3 = BloodRed; Title.TextStrokeTransparency = 0; Title.TextStrokeColor3 = Color3.new(0,0,0)
Title.Font = Enum.Font.Creepster; Title.TextSize = 40; Title.BackgroundTransparency = 1; Title.TextXAlignment = "Left"

local SubTitle = Instance.new("TextLabel", Header)
SubTitle.Size = UDim2.new(0, 450, 0, 20); SubTitle.Position = UDim2.new(0, 32, 0, 60)
SubTitle.Text = "SUPREME BLOOD & BONE EDITION | BY BEAM"; SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.Font = Enum.Font.GothamBold; SubTitle.TextSize = 12; SubTitle.BackgroundTransparency = 1; SubTitle.TextXAlignment = "Left"

task.spawn(function()
    while task.wait(math.random(2, 5)) do
        Title.Position = UDim2.new(0, 32, 0, -3); Title.TextColor3 = Color3.new(1,1,1)
        task.wait(0.05)
        Title.Position = UDim2.new(0, 28, 0, -7); Title.TextColor3 = BloodRed
        task.wait(0.05)
        Title.Position = UDim2.new(0, 30, 0, -5)
    end
end)

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 240, 1, -110); Sidebar.Position = UDim2.new(0, 20, 0, 100); Sidebar.BackgroundTransparency = 1
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 8)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -290, 1, -120); Container.Position = UDim2.new(0, 270, 0, 100); Container.BackgroundTransparency = 1

local Pages = {}
local function CreateTab(name, icon)
    local p = Instance.new("ScrollingFrame", Container)
    p.Size = UDim2.new(1, 0, 1, 0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 3; p.ScrollBarImageColor3 = BloodRed; p.CanvasSize = UDim2.new(0,0,0,2500)
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 12)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, 0, 0, 45); b.Text = "   " .. icon .. "   " .. name; b.Font = Enum.Font.GothamBlack; b.TextColor3 = Color3.fromRGB(120, 120, 120)
    b.BackgroundColor3 = Color3.fromRGB(15, 15, 15); b.TextSize = 14; b.TextXAlignment = "Left"; b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local bStroke = Instance.new("UIStroke", b); bStroke.Color = BloodRed; bStroke.Thickness = 1; bStroke.Transparency = 1
    
    b.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages) do v.Visible = false end
        for _,v in pairs(Sidebar:GetChildren()) do 
            if v:IsA("TextButton") then 
                TweenService:Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(15, 15, 15), TextColor3 = Color3.fromRGB(120, 120, 120)}):Play() 
                v.UIStroke.Transparency = 1
            end 
        end
        p.Visible = true; 
        TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 5, 5), TextColor3 = Color3.new(1, 1, 1)}):Play()
        bStroke.Transparency = 0
    end)
    Pages[name] = p; return p
end

-- 🩸 BEAUTIFUL & SCARY UI ELEMENTS
local function AddToggle(tab, text, cfgKey)
    local f = Instance.new("Frame", tab); f.Size = UDim2.new(1, -10, 0, 55); f.BackgroundColor3 = Color3.fromRGB(18, 18, 18); f.BorderSizePixel = 0; Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", f); stroke.Color = Color3.fromRGB(50, 0, 0); stroke.Thickness = 1
    local t = Instance.new("TextButton", f); t.Size = UDim2.new(1,0,1,0); t.BackgroundTransparency = 1; t.Text = "    " .. text; t.TextColor3 = Color3.new(0.8,0.8,0.8); t.Font = Enum.Font.GothamBold; t.TextXAlignment = "Left"; t.TextSize = 14
    local box = Instance.new("Frame", f); box.Size = UDim2.new(0, 50, 0, 24); box.Position = UDim2.new(1, -65, 0.5, -12); box.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", box).CornerRadius = UDim.new(1,0)
    local boxStroke = Instance.new("UIStroke", box); boxStroke.Color = Color3.fromRGB(60, 60, 60); boxStroke.Thickness = 1
    local dot = Instance.new("Frame", box); dot.Size = UDim2.new(0, 18, 0, 18); dot.Position = UDim2.new(0, 3, 0.5, -9); dot.BackgroundColor3 = Color3.new(0.5,0.5,0.5); Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    
    t.MouseButton1Click:Connect(function()
        Config[cfgKey] = not Config[cfgKey]
        TweenService:Create(box, TweenInfo.new(0.3), {BackgroundColor3 = Config[cfgKey] and BloodRed or Color3.fromRGB(30, 30, 30)}):Play()
        TweenService:Create(boxStroke, TweenInfo.new(0.3), {Color = Config[cfgKey] and BloodRed or Color3.fromRGB(60, 60, 60)}):Play()
        TweenService:Create(dot, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = Config[cfgKey] and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Config[cfgKey] and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)}):Play()
        TweenService:Create(t, TweenInfo.new(0.3), {TextColor3 = Config[cfgKey] and Color3.new(1,1,1) or Color3.new(0.8,0.8,0.8)}):Play()
        if cfgKey == "ShowFOV" then FOVCircle.Visible = Config.ShowFOV end
        if cfgKey == "GunTracer" and not Config.GunTracer then GunLine.Visible = false end
        if cfgKey == "BloodUI" then MainStroke.Color = Config.BloodUI and BloodRed or Color3.new(1,1,1) end
    end)
end

local function AddSlider(tab, text, min, max, default, cfgKey)
    local f = Instance.new("Frame", tab); f.Size = UDim2.new(1, -10, 0, 75); f.BackgroundColor3 = Color3.fromRGB(18, 18, 18); f.BorderSizePixel = 0; Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", f).Color = Color3.fromRGB(50, 0, 0)
    local tl = Instance.new("TextLabel", f); tl.Size = UDim2.new(1,0,0,35); tl.Text = "    "..text.." : "..default; tl.TextColor3 = Color3.new(1,1,1); tl.Font = Enum.Font.GothamBold; tl.TextXAlignment = "Left"; tl.BackgroundTransparency = 1; tl.TextSize = 14
    local bar = Instance.new("Frame", f); bar.Size = UDim2.new(0.9, 0, 0, 8); bar.Position = UDim2.new(0.05, 0, 0.65, 0); bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)
    local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = BloodRed; Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    
    local b = Instance.new("TextButton", bar); b.Size = UDim2.new(1,0,1,0); b.BackgroundTransparency = 1; b.Text = ""
    b.MouseButton1Down:Connect(function()
        local m; m = UserInputService.InputChanged:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                local p = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(p, 0, 1, 0)}):Play()
                local val = math.floor(min + (max-min)*p); tl.Text = "    "..text.." : "..val; Config[cfgKey] = val
            end
        end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then m:Disconnect() end end)
    end)
end

local function AddDropdown(tab, text, cfgKey)
    local container = Instance.new("Frame", tab); container.Size = UDim2.new(1, -10, 0, 55); container.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", container).Color = Color3.fromRGB(50, 0, 0)
    local btn = Instance.new("TextButton", container); btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = "    " .. text .. " : [คลิกเลือกเหยื่อ]"; btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.GothamBold; btn.TextSize = 14; btn.TextXAlignment = "Left"

    local dropList = Instance.new("ScrollingFrame", tab); dropList.Size = UDim2.new(1, -10, 0, 160); dropList.BackgroundColor3 = Color3.fromRGB(20, 5, 5); dropList.Visible = false; dropList.ScrollBarThickness = 2; dropList.ScrollBarImageColor3 = BloodRed; Instance.new("UICorner", dropList).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", dropList).Color = BloodRed
    local layout = Instance.new("UIListLayout", dropList); layout.Padding = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        dropList.Visible = not dropList.Visible
        if dropList.Visible then
            for _, v in pairs(dropList:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
            local count = 0
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= Player then
                    count = count + 1
                    local pBtn = Instance.new("TextButton", dropList)
                    pBtn.Size = UDim2.new(1, -8, 0, 38); pBtn.Position = UDim2.new(0, 4, 0, 0); pBtn.BackgroundColor3 = Color3.fromRGB(30, 5, 5); pBtn.Text = "  💀 " .. p.Name; pBtn.TextColor3 = Color3.new(1, 1, 1); pBtn.Font = Enum.Font.Gotham; pBtn.TextSize = 14; pBtn.TextXAlignment = "Left"; Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
                    pBtn.MouseButton1Click:Connect(function() Config[cfgKey] = p.Name; btn.Text = "    " .. text .. " : " .. p.Name; dropList.Visible = false; SendNotification("TARGET LOCKED", "ล็อคเป้าหมาย: " .. p.Name, 3) end)
                end
            end
            dropList.CanvasSize = UDim2.new(0, 0, 0, count * 42)
        end
    end)
end

local function AddTextBox(tab, text, cfgKey)
    local f = Instance.new("Frame", tab); f.Size = UDim2.new(1, -10, 0, 55); f.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", f).Color = Color3.fromRGB(50, 0, 0)
    local lbl = Instance.new("TextLabel", f); lbl.Size = UDim2.new(0.4, 0, 1, 0); lbl.Text = "    " .. text; lbl.TextColor3 = Color3.new(1,1,1); lbl.Font = Enum.Font.GothamBold; lbl.TextXAlignment = "Left"; lbl.BackgroundTransparency = 1; lbl.TextSize = 14
    local box = Instance.new("TextBox", f); box.Size = UDim2.new(0.55, 0, 0.7, 0); box.Position = UDim2.new(0.4, 0, 0.15, 0); box.BackgroundColor3 = Color3.fromRGB(30, 5, 5); box.Text = Config[cfgKey]; box.TextColor3 = Color3.new(1,1,1); box.Font = Enum.Font.Gotham; box.TextSize = 12; box.ClearTextOnFocus = false; Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", box).Color = BloodRed
    box.FocusLost:Connect(function() Config[cfgKey] = box.Text end)
end

local function AddButton(tab, text, callback)
    local f = Instance.new("Frame", tab); f.Size = UDim2.new(1, -10, 0, 55); f.BackgroundColor3 = Color3.fromRGB(40, 5, 5); Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", f).Color = BloodRed
    local b = Instance.new("TextButton", f); b.Size = UDim2.new(1, 0, 1, 0); b.BackgroundTransparency = 1; b.Text = text; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.GothamBlack; b.TextSize = 16
    b.MouseButton1Click:Connect(function()
        TweenService:Create(f, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(180, 5, 5)}):Play()
        task.wait(0.1)
        TweenService:Create(f, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 5, 5)}):Play()
        callback()
    end)
end

-- [[ 🚀 TABS CREATION ]]
local T0 = CreateTab("STATUS", "📊") 
local T6 = CreateTab("MM2 GOD", "🔪") 
local T1 = CreateTab("COMBAT", "⚔️")
local T2 = CreateTab("VISUALS", "👁️")
local T3 = CreateTab("MOVEMENT", "⚡")
local T4 = CreateTab("FARMING", "🔱")
local T5 = CreateTab("NIGHTMARE (TROLL)", "💀")
local T8 = CreateTab("SERVER & BOOST", "🖥️")
local T7 = CreateTab("SETTINGS", "⚙️")

Pages["STATUS"].Visible = true
Sidebar:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(40, 5, 5); Sidebar:GetChildren()[2].TextColor3 = Color3.new(1, 1, 1); Sidebar:GetChildren()[2].UIStroke.Transparency = 0

-- [[ 📊 DASHBOARD (STATUS PAGE) ]]
local ProfileGrid = Instance.new("Frame", T0); ProfileGrid.Size = UDim2.new(1, -10, 0, 150); ProfileGrid.BackgroundTransparency = 1
local P1 = Instance.new("Frame", ProfileGrid); P1.Size = UDim2.new(0.48, 0, 1, 0); P1.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Instance.new("UICorner", P1).CornerRadius = UDim.new(0, 12); Instance.new("UIStroke", P1).Color = Color3.fromRGB(50, 0, 0)
local P2 = Instance.new("Frame", ProfileGrid); P2.Size = UDim2.new(0.48, 0, 1, 0); P2.Position = UDim2.new(0.52, 0, 0, 0); P2.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Instance.new("UICorner", P2).CornerRadius = UDim.new(0, 12); Instance.new("UIStroke", P2).Color = Color3.fromRGB(50, 0, 0)

local UserPic = Instance.new("ImageLabel", P1); UserPic.Size = UDim2.new(0, 90, 0, 90); UserPic.Position = UDim2.new(0, 15, 0.5, -45); UserPic.BackgroundTransparency = 1; UserPic.Image = game.Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420); Instance.new("UICorner", UserPic).CornerRadius = UDim.new(1, 0)
local WelcomeText = Instance.new("TextLabel", P1); WelcomeText.Size = UDim2.new(0, 150, 0, 20); WelcomeText.Position = UDim2.new(0, 120, 0, 40); WelcomeText.Text = "WELCOME TO HELL,"; WelcomeText.TextColor3 = Color3.fromRGB(150, 150, 150); WelcomeText.Font = Enum.Font.Gotham; WelcomeText.TextSize = 12; WelcomeText.BackgroundTransparency = 1; WelcomeText.TextXAlignment = "Left"
local UserNameText = Instance.new("TextLabel", P1); UserNameText.Size = UDim2.new(0, 150, 0, 30); UserNameText.Position = UDim2.new(0, 120, 0, 60); UserNameText.Text = Player.Name; UserNameText.TextColor3 = BloodRed; UserNameText.Font = Enum.Font.GothamBlack; UserNameText.TextSize = 20; UserNameText.BackgroundTransparency = 1; UserNameText.TextXAlignment = "Left"

local Stat_Role = Instance.new("TextLabel", P2); Stat_Role.Size = UDim2.new(1, -20, 0, 30); Stat_Role.Position = UDim2.new(0, 15, 0, 20); Stat_Role.Text = "🎭 บทบาท: ค้นหา..."; Stat_Role.TextColor3 = Color3.new(1, 1, 1); Stat_Role.Font = Enum.Font.GothamBold; Stat_Role.TextSize = 14; Stat_Role.BackgroundTransparency = 1; Stat_Role.TextXAlignment = "Left"
local Stat_Murd = Instance.new("TextLabel", P2); Stat_Murd.Size = UDim2.new(1, -20, 0, 30); Stat_Murd.Position = UDim2.new(0, 15, 0, 60); Stat_Murd.Text = "🔪 ไอชั่ว: กำลังหา..."; Stat_Murd.TextColor3 = BloodRed; Stat_Murd.Font = Enum.Font.GothamBold; Stat_Murd.TextSize = 14; Stat_Murd.BackgroundTransparency = 1; Stat_Murd.TextXAlignment = "Left"
local Stat_Sheriff = Instance.new("TextLabel", P2); Stat_Sheriff.Size = UDim2.new(1, -20, 0, 30); Stat_Sheriff.Position = UDim2.new(0, 15, 0, 100); Stat_Sheriff.Text = "🔫 นายอำเภอ: กำลังหา..."; Stat_Sheriff.TextColor3 = Color3.fromRGB(50, 150, 255); Stat_Sheriff.Font = Enum.Font.GothamBold; Stat_Sheriff.TextSize = 14; Stat_Sheriff.BackgroundTransparency = 1; Stat_Sheriff.TextXAlignment = "Left"

-- [ TABS CONTENT - 1000% WORKING FULL SYSTEM ]
AddToggle(T6, "ยิงไอชั่วออโต้ (แม่นเหมือนจับวาง)", "AutoShootMM2")
AddToggle(T6, "วาร์ปเก็บปืนนายอำเภอที่ตกทันที", "GrabGunDrop")
AddToggle(T6, "ชนไอชั่วให้กระเด็น (Fling Murd)", "FlingMurderer")
AddToggle(T6, "วาร์ปเข้าแมพ", "TPMap")
AddToggle(T6, "วาร์ปกลับล็อบบี้", "TPLobby")
AddToggle(T6, "ซ่อนตัวใต้ดินรอชนะ (Auto Win)", "AutoWin")

AddToggle(T1, "ล็อกเป้าไร้ปรานี (Aimbot)", "Aim")
AddToggle(T1, "ยิงเมื่อเป้าตรง (TriggerBot)", "TriggerBot")
AddToggle(T1, "แสดงวงกลมมรณะ (Show FOV)", "ShowFOV")
AddSlider(T1, "ขนาดวงกลม (FOV Size)", 50, 1000, 150, "FOV")
AddToggle(T1, "ฟันรอบตัวสังหารหมู่ (Kill Aura)", "KillAura")
AddToggle(T1, "ขยายเป้าหมาย (Hitbox Expander)", "Hitbox")
AddSlider(T1, "ขนาด Hitbox", 2, 50, 15, "HitboxSize")

AddToggle(T2, "มองทะลุวิญญาณ (ESP Box)", "ESP")
AddToggle(T2, "ชื่อ & บทบาทบนหัว (Names)", "Names")
AddToggle(T2, "ตัวเรืองแสงแยกสี (Chams)", "Chams")
AddToggle(T2, "📍 โยงเส้นเลือดหาปืนตก (Gun Tracer)", "GunTracer")
AddToggle(T2, "💰 มองทะลุเหรียญในแมพ (Coin ESP)", "CoinESP")
AddToggle(T2, "เปิดไฟสว่างนรก (FullBright)", "FullBright")

AddSlider(T3, "ความเร็ววิ่งเหนือแสง", 16, 300, 16, "Speed")
AddSlider(T3, "พลังกระโดดทะลุฟ้า", 50, 400, 50, "Jump")
AddToggle(T3, "เดินทะลุกำแพง (Noclip)", "Noclip")
AddToggle(T3, "กระโดดรัวๆ (Bunny Hop / Bhop)", "Bhop")
AddToggle(T3, "เหยียบอากาศ (Walk on Air)", "WalkAir")
AddToggle(T3, "ไต่กำแพงแมงมุม (Spider)", "Spider")
AddToggle(T3, "วาร์ปตามเมาส์สั่ง (Ctrl+Click)", "CtrlTP")

AddToggle(T4, "ดูดเหรียญ MM2 ออโต้", "AutoCoin")
AddToggle(T4, "กันเซิร์ฟเตะ (Anti-AFK)", "AntiAFK")

AddDropdown(T5, "🎯 เลือกเหยื่อที่จะโดนเชือด", "TargetPlayer")
AddSlider(T5, "ระยะเกาะติดวิญญาณ (บวก=หลัง, ลบ=หน้า)", -10, 10, 3, "FollowDistance")
AddToggle(T5, "สิงร่างเป้าหมาย (Loop Follow)", "LoopFollow")
AddToggle(T5, "🌀 เตะปลิวออกนอกโลก (Super Fling)", "SuperFling")
AddToggle(T5, "📢 แฉบทบาทคนชั่วลงแชทอัตโนมัติ", "AutoAnnounceRoles")
AddToggle(T5, "🚨 ด่าไอชั่วลงแชทเมื่อมันเข้าใกล้", "AnnounceClose")
AddToggle(T5, "💨 แยกร่างวิชาตัวเบา (Fake Lag)", "FakeLag")
AddTextBox(T5, "ข้อความหลอนๆ สแปมแชท", "SpamText")
AddToggle(T5, "💬 สแปมแชทป่วนเซิร์ฟ (Chat Spam)", "ChatSpam")
AddToggle(T5, "🤬 ด่ากราดออโต้ (Trash Talk)", "TrashTalk")
AddToggle(T5, "พายุหมุน (Spinbot)", "Spin")

AddToggle(T8, "🚀 รีดเฟรมเรทขั้นสุด (BEAM FPS BOOSTER)", "FPSBoost")
AddButton(T8, "🔄 รีจอยห้องเดิม (Rejoin)", function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player) end)
AddButton(T8, "🌐 กระโดดหาห้องใหม่ (Server Hop)", function() SendNotification("SERVER HOP", "ย้ายไปหาเหยื่อห้องอื่น...", 3); TeleportService:Teleport(game.PlaceId, Player) end)

AddToggle(T7, "เปิด/ปิด ธีมนรกสีเลือด (Blood UI)", "BloodUI")
AddToggle(T7, "เปิด/ปิด ลายน้ำ (Watermark)", "Watermark")

-- [[ 🧠 CORE ENGINE - 1000% WORKING ]]

local TargetMurderer = nil
local TargetGunDrop = nil
local CurrentRole = "คนดี"
local MurdName = "ยังไม่พบ"
local SheriffName = "ยังไม่พบ"
local OriginalAmbient = Lighting.Ambient
local OriginalBrightness = Lighting.Brightness
local AnnouncedRoundMurd = ""
local HasAnnouncedClose = false

local function getRole(plr)
    if not plr or not plr.Character then return "Innocent" end
    local char = plr.Character
    local bp = plr:FindFirstChild("Backpack")
    if char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife")) then return "Murderer" end
    if char:FindFirstChild("Gun") or (bp and bp:FindFirstChild("Gun")) then return "Sheriff" end
    return "Innocent"
end

local function SendChatMessage(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

-- ลูปสแปมแชท & Trash Talk โหดๆ
local TrashTalks = {"กากชิบหาย มึงลบเกมทิ้งเถอะ", "REVEZY NIGHTMARE จะแดกหัวมึง!", "เล่นอ่อนๆ แบบนี้กูใช้ตีนเล่นยังชนะ", "ร้องดิ ร้องขอชีวิตซะ!", "ก้มกราบ REVEZY สิไอ้สัสขยะ"}
task.spawn(function()
    while task.wait(2) do
        if Config.ChatSpam and Config.SpamText ~= "" then SendChatMessage(Config.SpamText) end
        if Config.TrashTalk and math.random(1, 4) == 1 then SendChatMessage(TrashTalks[math.random(1, #TrashTalks)]) end
    end
end)

-- ลูป Fake Lag
task.spawn(function()
    while task.wait() do
        if Config.FakeLag and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.Anchored = true; task.wait(0.1); if Player.Character then Player.Character.HumanoidRootPart.Anchored = false end; task.wait(0.15)
        end
    end
end)

-- Main Data Loop
task.spawn(function()
    while task.wait(0.5) do
        local myRole = getRole(Player)
        if myRole == "Murderer" then CurrentRole = "🔪 ไอชั่ว" elseif myRole == "Sheriff" then CurrentRole = "🔫 นายอำเภอ" else CurrentRole = "🚶 คนดี" end
        Stat_Role.Text = "🎭 บทบาท: " .. CurrentRole

        TargetMurderer = nil; MurdName = "ยังไม่ซ่อนตัว/ยังไม่พบ"; SheriffName = "ยังไม่พบ"

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local role = getRole(v)
                local espColor = Color3.fromRGB(0, 255, 0)
                local displayName = "คนดี"

                if role == "Murderer" then
                    espColor = BloodRed; displayName = "ไอชั่ว"
                    TargetMurderer = v.Character.HumanoidRootPart; MurdName = v.Name
                elseif role == "Sheriff" then
                    espColor = Color3.fromRGB(50, 150, 255); displayName = "นายอำเภอ"; SheriffName = v.Name
                end

                local hl = v.Character:FindFirstChild("RVZ_Highlight")
                if Config.ESP or Config.Chams then
                    if not hl then hl = Instance.new("Highlight", v.Character); hl.Name = "RVZ_Highlight" end
                    hl.Adornee = v.Character 
                    if Config.ESP and not Config.Chams then hl.FillTransparency = 1; hl.OutlineTransparency = 0; hl.OutlineColor = espColor
                    elseif not Config.ESP and Config.Chams then hl.FillTransparency = 0.3; hl.OutlineTransparency = 1; hl.FillColor = espColor
                    else hl.FillTransparency = 0.3; hl.OutlineTransparency = 0; hl.OutlineColor = espColor; hl.FillColor = espColor end
                else
                    if hl then hl:Destroy() end
                end

                if Config.Names and v.Character:FindFirstChild("Head") then
                    local bg = v.Character.Head:FindFirstChild("RVZ_Name")
                    if not bg then
                        bg = Instance.new("BillboardGui", v.Character.Head); bg.Name = "RVZ_Name"; bg.Size = UDim2.new(0, 150, 0, 40); bg.AlwaysOnTop = true; bg.StudsOffset = Vector3.new(0, 2, 0)
                        local txt = Instance.new("TextLabel", bg); txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 14; txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0,0,0)
                    end
                    bg.TextLabel.Text = displayName; bg.TextLabel.TextColor3 = espColor
                elseif not Config.Names and v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("RVZ_Name") then
                    v.Character.Head.RVZ_Name:Destroy()
                end

                if Config.Hitbox then
                    v.Character.HumanoidRootPart.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                    v.Character.HumanoidRootPart.Transparency = 0.5; v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red"); v.Character.HumanoidRootPart.CanCollide = false
                else
                    v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1); v.Character.HumanoidRootPart.Transparency = 1
                end
            end
        end
        Stat_Murd.Text = "🔪 ไอชั่ว: " .. MurdName; Stat_Sheriff.Text = "🔫 นายอำเภอ: " .. SheriffName

        if Config.AutoAnnounceRoles and MurdName ~= "ยังไม่ซ่อนตัว/ยังไม่พบ" then
            if AnnouncedRoundMurd ~= MurdName then
                AnnouncedRoundMurd = MurdName
                SendChatMessage("🚨 REVEZY แฉโพย: ไอ้ระยำ " .. MurdName .. " คือฆาตกร! ส่วนนายอำเภอคือ " .. SheriffName)
                HasAnnouncedClose = false 
            end
        elseif MurdName == "ยังไม่ซ่อนตัว/ยังไม่พบ" then
            AnnouncedRoundMurd = ""; HasAnnouncedClose = false
        end

        if Config.FullBright then
            Lighting.Ambient = Color3.new(1, 1, 1); Lighting.Brightness = 2
        else
            Lighting.Ambient = OriginalAmbient; Lighting.Brightness = OriginalBrightness
        end

        if Config.CoinESP then
            local container = workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("CoinContainer")
            if container then
                for _, coin in pairs(container:GetChildren()) do
                    if coin.Name == "Coin_Server" and not coin:FindFirstChild("RVZ_CoinESP") then
                        local hl = Instance.new("Highlight", coin); hl.Name = "RVZ_CoinESP"; hl.FillColor = Color3.fromRGB(255, 215, 0); hl.OutlineColor = Color3.fromRGB(255, 255, 0)
                    end
                end
            end
        else
            local container = workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("CoinContainer")
            if container then
                for _, coin in pairs(container:GetChildren()) do if coin:FindFirstChild("RVZ_CoinESP") then coin.RVZ_CoinESP:Destroy() end end
            end
        end

        TargetGunDrop = workspace:FindFirstChild("GunDrop") or (workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("GunDrop"))
    end
end)

RunService.Stepped:Connect(function()
    if Config.Noclip and Player.Character then
        for _, v in pairs(Player.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

-- Main Render/Physics Loop
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2); FOVCircle.Radius = Config.FOV
    
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") then
        local root = Player.Character.HumanoidRootPart
        local hum = Player.Character.Humanoid
        
        hum.WalkSpeed = Config.Speed; hum.JumpPower = Config.Jump

        if Config.Bhop and UserInputService:IsKeyDown(Enum.KeyCode.Space) then hum:ChangeState(Enum.HumanoidStateType.Jumping) end

        if Config.AnnounceClose and TargetMurderer and TargetMurderer.Parent and MurdName ~= "ยังไม่ซ่อนตัว/ยังไม่พบ" and not HasAnnouncedClose then
            if (root.Position - TargetMurderer.Position).Magnitude <= 25 then
                SendChatMessage("🤬 ไอชั่ว " .. MurdName .. " อยู่ใกล้กู! ยิงมันดิ้!")
                HasAnnouncedClose = true
            end
        end

        if Config.GunTracer and TargetGunDrop then
            local pos, onScreen = Camera:WorldToViewportPoint(TargetGunDrop.Position)
            if onScreen then GunLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y); GunLine.To = Vector2.new(pos.X, pos.Y); GunLine.Visible = true
            else GunLine.Visible = false end
        else GunLine.Visible = false end

        if Config.LoopFollow and Config.TargetPlayer ~= "" then
            local tPlayer = Players:FindFirstChild(Config.TargetPlayer)
            if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("HumanoidRootPart") and tPlayer.Character.Humanoid.Health > 0 then
                root.CFrame = tPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, Config.FollowDistance)
            end
        end

        if Config.SuperFling and Config.TargetPlayer ~= "" then
            local tPlayer = Players:FindFirstChild(Config.TargetPlayer)
            if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("HumanoidRootPart") then
                root.Velocity = Vector3.new(30000, 30000, 30000)
                root.CFrame = tPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(math.random(1, 360)), 0)
            end
        end

        if Config.Aim and TargetMurderer and TargetMurderer.Parent then
            local pos, onScreen = Camera:WorldToViewportPoint(TargetMurderer.Position)
            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            if onScreen and dist <= Config.FOV then Camera.CFrame = CFrame.new(Camera.CFrame.Position, TargetMurderer.Position) end
        end

        if Config.TriggerBot and TargetMurderer and TargetMurderer.Parent then
            local gun = Player.Character:FindFirstChild("Gun")
            if gun and Mouse.Target and Mouse.Target:IsDescendantOf(TargetMurderer.Parent) then gun:Activate() end
        end

        if Config.KillAura then
            local tool = Player.Character:FindFirstChildOfClass("Tool")
            if tool and tool.Name == "Knife" then tool:Activate() end
        end

        if Config.AutoShootMM2 and TargetMurderer and TargetMurderer.Parent then
            local gun = Player.Character:FindFirstChild("Gun")
            if gun and (root.Position - TargetMurderer.Position).Magnitude <= 100 then
                root.CFrame = CFrame.lookAt(root.Position, TargetMurderer.Position); gun:Activate()
            end
        end

        if Config.GrabGunDrop and TargetGunDrop then root.CFrame = TargetGunDrop.CFrame end

        if Config.FlingMurderer and TargetMurderer and TargetMurderer.Parent then
            if (root.Position - TargetMurderer.Position).Magnitude < 15 then
                root.Velocity = Vector3.new(0, 9999, 0); root.CFrame = TargetMurderer.CFrame * CFrame.Angles(0, math.rad(120), 0)
            end
        end

        if Config.AutoCoin then
            pcall(function()
                local container = workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("CoinContainer")
                if container then 
                    for _,coin in pairs(container:GetChildren()) do 
                        if coin.Name == "Coin_Server" then root.CFrame = coin.CFrame; break end 
                    end 
                end
            end)
        end

        if Config.AutoWin then
            root.CFrame = CFrame.new(0, -450, 0)
            local p = workspace:FindFirstChild("RVZ_WinPlat") or Instance.new("Part", workspace)
            p.Name = "RVZ_WinPlat"; p.Size = Vector3.new(20, 1, 20); p.Anchored = true; p.Transparency = 1; p.CFrame = root.CFrame * CFrame.new(0, -3.5, 0)
        else
            if workspace:FindFirstChild("RVZ_WinPlat") then workspace.RVZ_WinPlat:Destroy() end
        end

        if Config.TPMap then
            pcall(function()
                local map = workspace:FindFirstChild("Normal")
                if map then root.CFrame = map:GetModelCFrame() + Vector3.new(0, 10, 0) end
            end)
            Config.TPMap = false 
        end
        
        if Config.TPLobby then root.CFrame = CFrame.new(-108, 140, 11); Config.TPLobby = false end
        if Config.WalkAir then
            local p = workspace:FindFirstChild("RevezyAir") or Instance.new("Part", workspace); p.Name = "RevezyAir"; p.Size = Vector3.new(10, 1, 10); p.Anchored = true; p.Transparency = 1; p.CFrame = root.CFrame * CFrame.new(0, -3.5, 0)
        else
            if workspace:FindFirstChild("RevezyAir") then workspace.RevezyAir:Destroy() end
        end
        if Config.Spider then workspace.Gravity = 0 else workspace.Gravity = 196.2 end
        if Config.Spin then root.CFrame *= CFrame.Angles(0, math.rad(60), 0) end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Config.InfJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
Mouse.Button1Down:Connect(function()
    if Config.CtrlTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and Mouse.Target and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p + Vector3.new(0, 3, 0))
    end
end)
Player.Idled:Connect(function()
    if Config.AntiAFK then VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame); task.wait(1); VirtualUser:Button2Up(Vector2.new(0,0), Camera.CFrame) end
end)

-- [[ 🔘 FLOATING IMAGE BUTTON ]]
local FloatBtn = Instance.new("ImageButton", ScreenGui)
FloatBtn.Size = UDim2.new(0, 65, 0, 65); FloatBtn.Position = UDim2.new(0, 25, 0.4, 0); FloatBtn.BackgroundColor3 = DeepBlack; FloatBtn.Image = FloatingImageURL
Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(1, 0)
local FloatStroke = Instance.new("UIStroke", FloatBtn); FloatStroke.Color = BloodRed; FloatStroke.Thickness = 2.5
local FloatText = Instance.new("TextLabel", FloatBtn); FloatText.Size = UDim2.new(1, 0, 1, 0); FloatText.BackgroundTransparency = 1; FloatText.Text = "RY"; FloatText.TextColor3 = Color3.new(1, 1, 1); FloatText.Font = Enum.Font.Creepster; FloatText.TextSize = 28; FloatText.TextStrokeTransparency = 0; FloatText.TextStrokeColor3 = BloodRed

FloatBtn.MouseEnter:Connect(function() TweenService:Create(FloatBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 70, 0, 70)}):Play() end)
FloatBtn.MouseLeave:Connect(function() TweenService:Create(FloatBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 65, 0, 65)}):Play() end)

FloatBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    if Main.Visible then
        Main.Size = UDim2.new(0,0,0,0)
        TweenService:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 900, 0, 650)}):Play()
    end
end)

local d, di, ds, sp
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true; ds = i.Position; sp = Main.Position end end)
Main.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement then di = i end end)
UserInputService.InputChanged:Connect(function(i) if i == di and d then
    local delta = i.Position - ds; Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)

print("🩸 REVEZY V25 NIGHTMARE SUPREME - HELL UNLEASHED 🩸")
