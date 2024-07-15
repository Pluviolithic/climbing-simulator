local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local slices = require(ReplicatedStorage.Common.Slices)
local playersSlice = require(ReplicatedStorage.Common.Slices.Players)

local function selectPlayerName(_, name: string)
	return name
end

local function selectStats(state: slices.SharedState)
	return state.Players.Stats
end

local function selectTimestamps(state: slices.SharedState)
	return state.Players.Timestamps
end

local function selectPlayerStatValue(playerName: string, statName: string)
	return function(state: slices.SharedState)
		return if state.Players.Stats[playerName]
			then state.Players.Stats[playerName][statName]
			else nil
	end
end

local function selectPlayerStats(playerName: string)
	return function(state: slices.SharedState)
		return state.Players.Stats[playerName]
	end
end

local function selectPlayerTimestamps(playerName: string)
	return function(state: slices.SharedState)
		return state.Players.Timestamps[playerName]
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

local function selectPlayerData(playerName: string)
	return Reflex.createSelector(
		selectPlayerStats(playerName),
		selectPlayerTimestamps(playerName),
		function(stats: playersSlice.PlayerStats?, timestamps: playersSlice.PlayerTimestamps?)
			if not stats or not timestamps then
				return
			end

			return {
				Stats = stats,
				Timestamps = timestamps,
			}
		end
	)
end

return {
	selectPlayerData = selectPlayerData,
	selectPlayerName = selectPlayerName,
	selectPlayerStats = selectPlayerStats,
	selectPlayerTimestamps = selectPlayerTimestamps,
	selectPlayerDisplayStats = selectPlayerDisplayStats,
	selectStats = selectStats,
	selectTimestamps = selectTimestamps,
	selectPlayerStatValue = selectPlayerStatValue,
}
