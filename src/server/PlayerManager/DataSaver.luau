local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local producer = require(ServerScriptService.Server.Producer)
local profiles = require(ServerScriptService.Server.PlayerManager.Profiles)

local function selectStats(state: producer.RootState)
	return state.Stats
end

local function getPlayerId(_, index: string)
	return index
end

local function selectStatsById(id: string)
	return function(state: producer.RootState)
		return state.Stats[id]
	end
end

local function selectPlayerData(id: string)
	return Reflex.createSelector(selectStatsById(id), function(stats)
		if not stats then
			return
		end
		return {
			Stats = stats,
		}
	end)
end

producer:observe(selectStats, getPlayerId, function(_, index)
	local unsubscribe = producer:subscribe(selectPlayerData(index), function(data)
		if profiles[index] then
			profiles[index].Data.Stats = data.Stats
		end
	end)
	return unsubscribe
end)

return 0
