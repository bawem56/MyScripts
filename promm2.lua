local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- // สร้างหน้าต่างหลัก //
local Window = Fluent:CreateWindow({
    Title = "Revezy Cloud | MM2 Special Edition",
    SubTitle = "โดย Beam (Revezy Studio)",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // การตั้งค่า //
local Options = {
    AimEnabled = false,
    AimSmooth = 0.2,
    AimFOV = 150,
    ShowFOV = true,
    FOVColor = Color3.fromRGB(255, 255, 255), -- เพิ่มตัวแปรสี
    EspEnabled = false,
    Speed = 16
}

local Tabs = {
    Main = Window:AddTab({ Title = "ระบบต่อสู้", Icon = "crosshair" }),
    Visuals = Window:AddTab({ Title = "การมองเห็น", Icon = "eye" }),
    Player = Window:AddTab({ Title = "ตัวละคร", Icon = "user" })
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()

-- // วงกลม FOV //
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Options.FOVColor
FOVCircle.Filled = false

-- // ฟังก์ชันหาเป้าหมาย (คำนวณจากกลางหน้าจอ) //
local function GetClosestMurderer()
    local Target = nil
    local Dist = Options.AimFOV
    local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local isMurd = v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")
            if isMurd then
                local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    -- คำนวณระยะห่างจากกลางหน้าจอ
                    local Magnitude = (Vector2.new(Pos.X, Pos.Y) - ScreenCenter).Magnitude
                    if Magnitude < Dist then
                        Target = v.Character.HumanoidRootPart
                        Dist = Magnitude
                    end
                end
            end
        end
    end
    return Target
end

-- // ระบบ ESP (เหมือนเดิม) //
local function UpdateESP()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character then
            local char = v.Character
            if not Options.EspEnabled then
                if char:FindFirstChild("RevezyHighlight") then char.RevezyHighlight:Destroy() end
                if char:FindFirstChild("Head") and char.Head:FindFirstChild("RevezyTag") then 
                    char.Head.RevezyTag:Destroy() 
                end
            else
                local highlight = char:FindFirstChild("RevezyHighlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "RevezyHighlight"
                    highlight.Parent = char
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Adornee = char
                end

                local head = char:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("RevezyTag")
                    if not tag then
                        local bg = Instance.new("BillboardGui", head)
                        bg.Name = "RevezyTag"
                        bg.Size = UDim2.new(0, 200, 0, 50)
                        bg.AlwaysOnTop = true
                        bg.ExtentsOffset = Vector3.new(0, 3, 0)
                        
                        local tl = Instance.new("TextLabel", bg)
                        tl.Size = UDim2.new(1, 0, 1, 0)
                        tl.BackgroundTransparency = 1
                        tl.TextScaled = true
                        tl.Font = Enum.Font.GothamBold
                        tag = bg
                    end

                    local color = Color3.fromRGB(0, 255, 0)
                    local text = "● คนดีสัส"

                    if v.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
                        color = Color3.fromRGB(255, 0, 0)
                        text = "● ไอเหี้ยเวร"
                    elseif v.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
                        color = Color3.fromRGB(0, 150, 255)
                        text = "● นายอำเภอ"
                    end

                    highlight.FillColor = color
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    tag.TextLabel.Text = text
                    tag.TextLabel.TextColor3 = color
                end
            end
        end
    end
end

-- // LOOP หลัก //
RunService.RenderStepped:Connect(function()
    -- ปรับตำแหน่ง FOV ให้อยู่กลางจอเสมอ
    FOVCircle.Visible = Options.ShowFOV
    FOVCircle.Radius = Options.AimFOV
    FOVCircle.Color = Options.FOVColor
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    if Options.AimEnabled then
        local target = GetClosestMurderer()
        if target then
            local look = CFrame.new(Camera.CFrame.Position, target.Position)
            Camera.CFrame = Camera.CFrame:Lerp(look, Options.AimSmooth)
        end
    end
    
    UpdateESP()
end)

-- // เมนูระบบต่อสู้ //
Tabs.Main:AddToggle("AimToggle", {Title = "เปิดระบบล็อคเป้า", Default = false}):OnChanged(function(v) Options.AimEnabled = v end)
Tabs.Main:AddSlider("AimSmooth", {Title = "ความเนียน", Default = 0.2, Min = 0.1, Max = 1, Rounding = 1}):OnChanged(function(v) Options.AimSmooth = v end)
Tabs.Main:AddSlider("AimFOV", {Title = "ระยะล็อค (FOV)", Default = 150, Min = 50, Max = 800, Rounding = 0}):OnChanged(function(v) Options.AimFOV = v end)
Tabs.Main:AddToggle("FOVToggle", {Title = "แสดงวงกลมล็อคเป้า", Default = true}):OnChanged(function(v) Options.ShowFOV = v end)

-- เพิ่มตัวเลือกปรับสี FOV
Tabs.Main:AddColorpicker("FOVColorPicker", {
    Title = "สีของวงกลม FOV",
    Default = Color3.fromRGB(255, 255, 255)
}):OnChanged(function(v)
    Options.FOVColor = v
end)

-- // เมนูการมองเห็น //
Tabs.Visuals:AddToggle("ESPToggle", {Title = "เปิดการมองเห็น (เส้นขอบ + ชื่อ)", Default = false}):OnChanged(function(v) Options.EspEnabled = v end)

-- // เมนูตัวละคร //
Tabs.Player:AddSlider("SpeedSlider", {Title = "ความเร็วการเดิน", Default = 16, Min = 16, Max = 200, Rounding = 0}):OnChanged(function(v) 
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v 
    end
end)

Tabs.Player:AddButton({
    Title = "วาร์ปไปเก็บปืน",
    Callback = function()
        local gun = workspace:FindFirstChild("GunDrop")
        if gun then
            LocalPlayer.Character.HumanoidRootPart.CFrame = gun.CFrame
        else
            Fluent:Notify({Title = "แจ้งเตือน", Content = "ยังไม่มีปืนตกในขณะนี้", Duration = 3})
        end
    end
})

Window:SelectTab(1)
Fluent:Notify({Title = "Revezy Cloud", Content = "อัปเดตระบบ FOV เรียบร้อยแล้ว!", Duration = 5})
