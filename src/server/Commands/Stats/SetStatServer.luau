local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local producer = require(ServerScriptService.Server.Producer)
local statsList = require(ReplicatedStorage.Common.DefaultStates).ProfileDataTemplate.Stats

return function(_, targetPlayer: Player, stat: string, value: number)
	if not statsList[stat] then
		return
	end
	producer.setStat(targetPlayer.Name, stat, value)
end
