local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local stats = require(script.Stats)
local timestamps = require(script.Timestamps)
local types = require(script.Types)

export type PlayerData = types.PlayerData
export type PlayerStats = types.PlayerStats
export type PlayerTimestamps = types.PlayerTimestamps

type PlayersProducer = Reflex.Producer<PlayersState, PlayersActions>

export type PlayersState = {
	Stats: stats.StatsState,
	Timestamps: timestamps.TimestampsState,
}

export type PlayersActions = stats.StatsActions & timestamps.TimestampsActions

local playersSlice: PlayersProducer = Reflex.combineProducers({
	Stats = stats.StatsSlice,
	Timestamps = timestamps.TimestampsSlice,
})

return {
	PlayersSlice = playersSlice,
}
