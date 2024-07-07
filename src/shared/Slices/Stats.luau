local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Immut = require(ReplicatedStorage.Common.lib.Immut)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)

export type StatsProducer = Reflex.Producer<StatsState, StatsActions>

export type StatsState = {
	[string]: {
		[string]: number,
	},
}

export type StatsActions = {
	addPlayerData: (id: string, data: { [any]: any }) -> (),
	removePlayerData: (id: string) -> (),
	incrementStat: (id: string, stat: string, amount: number) -> (),
	setStat: (id: string, stat: string, amount: number) -> (),
}

local initialState: StatsState = {}

local statsSlice = Reflex.createProducer(initialState, {
	addPlayerData = function(state: StatsState, id: string, data: any): StatsState
		return Immut.produce(state, function(draft)
			draft[id] = data.Stats
			return
		end) :: StatsState
	end,
	removePlayerData = function(state: StatsState, id: string): StatsState
		return Immut.produce(state, function(draft)
			draft[id] = nil
			return
		end) :: StatsState
	end,
	incrementStat = function(
		state: StatsState,
		id: string,
		stat: string,
		amount: number
	): StatsState
		return Immut.produce(state, function(draft)
			if draft[id] then
				draft[id][stat] = (draft[id][stat] or 0) + amount
			end
			return
		end) :: StatsState
	end,
	setStat = function(state: StatsState, id: string, stat: string, amount: number): StatsState
		return Immut.produce(state, function(draft)
			if draft[id] then
				draft[id][stat] = amount
			end
			return
		end) :: StatsState
	end,
}) :: StatsProducer

return {
	StatsSlice = statsSlice,
}
