local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local PetInventoryValues =
	require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.PetInventoryValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Computed = Fusion.Computed
local Children = Fusion.Children

local PetsToDelete = PetInventoryValues.PetsToDelete
local SelectedPetData = PetInventoryValues.SelectedPetData
local ConfirmingDelete = PetInventoryValues.ConfirmingDelete
local DeleteModeEnabled = PetInventoryValues.DeleteModeEnabled

local amountText = Computed(function()
	return `Are you sure you want to delete these {#PetsToDelete:get()} pets?`
end)

return New "ImageLabel" {
	Name = "DeleteConfirm",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Image = "http://www.roblox.com/asset/?id=17005093656",
	Position = UDim2.fromScale(0.333, 0.37),
	Size = UDim2.fromScale(0.334, 0.333),
	Visible = ConfirmingDelete,

	[Children] = {
		New "TextLabel" {
			Name = "Amount",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(0.062, 0.112),
			Size = UDim2.fromScale(0.884, 0.534),
			Text = amountText,
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

		New "ImageButton" {
			Name = "Cancel",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=17005094861",
			Position = UDim2.fromScale(0.518, 0.723),
			Size = UDim2.fromScale(0.275, 0.188),
			ZIndex = 2,

			[OnEvent "Activated"] = function()
				DeleteModeEnabled:set(false)
				PetsToDelete:set {}
				ConfirmingDelete:set(false)
			end,

			[Children] = {
				New "TextLabel" {
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
					Position = UDim2.fromScale(0.0455, 0.0861),
					Size = UDim2.fromScale(0.909, 0.796),
					Text = "No",
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
							Thickness = 1.2,
						},
					},
				},
			},
		},

		New "ImageButton" {
			Name = "Confirm",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=17005094372",
			Position = UDim2.fromScale(0.214, 0.723),
			Size = UDim2.fromScale(0.275, 0.188),
			ZIndex = 2,

			[OnEvent "Activated"] = function()
				require(ReplicatedStorage.Common.RedEvents.DeletePets)
					:Client()
					:Fire(PetsToDelete:get())

				SelectedPetData:set(nil)
				DeleteModeEnabled:set(false)
				PetsToDelete:set {}
				ConfirmingDelete:set(false)
			end,

			[Children] = {
				New "TextLabel" {
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
					Position = UDim2.fromScale(0.0455, 0.0861),
					Size = UDim2.fromScale(0.909, 0.796),
					Text = "Yes",
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
							Thickness = 1.2,
						},
					},
				},
			},
		},
	},
}
