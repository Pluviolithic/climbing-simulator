local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local Sift = require(ReplicatedStorage.Common.lib.Sift)

local petCache = {}
local currentId = 0

task.spawn(function()
	for _, map in ipairs(ReplicatedStorage.EvolvedPets:GetChildren()) do
		for _, pet in ipairs(map:GetChildren()) do
			petCache[pet.Name] = pet
		end
	end
	for _, map in ipairs(ReplicatedStorage.ShinyPets:GetChildren()) do
		for _, pet in ipairs(map:GetChildren()) do
			petCache[pet.Name] = pet
		end
	end
	for _, map in ipairs(ReplicatedStorage.Pets:GetChildren()) do
		for _, pet in ipairs(map:GetChildren()) do
			petCache[pet.Name] = pet
		end
	end
end)

export type PetModel = Model & {
	ImageID: StringValue,
	Multiplier: NumberValue,
	Rarity: NumberValue,
	RarityName: StringValue,
	Mesh: MeshPart & {
		Attachment: Attachment,
		AlignPosition: AlignPosition,
		AlignOrientation: AlignOrientation,
	},
	PetUI: BillboardGui & {
		Frame: Frame & {
			PetName: TextLabel & {
				UIGradient: UIGradient,
			},
			PetRarity: TextLabel & {
				UIGradient: UIGradient,
			},
		},
	},
}

local function getPet(petName: string): PetModel?
	return petCache[petName]
end

local function createPet(petName: string, rarity: string, equipped: boolean?): Types.Pet
	currentId += 1
	return {
		Id = currentId,
		Name = petName,
		Rarity = rarity,
		Equipped = equipped or false,
	}
end

local function getEquippedPetsMultiplier(equippedPets): (number, number)
	local multiplier = 0
	local multiplierWholePartCount = 0
	for petName, quantity in equippedPets do
		local pet = getPet(petName) :: PetModel
		multiplier += pet.Multiplier.Value * quantity
		if pet.Multiplier.Value > 1 then
			multiplierWholePartCount += quantity
		end
	end
	return multiplier, multiplierWholePartCount
end

local function getPetRarities(petNames: { string }): { string }
	local rarities = {}
	for _, petName in petNames do
		table.insert(
			rarities,
			ReplicatedStorage.Pets:FindFirstChild(petName, true).RarityName.Value
		)
	end
	return rarities
end

local function countPets(playerPets: Types.PlayerPets)
	return #playerPets
end

local function countEquippedPets(playerPets: Types.PlayerPets)
	return Sift.Array.count(playerPets, function(pet: Types.Pet?)
		return (pet :: Types.Pet).Equipped
	end)
end

local function countPetByType(playerPets: Types.PlayerPets, petName: string)
	return Sift.Array.count(playerPets, function(pet: Types.Pet?)
		return (pet :: Types.Pet).Name == petName
	end)
end

return {
	getPet = getPet,
	countPets = countPets,
	createPet = createPet,
	countPetByType = countPetByType,
	getPetRarities = getPetRarities,
	countEquippedPets = countEquippedPets,
	getEquippedPetsMultiplier = getEquippedPetsMultiplier,
}
