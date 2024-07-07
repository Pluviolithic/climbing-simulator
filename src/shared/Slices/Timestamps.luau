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
	addPlayerData: (id: string, data: { [any]: any }) -> (),
	removePlayerData: (id: string) -> (),
	setTimestamp: (id: string, timestampName: string, timestamp: number) -> (),
}

local initialState: TimestampsState = {}

local timestampsSlice = Reflex.createProducer(initialState, {
	addPlayerData = function(state: TimestampsState, id: string, data: any): TimestampsState
		return Immut.produce(state, function(draft)
			draft[id] = data.Timestamps
			return
		end) :: TimestampsState
	end,
	removePlayerData = function(state: TimestampsState, id: string): TimestampsState
		return Immut.produce(state, function(draft)
			draft[id] = nil
			return
		end) :: TimestampsState
	end,
	setTimestamp = function(
		state: TimestampsState,
		id: string,
		stat: string,
		amount: number
	): TimestampsState
		return Immut.produce(state, function(draft)
			if draft[id] then
				draft[id][stat] = amount
			end
			return
		end) :: TimestampsState
	end,
})

return {
	TimestampsSlice = timestampsSlice,
}
