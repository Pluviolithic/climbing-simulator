local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local AreaDumbbells = require(script.AreaDumbbells)
local DumbbellValues = require(script.DumbbellValues)
local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local ForValues = Fusion.ForValues

local player = Players.LocalPlayer
local Enabled = DumbbellValues.Enabled

AsyncHandlers.waitForChild(player, "PlayerGui"):andThen(function(PlayerGui: PlayerGui)
	New "ScreenGui"({
		Name = "Dumbbells",
		Enabled = Enabled,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,

		[Children] = {
			New "ImageLabel" {
				Name = "Background",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = "http://www.roblox.com/asset/?id=17674182126",
				Position = UDim2.fromScale(0.35, 0.214),
				Size = UDim2.fromScale(0.3, 0.622),
				ZIndex = 0,

				[Children] = {
					ForValues(
						ReplicatedStorage.Dumbbells:GetChildren(),
						AreaDumbbells,
						function(_, areaFrame)
							(areaFrame :: any):Destroy()
						end
					) :: any,
					New "ImageButton" {
						Name = "Close",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						Image = "http://www.roblox.com/asset/?id=16865012833",
						Position = UDim2.fromScale(0.927, 0.0239),
						Size = UDim2.fromScale(0.116, 0.0968),
					},
					New "TextLabel" {
						Name = "Text",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
						Position = UDim2.fromScale(0.324, 0.00961),
						Size = UDim2.fromScale(0.352, 0.128),
						Text = "GYM",
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
								Thickness = 2,
							},
						},
					},
				},
			},
		},
	}).Parent =
		PlayerGui
end)

return 0
