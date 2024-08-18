local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Types = require(script.Parent.Types)
local Sift = require(ReplicatedStorage.Common.lib.Sift)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local types = require(ReplicatedStorage.Common.Slices.Players.Types)

export type PetsProducer = Reflex.Producer<PetsState, PetsActions>

export type PetsState = {
	[string]: types.PlayerPets?,
}

export type PetsActions = {
	wipeData: (name: string) -> (),
	addPlayerData: (name: string, data: { [any]: any }) -> (),
	removePlayerData: (name: string) -> (),
	addPets: (name: string, pets: { Types.Pet }) -> (),
	deletePets: (name: string, indices: { number }) -> (),
	equipPets: (name: string, indices: { number }) -> (),
	unequipPets: (name: string, indices: { number }) -> (),
}

local initialState: PetsState = {}

local petsSlice = Reflex.createProducer(initialState, {
	wipeData = function(state: PetsState, name: string)
		return Sift.Dictionary.set(state, name, {})
	end,
	addPlayerData = function(state: PetsState, name: string, data: any): PetsState
		return Sift.Dictionary.merge(state, { [name] = data.Pets })
	end,
	removePlayerData = function(state: PetsState, name: string): PetsState
		return Sift.Dictionary.removeKey(state, name)
	end,
	addPets = function(state: PetsState, name: string, pets: { Types.Pet }): PetsState
		if not state[name] then
			return state
		end
		return Sift.Dictionary.merge(state, {
			[name] = Sift.Array.concat(state[name], pets),
		})
	end,
	deletePets = function(state: PetsState, name: string, indices: { number }): PetsState
		if not state[name] then
			return state
		end
		return Sift.Dictionary.merge(state, {
			[name] = Sift.Array.removeIndices(state[name] :: any, table.unpack(indices)),
		})
	end,
	equipPets = function(state: PetsState, name: string, indices: { number }): PetsState
		if not state[name] then
			return state
		end

		return Sift.Dictionary.mergeDeep(state, {
			[name] = Sift.Array.map(state[name] :: any, function(value, index)
				if table.find(indices, index) then
					value.Equipped = true
				end
				return value
			end),
		})
	end,
	unequipPets = function(state: PetsState, name: string, indices: { number }): PetsState
		if not state[name] then
			return state
		end

		return Sift.Dictionary.mergeDeep(state, {
			[name] = Sift.Array.map(state[name] :: any, function(value, index)
				if table.find(indices, index) then
					value.Equipped = false
				end
				return value
			end),
		})
	end,
})

return {
	PetsSlice = petsSlice,
}
