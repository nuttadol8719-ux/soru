--==============================
-- NEW SORU UI (DELTA / MOBILE SAFE)
--==============================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer
local Remote = ReplicatedStorage:WaitForChild("ReplicatorNoYield")

--==============================
-- UI SETUP
--==============================
local gui = Instance.new("ScreenGui")
gui.Name = "Soru_NewUI"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,160,0,70)
main.Position = UDim2.fromScale(0.5,0.6)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- TITLE BAR (ใช้ลาก)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,25)
title.BackgroundColor3 = Color3.fromRGB(30,30,30)
title.Text = "⚡ SORU"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BorderSizePixel = 0
title.Parent = main
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

-- BUTTON
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1,-10,0,30)
btn.Position = UDim2.new(0,5,0,35)
btn.Text = "กดค้างเพื่อใช้"
btn.Font = Enum.Font.Gotham
btn.TextScaled = true
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
btn.BorderSizePixel = 0
btn.Parent = main
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

--==============================
-- DRAG SYSTEM (ใหม่ / เสถียร)
--==============================
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        dragInput = input
    end
end)

title.InputEnded:Connect(function(input)
    if input == dragInput then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

--==============================
-- HOLD TO SPAM SORU
--==============================
local holding = false
local delay = 0 -- ความรัว

btn.MouseButton1Down:Connect(function()
    holding = true
end)

btn.MouseButton1Up:Connect(function()
    holding = false
end)

btn.MouseLeave:Connect(function()
    holding = false
end)

RunService.Heartbeat:Connect(function()
    if holding then
        pcall(function()
            Remote:FireServer("Core","Soru",{})
        end)
        task.wait(delay)
    end
end)

--==============================
-- END
--==============================
