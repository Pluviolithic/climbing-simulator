local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local PetInventoryValues =
	require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.PetInventoryValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

local Open = PetInventoryValues.Open

return New "ImageButton" {
	Name = "Pets",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Image = "http://www.roblox.com/asset/?id=16821818232",
	Position = UDim2.fromScale(0.0705, 0.442),
	Size = UDim2.fromScale(0.058, 0.099),

	[Children] = {
		New "ImageButton" {
			Name = "Icon",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16822536581",
			Size = UDim2.fromScale(1, 1),
			ZIndex = 0,

			[OnEvent "Activated"] = function()
				Open:set(not Open:get())
			end,
		},

		New "TextLabel" {
			Name = "Text",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(-0.078, 0.83),
			Size = UDim2.fromScale(1.16, 0.261),
			Text = "Pets",
			TextColor3 = Color3.fromRGB(253, 253, 253),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,

			[Children] = {
				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(0, 74, 109),
					Thickness = 3,
				},
			},
		},
	},
}
