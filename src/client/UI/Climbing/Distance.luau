local ReplicatedStorage = game:GetService "ReplicatedStorage"

local ClimbingValues = require(script.Parent.ClimbingValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Tween = Fusion.Tween
local Computed = Fusion.Computed
local Children = Fusion.Children

local ClimbProgress = ClimbingValues.ClimbProgress
local ClimbTarget = ClimbingValues.ClimbTarget
local NextClimbLength = ClimbingValues.NextClimbLength

local percentage = Computed(function()
	local target = ClimbTarget:get() or 1
	return ClimbProgress:get() / target
end)

local formattedPercentage = Computed(function()
	return `{math.round(percentage:get() * 100)}%`
end)

local percentagePosition = Computed(function()
	return UDim2.fromScale((0.957 + 0.0739) * percentage:get(), -0.179)
end)

local tweenInfo = Computed(function()
	return TweenInfo.new(NextClimbLength:get())
end)

local animatedPosition = Tween(percentagePosition, tweenInfo :: any)

return New "ImageLabel" {
	Name = "Distance",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderSizePixel = 0,
	Image = "http://www.roblox.com/asset/?id=91141286703853",
	Position = UDim2.fromScale(0.295, 0.922),
	Size = UDim2.fromScale(0.422, 0.063),

	[Children] = {
		New "ImageLabel" {
			Name = "Bar1",
			BackgroundColor3 = Color3.fromRGB(33, 196, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "http://www.roblox.com/asset/?id=97805880442449",
			Position = UDim2.fromScale(0.019, 0.13),
			Size = UDim2.fromScale(0.238, 0.697),
		},

		New "ImageLabel" {
			Name = "Image",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			BorderSizePixel = 0,
			Image = "http://www.roblox.com/asset/?id=138867962997710",
			Position = animatedPosition,
			Size = UDim2.fromScale(0.114, 1.31),
			ZIndex = 2,
		},

		New "TextLabel" {
			Name = "Percentage",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(0.396, 0.132),
			Size = UDim2.fromScale(0.23, 0.735),
			Text = formattedPercentage,
			TextColor3 = Color3.fromRGB(253, 253, 253),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,
			ZIndex = 2,

			[Children] = {
				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(27, 27, 27),
					Thickness = 3,
				},
			},
		},

		New "ImageLabel" {
			Name = "Image",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			BorderSizePixel = 0,
			Image = "http://www.roblox.com/asset/?id=72373630413551",
			Position = UDim2.fromScale(0.957, -0.159),
			Size = UDim2.fromScale(0.114, 1.31),
			ZIndex = 2,
		},

		New "ImageLabel" {
			Name = "Bar2",
			BackgroundColor3 = Color3.fromRGB(33, 196, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "http://www.roblox.com/asset/?id=107410864255475",
			Position = UDim2.fromScale(0.262, 0.13),
			Size = UDim2.fromScale(0.238, 0.697),
		},

		New "ImageLabel" {
			Name = "Bar3",
			BackgroundColor3 = Color3.fromRGB(33, 196, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "http://www.roblox.com/asset/?id=127265653214108",
			Position = UDim2.fromScale(0.505, 0.13),
			Size = UDim2.fromScale(0.238, 0.697),
		},

		New "ImageLabel" {
			Name = "Bar4",
			BackgroundColor3 = Color3.fromRGB(33, 196, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "http://www.roblox.com/asset/?id=74037487717930",
			Position = UDim2.fromScale(0.748, 0.13),
			Size = UDim2.fromScale(0.238, 0.697),
		},
	},
}
