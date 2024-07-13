local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local slices = require(ReplicatedStorage.Common.Slices)

local function selectStats(state: slices.SharedState)
	return state.Stats
end

local function selectPlayerStatValue(playerName: string, statName: string)
	return function(state: slices.SharedState)
		return state.Stats[playerName][statName]
	end
end

local function selectPlayerStats(playerName: string)
	return function(state: slices.SharedState)
		return state.Stats[playerName]
	end
end

local function selectPlayerDisplayStats(playerName: string)
	return Reflex.createSelector(
		selectPlayerStatValue(playerName, "Strength"),
		selectPlayerStatValue(playerName, "Wins"),
		selectPlayerStatValue(playerName, "Rebirths"),
		function(strength: number?, wins: number?, rebirths: number?)
			return {
				Strength = strength,
				Wins = wins,
				Rebirths = rebirths,
			}
		end
	)
end

return {
	selectPlayerStatValue = selectPlayerStatValue,
	selectPlayerStats = selectPlayerStats,
	selectPlayerDisplayStats = selectPlayerDisplayStats,
	selectStats = selectStats,
}
