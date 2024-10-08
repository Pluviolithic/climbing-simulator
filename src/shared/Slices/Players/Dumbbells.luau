local ReplicatedStorage = game:GetService "ReplicatedStorage"

local defaultStates = require(ReplicatedStorage.Common.DefaultStates)
local Sift = require(ReplicatedStorage.Common.lib.Sift)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)

export type DumbbellsProducer = Reflex.Producer<DumbbellsState, DumbbellsActions>

export type DumbbellsState = {
	[string]: {
		[string]: boolean,
	} | string,
}

export type DumbbellsActions = {
	wipeData: (name: string) -> (),
	addPlayerData: (name: string, data: { [any]: any }) -> (),
	removePlayerData: (name: string) -> (),
	addDumbbell: (name: string, DumbbellName: string) -> (),
	equipDumbbell: (name: string, DumbbellName: string) -> (),
}

local initialState: DumbbellsState = {}

local DumbbellsSlice = Reflex.createProducer(initialState, {
	wipeData = function(state: DumbbellsState, name: string)
		return Sift.Dictionary.set(
			state,
			name,
			table.clone(defaultStates.ProfileDataTemplate.Dumbbells) :: any
		)
	end,
	addPlayerData = function(state: DumbbellsState, name: string, data: any): DumbbellsState
		return Sift.Dictionary.merge(state, { [name] = data.Dumbbells })
	end,
	removePlayerData = function(state: DumbbellsState, name: string): DumbbellsState
		return Sift.Dictionary.removeKey(state, name)
	end,
	addDumbbell = function(
		state: DumbbellsState,
		name: string,
		DumbbellName: string
	): DumbbellsState
		return Sift.Dictionary.mergeDeep(
			state,
			{ [name] = { OwnedDumbbells = { [DumbbellName] = true } } }
		)
	end,
	equipDumbbell = function(
		state: DumbbellsState,
		name: string,
		DumbbellName: string
	): DumbbellsState
		return Sift.Dictionary.mergeDeep(state, { [name] = { EquippedDumbbell = DumbbellName } })
	end,
})

return {
	DumbbellsSlice = DumbbellsSlice,
}
