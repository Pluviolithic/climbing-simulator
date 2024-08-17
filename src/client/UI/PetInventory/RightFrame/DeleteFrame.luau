local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local sharedValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.SharedValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children

return New("Frame")({
	Name = "DeleteFrame",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Size = UDim2.fromScale(1, 1),
	Visible = sharedValues.DeleteModeEnabled,

	[Children] = {
		New("ImageLabel")({
			Name = "Image",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16995330301",
			Position = UDim2.fromScale(0.227, 0.156),
			Size = UDim2.fromScale(0.531, 0.273),
			ZIndex = 2,
		}),

		New("ImageButton")({
			Name = "Delete",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16865011748",
			Position = UDim2.fromScale(0.141, 0.7),
			Size = UDim2.fromScale(0.708, 0.124),

			[Children] = {
				New("TextLabel")({
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
					Position = UDim2.fromScale(0.0455, 0.0861),
					Size = UDim2.fromScale(0.909, 0.796),
					Text = "DELETE",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
					TextStrokeTransparency = 0,
					TextWrapped = true,
					ZIndex = 0,

					[Children] = {
						New("UIStroke")({
							Name = "UIStroke",
							Color = Color3.fromRGB(24, 24, 24),
							Thickness = 1.2,
						}),
					},
				}),
			},
		}),

		New("ImageButton")({
			Name = "Cancel",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16865012748",
			Position = UDim2.fromScale(0.106, 0.842),
			Size = UDim2.fromScale(0.78, 0.124),

			[Children] = {
				New("TextLabel")({
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
					Position = UDim2.fromScale(0.0455, 0.0861),
					Size = UDim2.fromScale(0.909, 0.796),
					Text = "CANCEL",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
					TextStrokeTransparency = 0,
					TextWrapped = true,
					ZIndex = 0,

					[Children] = {
						New("UIStroke")({
							Name = "UIStroke",
							Color = Color3.fromRGB(24, 24, 24),
							Thickness = 1.2,
						}),
					},
				}),
			},
		}),

		New("TextLabel")({
			Name = "Text",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
			Position = UDim2.fromScale(0.0263, 0.0201),
			Size = UDim2.fromScale(0.938, 0.101),
			Text = "Multi Delete",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,

			[Children] = {
				New("UIStroke")({
					Name = "UIStroke",
					Color = Color3.fromRGB(24, 24, 24),
					Thickness = 2,
				}),
			},
		}),

		New("TextLabel")({
			Name = "Selected",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
			Position = UDim2.fromScale(0.0263, 0.506),
			Size = UDim2.fromScale(0.938, 0.101),
			Text = "0 Selected",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,

			[Children] = {
				New("UIStroke")({
					Name = "UIStroke",
					Color = Color3.fromRGB(24, 24, 24),
					Thickness = 2,
				}),
			},
		}),
	},
})
