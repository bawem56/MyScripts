local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- // สร้างหน้าต่างหลัก //
local Window = Fluent:CreateWindow({
    Title = "Revezy Cloud | MM2 ULTIMATE Edition",
    SubTitle = "โดย Beam (Revezy Studio)",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // การตั้งค่าเริ่มต้น //
local Options = {
    AimEnabled = false,
    AimSmooth = 0.2,
    AimFOV = 150,
    ShowFOV = true,
    FOVColor = Color3.fromRGB(255, 255, 255),
    EspEnabled = false,
    ItemEsp = false,
    Speed = 16,
    InfJump = false,
    Noclip = false,
    AutoFarm = false,
    FieldOfView = 70
}

local Tabs = {
    Main = Window:AddTab({ Title = "ระบบต่อสู้", Icon = "crosshair" }),
    Visuals = Window:AddTab({ Title = "การมองเห็น", Icon = "eye" }),
    Player = Window:AddTab({ Title = "ตัวละคร", Icon = "user" }),
    Farm = Window:AddTab({ Title = "ฟาร์ม/วาร์ป", Icon = "shovels" }),
    Spectate = Window:AddTab({ Title = "ส่องผู้เล่น", Icon = "video" }),
    Misc = Window:AddTab({ Title = "อื่นๆ", Icon = "settings" })
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- // วงกลม FOV //
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Filled = false

-- // --- ฟังก์ชันจัดการ ESP (แบบมี Tag บนหัว) --- //
local function CreateTag(character, text, color)
    local head = character:WaitForChild("Head", 5)
    if not head then return end
    
    local tag = head:FindFirstChild("RevezyTag")
    if not tag then
        tag = Instance.new("BillboardGui")
        tag.Name = "RevezyTag"
        tag.Parent = head
        tag.Size = UDim2.new(0, 200, 0, 50)
        tag.AlwaysOnTop = true
        tag.ExtentsOffset = Vector3.new(0, 3, 0)
        
        local label = Instance.new("TextLabel")
        label.Parent = tag
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        label.TextStrokeTransparency = 0
    end
    
    tag.TextLabel.Text = text
    tag.TextLabel.TextColor3 = color
end

local function UpdateVisuals()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character then
            local char = v.Character
            local highlight = char:FindFirstChild("RevezyHighlight")
            local head = char:FindFirstChild("Head")
            
            if Options.EspEnabled then
                -- เช็คบทบาท
                local isMurd = v.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                local isSheriff = v.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
                
                local roleText = "● คนดี"
                local roleColor = Color3.new(0, 1, 0)
                
                if isMurd then
                    roleText = "☠️ ไอชั่ว (ฆาตกร)"
                    roleColor = Color3.new(1, 0, 0)
                elseif isSheriff then
                    roleText = "⭐ นายอำเภอ"
                    roleColor = Color3.new(0, 0.6, 1)
                end
                
                -- ใส่ Highlight (เส้นขอบ)
                if not highlight then
                    highlight = Instance.new("Highlight", char)
                    highlight.Name = "RevezyHighlight"
                end
                highlight.FillColor = roleColor
                highlight.FillTransparency = 0.5
                
                -- ใส่ Tag บนหัว
                CreateTag(char, roleText, roleColor)
            else
                -- ลบออกถ้าปิด ESP
                if highlight then highlight:Destroy() end
                if head and head:FindFirstChild("RevezyTag") then head.RevezyTag:Destroy() end
            end
        end
    end
end

-- // LOOP หลัก //
RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = Options.ShowFOV
    FOVCircle.Radius = Options.AimFOV
    FOVCircle.Color = Options.FOVColor
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    if Options.AimEnabled then
        local target = nil
        local dist = Options.AimFOV
        local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                    local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    if OnScreen then
                        local Mag = (Vector2.new(Pos.X, Pos.Y) - ScreenCenter).Magnitude
                        if Mag < dist then target = v.Character.HumanoidRootPart; dist = Mag end
                    end
                end
            end
        end
        if target then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Position), Options.AimSmooth)
        end
    end

    Camera.FieldOfView = Options.FieldOfView
    UpdateVisuals()

    -- Item ESP (ปืนตก)
    local gun = workspace:FindFirstChild("GunDrop")
    if gun and Options.ItemEsp then
        if not gun:FindFirstChild("ItemHighlight") then
            local h = Instance.new("Highlight", gun); h.Name = "ItemHighlight"; h.FillColor = Color3.new(1,1,0)
        end
    elseif gun and gun:FindFirstChild("ItemHighlight") then
        gun.ItemHighlight:Destroy()
    end
end)

-- // --- UI Components --- //

-- TAB: ระบบต่อสู้
Tabs.Main:AddToggle("AimToggle", {Title = "เปิดระบบล็อคเป้า", Default = false}):OnChanged(function(v) Options.AimEnabled = v end)
Tabs.Main:AddSlider("AimSmooth", {Title = "ความเนียน", Default = 0.2, Min = 0.1, Max = 1, Rounding = 1}):OnChanged(function(v) Options.AimSmooth = v end)
Tabs.Main:AddSlider("AimFOV", {Title = "ระยะล็อค (FOV)", Default = 150, Min = 50, Max = 800, Rounding = 0}):OnChanged(function(v) Options.AimFOV = v end)
Tabs.Main:AddColorpicker("FOVColor", {Title = "สีวงกลม FOV", Default = Color3.new(1,1,1)}):OnChanged(function(v) Options.FOVColor = v end)

-- TAB: การมองเห็น
Tabs.Visuals:AddToggle("ESPToggle", {Title = "เปิด ESP (คนดี/ไอชั่ว)", Default = false}):OnChanged(function(v) Options.EspEnabled = v end)
Tabs.Visuals:AddToggle("ItemEsp", {Title = "มองเห็นปืนที่ตก", Default = false}):OnChanged(function(v) Options.ItemEsp = v end)
Tabs.Visuals:AddSlider("FOVSetting", {Title = "ระยะมุมมอง (Field of View)", Default = 70, Min = 70, Max = 120, Rounding = 0}):OnChanged(function(v) Options.FieldOfView = v end)

-- TAB: ตัวละคร
Tabs.Player:AddSlider("Speed", {Title = "ความเร็วการเดิน", Default = 16, Min = 16, Max = 150, Rounding = 0}):OnChanged(function(v) 
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v end 
end)
Tabs.Player:AddToggle("InfJump", {Title = "กระโดดไม่จำกัด", Default = false}):OnChanged(function(v) Options.InfJump = v end)
Tabs.Player:AddToggle("Noclip", {Title = "เดินทะลุกำแพง", Default = false}):OnChanged(function(v) Options.Noclip = v end)

-- TAB: ฟาร์ม/วาร์ป
Tabs.Farm:AddToggle("AutoFarm", {Title = "ฟาร์มเหรียญอัตโนมัติ", Default = false}):OnChanged(function(v)
    Options.AutoFarm = v
    task.spawn(function()
        while Options.AutoFarm do
            task.wait(0.1)
            local container = workspace:FindFirstChild("CoinContainer", true) or workspace:FindFirstChild("CoinHolder", true)
            if container then
                for _, coin in pairs(container:GetChildren()) do
                    if Options.AutoFarm and LocalPlayer.Character and coin:IsA("BasePart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
                        task.wait(0.4)
                    end
                end
            end
        end
    end)
end)

Tabs.Farm:AddButton({
    Title = "วาร์ปไปเก็บปืน",
    Callback = function()
        local gun = workspace:FindFirstChild("GunDrop")
        if gun then LocalPlayer.Character.HumanoidRootPart.CFrame = gun.CFrame 
        else Fluent:Notify({Title="แจ้งเตือน", Content="ไม่มีปืนตก"}) end
    end
})

-- TAB: ส่องผู้เล่น
local SpectateDropdown = Tabs.Spectate:AddDropdown("Spec", {Title = "เลือกผู้เล่นที่ต้องการส่อง", Values = {}})
local function UpdatePlayers()
    local tbl = {}
    for _, p in pairs(Players:GetPlayers()) do table.insert(tbl, p.Name) end
    SpectateDropdown:SetValues(tbl)
end
Tabs.Spectate:AddButton({Title = "รีเฟรชรายชื่อ", Callback = UpdatePlayers})
Tabs.Spectate:AddButton({Title = "เลิกส่อง", Callback = function() Camera.CameraSubject = LocalPlayer.Character.Humanoid end})
SpectateDropdown:OnChanged(function(v)
    local p = Players:FindFirstChild(v)
    if p and p.Character then Camera.CameraSubject = p.Character.Humanoid end
end)

-- TAB: อื่นๆ
Tabs.Misc:AddButton({
    Title = "ย้ายเซิร์ฟเวอร์ (Rejoin)",
    Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end
})

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ระบบ Infinite Jump Logic
game:GetService("UserInputService").JumpRequest:Connect(function()
    if Options.InfJump and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- ระบบ Noclip Logic
RunService.Stepped:Connect(function()
    if Options.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

Window:SelectTab(1)
UpdatePlayers()
Fluent:Notify({Title = "Revezy Cloud", Content = "อัปเดตระบบ ESP 'คนดี/ไอชั่ว' เรียบร้อย!", Duration = 5})
