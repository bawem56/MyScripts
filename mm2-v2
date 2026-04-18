-- [[ REVEZY ULTIMATE KEY SYSTEM ]]
-- สไตล์: พรีเมียมโกลด์ & กระจกเงา

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- [[ ตั้งค่าคีย์ที่นี่ ]]
local CORRECT_KEY = "REVEZY-PRO-2026" -- เปลี่ยนคีย์ตรงนี้ได้เลย
local SCRIPT_URL = "https://raw.githubusercontent.com/bawem56/MyScripts/main/mm2-revezy-v2.lua"

-- ลบ UI เก่า
if CoreGui:FindFirstChild("RevezyKeySystem") then CoreGui.RevezyKeySystem:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "RevezyKeySystem"

-- [[ สร้างหน้าต่างหลัก ]]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
local Stroke = Instance.new("UIStroke", Main); Stroke.Color = Color3.fromRGB(255, 170, 0); Stroke.Thickness = 3; Stroke.Transparency = 0.5

-- อนิเมชั่นตอนเปิด (Pop-up)
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 450, 0, 300)}):Play()

-- หัวข้อ
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60); Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "REVEZY KEY SYSTEM"; Title.TextColor3 = Color3.fromRGB(255, 170, 0)
Title.Font = "GothamBlack"; Title.TextSize = 28; Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", Main)
SubTitle.Size = UDim2.new(1, 0, 0, 20); SubTitle.Position = UDim2.new(0, 0, 0, 65)
SubTitle.Text = "กรุณาใส่คีย์เพื่อเข้าสู่ระบบ"; SubTitle.TextColor3 = Color3.new(0.8, 0.8, 0.8)
SubTitle.Font = "GothamBold"; SubTitle.TextSize = 14; SubTitle.BackgroundTransparency = 1

-- ช่องใส่คีย์ (TextBox)
local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(0, 350, 0, 50); KeyBox.Position = UDim2.new(0.5, 0, 0.45, 0); KeyBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35); KeyBox.Text = ""; KeyBox.PlaceholderText = "ใส่คีย์ที่นี่..."
KeyBox.TextColor3 = Color3.new(1,1,1); KeyBox.Font = "GothamBold"; KeyBox.TextSize = 18
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)
local BoxStroke = Instance.new("UIStroke", KeyBox); BoxStroke.Color = Color3.fromRGB(255, 170, 0); BoxStroke.Thickness = 1.5; BoxStroke.Transparency = 0.7

-- ปุ่มตรวจสอบ (Submit)
local SubmitBtn = Instance.new("TextButton", Main)
SubmitBtn.Size = UDim2.new(0, 170, 0, 45); SubmitBtn.Position = UDim2.new(0.28, 0, 0.75, 0); SubmitBtn.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0); SubmitBtn.Text = "ตกลง"; SubmitBtn.Font = "GothamBlack"
SubmitBtn.TextColor3 = Color3.fromRGB(0,0,0); SubmitBtn.TextSize = 18; Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 10)

-- ปุ่มรับคีย์ (Get Key)
local GetKeyBtn = Instance.new("TextButton", Main)
GetKeyBtn.Size = UDim2.new(0, 170, 0, 45); GetKeyBtn.Position = UDim2.new(0.72, 0, 0.75, 0); GetKeyBtn.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50); GetKeyBtn.Text = "รับคีย์"; GetKeyBtn.Font = "GothamBlack"
GetKeyBtn.TextColor3 = Color3.new(1,1,1); GetKeyBtn.TextSize = 18; Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 10)

-- ข้อความแจ้งสถานะ
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30); Status.Position = UDim2.new(0, 0, 0.58, 0)
Status.Text = ""; Status.TextColor3 = Color3.new(1, 0.3, 0.3); Status.Font = "GothamBold"; Status.TextSize = 14; Status.BackgroundTransparency = 1

-- [[ ⚙️ LOGIC & ANIMATIONS ]]

-- ปุ่ม Hover Effect
SubmitBtn.MouseEnter:Connect(function() TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 200, 50)}):Play() end)
SubmitBtn.MouseLeave:Connect(function() TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 170, 0)}):Play() end)

-- ฟังชั่นตรวจสอบคีย์
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CORRECT_KEY then
        Status.TextColor3 = Color3.new(0.3, 1, 0.3); Status.Text = "คีย์ถูกต้อง! กำลังโหลดสคริปต์..."
        
        -- อนิเมชั่นปิดหน้า Key
        task.wait(1)
        TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.5)
        ScreenGui:Destroy()
        
        -- 🚀 รันสคริปต์ตัวจริง!
        loadstring(game:HttpGet(SCRIPT_URL))()
    else
        Status.Text = "คีย์ไม่ถูกต้อง! กรุณาลองใหม่"
        -- สั่นหน้าจอเวลาใส่ผิด
        local oldPos = Main.Position
        for i = 1, 5 do
            Main.Position = oldPos + UDim2.new(0, math.random(-5,5), 0, 0)
            task.wait(0.02)
        end
        Main.Position = oldPos
    end
end)

-- ปุ่มก๊อปปี้ลิงก์รับคีย์ (สำหรับคุณไปใส่ Discord หรือเว็บ)
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/A4my9aPAsc") -- เปลี่ยนลิงก์ได้ตรงนี้
    Status.TextColor3 = Color3.new(1, 1, 1); Status.Text = "คัดลอกลิงก์รับคีย์แล้ว!"
    task.wait(2); Status.Text = ""
end)

print("Key System Loaded!")
