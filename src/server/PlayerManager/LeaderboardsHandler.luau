local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileService = require(ServerScriptService.Server.lib.ProfileService)
local profileTemplate = require(ReplicatedStorage.Common.DefaultStates).ProfileDataTemplate
local profiles = require(ServerScriptService.Server.PlayerManager.Profiles)
local formatter = require(ReplicatedStorage.Common.Utils.Formatter)
local producer = require(ServerScriptService.Server.Producer)
local selectors = require(ReplicatedStorage.Common.Selectors)

-- https://zerowidthspace.me/
local zeroWidthSpace = "​"

local function initializeRobloxLeaderboard(player: Player, data)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"

	local strength = Instance.new("StringValue")
	strength.Name = "Strength"
	strength.Value = formatter.formatNumberWithSuffix(data.Stats.Strength)
	strength.Parent = leaderstats

	-- local rank = Instance.new "StringValue"
	-- rank.Name = "Rank"
	-- rank.Value = formatter.formatNumberWithSuffix(data.Stats.Rank)
	-- rank.Parent = leaderstats

	local kills = Instance.new("StringValue")
	kills.Name = "Wins"
	kills.Value = formatter.formatNumberWithSuffix(data.Stats.Wins)
	kills.Parent = leaderstats

	local rebirths = Instance.new("StringValue")
	rebirths.Name = "Rebirths"
	rebirths.Value = formatter.formatNumberWithSuffix(data.Stats.Rebirths)
	rebirths.Parent = leaderstats

	leaderstats.Parent = player
end

local function fixListingOrder()
	local playerStrengthInfo = {}

	for _, player in ipairs(Players:GetPlayers()) do
		local leaderstats = player:FindFirstChild("leaderstats")

		if not leaderstats then
			continue
		end

		local strength =
			selectors.selectPlayerStatValue(player.Name, "Strength")(producer:getState())

		table.insert(playerStrengthInfo, {
			Strength = strength,
			StrengthStat = leaderstats.Strength,
			FormattedStrength = formatter.formatNumberWithSuffix(strength),
		})

		table.sort(playerStrengthInfo, function(a, b)
			return a.Strength < b.Strength
		end)

		for index, info in ipairs(playerStrengthInfo) do
			info.StrengthStat.Value = `{zeroWidthSpace:rep(index - 1)}{info.FormattedStrength}`
		end
	end
end

producer:observe(selectors.selectStats, selectors.selectPlayerName, function(_, playerName)
	local unsubscribe = producer:subscribe(
		selectors.selectPlayerDisplayStats(playerName),
		function(displayStats)
			local player = Players:FindFirstChild(playerName)

			if not player then
				return
			end

			player.leaderstats.Wins.Value = formatter.formatNumberWithSuffix(displayStats.Wins)
			player.leaderstats.Strength.Value =
				formatter.formatNumberWithSuffix(displayStats.Strength)
			player.leaderstats.Rebirths.Value =
				formatter.formatNumberWithSuffix(displayStats.Rebirths)

			fixListingOrder()
		end
	)

	return unsubscribe
end)

return {
	initializeRobloxLeaderboard = initializeRobloxLeaderboard,
}
