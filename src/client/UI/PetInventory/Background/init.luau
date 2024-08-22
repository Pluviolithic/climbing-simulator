local ReplicatedStorage = game:GetService "ReplicatedStorage"

local PetInventoryValues = require(script.Parent.PetInventoryValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

local Open = PetInventoryValues.Open
local PetsToDelete = PetInventoryValues.PetsToDelete
local SelectedPetData = PetInventoryValues.SelectedPetData
local DeleteModeEnabled = PetInventoryValues.DeleteModeEnabled

return New "ImageLabel" {
	Name = "Background",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Image = "http://www.roblox.com/asset/?id=16865012439",
	Position = UDim2.fromScale(0.235, 0.197),
	Size = UDim2.fromScale(0.53, 0.655),

	[Children] = {
		require(script.PetFrame),
		require(script.BottomFrame),
		New "ImageButton" {
			Name = "Close",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16865012833",
			Position = UDim2.fromScale(0.947, 0.0281),
			Size = UDim2.fromScale(0.0695, 0.0968),

			[OnEvent "Activated"] = function()
				Open:set(false)
			end,
		},
		New "ImageButton" {
			Name = "DeletePets",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			HoverImage = "http://www.roblox.com/asset/?id=16995329121",
			Image = "http://www.roblox.com/asset/?id=16995330301",
			Position = UDim2.fromScale(0.925, 0.131),
			Size = UDim2.fromScale(0.0486, 0.0677),

			[OnEvent "Activated"] = function()
				PetsToDelete:set {}
				SelectedPetData:set(nil)
				DeleteModeEnabled:set(not DeleteModeEnabled:get())
			end,
		},
		New "ImageButton" {
			Name = "EvolveAll",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16865012947",
			Position = UDim2.fromScale(0.54, 0.122),
			Size = UDim2.fromScale(0.188, 0.0845),

			[OnEvent "Activated"] = function()
				require(ReplicatedStorage.Common.RedEvents.EvolveAllPets):Client():Fire()
				SelectedPetData:set(nil)
			end,

			[Children] = {
				New "TextLabel" {
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
					Position = UDim2.fromScale(0.0455, 0.235),
					Size = UDim2.fromScale(0.909, 0.53),
					Text = "EVOLVE ALL",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
					TextStrokeTransparency = 0,
					TextWrapped = true,
					ZIndex = 0,

					[Children] = {
						New "UIStroke" {
							Name = "UIStroke",
							Color = Color3.fromRGB(24, 24, 24),
						},
					},
				},
			},
		},
		New "ImageButton" {
			Name = "UnequipAll",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16865012220",
			Position = UDim2.fromScale(0.73, 0.122),
			Size = UDim2.fromScale(0.188, 0.0841),

			[OnEvent "Activated"] = function()
				SelectedPetData:set(nil)
				require(ReplicatedStorage.Common.RedEvents.UnequipAllPets):Client():Fire()
			end,

			[Children] = {
				New "TextLabel" {
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
					Position = UDim2.fromScale(0.0456, 0.199),
					Size = UDim2.fromScale(0.909, 0.602),
					Text = "UNEQUIP ALL",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
					TextStrokeTransparency = 0,
					TextWrapped = true,
					ZIndex = 0,

					[Children] = {
						New "UIStroke" {
							Name = "UIStroke",
							Color = Color3.fromRGB(24, 24, 24),
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
			Position = UDim2.fromScale(0.362, 0.00961),
			Size = UDim2.fromScale(0.277, 0.101),
			Text = "PETS",
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
}
