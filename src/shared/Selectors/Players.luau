local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Common.lib.Reflex)
local statsSelectors = require(ReplicatedStorage.Common.Selectors.Stats)
local statsSlice = require(ReplicatedStorage.Common.Slices.Stats)

local function selectPlayerName(_, name: string)
	return name
end

local function selectPlayerData(playerName: string)
	return Reflex.createSelector(
		statsSelectors.selectPlayerStats(playerName),
		function(stats: statsSlice.StatsState?)
			if not stats then
				return
			end

			return {
				Stats = stats,
			}
		end
	)
end

return {
	selectPlayerData = selectPlayerData,
	selectPlayerName = selectPlayerName,
}
