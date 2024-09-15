local ReplicatedStorage = game:GetService "ReplicatedStorage"

local ClimbingValues = require(script.Parent.ClimbingValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Tween = Fusion.Tween
local Children = Fusion.Children

local CheckpointTextTransparency = ClimbingValues.CheckpointTextTransparency
local animatedTransparency = Tween(CheckpointTextTransparency)

return New "TextLabel" {
	Name = "CheckpointText",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
	Position = UDim2.fromScale(0.385, 0.177),
	Size = UDim2.fromScale(0.229, 0.058),
	Text = "Checkpoint!",
	TextColor3 = Color3.fromRGB(251, 251, 251),
	TextScaled = true,
	TextSize = 14,
	TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
	TextStrokeTransparency = 0,
	TextWrapped = true,
	Visible = true,
	TextTransparency = animatedTransparency,

	[Children] = {
		New "UIStroke" {
			Name = "UIStroke",
			Color = Color3.fromRGB(27, 27, 27),
			Thickness = 3,
			Transparency = animatedTransparency,
		},
	},
}
