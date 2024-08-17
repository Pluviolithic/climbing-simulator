local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local SharedValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.SharedValues)
local petUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

local SelectedPetData = SharedValues.SelectedPetData

local rarityImages = {
	Common = "http://www.roblox.com/asset/?id=18215905706",
	Uncommon = "http://www.roblox.com/asset/?id=18215687524",
	Rare = "http://www.roblox.com/asset/?id=18215714263",
	Epic = "http://www.roblox.com/asset/?id=18215798575",
	Legendary = "http://www.roblox.com/asset/?id=18215871283",
}

return function(props)
	local pet = petUtils.getPet(props.Pet.Name) :: petUtils.PetModel
	return New("ImageButton")({
		Name = props.Pet.Name,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(27, 42, 53),
		Image = rarityImages[pet.RarityName.Value],
		Position = UDim2.fromScale(-9.06e-08, 0),
		Selectable = false,
		Size = UDim2.fromScale(-0.726, 0.3),

		[OnEvent("Activated")] = function()
			SelectedPetData:set({ Idx = props.PetIndex, Pet = props.Pet })
		end,

		[Children] = {
			New("ImageLabel")({
				Name = "PetImage",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = pet.ImageID.Value,
				Position = UDim2.fromScale(0.196, 0.0756),
				Size = UDim2.fromScale(0.602, 0.55),
			}),

			New("TextLabel")({
				Name = "PetName",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json"),
				Position = UDim2.fromScale(0.041, 0.68),
				Size = UDim2.fromScale(0.918, 0.263),
				Text = props.Pet.Name,
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

			New("ImageLabel")({
				Name = "Equipped",
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = "http://www.roblox.com/asset/?id=16992384105",
				Position = UDim2.fromScale(0.723, -0.00386),
				Selectable = true,
				Size = UDim2.fromScale(0.274, 0.275),
				Visible = false,
				ZIndex = 2,
			}),

			New("ImageLabel")({
				Name = "Delete",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = "http://www.roblox.com/asset/?id=16995264624",
				Position = UDim2.fromScale(0.196, 0.0519),
				Size = UDim2.fromScale(0.602, 0.596),
				Visible = false,
			}),
		},
	})
end
