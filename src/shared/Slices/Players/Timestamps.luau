local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Immut = require(ReplicatedStorage.Common.lib.Immut)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)

export type TimestampsProducer = Reflex.Producer<TimestampsState, TimestampsActions>

export type TimestampsState = {
	[string]: {
		[string]: number,
	},
}

export type TimestampsActions = {
	addPlayerData: (name: string, data: { [any]: any }) -> (),
	removePlayerData: (name: string) -> (),
	setTimestamp: (name: string, timestampName: string, timestamp: number) -> (),
}

local initialState: TimestampsState = {}

local timestampsSlice = Reflex.createProducer(initialState, {
	addPlayerData = function(state: TimestampsState, name: string, data: any): TimestampsState
		return Immut.produce(state, function(draft)
			draft[name] = data.Timestamps
			return
		end) :: TimestampsState
	end,
	removePlayerData = function(state: TimestampsState, name: string): TimestampsState
		return Immut.produce(state, function(draft)
			draft[name] = nil
			return
		end) :: TimestampsState
	end,
	setTimestamp = function(
		state: TimestampsState,
		name: string,
		stat: string,
		amount: number
	): TimestampsState
		return Immut.produce(state, function(draft)
			if draft[name] then
				draft[name][stat] = amount
			end
			return
		end) :: TimestampsState
	end,
})

return {
	TimestampsSlice = timestampsSlice,
}
