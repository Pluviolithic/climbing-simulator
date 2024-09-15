local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local slices = require(ReplicatedStorage.Common.Slices)
local playersSlice = require(ReplicatedStorage.Common.Slices.Players)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local Sift = require(ReplicatedStorage.Common.lib.Sift)

local function selectPlayerName(_, name: string)
	return name
end

local function selectStats(state: slices.SharedState)
	return state.Players.Stats
end

local function selectTimestamps(state: slices.SharedState)
	return state.Players.Timestamps
end

local function selectPets(state: slices.SharedState)
	return state.Players.Pets
end

local function selectPlayerStatValue(playerName: string, statName: string)
	return function(state: slices.SharedState)
		return if state.Players.Stats[playerName]
			then (state.Players.Stats[playerName] :: Types.PlayerStats)[statName]
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

local function selectPlayerPets(playerName: string)
	return function(state: slices.SharedState)
		return state.Players.Pets[playerName]
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
		selectPlayerPets(playerName),
		function(
			stats: playersSlice.PlayerStats?,
			timestamps: playersSlice.PlayerTimestamps?,
			pets: playersSlice.PlayerPets?
		)
			if not stats or not timestamps or not pets then
				return
			end

			return {
				Pets = pets,
				Stats = stats,
				Timestamps = timestamps,
			}
		end
	)
end

local function selectEquippedPets(playerName: string)
	return Reflex.createSelector(
		selectPlayerPets(playerName),
		function(pets: playersSlice.PlayerPets?)
			pets = if typeof(pets) == "table" then pets else {}
			return Sift.Array.filter(pets :: any, function(pet: Types.Pet)
				return pet.Equipped
			end)
		end
	)
end

return {
	selectEquippedPets = selectEquippedPets,
	selectPlayerData = selectPlayerData,
	selectPlayerName = selectPlayerName,
	selectPlayerStats = selectPlayerStats,
	selectPlayerTimestamps = selectPlayerTimestamps,
	selectPlayerDisplayStats = selectPlayerDisplayStats,
	selectStats = selectStats,
	selectTimestamps = selectTimestamps,
	selectPlayerStatValue = selectPlayerStatValue,
	selectPlayerPets = selectPlayerPets,
	selectPets = selectPets,
}
