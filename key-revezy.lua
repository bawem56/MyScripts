-- [[ REVEZY STUDIO PREMIUM KEY SYSTEM (MODERN UI WITH ANIMATIONS) ]]
-- Optimized for low-end executors like Xeon

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- ลบ UI เก่าถ้ามี (ป้องกันการรันซ้ำแล้ว UI ซ้อน)
if CoreGui:FindFirstChild("RevezyModernKey") then
    CoreGui.RevezyModernKey:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient") -- เพิ่มแสงเงาไล่สี
local UIStroke = Instance.new("UIStroke") -- เพิ่มขอบเงา
local Title = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel") -- หัวข้อรอง
local KeyBox = Instance.new("TextBox")
local CheckBtn = Instance.new("TextButton")
local DropShadow = Instance.new("ImageLabel") -- ใส่เงาด้านหลัง

-- ** ตั้งค่าคีย์ที่ถูกต้องตรงนี้ **
local CORRECT_KEY = "REVEZY-TOP-SECRET" 

-- 1. Setup ScreenGui
ScreenGui.Name = "RevezyModernKey"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true -- ให้ UI อยู่หน้าสุดจริงๆ

-- 2. Drop Shadow (เงาด้านหลัง)
DropShadow.Name = "DropShadow"
DropShadow.Parent = MainFrame
DropShadow.BackgroundTransparency = 1
DropShadow.Position = UDim2.new(0, -20, 0, -20)
DropShadow.Size = UDim2.new(1, 40, 1, 40)
DropShadow.Image = "rbxassetid://6014261993" -- ID รูปเงา
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.5
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

-- 3. Main Frame (ดีไซน์ใหม่ ทรงโมเดิร์น)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- สีพื้นหลังเข้มเข้ม
MainFrame.BorderSizePixel = 0
-- ตั้งค่าตำแหน่งเริ่มต้นให้อยู่กลางจอ แต่อยู่ต่ำกว่าปกติเล็กน้อย (เตรียมทำอนิเมชั่น)
MainFrame.Position = UDim2.new(0.5, -150, 0.6, -100) 
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.ClipsDescendants = false -- ยอมให้เงาแสดงผล

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10) -- ขอบมนแบบทันสมัย
MainCorner.Parent = MainFrame

-- ไล่สีพื้นหลังให้ดูมีมิติ
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

-- เพิ่มขอบเรืองแสงสีฟ้าอ่อน
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(0, 170, 255)
MainStroke.Transparency = 0.7
MainStroke.Parent = MainFrame

-- 4. หัวข้อหลัก (Title)
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "REVEZY CLOUD"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.ZIndex = 2

-- 5. หัวข้อรอง (SubTitle)
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0, 45)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Please input your access key"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180) -- สีเทาอ่อน
SubTitle.TextSize = 14
SubTitle.ZIndex = 2

-- 6. ช่องใส่คีย์ (Modern Style)
KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.45, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.ZIndex = 2

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 8)
KeyCorner.Parent = KeyBox

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 1
KeyStroke.Color = Color3.fromRGB(60, 60, 60) -- ขอบช่องใส่คีย์ปกติ
KeyStroke.Parent = KeyBox

-- 7. ปุ่มเช็คคีย์ (Modern Blue)
CheckBtn.Parent = MainFrame
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 132, 255) -- สีฟ้าเข้ม
CheckBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Text = "GET ACCESS"
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.TextSize = 16
CheckBtn.ZIndex = 2
CheckBtn.AutoButtonColor = false -- ปิดสีอนิเมชั่นพื้นฐานเพื่อใช้ของเราเอง

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = CheckBtn

-- ==========================================
-- [[ ANIMATIONS FUNCTION ]]
-- ==========================================

-- 1. Intro Animation (เฟดเข้าและเลื่อนขึ้น)
MainFrame.BackgroundTransparency = 1
Title.TextTransparency = 1
SubTitle.TextTransparency = 1
KeyBox.BackgroundTransparency = 1
KeyBox.TextTransparency = 1
CheckBtn.BackgroundTransparency = 1
CheckBtn.TextTransparency = 1
DropShadow.ImageTransparency = 1

local introInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- สร้าง Tween สำหรับ MainFrame
local frameTween = TweenService:Create(MainFrame, introInfo, {
    Position = UDim2.new(0.5, -150, 0.5, -100), -- เลื่อนขึ้นมาตรงกลางพอดี
    BackgroundTransparency = 0
})

-- เฟด Text และ Elements อื่นๆ
TweenService:Create(Title, introInfo, {TextTransparency = 0}):Play()
TweenService:Create(SubTitle, introInfo, {TextTransparency = 0}):Play()
TweenService:Create(KeyBox, introInfo, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
TweenService:Create(CheckBtn, introInfo, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
TweenService:Create(DropShadow, introInfo, {ImageTransparency = 0.5}):Play()

frameTween:Play() -- เริ่มอนิเมชั่นตอนเปิด

-- 2. Button Hover Animation (ปุ่มขยายและสว่างขึ้นเวลาเอาเมาส์ชี้)
CheckBtn.MouseEnter:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(0, 162, 255), -- สว่างขึ้น
        Size = UDim2.new(0.82, 0, 0, 42), -- ขยายใหญ่เล็กน้อย
        Position = UDim2.new(0.09, 0, 0.71, 0) -- ปรับตำแหน่งไม่ให้เบี้ยว
    }):Play()
end)

CheckBtn.MouseLeave:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(0, 132, 255), -- กลับสีเดิม
        Size = UDim2.new(0.8, 0, 0, 40), -- ขนาดเดิม
        Position = UDim2.new(0.1, 0, 0.72, 0) -- ตำแหน่งเดิม
    }):Play()
end)

-- 3. Click & Access Function
CheckBtn.MouseButton1Click:Connect(function()
    -- Click Animation (กดแล้วยุบ)
    TweenService:Create(CheckBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.78, 0, 0, 38)}):Play()
    wait(0.1)
    TweenService:Create(CheckBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.8, 0, 0, 40)}):Play()

    if KeyBox.Text == CORRECT_KEY then
        -- Correct Key Animation
        CheckBtn.Text = "LOADING SCRIPT..."
        TweenService:Create(CheckBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 212, 116)}):Play() -- เปลี่ยนเป็นสีเขียว
        TweenService:Create(MainStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(0, 212, 116), Transparency = 0.4}):Play() -- ขอบเขียว
        wait(1.5)
        
        -- Outro Animation (เฟดออก)
        frameTween = TweenService:Create(MainFrame, introInfo, {Position = UDim2.new(0.5, -150, 0.4, -100), BackgroundTransparency = 1})
        TweenService:Create(Title, introInfo, {TextTransparency = 1}):Play()
        TweenService:Create(SubTitle, introInfo, {TextTransparency = 1}):Play()
        TweenService:Create(KeyBox, introInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(CheckBtn, introInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(DropShadow, introInfo, {ImageTransparency = 1}):Play()
        frameTween:Play()
        
        wait(0.8)
        ScreenGui:Destroy() -- ปิด UI
        
        -- [[ รันสคริปต์ของน็อต ]]
        loadstring(game:HttpGet("https://raw.githubusercontent.com/bawem56/MyScripts/main/promm2.lua"))()
    else
        -- Wrong Key Animation (สั่นและสีแดง)
        CheckBtn.Text = "INVALID KEY!"
        TweenService:Create(CheckBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 65, 65)}):Play() -- สีแดง
        TweenService:Create(KeyStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255, 65, 65)}):Play() -- ขอบช่องใส่คีย์แดง
        
        -- Shake Animation (สั่น UI)
        local origPos = MainFrame.Position
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = origPos + UDim2.new(0, 10, 0, 0)}):Play(); wait(0.05)
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = origPos - UDim2.new(0, 10, 0, 0)}):Play(); wait(0.05)
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = origPos + UDim2.new(0, 10, 0, 0)}):Play(); wait(0.05)
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = origPos}):Play() -- กลับที่เดิม

        wait(1)
        -- กลับสู่สถานะปกติ
        CheckBtn.Text = "GET ACCESS"
        TweenService:Create(CheckBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 132, 255)}):Play()
        TweenService:Create(KeyStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(60, 60, 60)}):Play()
    end
end)

-- Make it draggable (ยอมให้ลาก UI ได้หลังเปิดอนิเมชั่นเสร็จ)
delay(1, function()
    MainFrame.Active = true
    MainFrame.Draggable = true
end)
