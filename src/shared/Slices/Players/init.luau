local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local pets = require(script.Pets)
local stats = require(script.Stats)
local timestamps = require(script.Timestamps)
local types = require(script.Types)

export type PlayerData = types.PlayerData
export type PlayerPets = types.PlayerPets
export type PlayerStats = types.PlayerStats
export type PlayerTimestamps = types.PlayerTimestamps

type PlayersProducer = Reflex.Producer<PlayersState, PlayersActions>

export type PlayersState = {
	Stats: stats.StatsState,
	Pets: pets.PetsState,
	Timestamps: timestamps.TimestampsState,
}

export type PlayersActions = stats.StatsActions & timestamps.TimestampsActions & pets.PetsActions

local playersSlice: PlayersProducer = Reflex.combineProducers({
	Stats = stats.StatsSlice,
	Pets = pets.PetsSlice,
	Timestamps = timestamps.TimestampsSlice,
})

return {
	PlayersSlice = playersSlice,
}
