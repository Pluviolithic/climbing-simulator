local ReplicatedStorage = game:GetService("ReplicatedStorage")

local defaultStates = require(ReplicatedStorage.Common.DefaultStates)
local Sift = require(ReplicatedStorage.Common.lib.Sift)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)

export type TimestampsProducer = Reflex.Producer<TimestampsState, TimestampsActions>

export type TimestampsState = {
	[string]: {
		[string]: number,
	},
}

export type TimestampsActions = {
	wipeData: (name: string) -> (),
	addPlayerData: (name: string, data: { [any]: any }) -> (),
	removePlayerData: (name: string) -> (),
	setTimestamp: (name: string, timestampName: string, timestamp: number) -> (),
}

local initialState: TimestampsState = {}

local timestampsSlice = Reflex.createProducer(initialState, {
	wipeData = function(state: TimestampsState, name: string)
		return Sift.Dictionary.set(
			state,
			name,
			table.clone(defaultStates.ProfileDataTemplate.Timestamps)
		)
	end,
	addPlayerData = function(state: TimestampsState, name: string, data: any): TimestampsState
		return Sift.Dictionary.merge(state, { [name] = data.Timestamps })
	end,
	removePlayerData = function(state: TimestampsState, name: string): TimestampsState
		return Sift.Dictionary.removeKey(state, name)
	end,
	setTimestamp = function(
		state: TimestampsState,
		name: string,
		stat: string,
		amount: number
	): TimestampsState
		return Sift.Dictionary.mergeDeep(state, { [name] = { [stat] = amount } })
	end,
})

return {
	TimestampsSlice = timestampsSlice,
}
