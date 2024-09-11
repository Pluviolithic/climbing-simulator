local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local ClimbingHandler = require(StarterPlayer.StarterPlayerScripts.Client.ClimbingHandler)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

return New "ImageButton" {
	Name = "StopClimb",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Image = "http://www.roblox.com/asset/?id=16632893783",
	Position = UDim2.fromScale(0.771, 0.91),
	Size = UDim2.fromScale(0.117, 0.075),

	[OnEvent "Activated"] = function()
		ClimbingHandler.Cancel()
	end,

	[Children] = {
		New "TextLabel" {
			Name = "Text",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(0.0597, 0.198),
			Size = UDim2.fromScale(0.881, 0.603),
			Text = "Stop Climb",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,

			[Children] = {
				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(24, 24, 24),
					Thickness = 2.7,
				},
			},
		},
	},
}
