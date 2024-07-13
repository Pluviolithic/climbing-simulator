local StarterPlayer = game:GetService("StarterPlayer")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local Promise = require(ReplicatedStorage.Common.lib.Promise)
local selectors = require(ReplicatedStorage.Common.Selectors)

local function waitForChild(parent: Instance, name: string)
	return Promise.new(function(resolve)
		resolve(parent:WaitForChild(name))
	end)
end

local function waitForPlayerStats(player: Player)
	return producer:wait(selectors.selectStats, function(stats)
		return stats[player.Name] ~= nil
	end)
end

return {
	waitForChild = waitForChild,
	waitForPlayerStats = waitForPlayerStats,
}
