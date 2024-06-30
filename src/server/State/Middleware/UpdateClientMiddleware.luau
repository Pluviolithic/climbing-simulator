local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Enum = require(ReplicatedStorage.Common.Utils.Enum)
local Dispatch = require(ReplicatedStorage.Common.RedEvents.Dispatch):Server()
local replicationRules = require(ServerScriptService.Server.State.ReplicationRules)

return function(nextDispatch)
	return function(action)
		local replicationRule = replicationRules[action.type]
		if replicationRule == Enum.ReplicationRules.All or not action.playerName then
			Dispatch:FireAll(action)
		elseif replicationRule ~= Enum.ReplicationRules.None then
			if Players:FindFirstChild(action.playerName) then
				Dispatch:Fire(Players[action.playerName], action)
			end
		end
		nextDispatch(action)
	end
end
