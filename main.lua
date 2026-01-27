--==============================
-- MINI SORU BUTTON (DRAGGABLE)
--==============================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local lp = Players.LocalPlayer

-- Remote
local Remote = ReplicatedStorage:WaitForChild("ReplicatorNoYield")

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "SoruUI"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(120, 40)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 8)

local button = Instance.new("TextButton")
button.Size = UDim2.fromScale(1, 1)
button.BackgroundTransparency = 1
button.Text = "⚡ SORU"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.Parent = frame

--==============================
-- DRAG SYSTEM
--==============================
local dragging, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--==============================
-- BUTTON ACTION
--==============================
button.MouseButton1Click:Connect(function()
    pcall(function()
        Remote:FireServer("Core", "Soru", {})
    end)
end)

--==============================
-- END
--==============================
