local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Immut = require(ReplicatedStorage.Common.lib.Immut)
local Rodux = require(ReplicatedStorage.Common.lib.Rodux)
local Dict = require(ReplicatedStorage.Common.lib.Sift).Dictionary
local defaultStates = require(ReplicatedStorage.Common.State.DefaultStates)

local produce = Immut.produce
local dumbells = ReplicatedStorage.Dumbells

return Rodux.createReducer({}, {
	addPlayer = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName] =
				Dict.mergeDeep(defaultStates.DumbellData, action.profileData.DumbellData)
		end)
	end,
	removePlayer = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName] = nil
		end)
	end,
	resetPlayerData = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName] = table.clone(defaultStates.DumbellData)
		end)
	end,
	givePlayerDumbell = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName].OwnedDumbells[action.dumbellName] = true
		end)
	end,
	takePlayerDumbell = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName].OwnedDumbells[action.dumbellName] = nil
			local bestDumbellName, bestDumbellDamage = "-", -1
			for dumbellName in draft[action.playerName].OwnedDumbells do
				if dumbellName == "-" then
					continue
				end
				if dumbells[dumbellName].Damage.Value > bestDumbellDamage then
					bestDumbellName = dumbellName
					bestDumbellDamage = dumbells[dumbellName].Damage.Value
				end
			end
			draft[action.playerName].EquippedDumbell = bestDumbellName
		end)
	end,
	unequipDumbell = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName].EquippedDumbell = "-"
		end)
	end,
	equipDumbell = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName].EquippedDumbell = action.dumbellName
		end)
	end,
	rebirthPlayer = function(state, action)
		return produce(state, function(draft)
			local bestDumbellName, bestDumbellDamage = "-", -1
			local ownedDumbells = table.clone(state[action.playerName].OwnedDumbells)
			for dumbellName in ownedDumbells do
				if dumbellName == "-" then
					continue
				end
				if dumbells[dumbellName]:FindFirstChild("Price") then
					draft[action.playerName].OwnedDumbells[dumbellName] = nil
				elseif dumbells[dumbellName].Damage.Value > bestDumbellDamage then
					bestDumbellName = dumbellName
					bestDumbellDamage = dumbells[dumbellName].Damage.Value
				end
			end
			draft[action.playerName].EquippedDumbell = bestDumbellName
		end)
	end,
})
