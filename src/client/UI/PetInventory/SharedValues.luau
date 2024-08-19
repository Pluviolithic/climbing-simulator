local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local selectors = require(ReplicatedStorage.Common.Selectors)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Sift = require(ReplicatedStorage.Common.lib.Sift)

local Value = Fusion.Value

local player = Players.LocalPlayer

export type petAndIdx = {
	Idx: number,
	Pet: Types.Pet,
}

local DeleteModeEnabled: Fusion.Value<boolean> = Value(false)
local PlayerPets: Fusion.Value<Types.PlayerPets> = Value {}
local SelectedPetData: Fusion.Value<petAndIdx?> = Value(nil)
local PetsToDelete: Fusion.Value<{ number }> = Value {}
local ConfirmingDelete: Fusion.Value<boolean> = Value(false)

local function sortPets(pets: Types.PlayerPets)
	local sortedEquipped = Sift.Array.filter(
		pets,
		function(pet: Types.Pet)
			return pet.Equipped
		end :: any
	)
	local sortedUnequipped = Sift.Array.filter(
		pets,
		function(pet: Types.Pet)
			return not pet.Equipped
		end :: any
	)
	table.sort(sortedEquipped, function(a, b)
		return (PetUtils.getPet((a :: Types.Pet).Name) :: PetUtils.PetModel).Multiplier.Value
			> (PetUtils.getPet((b :: Types.Pet).Name) :: PetUtils.PetModel).Multiplier.Value
	end)
	table.sort(sortedUnequipped, function(a, b)
		return (PetUtils.getPet((a :: Types.Pet).Name) :: PetUtils.PetModel).Multiplier.Value
			> (PetUtils.getPet((b :: Types.Pet).Name) :: PetUtils.PetModel).Multiplier.Value
	end)
	return Sift.Array.concat(sortedEquipped, sortedUnequipped)
end

producer:subscribe(selectors.selectPlayerPets(player.Name), function(pets: any)
	local sortedPets = sortPets(pets)
	PlayerPets:set(sortedPets)

	if SelectedPetData:get() then
		local newIndex = Sift.Array.findWhere(sortedPets, function(pet)
			return pet.Id == (SelectedPetData:get() :: petAndIdx).Pet.Id
		end)
		if not newIndex then
			return
		end
		SelectedPetData:set { Idx = newIndex, Pet = sortedPets[newIndex] }
	end
end)

return {
	DeleteModeEnabled = DeleteModeEnabled,
	PlayerPets = PlayerPets,
	SelectedPetData = SelectedPetData,
	PetsToDelete = PetsToDelete,
	ConfirmingDelete = ConfirmingDelete,
}
