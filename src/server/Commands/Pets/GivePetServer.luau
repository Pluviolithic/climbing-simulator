local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local Producer = require(ServerScriptService.Server.Producer)

return function(_, targetPlayer: Player, name: string)
	local pet = PetUtils.getPet(name)
	if not pet then
		return
	end
	Producer.addPets(targetPlayer.Name, { PetUtils.createPet(name, pet.RarityName.Value) })
end
