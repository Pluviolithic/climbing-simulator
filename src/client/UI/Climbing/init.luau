local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local ClimbingValues = require(script.ClimbingValues)
local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local player = Players.LocalPlayer

local Climbing = ClimbingValues.Climbing

AsyncHandlers.waitForChild(player, "PlayerGui"):andThen(function(PlayerGui: PlayerGui)
	New "ScreenGui"({
		Name = "Climbing",
		Enabled = Climbing,
		IgnoreGuiInset = true,
		ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		[Children] = {
			require(script.Mouse),
			require(script.Distance),
			require(script.StopClimb),
			require(script.SpeedMeter),
			require(script.CheckpointText),

			New "TextLabel" {
				Name = "Text",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
				Position = UDim2.fromScale(0.351, 0.092),
				Size = UDim2.fromScale(0.297, 0.0752),
				Text = "The further you climb, the more wins you get!",
				TextColor3 = Color3.fromRGB(251, 251, 251),
				TextScaled = true,
				TextSize = 14,
				TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
				TextStrokeTransparency = 0,
				TextWrapped = true,

				[Children] = {
					New "UIStroke" {
						Name = "UIStroke",
						Color = Color3.fromRGB(27, 27, 27),
						Thickness = 3,
					},
				},
			},

			New "TextLabel" {
				Name = "Text",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
				Position = UDim2.fromScale(0.419, 0.842),
				Size = UDim2.fromScale(0.177, 0.0757),
				Text = "Click to climb faster!",
				TextColor3 = Color3.fromRGB(251, 251, 251),
				TextScaled = true,
				TextSize = 14,
				TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
				TextStrokeTransparency = 0,
				TextWrapped = true,

				[Children] = {
					New "UIStroke" {
						Name = "UIStroke",
						Color = Color3.fromRGB(27, 27, 27),
						Thickness = 3,
					},
				},
			},
		},
	}).Parent =
		PlayerGui
end)

return 0
