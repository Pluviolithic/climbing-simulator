local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local Selectors = require(ReplicatedStorage.Common.Selectors)
local Producer = require(ServerScriptService.Server.Producer)

local EvolvePet = require(ReplicatedStorage.Common.RedFunctions.EvolvePet)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local Sift = require(ReplicatedStorage.Common.lib.Sift)
local EquipPet = require(ReplicatedStorage.Common.RedEvents.EquipPet):Server()
local DeletePets = require(ReplicatedStorage.Common.RedEvents.DeletePets):Server()
local UnequipPet = require(ReplicatedStorage.Common.RedEvents.UnequipPet):Server()

local function getEvolvedName(petName: string): string
	if petName:match "Shiny" then
		return petName
	elseif petName:match "Evolved" then
		return petName:gsub("Shiny", "Evolved")
	else
		return `Evovled {petName}`
	end
end

local function getPetsOfTypeForEvolve(
	playerPets: Types.PlayerPets,
	petName: string,
	maximum: boolean?
): { number }?
	local filteredPetIds = Sift.Array.map(
		Sift.Array.filter(playerPets, function(pet)
			return (pet :: Types.Pet).Name == petName
		end),
		function(pet)
			return (pet :: Types.Pet).Id
		end
	)

	if petName:match "Shiny" then
		return nil
	elseif petName:match "Evolved" then
		local maxEvolves = #filteredPetIds // 5
		if maxEvolves < 1 then
			return nil
		end

		if maximum then
			return Sift.Array.slice(filteredPetIds, 5 * maxEvolves)
		else
			return Sift.Array.slice(filteredPetIds, 5)
		end
	else
		local maxEvolves = #filteredPetIds // 3
		if maxEvolves < 1 then
			return nil
		end

		if maximum then
			return Sift.Array.slice(filteredPetIds, 3 * maxEvolves)
		else
			return Sift.Array.slice(filteredPetIds, 3)
		end
	end
end

DeletePets:On(function(player, petIds)
	Producer.deletePets(player.Name, petIds)
end)

EquipPet:On(function(player, petId)
	if
		#Producer:getState(Selectors.selectEquippedPets(player.Name) :: any)
		< Producer:getState(Selectors.selectPlayerStatValue(player.Name, "MaxPetEquipCount"))
	then
		Producer.equipPets(player.Name, { petId })
	end
end)

UnequipPet:On(function(player, petId)
	Producer.unequipPets(player.Name, { petId })
end)

EvolvePet:SetCallback(function(player, petId)
	local playerPets =
		Producer:getState(Selectors.selectPlayerPets(player.Name)) :: Types.PlayerPets
	local petIndex = Sift.Array.findWhere(playerPets :: any, function(pet)
		return pet.Id == petId
	end)

	if not petIndex then
		return nil
	end

	local pet = playerPets[petIndex] :: Types.Pet
	local petIdsToDelete = getPetsOfTypeForEvolve(playerPets, pet.Name)

	if not petIdsToDelete then
		return nil
	end

	local newPet = PetUtils.createPet(getEvolvedName(pet.Name), pet.Rarity)

	Producer.deletePets(player.Name, petIdsToDelete)
	Producer.addPets(player.Name, { newPet })

	return newPet.Id
end)

return 0
