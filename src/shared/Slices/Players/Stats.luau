local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Immut = require(ReplicatedStorage.Common.lib.Immut)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local types = require(ReplicatedStorage.Common.Slices.Players.Types)

export type StatsProducer = Reflex.Producer<StatsState, StatsActions>

export type StatsState = {
	[string]: types.PlayerStats?,
}

export type StatsActions = {
	addPlayerData: (name: string, data: { [any]: any }) -> (),
	removePlayerData: (name: string) -> (),
	incrementStat: (name: string, stat: string, amount: number) -> (),
	setStat: (name: string, stat: string, amount: number) -> (),
}

local initialState: StatsState = {}

local statsSlice = Reflex.createProducer(initialState, {
	addPlayerData = function(state: StatsState, name: string, data: any): StatsState
		return Immut.produce(state, function(draft)
			draft[name] = data.Stats
			return
		end) :: StatsState
	end,
	removePlayerData = function(state: StatsState, name: string): StatsState
		return Immut.produce(state, function(draft)
			draft[name] = nil
			return
		end) :: StatsState
	end,
	incrementStat = function(
		state: StatsState,
		name: string,
		stat: string,
		amount: number
	): StatsState
		return Immut.produce(state, function(draft)
			if draft[name] then
				draft[name][stat] = (draft[name][stat] or 0) + amount
			end
			return
		end) :: StatsState
	end,
	setStat = function(state: StatsState, name: string, stat: string, amount: number): StatsState
		return Immut.produce(state, function(draft)
			if draft[name] then
				draft[name][stat] = amount
			end
			return
		end) :: StatsState
	end,
}) :: StatsProducer

return {
	StatsSlice = statsSlice,
}
