local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local Producer = require(ServerScriptService.Server.Producer)

return function(_, targetPlayer: Player, name: string, quantity: number)
	local pet = PetUtils.getPet(name)
	if not pet then
		return
	end

	local newPets = {}

	for _ = 1, quantity do
		table.insert(newPets, PetUtils.createPet(name, pet.RarityName.Value))
	end

	Producer.addPets(targetPlayer.Name, newPets)
end
