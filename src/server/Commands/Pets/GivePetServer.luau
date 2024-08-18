local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local petUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local producer = require(ServerScriptService.Server.Producer)

return function(_, targetPlayer: Player, name: string)
	local pet = petUtils.getPet(name)
	if not pet then
		return
	end
	producer.addPets(
		targetPlayer.Name,
		{ {
			Name = name,
			Equipped = false,
			Rarity = pet.RarityName.Value,
		} }
	)
end
