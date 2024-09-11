local ReplicatedStorage = game:GetService "ReplicatedStorage"
local UserInputService = game:GetService "UserInputService"

local ClimbingValues = require(script.Parent.ClimbingValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Ratelimit = require(ReplicatedStorage.Common.lib.Ratelimit)

local New = Fusion.New
local Value = Fusion.Value
local Tween = Fusion.Tween
local Children = Fusion.Children

local Climbing = ClimbingValues.Climbing
local ClickCount = ClimbingValues.ClickCount

local maxClicks = 0
local speedMeterLevels = ReplicatedStorage.Config.SpeedMeterLevels:GetChildren()

for _, folder in ipairs(speedMeterLevels) do
	maxClicks += folder.Clicks.Value
end

local goalScale = Value(1)
local animatedScale =
	Tween(goalScale, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))

local clickLimit = Ratelimit(1, 0.3)
UserInputService.InputBegan:Connect(function(input: InputObject)
	if not Climbing:get() then
		return
	end

	if
		(
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		) and clickLimit "Screen"
	then
		ClickCount:set(math.min(ClickCount:get() + 1, maxClicks))
		goalScale:set(0.9)
		task.wait(0.1)
		goalScale:set(1)
	end
end)

return New "ImageLabel" {
	Name = "Mouse",
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderSizePixel = 0,
	Image = "http://www.roblox.com/asset/?id=95987719801251",
	Position = UDim2.fromScale(0.616, 0.854),
	Size = UDim2.fromScale(0.0604, 0.117),

	[Children] = {
		New "UIScale" {
			Name = "UIScale",
			Scale = animatedScale,
		},
	},
}
