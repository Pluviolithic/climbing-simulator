local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local PetInventoryValues = require(script.PetInventoryValues)
local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local player = Players.LocalPlayer
local Open = PetInventoryValues.Open

AsyncHandlers.waitForChild(player, "PlayerGui"):andThen(function(PlayerGui: PlayerGui)
	New "ScreenGui"({
		Name = "PetInventory",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		Enabled = Open,

		[Children] = {
			require(script.Background),
			require(script.RightFrame),
			require(script.DeleteConfirm),
		},
	}).Parent =
		PlayerGui
end)

return 0
