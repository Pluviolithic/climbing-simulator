local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local selectors = require(ReplicatedStorage.Common.Selectors)
local Formatter = require(ReplicatedStorage.Common.Utils.Formatter)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Tween = Fusion.Tween
local Computed = Fusion.Computed
local Children = Fusion.Children

local player = Players.LocalPlayer

return function(props)
	local statValue: Fusion.Value<number> = Value(0)
	local animatedStatValue = Tween(statValue)
	local formattedStatValue = Computed(function()
		return Formatter.formatNumberWithSuffix(animatedStatValue:get())
	end)

	producer:subscribe(selectors.selectPlayerStatValue(player.Name, props.Name), function(value)
		statValue:set(value)
	end)

	return New("ImageLabel")({
		Name = props.Name,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(27, 42, 53),
		Image = "http://www.roblox.com/asset/?id=16632885992",
		Position = props.Position,
		Size = props.Size,

		[Children] = {
			New("ImageLabel")({
				Name = "Icon",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = props.Icon,
				Position = UDim2.fromScale(-0.0962, -4.45e-08),
				Size = UDim2.fromScale(0.331, 1),
				ZIndex = 0,
			}),

			New("TextLabel")({
				Name = "Text",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
				Position = UDim2.fromScale(0.26, 0.186),
				Size = UDim2.fromScale(0.552, 0.641),
				Text = formattedStatValue,
				TextColor3 = Color3.fromRGB(253, 253, 253),
				TextScaled = true,
				TextSize = 14,
				TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
				TextStrokeTransparency = 0,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,

				[Children] = {
					New("UIStroke")({
						Name = "UIStroke",
						Color = Color3.fromRGB(24, 24, 24),
						Thickness = 2.1,
					}),

					New("UIGradient")({
						Name = "UIGradient",
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 237, 215)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 181, 65)),
						}),
						Rotation = 90,
					}),
				},
			}),

			New("ImageButton")({
				Name = "Buy",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=16632893529",
				Position = UDim2.fromScale(0.875, 0.209),
				Size = UDim2.fromScale(0.196, 0.57),
			}),
		},
	})
end
