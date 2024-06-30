local stats = require(script.Stats)
local timestamps = require(script.Timestamps)

export type SharedState = {
	Stats: stats.StatsState,
	Timestamps: timestamps.TimestampsState,
}

export type SharedActions = stats.StatsActions & timestamps.TimestampsActions

return {
	Stats = stats.StatsSlice,
	Timestamps = timestamps.TimestampsSlice,
}
