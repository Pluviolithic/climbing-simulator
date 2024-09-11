local ReplicatedStorage = game:GetService "ReplicatedStorage"

local ClimbingValues = require(script.Parent.ClimbingValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

--local ClickCount = ClimbingValues.ClickCount
local SpeedMultiplier = ClimbingValues.SpeedMultiplier

local multiplierText = Computed(function()
	return `{SpeedMultiplier:get()}x Speed`
end)

return New "ImageLabel" {
	Name = "SpeedMeter",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderSizePixel = 0,
	ClipsDescendants = true,
	Image = "http://www.roblox.com/asset/?id=128618182086204",
	Position = UDim2.fromScale(0.352, 0.794),
	Size = UDim2.fromScale(0.0649, 0.124),

	[Children] = {
		New "CanvasGroup" {
			Name = "Meter",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.119, 0.121),
			Size = UDim2.fromScale(0.761, 0.698),

			[Children] = {
				New "UICorner" {
					Name = "UICorner",
					CornerRadius = UDim.new(1, 0),
				},

				New "Frame" {
					Name = "5",
					BackgroundColor3 = Color3.fromRGB(255, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.fromScale(1, 0),
					Visible = false,

					[Children] = {
						New "UIGradient" {
							Name = "UIGradient",
							Color = ColorSequence.new {
								ColorSequenceKeypoint.new(0, Color3.fromRGB(136, 255, 0)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
							},
							Rotation = -90,
						},
					},
				},

				New "Frame" {
					Name = "4",
					BackgroundColor3 = Color3.fromRGB(255, 170, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.fromScale(1, 0),
					Visible = false,

					[Children] = {
						New "UIGradient" {
							Name = "UIGradient",
							Color = ColorSequence.new {
								ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 160, 52)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
							},
							Rotation = -90,
						},
					},
				},

				New "Frame" {
					Name = "3",
					BackgroundColor3 = Color3.fromRGB(255, 247, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.fromScale(1, 0),
					Visible = false,

					[Children] = {
						New "UIGradient" {
							Name = "UIGradient",
							Color = ColorSequence.new {
								ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 255, 124)),
								ColorSequenceKeypoint.new(0.439, Color3.fromRGB(255, 255, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
							},
							Rotation = -90,
						},
					},
				},

				New "Frame" {
					Name = "2",
					BackgroundColor3 = Color3.fromRGB(0, 255, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.fromScale(1, 0),
					Visible = false,

					[Children] = {
						New "UIGradient" {
							Name = "UIGradient",
							Color = ColorSequence.new {
								ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 174, 197)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
							},
							Rotation = -90,
						},
					},
				},

				New "Frame" {
					Name = "1",
					BackgroundColor3 = Color3.fromRGB(35, 251, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.fromScale(1, 0),

					[Children] = {
						New "UIGradient" {
							Name = "UIGradient",
							Color = ColorSequence.new {
								ColorSequenceKeypoint.new(0, Color3.fromRGB(82, 178, 202)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
							},
							Rotation = -90,
						},
					},
				},

				New "Frame" {
					Name = "6",
					BackgroundColor3 = Color3.fromRGB(196, 46, 255),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.fromScale(1, 0),
					Visible = false,

					[Children] = {
						New "UIGradient" {
							Name = "UIGradient",
							Color = ColorSequence.new {
								ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 162, 186)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
							},
							Rotation = -90,
						},
					},
				},
			},
		},

		New "TextLabel" {
			Name = "Speed",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(-0.43, -0.1),
			Rotation = -18,
			Size = UDim2.fromScale(1.52, 0.32),
			Text = multiplierText,
			TextColor3 = Color3.fromRGB(251, 251, 251),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,
			ZIndex = 5,

			[Children] = {
				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(27, 27, 27),
					Thickness = 3,
				},
			},
		},
	},
}
