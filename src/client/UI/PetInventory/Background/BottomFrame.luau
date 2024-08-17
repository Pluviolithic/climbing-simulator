local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local Selectors = require(ReplicatedStorage.Common.Selectors)
local Producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local petUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local SharedValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.SharedValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Computed = Fusion.Computed
local Children = Fusion.Children

local player = Players.LocalPlayer

local maxPetCount: Fusion.Value<number> = Value(0)
local maxPetEquipCount: Fusion.Value<number> = Value(0)

local PlayerPets = SharedValues.PlayerPets

local storageText = Computed(function()
	return `{petUtils.countPets(PlayerPets:get())}/{maxPetCount:get()}`
end)

local equippedText = Computed(function()
	return `{petUtils.countEquippedPets(PlayerPets:get())}/{maxPetEquipCount:get()}`
end)

Producer:subscribe(Selectors.selectPlayerStatValue(player.Name, "MaxPetCount"), function(count)
	maxPetCount:set(count)
end)

Producer:subscribe(Selectors.selectPlayerStatValue(player.Name, "MaxPetEquipCount"), function(count)
	maxPetEquipCount:set(count)
end)

return New "ImageLabel" {
	Name = "BottomFrame",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Image = "http://www.roblox.com/asset/?id=16865013063",
	Position = UDim2.fromScale(0.27, 0.947),
	Size = UDim2.fromScale(0.455, 0.0965),

	[Children] = {
		New "ImageLabel" {
			Name = "Icon",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16822536581",
			Position = UDim2.fromScale(0.519, -0.0978),
			Size = UDim2.fromScale(0.161, 1.09),
		},

		New "ImageLabel" {
			Name = "Icon",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16865308273",
			Position = UDim2.fromScale(0.0162, 0.0588),
			Size = UDim2.fromScale(0.102, 0.789),
		},

		New "ImageButton" {
			Name = "BuyInventory",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Image = "http://www.roblox.com/asset/?id=16865262078",
			Position = UDim2.fromScale(0.422, 0.165),
			Size = UDim2.fromScale(0.0911, 0.618),
		},

		New "TextLabel" {
			Name = "PetStorage",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(0.131, 0.13),
			Size = UDim2.fromScale(0.271, 0.69),
			Text = storageText,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,

			[Children] = {
				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(24, 24, 24),
					Thickness = 2,
				},
			},
		},

		New "TextLabel" {
			Name = "PetEquipped",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(0.668, 0.13),
			Size = UDim2.fromScale(0.235, 0.69),
			Text = equippedText,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 14,
			TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
			TextStrokeTransparency = 0,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,

			[Children] = {
				New "UIStroke" {
					Name = "UIStroke",
					Color = Color3.fromRGB(24, 24, 24),
					Thickness = 2,
				},
			},
		},

		New "ImageButton" {
			Name = "BuyEquipped",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Image = "http://www.roblox.com/asset/?id=16865262078",
			Position = UDim2.fromScale(0.893, 0.165),
			Size = UDim2.fromScale(0.0902, 0.618),
		},
	},
}
