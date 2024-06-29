local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Immut = require(ReplicatedStorage.Common.lib.Immut)
local Rodux = require(ReplicatedStorage.Common.lib.Rodux)
local petUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local defaultStates = require(ReplicatedStorage.Common.State.DefaultStates)

local produce = Immut.produce

return Rodux.createReducer({}, {
	addPlayer = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName] = table.clone(defaultStates.MultiplierData)
		end)
	end,
	removePlayer = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName] = nil
		end)
	end,
	resetPlayerData = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName] = table.clone(defaultStates.MultiplierData)
		end)
	end,
	incrementPlayerMultiplier = function(state, action)
		return produce(state, function(draft)
			if not draft[action.playerName][action.multiplierName] then
				draft[action.playerName][action.multiplierName] = 0
			end
			local multiplierWholePartCount = draft[action.playerName][action.multiplierName .. "Count"]
				or 0
			draft[action.playerName][action.multiplierName] += action.incrementAmount
			if action.incrementAmount > 1 then
				multiplierWholePartCount += 1
			end
			draft[action.playerName][action.multiplierName .. "Count"] = multiplierWholePartCount
		end)
	end,
	setPlayerMultiplier = function(state, action)
		return produce(state, function(draft)
			draft[action.playerName][action.multiplierName] = action.value
			if action.value > 1 then
				draft[action.playerName][action.multiplierName .. "Count"] = 1
			else
				draft[action.playerName][action.multiplierName .. "Count"] = 0
			end
		end)
	end,
})
