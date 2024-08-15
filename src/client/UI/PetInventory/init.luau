local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local player = Players.LocalPlayer

AsyncHandlers.waitForChild(player, "PlayerGui"):andThen(function(PlayerGui: PlayerGui)
	New("ScreenGui")({
		Name = "PetInventory",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		[Children] = {
			require(script.Background),
		},
	}).Parent =
		PlayerGui
end)

return 0
