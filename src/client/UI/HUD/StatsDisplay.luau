local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local formatter = require(ReplicatedStorage.Common.Utils.Formatter)
local asyncUtils = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local selectors = require(ReplicatedStorage.Common.Selectors)

local player = Players.LocalPlayer

local function updateHUD(HUD: ScreenGui, new, old)
	for statName, statValue in pairs(new) do
		formatter.tweenFormattedTextNumber(HUD[statName].Text, {
			startValue = old[statName],
			endValue = statValue,
			duration = 0.3,
		})
	end
end

asyncUtils.waitForChild(player, "PlayerGui"):andThen(function(PlayerGui: PlayerGui)
	local HUD = PlayerGui:WaitForChild("HUD") :: ScreenGui
	asyncUtils.waitForPlayerStats(player):andThen(function(stats)
		updateHUD(
			HUD,
			{ Strength = stats.Strength, Wins = stats.Wins, Rebirths = stats.Rebirths },
			{ Strength = 0, Wins = 0, Rebirths = 0 }
		)
		producer:subscribe(selectors.selectPlayerDisplayStats(player.Name), function(new, old)
			updateHUD(HUD, new, old)
		end)
	end)
end)

return 0
