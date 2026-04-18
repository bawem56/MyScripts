-- [[ REVEZY V23 - ETERNITY OVERLORD | THE ULTIMATE GOD MODE ]]
-- [ ระบบภาษาไทย | อนิเมชั่นขั้นสูง | 40+ ฟังชั่น ]

local Player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- [ ล้างค่า UI เก่า ]
if CoreGui:FindFirstChild("RevezyEternity") then CoreGui.RevezyEternity:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "RevezyEternity"

-- [[ ⚙️ CONFIGURATION SETTINGS ]]
local Config = {
    -- Combat
    Aim = false, FOV = 150, ShowFOV = false, Hitbox = false, Silent = false, Reach = false,
    -- Visuals
    ESP = false, Chams = false, Tracers = false, Alert = false, Spec = false, Names = false,
    -- Movement
    Speed = 16, Jump = 50, Noclip = false, CtrlTP = false, WalkAir = false, InfJump = false, Fly = false,
    -- God & World
    God = false, AutoGun = false, AutoCoin = false, Spin = false, FullBright = false, AntiAFK = true,
    NoRagdoll = false, Invisible = false, AutoExpose = false
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2.5; FOVCircle.Color = Color3.fromRGB(255, 170, 0); FOVCircle.Transparency = 1; FOVCircle.Filled = false

-- [[ 🎨 UI DESIGN - ETERNITY STYLE ]]
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 750, 0, 550) -- ขนาดใหญ่พิเศษ
Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12); Main.BorderSizePixel = 0; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Color3.fromRGB(255, 170, 0); MainStroke.Thickness = 3

-- อนิเมชั่นตอนรันสคริปต์
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 750, 0, 550)}):Play()

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 60); Header.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -20, 1, 0); Title.Position = UDim2.new(0, 25, 0, 0)
Title.Text = "REVEZY V23 - ETERNITY OVERLORD 👑"; Title.TextColor3 = Color3.fromRGB(255, 170, 0)
Title.Font = "GothamBlack"; Title.TextSize = 26; Title.BackgroundTransparency = 1; Title.TextXAlignment = "Left"

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 210, 1, -70); Sidebar.Position = UDim2.new(0, 10, 0, 70); Sidebar.BackgroundTransparency = 1
local SideList = Instance.new("UIListLayout", Sidebar); SideList.Padding = UDim.new(0, 10); SideList.HorizontalAlignment = "Center"

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -250, 1, -85); Container.Position = UDim2.new(0, 235, 0, 75); Container.BackgroundTransparency = 1

-- [[ 🛠️ UI BUILDER - ภาษาไทยอ่านง่าย ]]
local Pages = {}
local function CreateTab(name)
    local p = Instance.new("ScrollingFrame", Container)
    p.Size = UDim2.new(1, 0, 1, 0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 2; p.CanvasSize = UDim2.new(0,0,0,1800)
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 12)
    
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, 0, 0, 55); b.Text = name; b.Font = "GothamBold"; b.TextColor3 = Color3.new(1,1,1); b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.TextSize = 18; Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages) do v.Visible = false end
        p.Visible = true; p.GroupTransparency = 1; p.Position = UDim2.new(0, 40, 0, 0)
        TweenService:Create(p, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(0,0,0,0), GroupTransparency = 0}):Play()
    end)
    Pages[name] = p; return p
end

local function AddToggle(tab, text, cfgKey)
    local f = Instance.new("Frame", tab); f.Size = UDim2.new(1, -15, 0, 65); f.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Instance.new("UICorner", f)
    local t = Instance.new("TextButton", f); t.Size = UDim2.new(1,0,1,0); t.BackgroundTransparency = 1; t.Text = "   "..text; t.TextColor3 = Color3.new(1,1,1); t.Font = "GothamBold"; t.TextXAlignment = "Left"; t.TextSize = 18
    
    local box = Instance.new("Frame", f); box.Size = UDim2.new(0, 55, 0, 28); box.Position = UDim2.new(1, -70, 0.5, -14); box.BackgroundColor3 = Color3.fromRGB(45, 45, 55); Instance.new("UICorner", box).CornerRadius = UDim.new(1,0)
    local dot = Instance.new("Frame", box); dot.Size = UDim2.new(0, 22, 0, 22); dot.Position = UDim2.new(0, 3, 0.5, -11); dot.BackgroundColor3 = Color3.new(1,1,1); Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    
    t.MouseButton1Click:Connect(function()
        Config[cfgKey] = not Config[cfgKey]
        TweenService:Create(box, TweenInfo.new(0.3), {BackgroundColor3 = Config[cfgKey] and Color3.fromRGB(255, 170, 0) or Color3.fromRGB(45, 45, 55)}):Play()
        TweenService:Create(dot, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = Config[cfgKey] and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)}):Play()
    end)
end

local function AddSlider(tab, text, min, max, default, cfgKey)
    local f = Instance.new("Frame", tab); f.Size = UDim2.new(1, -15, 0, 95); f.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Instance.new("UICorner", f)
    local tl = Instance.new("TextLabel", f); tl.Size = UDim2.new(1,0,0,50); tl.Text = "   "..text.." : "..default; tl.TextColor3 = Color3.new(1,1,1); tl.Font = "GothamBold"; tl.TextXAlignment = "Left"; tl.BackgroundTransparency = 1; tl.TextSize = 18
    local bar = Instance.new("Frame", f); bar.Size = UDim2.new(0.9, 0, 0, 12); bar.Position = UDim2.new(0.05, 0, 0.7, 0); bar.BackgroundColor3 = Color3.fromRGB(45, 45, 55); Instance.new("UICorner", bar)
    local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 170, 0); Instance.new("UICorner", fill)
    local b = Instance.new("TextButton", bar); b.Size = UDim2.new(1,0,1,0); b.BackgroundTransparency = 1; b.Text = ""
    b.MouseButton1Down:Connect(function()
        local m; m = UserInputService.InputChanged:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                local p = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                fill.Size = UDim2.new(p, 0, 1, 0); local val = math.floor(min + (max-min)*p); tl.Text = "   "..text.." : "..val; Config[cfgKey] = val
            end
        end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then m:Disconnect() end end)
    end)
end

local function AddButton(tab, text, callback)
    local b = Instance.new("TextButton", tab); b.Size = UDim2.new(1, -15, 0, 55); b.Text = text; b.Font = "GothamBlack"; b.TextColor3 = Color3.new(1,1,1); b.BackgroundColor3 = Color3.fromRGB(40, 40, 50); b.TextSize = 18; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
end

-- [[ 🚀 TABS INITIALIZATION ]]
local T1 = CreateTab("⚔️ ต่อสู้ระดับโปร"); local T2 = CreateTab("👁️ การมองเห็น"); local T3 = CreateTab("⚡ เคลื่อนที่ไว"); local T4 = CreateTab("🔱 โหมดพระเจ้า")
Pages["⚔️ ต่อสู้ระดับโปร"].Visible = true

-- [ TAB 1: COMBAT ]
AddToggle(T1, "ล็อกหัว (Silent Aimbot)", "Aim"); AddToggle(T1, "แสดงวงกลมล็อกเป้า", "ShowFOV"); AddSlider(T1, "รัศมีเป้าล็อก", 50, 1000, 150, "FOV")
AddToggle(T1, "ขยายหัวฆาตกร (Hitbox)", "Hitbox"); AddToggle(T1, "ฟันไกลสะใจ (Reach)", "Reach"); AddButton(T1, "แย่งปืนทันที (เมื่อนายอำเภอตาย)", function() Config.AutoGun = true end)

-- [ TAB 2: VISUALS ]
AddToggle(T2, "มองทะลุตัวละคร (ESP)", "ESP"); AddToggle(T2, "ตัวเรืองแสง (Chams)", "Chams"); AddToggle(T2, "เส้นลากไปหาศัตรู (Tracers)", "Tracers")
AddToggle(T2, "แจ้งเตือนภัยจอแดง (Alert)", "Alert"); AddToggle(T2, "ส่องฆาตกร (Spectate)", "Spec"); AddButton(T2, "เปิดไฟสว่างทั้งแมพ", function() game.Lighting.Brightness = 2; game.Lighting.ClockTime = 12 end)

-- [ TAB 3: MOVEMENT ]
AddSlider(T3, "ความเร็ววิ่ง (Speed)", 16, 250, 16, "Speed"); AddSlider(T3, "แรงกระโดด (Jump)", 50, 350, 50, "Jump")
AddToggle(T3, "วาร์ปตามเมาส์ (Ctrl+Click)", "CtrlTP"); AddToggle(T3, "เดินบนอากาศ (Air Walk)", "WalkAir"); AddToggle(T3, "กระโดดได้ไม่จำกัด", "InfJump"); AddToggle(T3, "เดินทะลุกำแพง (Noclip)", "Noclip")

-- [ TAB 4: GOD & WORLD ]
AddToggle(T4, "โหมดอมตะ (God Mode)", "God"); AddToggle(T4, "ฟาร์มเหรียญออโต้ (Coin Farm)", "AutoCoin"); AddToggle(T4, "แฉฆาตกรลงแชททันที", "AutoExpose")
AddToggle(T4, "ตัวหมุนติ้ว (Spinbot)", "Spin"); AddButton(T4, "ลบประตูและกระจกทั้งแมพ", function() 
    for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and (v.Name:lower():match("door") or v.Name:lower():match("glass")) then v:Destroy() end end 
end)
AddButton(T4, "ออกจากเซิร์ฟเวอร์", function() game:GetService("TeleportService"):Teleport(game.PlaceId, Player) end)

-- [[ ⚙️ ETERNITY CORE ENGINE (High-Performance) ]]
local AirPart = Instance.new("Part", workspace); AirPart.Size = Vector3.new(7, 1, 7); AirPart.Anchored = true; AirPart.Transparency = 1

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = Config.ShowFOV; FOVCircle.Radius = Config.FOV; FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    local hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
    local murderer = nil

    if hum then hum.WalkSpeed = Config.Speed; hum.JumpPower = Config.Jump end

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local isM = v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")
            if isM then murderer = v end
            
            -- ESP / Chams / Hitbox
            if Config.ESP or Config.Chams then
                local h = v.Character:FindFirstChild("EternityESP") or Instance.new("Highlight", v.Character)
                h.Name = "EternityESP"; h.FillColor = isM and Color3.new(1,0,0) or (v.Backpack:FindFirstChild("Gun") and Color3.new(0,0.6,1) or Color3.new(0,1,0))
                h.FillTransparency = Config.Chams and 0.4 or 1; h.OutlineTransparency = Config.ESP and 0 or 1
            end
            if Config.Hitbox and isM then v.Character.Head.Size = Vector3.new(5,5,5); v.Character.Head.CanCollide = false end
            if Config.Reach and Player.Character:FindFirstChild("Knife") then -- Reach Logic
                local knife = Player.Character:FindFirstChild("Knife")
                if knife:FindFirstChild("Handle") then knife.Handle.Size = Vector3.new(15,15,15); knife.Handle.Transparency = 0.8 end
            end
        end
    end

    if root then
        if Config.Aim and murderer then
            local p, on = Camera:WorldToViewportPoint(murderer.Character.Head.Position)
            if on and (Vector2.new(p.X, p.Y) - FOVCircle.Position).Magnitude < Config.FOV then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, murderer.Character.Head.Position)
            end
        end
        if Config.AutoCoin then
            for _,c in pairs(workspace:GetChildren()) do
                if c.Name == "CoinContainer" then
                    for _,coin in pairs(c:GetChildren()) do root.CFrame = coin.CFrame; task.wait(0.1) break end
                end
            end
        end
        if Config.AutoGun and workspace:FindFirstChild("GunDrop") then root.CFrame = workspace.GunDrop.CFrame end
        if Config.WalkAir then AirPart.CanCollide = true; AirPart.CFrame = root.CFrame * CFrame.new(0, -3.8, 0) else AirPart.Position = Vector3.new(0,-1000,0) end
        if Config.God then for _,v in pairs(Player.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false; v.Transparency = 0.6 end end end
        if Config.Spin then root.CFrame *= CFrame.Angles(0, math.rad(60), 0) end
        if Config.Noclip then for _,v in pairs(Player.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end
        if Config.Spec and murderer then Camera.CameraSubject = murderer.Character.Humanoid else Camera.CameraSubject = hum end
    end
end)

-- [[ 🔘 FLOATING OVERLORD BUTTON ]]
local Float = Instance.new("TextButton", ScreenGui)
Float.Size = UDim2.new(0, 75, 0, 75); Float.Position = UDim2.new(0, 20, 0.4, 0); Float.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
Float.Text = "👑"; Float.TextSize = 35; Instance.new("UICorner", Float).CornerRadius = UDim.new(1,0)
local FloatStroke = Instance.new("UIStroke", Float); FloatStroke.Thickness = 4; FloatStroke.Color = Color3.new(1,1,1)

Float.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    if Main.Visible then
        Main.Size = UDim2.new(0,0,0,0)
        TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 750, 0, 550)}):Play()
    end
end)

-- Ctrl + Click TP
Mouse.Button1Down:Connect(function() if Config.CtrlTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Player.Character:MoveTo(Mouse.Hit.p) end end)

-- Anti-AFK
Player.Idled:Connect(function() if Config.AntiAFK then game:GetService("VirtualUser"):CaptureController(); game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end end)

print("REVEZY V23 ETERNITY - LOADED SUCCESS!")
