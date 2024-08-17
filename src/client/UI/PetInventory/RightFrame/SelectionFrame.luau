local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local SharedValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.SharedValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

local SelectedPetData = SharedValues.SelectedPetData
local DeleteModeEnabled = SharedValues.DeleteModeEnabled

local visible = Computed(function()
	return SelectedPetData:get() ~= nil and not DeleteModeEnabled:get()
end)

local petName = Computed(function()
	local petData = SelectedPetData:get()
	if not petData then
		return ""
	end

	return petData.Pet.Name
end)

local petImage = Computed(function()
	local petData = SelectedPetData:get()
	if not petData then
		return ""
	end

	local pet = PetUtils.getPet(petData.Pet.Name) :: PetUtils.PetModel
	return pet.ImageID.Value
end)

return New "Frame" {
	Name = "SelectionFrame",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Size = UDim2.fromScale(1, 1),
	Visible = visible,

	[Children] = {
		New "ImageButton" {
			Name = "Equip",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16865012748",
			Position = UDim2.fromScale(0.141, 0.7),
			Size = UDim2.fromScale(0.708, 0.124),

			[Children] = {
				New "TextLabel" {
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
					Position = UDim2.fromScale(0.0455, 0.0861),
					Size = UDim2.fromScale(0.909, 0.796),
					Text = "EQUIP",
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
			Name = "Evolve",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16992643775",
			Position = UDim2.fromScale(0.106, 0.842),
			Size = UDim2.fromScale(0.78, 0.124),

			[Children] = {
				New "TextLabel" {
					Name = "Text",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
					Position = UDim2.fromScale(0.0455, 0.0861),
					Size = UDim2.fromScale(0.909, 0.796),
					Text = "EVOLVE (0/3)",
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

		New "ImageLabel" {
			Name = "PetDisplay",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Image = "http://www.roblox.com/asset/?id=16992554585",
			Position = UDim2.fromScale(0.0574, 0.0151),
			Size = UDim2.fromScale(0.891, 0.465),

			[Children] = {
				New "TextLabel" {
					Name = "PetName",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
					Position = UDim2.fromScale(0.0563, 0.705),
					Size = UDim2.fromScale(0.88, 0.239),
					Text = petName,
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

				New "ImageLabel" {
					Name = "PetImage",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Image = petImage,
					Position = UDim2.fromScale(0.203, 0.0495),
					Size = UDim2.fromScale(0.599, 0.584),
					ZIndex = 2,
				},
			},
		},

		New "TextLabel" {
			Name = "Strength",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
			Position = UDim2.fromScale(0.438, 0.528),
			Size = UDim2.fromScale(0.453, 0.117),
			Text = "x2k",
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

				New "ImageLabel" {
					Name = "Icon",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(27, 42, 53),
					Image = "http://www.roblox.com/asset/?id=16822848077",
					Position = UDim2.fromScale(-0.54, 0),
					Size = UDim2.fromScale(0.472, 1),
				},
			},
		},
	},
}
