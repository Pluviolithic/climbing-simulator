local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local producer = require(ServerScriptService.Server.Producer)
local profiles = require(ServerScriptService.Server.PlayerManager.Profiles)
local selectors = require(ReplicatedStorage.Common.Selectors)
local Sift = require(ReplicatedStorage.Common.lib.Sift)

producer:observe(selectors.selectStats, selectors.selectPlayerName, function(_, index)
	local unsubscribe = producer:subscribe(selectors.selectPlayerData(index), function(data)
		if profiles[index] then
			profiles[index].Data.Stats = data.Stats
			profiles[index].Data.Timestamps = data.Timestamps

			profiles[index].Data.Pets = Sift.Array.map(data.Pets, function(pet)
				return {
					Name = pet.Name,
					Rarity = pet.Rarity,
					Equipped = pet.Equipped,
				}
			end)
		end
	end)
	return unsubscribe
end)

return 0
