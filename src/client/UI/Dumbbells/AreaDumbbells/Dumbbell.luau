local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local DumbbellValues =
	require(StarterPlayer.StarterPlayerScripts.Client.UI.Dumbbells.DumbbellValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

local PLayerStrength = DumbbellValues.PlayerStrength
local EquippedDumbell = DumbbellValues.EquippedDumbbell

return function(dumbbellObject)
	local buttonText = Computed(function()
		if EquippedDumbell:get() == dumbbellObject.Name then
			return "Equipped"
		elseif PLayerStrength:get() < dumbbellObject.Requirement.Value then
			return "Locked"
		else
			return "Equip"
		end
	end)

	return New "ImageLabel" {
		Name = "VIP",
		Active = true,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(27, 42, 53),
		Image = "http://www.roblox.com/asset/?id=18238668601",
		Position = UDim2.fromScale(0.0436, -0.0276),
		Selectable = true,
		Size = UDim2.fromScale(0.559, 0.28),
		ZIndex = 2,

		[Children] = {
			New "ImageLabel" {
				Name = "Close",
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = dumbbellObject.Image.Value,
				Position = UDim2.fromScale(0.0104, 0.155),
				Selectable = true,
				Size = UDim2.fromScale(0.269, 0.927),
				ZIndex = 2,
			},

			New "ImageButton" {
				Name = "Equip",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = "http://www.roblox.com/asset/?id=17674182493",
				Position = UDim2.fromScale(0.616, 0.363),
				Size = UDim2.fromScale(0.347, 0.47),
				ZIndex = 2,

				[Children] = {
					New "TextLabel" {
						Name = "Text",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(27, 42, 53),
						FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
						Position = UDim2.fromScale(0, 0.06),
						Size = UDim2.fromScale(1, 0.769),
						Text = buttonText,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 14,
						TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
						TextStrokeTransparency = 0,
						TextWrapped = true,
						ZIndex = 2,

						[Children] = {
							New "UIStroke" {
								Name = "UIStroke",
								Color = Color3.fromRGB(24, 24, 24),
								Thickness = 1.9,
							},
						},
					},
				},
			},

			New "TextLabel" {
				Name = "Text",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
				Position = UDim2.fromScale(0.303, 0.303),
				Size = UDim2.fromScale(0.289, 0.541),
				Text = `x{dumbbellObject.Strength.Value}`,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
				TextStrokeTransparency = 0,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2,

				[Children] = {
					New "UIStroke" {
						Name = "UIStroke",
						Color = Color3.fromRGB(24, 24, 24),
						Thickness = 1.9,
					},
				},
			},

			New "TextLabel" {
				Name = "Text",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
				Position = UDim2.fromScale(1.19e-07, -0.0379),
				Size = UDim2.fromScale(1, 0.335),
				Text = "OP Dumbbell",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
				TextStrokeTransparency = 0,
				TextWrapped = true,
				ZIndex = 3,

				[Children] = {
					New "UIStroke" {
						Name = "UIStroke",
						Color = Color3.fromRGB(24, 24, 24),
						Thickness = 1.9,
					},
				},
			},
		},
	}
end
