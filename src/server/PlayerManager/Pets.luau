local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local Producer = require(ServerScriptService.Server.Producer)

local EquipPets = require(ReplicatedStorage.Common.RedEvents.EquipPets):Server()
local DeletePets = require(ReplicatedStorage.Common.RedEvents.DeletePets):Server()
local UnequipPets = require(ReplicatedStorage.Common.RedEvents.UnequipPets):Server()

DeletePets:On(function(player, petIndices)
	Producer.deletePets(player.Name, petIndices)
end)

EquipPets:On(function(player, petIndices)
	Producer.equipPets(player.Name, petIndices)
end)

UnequipPets:On(function(player, petIndices)
	Producer.unequipPets(player.Name, petIndices)
end)

return 0
