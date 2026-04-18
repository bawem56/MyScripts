-- [[ REVEZY ULTIMATE KEY SYSTEM x KEYAUTH - EXECUTOR VERSION ]]

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- [[ ⚙️ KEYAUTH CONFIGURATION ]]
local APP_NAME = "Gooldbg492's Application"
local OWNER_ID = "6EPAVvr7YR"
local APP_SECRET = "50dbfc5c230a8c1e67f26260e25675d7455f640ce730f36103c779addf6b434e"
local APP_VERSION = "1.0"

local SCRIPT_URL = "https://raw.githubusercontent.com/bawem56/MyScripts/main/mm2-revezy-v2.lua"

-- ลบ UI เก่า (ใช้ pcall กัน Error ในตัวรัน)
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("RevezyKeySystem") then 
        game:GetService("CoreGui").RevezyKeySystem:Destroy() 
    end
end)

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "RevezyKeySystem"

-- [[ UI CONSTRUCTION ]]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
local Stroke = Instance.new("UIStroke", Main); Stroke.Color = Color3.fromRGB(255, 170, 0); Stroke.Thickness = 3; Stroke.Transparency = 0.5

-- หัวข้อ
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60); Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "REVEZY KEY SYSTEM"; Title.TextColor3 = Color3.fromRGB(255, 170, 0)
Title.Font = "GothamBlack"; Title.TextSize = 28; Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", Main)
SubTitle.Size = UDim2.new(1, 0, 0, 20); SubTitle.Position = UDim2.new(0, 0, 0, 65)
SubTitle.Text = "EXECUTOR OPTIMIZED (XEON)"; SubTitle.TextColor3 = Color3.new(0.8, 0.8, 0.8)
SubTitle.Font = "GothamBold"; SubTitle.TextSize = 14; SubTitle.BackgroundTransparency = 1

-- ช่องใส่คีย์
local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(0, 350, 0, 50); KeyBox.Position = UDim2.new(0.5, 0, 0.45, 0); KeyBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35); KeyBox.Text = ""; KeyBox.PlaceholderText = "ใส่ KeyAuth License ที่นี่..."
KeyBox.TextColor3 = Color3.new(1,1,1); KeyBox.Font = "GothamBold"; KeyBox.TextSize = 18
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)

-- ปุ่มตกลง
local SubmitBtn = Instance.new("TextButton", Main)
SubmitBtn.Size = UDim2.new(0, 170, 0, 45); SubmitBtn.Position = UDim2.new(0.28, 0, 0.75, 0); SubmitBtn.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0); SubmitBtn.Text = "ตกลง"; SubmitBtn.Font = "GothamBlack"
SubmitBtn.TextColor3 = Color3.fromRGB(0,0,0); SubmitBtn.TextSize = 18; Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 10)

-- ปุ่มรับคีย์
local GetKeyBtn = Instance.new("TextButton", Main)
GetKeyBtn.Size = UDim2.new(0, 170, 0, 45); GetKeyBtn.Position = UDim2.new(0.72, 0, 0.75, 0); GetKeyBtn.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50); GetKeyBtn.Text = "รับคีย์"; GetKeyBtn.Font = "GothamBlack"
GetKeyBtn.TextColor3 = Color3.new(1,1,1); GetKeyBtn.TextSize = 18; Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 10)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30); Status.Position = UDim2.new(0, 0, 0.58, 0)
Status.Text = ""; Status.TextColor3 = Color3.new(1, 0.3, 0.3); Status.Font = "GothamBold"; Status.TextSize = 14; Status.BackgroundTransparency = 1

-- [[ 🚀 EXECUTOR REQUEST LOGIC ]]
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
    if sessionid == "" then if not KeyAuthInit() then return false, "Init Failed" end end
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local data = "type=license&key="..key.."&hwid="..hwid.."&sessionid="..sessionid.."&name="..APP_NAME.."&ownerid="..OWNER_ID
    local res = KeyAuthRequest(data)
    if res then return res.success, res.message end
    return false, "Error"
end

-- ปุ่มตกลง
SubmitBtn.MouseButton1Click:Connect(function()
    Status.Text = "กำลังตรวจสอบ..."
    local success, msg = VerifyLicense(KeyBox.Text)
    if success then
        Status.TextColor3 = Color3.new(0.3, 1, 0.3); Status.Text = "สำเร็จ!"
        task.wait(0.5)
        ScreenGui:Destroy()
        loadstring(game:HttpGet(SCRIPT_URL))()
    else
        Status.Text = "❌ " .. (msg or "ผิดพลาด")
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/A4my9aPAsc")
    Status.Text = "คัดลอกลิงก์แล้ว!"
end)
