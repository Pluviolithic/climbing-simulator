local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local slices = require(ReplicatedStorage.Common.Slices)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local producer = require(ServerScriptService.Server.Producer)

local start = require(ReplicatedStorage.Common.RedEvents.Start):Server()
local dispatch = require(ReplicatedStorage.Common.RedEvents.Dispatch):Server()

local broadcaster = Reflex.createBroadcaster {
	producers = slices,
	dispatch = function(player, actions)
		dispatch:Fire(player, actions)
	end,
	beforeDispatch = function(player, action)
		if action.arguments[1] ~= player.Name then
			return
		end
		return action
	end,
	beforeHydrate = function(player, state)
		local newState = {}

		newState.Stats = {
			[player.Name] = state.Players.Stats[player.Name],
		}

		newState.Timestamps = {
			[player.Name] = state.Players.Timestamps[player.Name],
		}

		newState.Pets = {
			[player.Name] = state.Players.Pets[player.Name],
		}

		return newState
	end,
}

start:On(function(player)
	broadcaster:start(player)
end)

producer:applyMiddleware(broadcaster.middleware)

return 0
