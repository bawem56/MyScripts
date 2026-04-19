-- [[ 🩸 REVEZY ULTIMATE KEY SYSTEM - NIGHTMARE EDITION 🩸 ]]
-- [ EXECUTOR OPTIMIZED | KEYAUTH INTEGRATION | BLOOD THEME ]

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- [[ ⚙️ KEYAUTH CONFIGURATION ]]
local APP_NAME = "Gooldbg492's Application"
local OWNER_ID = "6EPAVvr7YR"
local APP_SECRET = "50dbfc5c230a8c1e67f26260e25675d7455f640ce730f36103c779addf6b434e"
local APP_VERSION = "1.0"
local SCRIPT_URL = "https://raw.githubusercontent.com/bawem56/MyScripts/main/mm2-revezy-v2.lua"

-- [[ 🩸 THEME COLORS ]]
local BloodRed = Color3.fromRGB(180, 5, 5)
local DeepBlack = Color3.fromRGB(8, 8, 8)
local DarkRed = Color3.fromRGB(40, 5, 5)

-- ลบ UI เก่า (ใช้ pcall กัน Error ในตัวรัน)
pcall(function()
    if CoreGui:FindFirstChild("RevezyKeySystem") then 
        CoreGui.RevezyKeySystem:Destroy() 
    end
end)

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "RevezyKeySystem"
if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end

-- [[ 🎨 UI CONSTRUCTION ]]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 480, 0, 320)
Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = DeepBlack; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Gradient พื้นหลังให้ดูมืดๆ หลอนๆ
local MainGrad = Instance.new("UIGradient", Main)
MainGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, DeepBlack), ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 2, 2))}
MainGrad.Rotation = 45

-- 🫀 ขอบเรืองแสงจังหวะหัวใจ (Heartbeat Stroke)
local Stroke = Instance.new("UIStroke", Main); Stroke.Color = BloodRed; Stroke.Thickness = 3; Stroke.Transparency = 0
task.spawn(function()
    while task.wait() do
        TweenService:Create(Stroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Transparency = 0, Thickness = 4}):Play()
        task.wait(0.2)
        TweenService:Create(Stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {Transparency = 0.6, Thickness = 2}):Play()
        task.wait(0.8)
    end
end)

-- 💀 หัวข้อ (Title) พร้อมแอนิเมชัน Glitch
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60); Title.Position = UDim2.new(0, 0, 0, 15)
Title.Text = "REVEZY NIGHTMARE"; Title.TextColor3 = BloodRed
Title.Font = Enum.Font.Creepster; Title.TextSize = 45; Title.BackgroundTransparency = 1
Title.TextStrokeTransparency = 0; Title.TextStrokeColor3 = Color3.new(0,0,0)

task.spawn(function()
    while task.wait(math.random(2, 4)) do
        Title.Position = UDim2.new(0, 2, 0, 13); Title.TextColor3 = Color3.new(1,1,1)
        task.wait(0.05)
        Title.Position = UDim2.new(0, -2, 0, 17); Title.TextColor3 = BloodRed
        task.wait(0.05)
        Title.Position = UDim2.new(0, 0, 0, 15)
    end
end)

local SubTitle = Instance.new("TextLabel", Main)
SubTitle.Size = UDim2.new(1, 0, 0, 20); SubTitle.Position = UDim2.new(0, 0, 0, 70)
SubTitle.Text = "AUTHENTICATION | BLOOD & BONE EDITION"; SubTitle.TextColor3 = Color3.fromRGB(120, 120, 120)
SubTitle.Font = Enum.Font.GothamBold; SubTitle.TextSize = 12; SubTitle.BackgroundTransparency = 1

-- ช่องใส่คีย์
local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(0, 380, 0, 55); KeyBox.Position = UDim2.new(0.5, 0, 0.45, 0); KeyBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 2, 2); KeyBox.Text = ""; KeyBox.PlaceholderText = "💀 ใส่ KeyAuth ของมึงที่นี่..."
KeyBox.TextColor3 = Color3.new(1,1,1); KeyBox.Font = Enum.Font.GothamBold; KeyBox.TextSize = 16
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", KeyBox).Color = BloodRed

-- ปุ่มตกลง
local SubmitBtn = Instance.new("TextButton", Main)
SubmitBtn.Size = UDim2.new(0, 180, 0, 45); SubmitBtn.Position = UDim2.new(0.28, 0, 0.75, 0); SubmitBtn.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitBtn.BackgroundColor3 = BloodRed; SubmitBtn.Text = "ปลดล็อคพลัง"; SubmitBtn.Font = Enum.Font.GothamBlack
SubmitBtn.TextColor3 = Color3.new(1,1,1); SubmitBtn.TextSize = 16; Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)
local SubmitStroke = Instance.new("UIStroke", SubmitBtn); SubmitStroke.Color = Color3.new(0,0,0); SubmitStroke.Thickness = 2

-- ปุ่มรับคีย์
local GetKeyBtn = Instance.new("TextButton", Main)
GetKeyBtn.Size = UDim2.new(0, 180, 0, 45); GetKeyBtn.Position = UDim2.new(0.72, 0, 0.75, 0); GetKeyBtn.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyBtn.BackgroundColor3 = DarkRed; GetKeyBtn.Text = "รับคีย์"; GetKeyBtn.Font = Enum.Font.GothamBlack
GetKeyBtn.TextColor3 = Color3.new(1,1,1); GetKeyBtn.TextSize = 16; Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)
local GetKeyStroke = Instance.new("UIStroke", GetKeyBtn); GetKeyStroke.Color = BloodRed; GetKeyStroke.Thickness = 1

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30); Status.Position = UDim2.new(0, 0, 0.58, 0)
Status.Text = ""; Status.TextColor3 = Color3.new(1, 0.3, 0.3); Status.Font = Enum.Font.GothamBold; Status.TextSize = 13; Status.BackgroundTransparency = 1

-- [[ แอนิเมชันปุ่มตอนเอาเมาส์ชี้ ]]
local function HoverEffect(btn, originalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
    end)
end
HoverEffect(SubmitBtn, BloodRed, Color3.fromRGB(220, 20, 20))
HoverEffect(GetKeyBtn, DarkRed, Color3.fromRGB(60, 10, 10))

-- [[ 🚀 EXECUTOR REQUEST LOGIC (ของเดิม 100%) ]]
local sessionid = ""
local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request

local function KeyAuthRequest(formData)
    local response = httpRequest({
        Url = "https://keyauth.win/api/1.2/",
        Method = "POST",
        Headers = {["Content-Type"] = "application/x-www-form-urlencoded"},
        Body = formData
    })
    
    if response and response.Body then
        return HttpService:JSONDecode(response.Body)
    end
    return nil
end

local function KeyAuthInit()
    local data = "type=init&name="..APP_NAME.."&ownerid="..OWNER_ID.."&secret="..APP_SECRET.."&ver="..APP_VERSION
    local res = KeyAuthRequest(data)
    if res and res.success then
        sessionid = res.sessionid
        return true
    end
    return false
end

local function VerifyLicense(key)
    if sessionid == "" then if not KeyAuthInit() then return false, "เชื่อมต่อเซิร์ฟเวอร์นรกไม่สำเร็จ" end end
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local data = "type=license&key="..key.."&hwid="..hwid.."&sessionid="..sessionid.."&name="..APP_NAME.."&ownerid="..OWNER_ID
    local res = KeyAuthRequest(data)
    if res then return res.success, res.message end
    return false, "Error"
end

-- ปุ่มตกลง (Submit)
SubmitBtn.MouseButton1Click:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 170, 0, 40)}):Play()
    task.wait(0.1)
    TweenService:Create(SubmitBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 180, 0, 45)}):Play()

    Status.TextColor3 = Color3.new(1, 1, 0)
    Status.Text = "⏳ กำลังตรวจสอบวิญญาณ..."
    
    local success, msg = VerifyLicense(KeyBox.Text)
    if success then
        Status.TextColor3 = Color3.fromRGB(50, 255, 50); Status.Text = "✅ ต้อนรับสู่นรก!"
        
        -- เฟดหน้าต่างทิ้งแบบหลอนๆ
        TweenService:Create(Main, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(1)
        ScreenGui:Destroy()
        
        -- รันสคริปต์หลัก
        loadstring(game:HttpGet(SCRIPT_URL))()
    else
        Status.TextColor3 = BloodRed; Status.Text = "❌ " .. (msg or "คีย์ไม่ถูกต้องไอ้สัส")
        -- แอนิเมชันสั่นตอนใส่คีย์ผิด
        for i = 1, 5 do
            Main.Position = UDim2.new(0.5, math.random(-10, 10), 0.5, math.random(-10, 10))
            task.wait(0.05)
        end
        Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
end)

-- ปุ่มรับคีย์ (Get Key)
GetKeyBtn.MouseButton1Click:Connect(function()
    TweenService:Create(GetKeyBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 170, 0, 40)}):Play()
    task.wait(0.1)
    TweenService:Create(GetKeyBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 180, 0, 45)}):Play()

    if setclipboard then
        setclipboard("https://discord.gg/A4my9aPAsc")
        Status.TextColor3 = Color3.new(1, 1, 1)
        Status.Text = "🔗 ก๊อปลิงก์ Discord ให้แล้ว ไปเอาคีย์ซะ!"
    else
        Status.TextColor3 = BloodRed
        Status.Text = "❌ ตัวรันมึงไม่รองรับการก๊อปลิงก์"
    end
end)

-- ทำให้ UI เลื่อนได้
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = Main.Position
    end
end)
Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

print("🩸 REVEZY NIGHTMARE KEY SYSTEM LOADED 🩸")
