local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local Producer = require(ServerScriptService.Server.Producer)

local DeletePets = require(ReplicatedStorage.Common.RedEvents.DeletePets):Server()

DeletePets:On(function(player, petIndices)
	Producer.deletePets(player.Name, petIndices)
end)

return 0
