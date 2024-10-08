local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local pets = require(script.Pets)
local stats = require(script.Stats)
local timestamps = require(script.Timestamps)
local Dumbbells = require(script.Dumbbells)
local Types = require(script.Types)

export type PlayerData = Types.PlayerData
export type PlayerPets = Types.PlayerPets
export type PlayerStats = Types.PlayerStats
export type PlayerDumbbells = Types.PlayerDumbbells
export type PlayerTimestamps = Types.PlayerTimestamps

type PlayersProducer = Reflex.Producer<PlayersState, PlayersActions>

export type PlayersState = {
	Stats: stats.StatsState,
	Pets: pets.PetsState,
	Timestamps: timestamps.TimestampsState,
	Dumbbells: Dumbbells.DumbbellsState,
}

export type PlayersActions =
	stats.StatsActions
	& timestamps.TimestampsActions
	& pets.PetsActions
	& Dumbbells.DumbbellsActions

local playersSlice: PlayersProducer = Reflex.combineProducers {
	Stats = stats.StatsSlice,
	Pets = pets.PetsSlice,
	Dumbbells = Dumbbells.DumbbellsSlice,
	Timestamps = timestamps.TimestampsSlice,
}

return {
	PlayersSlice = playersSlice,
}
