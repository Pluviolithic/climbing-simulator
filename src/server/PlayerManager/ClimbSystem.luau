local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local Producer = require(ServerScriptService.Server.Producer)
local ReachedCheckpoint = require(ReplicatedStorage.Common.RedEvents.ReachedCheckpoint)
local RegionUtils = require(ReplicatedStorage.Common.Utils.Player.RegionUtils)
local Ratelimit = require(ReplicatedStorage.Common.lib.Ratelimit)

local limiter = Ratelimit(1, 0.25)
ReachedCheckpoint:Server():On(function(player, isFinal)
	if not limiter(player.Name) then
		return
	end

	local areaName = RegionUtils.getPlayerLocationName(player.Name)
	local areaData = ReplicatedStorage.Config.AreaData[areaName]

	if isFinal then
		Producer.incrementStat(player.Name, "Wins", areaData.MaxWins.Value)
	else
		Producer.incrementStat(player.Name, "Wins", 0.1 * areaData.MaxWins.Value)
	end
end)

return 0
