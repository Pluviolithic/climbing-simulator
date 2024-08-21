local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Types = require(script.Parent.Types)
local Sift = require(ReplicatedStorage.Common.lib.Sift)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local types = require(ReplicatedStorage.Common.Slices.Players.Types)
local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)

export type PetsProducer = Reflex.Producer<PetsState, PetsActions>

export type PetsState = {
	[string]: types.PlayerPets?,
}

export type PetsActions = {
	wipeData: (name: string) -> (),
	addPlayerData: (name: string, data: { [any]: any }) -> (),
	removePlayerData: (name: string) -> (),
	addPets: (name: string, pets: { Types.Pet }) -> (),
	deletePets: (name: string, Ids: { number }) -> (),
	equipPets: (name: string, Ids: { number }) -> (),
	unequipPets: (name: string, Ids: { number }) -> (),
	unequipAllPets: (name: string) -> (),
}

local initialState: PetsState = {}

local petsSlice = Reflex.createProducer(initialState, {
	wipeData = function(state: PetsState, name: string)
		return Sift.Dictionary.set(state, name, {})
	end,
	addPlayerData = function(state: PetsState, name: string, data: any): PetsState
		local newPets = {}
		for _, pet in ipairs(data.Pets) do
			table.insert(newPets, PetUtils.createPet(pet.Name, pet.Rarity, pet.Equipped))
		end
		return Sift.Dictionary.merge(state, { [name] = newPets })
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
	deletePets = function(state: PetsState, name: string, Ids: { number }): PetsState
		if not state[name] then
			return state
		end
		return Sift.Dictionary.merge(state, {
			[name] = Sift.Array.filter(state[name] :: any, function(pet)
				return table.find(Ids, pet.Id) == nil
			end),
		})
	end,
	equipPets = function(state: PetsState, name: string, Ids: { number }): PetsState
		if not state[name] then
			return state
		end

		return Sift.Dictionary.mergeDeep(state, {
			[name] = Sift.Array.map(state[name] :: any, function(pet)
				if table.find(Ids, pet.Id) then
					pet.Equipped = true
				end
				return pet
			end),
		})
	end,
	unequipPets = function(state: PetsState, name: string, Ids: { number }): PetsState
		if not state[name] then
			return state
		end

		return Sift.Dictionary.mergeDeep(state, {
			[name] = Sift.Array.map(state[name] :: any, function(pet)
				if table.find(Ids, pet.Id) then
					pet.Equipped = false
				end
				return pet
			end),
		})
	end,
	unequipAllPets = function(state: PetsState, name: string): PetsState
		if not state[name] then
			return state
		end

		return Sift.Dictionary.mergeDeep(state, {
			[name] = Sift.Array.map(state[name] :: any, function(pet)
				pet.Equipped = false
				return pet
			end),
		})
	end,
})

return {
	PetsSlice = petsSlice,
}
