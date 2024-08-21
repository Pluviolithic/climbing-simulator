local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local Formatter = require(ReplicatedStorage.Common.Utils.Formatter)
local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local PetInventoryValues =
	require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.PetInventoryValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Sift = require(ReplicatedStorage.Common.lib.Sift)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Computed = Fusion.Computed
local Children = Fusion.Children

local PlayerPets = PetInventoryValues.PlayerPets
local SelectedPetData = PetInventoryValues.SelectedPetData
local MaxPetEquipCount = PetInventoryValues.MaxPetEquipCount
local DeleteModeEnabled = PetInventoryValues.DeleteModeEnabled

local visible = Computed(function()
	return SelectedPetData:get() ~= nil and not DeleteModeEnabled:get()
end)

local equippedText = Computed(function()
	return if SelectedPetData:get()
			and (SelectedPetData:get() :: PetInventoryValues.petAndIdx).Pet.Equipped
		then "UNEQUIP"
		else "EQUIP"
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

local petMultiplier = Computed(function()
	local petData = SelectedPetData:get()
	if not petData then
		return ""
	end

	local pet = PetUtils.getPet(petData.Pet.Name) :: PetUtils.PetModel
	return `x{Formatter.formatNumberWithSuffix(pet.Multiplier.Value)}`
end)

local evolveText = Computed(function()
	local petData = SelectedPetData:get()
	if not petData then
		return ""
	end

	local requirement = 3

	if petData.Pet.Name:match "Evolved" then
		requirement = 5
	elseif petData.Pet.Name:match "Shiny" then
		return "MAX EVOLVED"
	end

	return `EVOLVE ({PetUtils.countPetByType(PlayerPets:get(), petData.Pet.Name)}/{requirement})`
end)

local canUseEquipButton = Computed(function()
	if not SelectedPetData:get() then
		return false
	end
	return PetUtils.countEquippedPets(PlayerPets:get()) < MaxPetEquipCount:get()
		or (SelectedPetData:get() :: PetInventoryValues.petAndIdx).Pet.Equipped
end)

local canUseEvolveButton = Computed(function()
	local petData = SelectedPetData:get()
	if not petData then
		return false
	end

	local requirement = 3

	if petData.Pet.Name:match "Evolved" then
		requirement = 5
	elseif petData.Pet.Name:match "Shiny" then
		return false
	end

	return PetUtils.countPetByType(PlayerPets:get(), petData.Pet.Name) >= requirement
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
			Active = canUseEquipButton,

			[OnEvent "Activated"] = function()
				if (SelectedPetData:get() :: PetInventoryValues.petAndIdx).Pet.Equipped then
					require(ReplicatedStorage.Common.RedEvents.UnequipPet)
						:Client()
						:Fire((SelectedPetData:get() :: PetInventoryValues.petAndIdx).Pet.Id)
				else
					require(ReplicatedStorage.Common.RedEvents.EquipPet)
						:Client()
						:Fire((SelectedPetData:get() :: PetInventoryValues.petAndIdx).Pet.Id)
				end
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
					Text = equippedText,
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
			Active = canUseEvolveButton,

			[OnEvent "Activated"] = function()
				local petData = SelectedPetData:get() :: PetInventoryValues.petAndIdx
				local _, newId = require(ReplicatedStorage.Common.RedFunctions.EvolvePet)
					:Call(petData.Pet.Id)
					:Await()

				if newId then
					local index = nil
					repeat
						task.wait(0.1)
						index = Sift.Array.findWhere(PlayerPets:get(), function(pet)
							return (pet :: Types.Pet).Id == newId
						end)
					until index
					SelectedPetData:set {
						Idx = index,
						Pet = PlayerPets:get()[index :: number],
					}
				end
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
					Text = evolveText,
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
			Text = petMultiplier,
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
