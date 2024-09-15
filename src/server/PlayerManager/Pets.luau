local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local RunService = game:GetService "RunService"
local ServerScriptService = game:GetService "ServerScriptService"

local EvolveAllPets = require(ReplicatedStorage.Common.RedEvents.EvolveAllPets)
local UnequipAllPets = require(ReplicatedStorage.Common.RedEvents.UnequipAllPets)
local Selectors = require(ReplicatedStorage.Common.Selectors)
local Producer = require(ServerScriptService.Server.Producer)

local EvolvePet = require(ReplicatedStorage.Common.RedFunctions.EvolvePet)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local Ratelimit = require(ReplicatedStorage.Common.lib.Ratelimit)
local Sift = require(ReplicatedStorage.Common.lib.Sift)
local EquipPet = require(ReplicatedStorage.Common.RedEvents.EquipPet)
local DeletePets = require(ReplicatedStorage.Common.RedEvents.DeletePets)
local UnequipPet = require(ReplicatedStorage.Common.RedEvents.UnequipPet)
local Grids = require(ReplicatedStorage.Common.Utils.Player.PetUtils.Grids)
local Janitor = require(ReplicatedStorage.Common.lib.Janitor)

local padding = ReplicatedStorage.Config.Pets.Padding.Value

local function getEvolutionRequirement(petName: string): number
	if petName:match "Shiny" then
		return 0
	elseif petName:match "Evolved" then
		return 5
	else
		return 3
	end
end

local function getEvolvedName(petName: string): string
	if petName:match "Shiny" then
		return petName
	elseif petName:match "Evolved" then
		return petName:gsub("Shiny", "Evolved")
	else
		return `Evolved {petName}`
	end
end

local function getPetsOfTypeForEvolve(
	playerPets: Types.PlayerPets,
	petName: string,
	maximum: boolean?
): { number }
	local filteredPetIds = Sift.Array.map(
		Sift.Array.filter(playerPets, function(pet)
			return (pet :: Types.Pet).Name == petName
		end),
		function(pet)
			return (pet :: Types.Pet).Id
		end
	)
	local requirement = getEvolutionRequirement(petName)

	if requirement == 0 then
		return {}
	else
		local maxEvolves = #filteredPetIds // requirement
		if maxEvolves < 1 then
			return {}
		end

		if maximum then
			return Sift.Array.slice(filteredPetIds, requirement * maxEvolves)
		else
			return Sift.Array.slice(filteredPetIds, requirement)
		end
	end
end

local deleteLimit = Ratelimit(5, 1)
DeletePets:Server():On(function(player, petIds)
	if not deleteLimit(player.UserId) then
		return
	end
	Producer.deletePets(player.Name, petIds)
end)

local equipLimit = Ratelimit(5, 1)
EquipPet:Server():On(function(player, petId)
	if not equipLimit(player.UserId) then
		return
	end
	if
		#Producer:getState(Selectors.selectEquippedPets(player.Name) :: any)
		< Producer:getState(Selectors.selectPlayerStatValue(player.Name, "MaxPetEquipCount"))
	then
		Producer.equipPets(player.Name, { petId })
	end
end)

local unequipLimit = Ratelimit(5, 1)
UnequipPet:Server():On(function(player, petId)
	if not unequipLimit(player.UserId) then
		return
	end
	Producer.unequipPets(player.Name, { petId })
end)

local evolveLimit = Ratelimit(5, 1)
EvolvePet:SetCallback(function(player, petId)
	if not evolveLimit(player.UserId) then
		return
	end
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

UnequipAllPets:Server():On(function(player)
	if not unequipLimit(player.UserId) then
		return
	end
	Producer.unequipAllPets(player.Name)
end)

EvolveAllPets:Server():On(function(player)
	if not evolveLimit(player.UserId) then
		return
	end
	local foundPets = {}
	local playerPets =
		Producer:getState(Selectors.selectPlayerPets(player.Name)) :: Types.PlayerPets
	local uniquePetsList = Sift.Array.filter(playerPets, function(pet: any)
		if foundPets[pet.Name] then
			return false
		end
		foundPets[pet.Name] = true
		return true
	end)

	for _, pet: any in ipairs(uniquePetsList) do
		local requirement = getEvolutionRequirement(pet.Name)
		local petsToDelete = getPetsOfTypeForEvolve(playerPets, pet.Name)

		if #petsToDelete == 0 then
			continue
		end

		local newPets = {}
		for _ = 1, #petsToDelete / requirement do
			table.insert(newPets, PetUtils.createPet(getEvolvedName(pet.Name), pet.Rarity))
		end

		Producer.deletePets(player.Name, petsToDelete)
		Producer.addPets(player.Name, newPets)
	end
end)

Producer:observe(Selectors.selectPets, Selectors.selectPlayerName, function(_, index)
	local petsFolder = Instance.new "Folder"
	local obliterator = Janitor.new()

	local function updateModels(equippedPets)
		if not Janitor.Is(obliterator) then
			return
		end

		obliterator:Cleanup()

		local petModels = {}
		for _, pet: Types.Pet in ipairs(equippedPets) do
			local petModel = (PetUtils.getPet(pet.Name) :: PetUtils.PetModel):Clone()
			obliterator:Add(petModel)
			table.insert(petModels, petModel)
		end

		table.sort(petModels, function(petA, petB)
			return petA.Multiplier.Value > petB.Multiplier.Value
		end)

		local grid = Grids[#petModels]

		obliterator:Add(RunService.Stepped:Connect(function()
			local player = Players:FindFirstChild(index)
			local character = if player then player.Character else nil
			local humanoid = if character then character:FindFirstChild "Humanoid" else nil

			if not humanoid then
				return
			end

			local playerPosition = humanoid.RootPart.Position
			local lookVector = humanoid.RootPart.CFrame.LookVector
			local leftVector = -humanoid.RootPart.CFrame.RightVector

			-- 4 is max no. of pets in row + 1
			local gridWidth = padding * 4
			local gridTopLeft = playerPosition - lookVector * padding - leftVector * gridWidth / 2

			for rowIdx, row in ipairs(grid) do
				local actualPadding = gridWidth / (#row + 1)

				for idx, petIdx in ipairs(row) do
					local petPosition = gridTopLeft
						- lookVector * padding * (rowIdx - 1)
						+ leftVector * actualPadding * idx
					local petCFrame = CFrame.new(petPosition, petPosition + lookVector)

					petModels[petIdx].Mesh.AlignOrientation.CFrame = petCFrame
					petModels[petIdx].Mesh.AlignPosition.Position = petPosition

					petModels[petIdx].Parent = petsFolder
				end
			end
		end))
	end

	updateModels(Producer:getState(Selectors.selectEquippedPets(index) :: any))
	Producer:subscribe(Selectors.selectEquippedPets(index), updateModels)

	petsFolder.Name = index
	petsFolder.Parent = workspace
	return function()
		obliterator:Destroy()
		petsFolder:Destroy()
	end
end)

return 0
