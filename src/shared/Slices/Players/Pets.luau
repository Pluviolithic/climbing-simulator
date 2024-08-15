local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
	addPet: (name: string, petName: string, rarity: string) -> (),
	removePet: (name: string, index: number) -> (),
	equipPet: (name: string, index: number) -> (),
	unequipPet: (name: string, index: number) -> (),
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
	addPet = function(state: PetsState, name: string, petName: string, rarity: string): PetsState
		if not state[name] then
			return state
		end
		return Sift.Dictionary.merge(state, {
			[name] = Sift.Array.append(state[name], {
				Name = petName,
				Rarity = rarity,
				Equipped = false,
			}),
		})
	end,
	removePet = function(state: PetsState, name: string, index: number): PetsState
		if not state[name] then
			return state
		end
		return Sift.Dictionary.merge(state, {
			[name] = Sift.Array.removeIndex(state[name], index),
		})
	end,
	equipPet = function(state: PetsState, name: string, index: number): PetsState
		if not state[name] or not state[name][index] then
			return state
		end

		return Sift.Dictionary.mergeDeep(state, { [name] = { [index] = { Equipped = true } } })
	end,
	unEquipPet = function(state: PetsState, name: string, index: number): PetsState
		if not state[name] or not state[name][index] then
			return state
		end

		return Sift.Dictionary.mergeDeep(state, { [name] = { [index] = { Equipped = false } } })
	end,
})

return {
	PetsSlice = petsSlice,
}
