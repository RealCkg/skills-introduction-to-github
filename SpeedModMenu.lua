-- SpeedModMenu.lua
-- Ckg Speed Mod Menu

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variable to keep track of the current Humanoid
local currentHumanoid

local function onCharacterAdded(character)
	currentHumanoid = character:WaitForChild("Humanoid")
end

-- Set up Humanoid reference when character is loaded or respawned
if player.Character then
	onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)

--------------------------------------------------
-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedModMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame with dark theme
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 220)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)  -- dark background
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Header label with the author name
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 40)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundTransparency = 1
header.Text = "ckg test Speed"
header.TextColor3 = Color3.new(1, 1, 1)
header.TextScaled = true
header.Font = Enum.Font.SourceSansBold
header.Parent = mainFrame

-- Default Speed button: resets WalkSpeed to default (16)
local defaultButton = Instance.new("TextButton")
defaultButton.Size = UDim2.new(0.9, 0, 0, 40)
defaultButton.Position = UDim2.new(0.05, 0, 0, 60)
defaultButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
defaultButton.BorderSizePixel = 0
defaultButton.Text = "Default Speed"
defaultButton.TextColor3 = Color3.new(1, 1, 1)
defaultButton.Font = Enum.Font.SourceSans
defaultButton.TextScaled = true
defaultButton.Parent = mainFrame

-- Increase Speed button: toggles the dropdown
local increaseButton = Instance.new("TextButton")
increaseButton.Size = UDim2.new(0.9, 0, 0, 40)
increaseButton.Position = UDim2.new(0.05, 0, 0, 110)
increaseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
increaseButton.BorderSizePixel = 0
increaseButton.Text = "Increase Speed"
increaseButton.TextColor3 = Color3.new(1, 1, 1)
increaseButton.Font = Enum.Font.SourceSans
increaseButton.TextScaled = true
increaseButton.Parent = mainFrame

--------------------------------------------------
-- Dropdown frame for speed options (initially hidden)
local dropdown = Instance.new("Frame")
dropdown.Size = UDim2.new(0.9, 0, 0, 400)  -- enough space for our options
dropdown.Position = UDim2.new(0.05, 0, 0, 160)
dropdown.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
dropdown.BorderSizePixel = 0
dropdown.Visible = false
dropdown.Parent = mainFrame

-- ScrollingFrame for the list of speeds
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  -- will adjust after populating buttons
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = dropdown

--------------------------------------------------
-- Populate dropdown with speed option buttons (from 10 to 200 in increments of 10)
local SPEED_MIN = 10
local SPEED_MAX = 200
local SPEED_STEP = 10
local optionHeight = 30
local numOptions = math.floor((SPEED_MAX - SPEED_MIN) / SPEED_STEP) + 1

for i = 0, numOptions - 1 do
    local speedValue = SPEED_MIN + i * SPEED_STEP
    
    local speedButton = Instance.new("TextButton")
    speedButton.Size = UDim2.new(1, 0, 0, optionHeight)
    speedButton.Position = UDim2.new(0, 0, 0, i * optionHeight)
    speedButton.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
    speedButton.BorderSizePixel = 0
    speedButton.Text = tostring(speedValue)
    speedButton.TextColor3 = Color3.new(1, 1, 1)
    speedButton.Font = Enum.Font.SourceSans
    speedButton.TextScaled = true
    speedButton.Parent = scrollFrame

    speedButton.MouseButton1Click:Connect(function()
        if currentHumanoid then
            currentHumanoid.WalkSpeed = speedValue
        end
        dropdown.Visible = false  -- hide dropdown after selection
    end)
end

-- Adjust the canvas size of the scroll frame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, numOptions * optionHeight)

--------------------------------------------------
-- Button actions

defaultButton.MouseButton1Click:Connect(function()
    if currentHumanoid then
        currentHumanoid.WalkSpeed = 16
    end
end)

increaseButton.MouseButton1Click:Connect(function()
    dropdown.Visible = not dropdown.Visible
end)
