--// SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

--// OPTIONS (รวมระบบเทพทั้งหมด)
local Options = {
    AimEnabled = false,
    AimSmooth = 0.15,
    AimFOV = 150,
    ShowFOV = true,
    EspEnabled = false,
    EspTags = false, -- ใหม่: เปิด/ปิด ชื่อบนหัว
    AutoGrabGun = false,
    Speed = 16,
    InfJump = false,
    Noclip = false,
    AutoFarm = false,
    FieldOfView = 70,
    SpectateTarget = nil -- ใหม่: เป้าหมายการส่อง
}

--// UI CONSTRUCT (Mobile Optimized)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "RevezyCloud_MobileV3"
ScreenGui.ResetOnSpawn = false

-- MAIN FRAME
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 340, 0, 480) -- เพิ่มความสูงรองรับ Spectate
Main.Position = UDim2.new(0.5, -170, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(45, 45, 55)

-- TITLE BAR
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "REVEZY CLOUD | MM2 MOBILE"
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 12)

-- SCROLLING CONTENT
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 950) -- ปรับขนาดตามจำนวนปุ่ม
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

--// UI ELEMENT FUNCTIONS
local function CreateToggle(name, default, callback)
    local Btn = Instance.new("TextButton", Scroll)
    Btn.Size = UDim2.new(1, 0, 0, 45)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Btn.Text = name .. " : " .. (default and "ON" or "OFF")
    Btn.TextColor3 = default and Color3.fromRGB(0, 255, 150) or Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 14
    
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    local state = default
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = name .. " : " .. (state and "ON" or "OFF")
        Btn.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.new(1, 1, 1)
        callback(state)
    end)
end

local function CreateButton(name, callback)
    local Btn = Instance.new("TextButton", Scroll)
    Btn.Size = UDim2.new(1, 0, 0, 45)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    Btn.Text = name
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 14
    
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Btn.MouseButton1Click:Connect(callback)
end

-- ใหม่: ฟังก์ชันสร้าง Dropdown สำหรับส่องผู้เล่น (Spectate)
local function CreateSpectateDropdown()
    local DropdownFrame = Instance.new("Frame", Scroll)
    DropdownFrame.Size = UDim2.new(1, 0, 0, 50)
    DropdownFrame.BackgroundTransparency = 1
    
    local DropdownBtn = Instance.new("TextButton", DropdownFrame)
    DropdownBtn.Size = UDim2.new(1, 0, 1, 0)
    DropdownBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    DropdownBtn.Text = "🔍 ส่องผู้เล่น (Spectate)"
    DropdownBtn.TextColor3 = Color3.new(1, 1, 1)
    DropdownBtn.Font = Enum.Font.GothamSemibold
    DropdownBtn.TextSize = 14
    Instance.new("UICorner", DropdownBtn).CornerRadius = UDim.new(0, 8)
    
    local PlayerListFrame = Instance.new("ScrollingFrame", ScreenGui) -- แยก Frame ลิสต์ออกมา
    PlayerListFrame.Size = UDim2.new(0, 200, 0, 250)
    PlayerListFrame.Position = UDim2.new(0, 0, 0, 0) -- จะปรับตำแหน่งตอนคลิก
    PlayerListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    PlayerListFrame.Visible = false
    PlayerListFrame.BorderSizePixel = 0
    PlayerListFrame.ZIndex = 10
    Instance.new("UICorner", PlayerListFrame)
    local ListLayout = Instance.new("UIListLayout", PlayerListFrame); ListLayout.Padding = UDim.new(0, 5)
    
    local function UpdatePlayerList()
        for _, child in pairs(PlayerListFrame:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
        for _, p in pairs(Players:GetPlayers()) do
            local pBtn = Instance.new("TextButton", PlayerListFrame)
            pBtn.Size = UDim2.new(1, -10, 0, 35)
            pBtn.Position = UDim2.new(0, 5, 0, 0)
            pBtn.Text = p.Name
            pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            pBtn.TextColor3 = (p == LocalPlayer) and Color3.new(0, 1, 0) or Color3.new(1, 1, 1)
            pBtn.Font = Enum.Font.Gotham; pBtn.TextSize = 12
            Instance.new("UICorner", pBtn)
            
            pBtn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("Humanoid") then
                    Camera.CameraSubject = p.Character.Humanoid
                    Options.SpectateTarget = p
                    Title.Text = "REVEZY | ส่อง: " .. p.Name -- เปลี่ยน Title ชั่วคราว
                    print("Revezy | กำลังส่อง: " .. p.Name)
                end
                PlayerListFrame.Visible = false
            end)
        end
        PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, (#Players:GetPlayers() * 40))
    end
    
    DropdownBtn.MouseButton1Click:Connect(function()
        UpdatePlayerList()
        local btnPos = DropdownBtn.AbsolutePosition
        local btnSize = DropdownBtn.AbsoluteSize
        PlayerListFrame.Position = UDim2.new(0, btnPos.X, 0, btnPos.Y + btnSize.Y + 35) -- ปรับตำแหน่งลอย
        PlayerListFrame.Visible = not PlayerListFrame.Visible
    end)
    
    -- ปุ่มเลิกส่อง
    CreateButton("❌ เลิกส่อง (กลับตัวเรา)", function()
        if LocalPlayer.Character then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
            Options.SpectateTarget = nil
            Title.Text = "REVEZY CLOUD | MM2 MOBILE"
            print("Revezy | เลิกส่อง")
        end
    end)
end

--// FEATURES LOGIC
local function GetMurderer()
    local target = nil
    local dist = Options.AimFOV
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                local pos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if onScreen then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then target = v.Character.HumanoidRootPart; dist = mag end
                end
            end
        end
    end
    return target
end

-- ใหม่: ฟังก์ชันสร้าง Tag บนหัว
local function CreateTag(char, text, color)
    local head = char:WaitForChild("Head", 2)
    if not head then return end
    local tag = head:FindFirstChild("RevezyTag") or Instance.new("BillboardGui", head)
    tag.Name = "RevezyTag"; tag.Size = UDim2.new(0, 120, 0, 45); tag.AlwaysOnTop = true; tag.ExtentsOffset = Vector3.new(0, 3, 0)
    local label = tag:FindFirstChild("Label") or Instance.new("TextLabel", tag)
    label.Name = "Label"; label.Size = UDim2.new(1, 0, 1, 0); label.BackgroundTransparency = 1; label.TextScaled = true
    label.Font = Enum.Font.GothamBold; label.Text = text; label.TextColor3 = color; label.TextStrokeTransparency = 0
    
    tag.Enabled = Options.EspTags -- เปิด/ปิดตามค่า Options
end

--// TOGGLES SETUP
CreateToggle("Aimbot (ล็อคฆาตกร)", false, function(v) Options.AimEnabled = v end)
CreateToggle("ESP (มองทะลุ)", false, function(v) Options.EspEnabled = v end)
CreateToggle("ชื่อบนหัว (คนดี/ไอชั่ว)", false, function(v) Options.EspTags = v end) -- ใหม่
CreateToggle("Auto Grab Gun (เก็บปืน)", false, function(v) Options.AutoGrabGun = v end)
CreateToggle("Noclip (ทะลุกำแพง)", false, function(v) Options.Noclip = v end)
CreateToggle("Infinite Jump", false, function(v) Options.InfJump = v end)

CreateButton("เพิ่มความเร็ว (+10)", function()
    Options.Speed = Options.Speed + 10
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = Options.Speed end
end)

CreateSpectateDropdown() -- ใหม่: ใส่ระบบส่องผู้เล่น

--// FLOAT BUTTON (Mobile Toggle)
local Float = Instance.new("TextButton", ScreenGui)
Float.Size = UDim2.new(0, 60, 0, 60)
Float.Position = UDim2.new(0, 15, 0.5, -30)
Float.Text = "REVEZY"
Float.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Float.TextColor3 = Color3.fromRGB(0, 200, 255)
Float.TextSize = 12
Float.Font = Enum.Font.GothamBold
Float.Draggable = true
Float.Active = true
Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Float).Thickness = 2

Float.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

--// FOV CIRCLE
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Filled = false

--// MAIN LOOP
RunService.RenderStepped:Connect(function()
    -- FOV
    FOVCircle.Visible = Options.ShowFOV and Options.AimEnabled
    FOVCircle.Radius = Options.AimFOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    -- AIMBOT
    if Options.AimEnabled then
        local target = GetMurderer()
        if target then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Options.AimSmooth)
        end
    end

    -- Spectate ป้องกันกล้องหลุด
    if Options.SpectateTarget and Options.SpectateTarget.Character and Options.SpectateTarget.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = Options.SpectateTarget.Character.Humanoid
    end

    -- AUTO GRAB
    if Options.AutoGrabGun then
        local gun = workspace:FindFirstChild("GunDrop")
        if gun and LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = gun.CFrame
        end
    end

    -- ESP & TAGS
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character then
            local char = v.Character
            local hl = char:FindFirstChild("RevezyHL")
            
            -- ตรวจสอบบทบาท
            local isM = v.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
            local isS = v.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
            
            local col = isM and Color3.new(1,0,0) or (isS and Color3.new(0,0.7,1) or Color3.new(0,1,0))
            local txt = isM and "☠️ ไอคนชั่ว" or (isS and "⭐ นายอำเภอ" or "● คนดี")
            
            -- ESP มองทะลุ (Highlight)
            if Options.EspEnabled then
                if not hl then hl = Instance.new("Highlight", char); hl.Name = "RevezyHL"; hl.OutlineTransparency = 0 end
                hl.FillColor = col; hl.FillTransparency = 0.5
            elseif hl then hl:Destroy() end
            
            -- ชื่อบนหัว (Tag)
            if Options.EspTags then
                CreateTag(char, txt, col) -- เรียกฟังก์ชันสร้าง/อัปเดต Tag
            else
                if char:FindFirstChild("Head") and char.Head:FindFirstChild("RevezyTag") then
                    char.Head.RevezyTag:Destroy()
                end
            end
        end
    end
end)

-- NOCLIP / INF JUMP
RunService.Stepped:Connect(function()
    if Options.Noclip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if Options.InfJump and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

print("Revezy Cloud Mobile V3 Loaded!")
