local ReplicatedStorage = game:GetService "ReplicatedStorage"

local defaultStates = require(ReplicatedStorage.Common.DefaultStates)
local Sift = require(ReplicatedStorage.Common.lib.Sift)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local types = require(ReplicatedStorage.Common.Slices.Players.Types)

export type StatsProducer = Reflex.Producer<StatsState, StatsActions>

export type StatsState = {
	[string]: types.PlayerStats?,
}

export type StatsActions = {
	wipeData: (name: string) -> (),
	addPlayerData: (name: string, data: { [any]: any }) -> (),
	removePlayerData: (name: string) -> (),
	incrementStat: (name: string, stat: string, amount: number) -> (),
	setStat: (name: string, stat: string, amount: number) -> (),
}

local initialState: StatsState = {}

local statsSlice = Reflex.createProducer(initialState, {
	wipeData = function(state: StatsState, name: string)
		return Sift.Dictionary.set(
			state,
			name,
			table.clone(defaultStates.ProfileDataTemplate.Stats)
		)
	end,
	addPlayerData = function(state: StatsState, name: string, data: any): StatsState
		return Sift.Dictionary.merge(state, { [name] = data.Stats })
	end,
	removePlayerData = function(state: StatsState, name: string): StatsState
		return Sift.Dictionary.removeKey(state, name)
	end,
	incrementStat = function(
		state: StatsState,
		name: string,
		stat: string,
		amount: number
	): StatsState
		local currentValue = if state[name] then state[name][stat] else 0
		return Sift.Dictionary.mergeDeep(state, { [name] = { [stat] = currentValue + amount } })
	end,
	setStat = function(state: StatsState, name: string, stat: string, amount: number): StatsState
		return Sift.Dictionary.mergeDeep(state, { [name] = { [stat] = amount } })
	end,
})

return {
	StatsSlice = statsSlice,
}
