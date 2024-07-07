local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local producer = require(ServerScriptService.Server.Producer)

local random = Random.new()

Players.PlayerAdded:Connect(function(player)
	task.wait(5)
	while Players:FindFirstChild(player.Name) do
		producer.incrementStat(player.Name, "Strength", random:NextInteger(1, 100))
		task.wait(5)
	end
end)

return 0
