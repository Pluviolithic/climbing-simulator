local ServerScriptService = game:GetService "ServerScriptService"

local producer = require(ServerScriptService.Server.Producer)

return function(_, targetPlayer: Player)
	producer.wipeData(targetPlayer.Name)
end
