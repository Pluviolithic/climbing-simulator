local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local PetInventoryValues =
	require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.PetInventoryValues)
local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local MenuOpener = require(script.MenuOpener)
local StatDisplay = require(script.StatDisplay)

local New = Fusion.New
local Children = Fusion.Children
local PetInventoryOpen = PetInventoryValues.Open

local player = Players.LocalPlayer

AsyncHandlers.waitForChild(player, "PlayerGui"):andThen(function(PlayerGui: PlayerGui)
	New "ScreenGui"({
		Name = "HUD",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		[Children] = {
			StatDisplay {
				Name = "Strength",
				Icon = "http://www.roblox.com/asset/?id=16822848077",
				Size = UDim2.fromScale(0.123, 0.0735),
				Position = UDim2.fromScale(0.319, 0.0181),
			},
			StatDisplay {
				Name = "Wins",
				Icon = "http://www.roblox.com/asset/?id=16632906526",
				Size = UDim2.fromScale(0.1, 0.0735),
				Position = UDim2.fromScale(0.465, 0.018),
			},
			StatDisplay {
				Name = "Rebirths",
				Icon = "http://www.roblox.com/asset/?id=16632905202",
				Size = UDim2.fromScale(0.0971, 0.0735),
				Position = UDim2.fromScale(0.583, 0.018),
			},
			MenuOpener {
				Text = "Pets",
				Size = UDim2.fromScale(0.058, 0.099),
				Position = UDim2.fromScale(0.0705, 0.442),
				IconSize = UDim2.fromScale(1, 1),
				IconImage = "http://www.roblox.com/asset/?id=16822536581",
				Callback = function()
					PetInventoryOpen:set(not PetInventoryOpen:get())
				end,
			},
			MenuOpener {
				Text = "VIP",
				Size = UDim2.fromScale(0.058, 0.099),
				Position = UDim2.fromScale(0.0705, 0.678),
				IconSize = UDim2.fromScale(0.597, 0.637),
				IconPosition = UDim2.fromScale(0.201, 0.17),
				IconImage = "http://www.roblox.com/asset/?id=16821694685",
				Callback = function() end,
			},
			MenuOpener {
				Text = "Store",
				Size = UDim2.fromScale(0.058, 0.099),
				Position = UDim2.fromScale(0.00694, 0.442),
				IconSize = UDim2.fromScale(1, 1),
				IconImage = "http://www.roblox.com/asset/?id=16821898354",
				Callback = function()
					PetInventoryOpen:set(not PetInventoryOpen:get())
				end,
			},
			MenuOpener {
				Text = "Rebirth",
				Size = UDim2.fromScale(0.058, 0.099),
				Position = UDim2.fromScale(0.007, 0.555),
				IconSize = UDim2.fromScale(0.632, 0.637),
				IconPosition = UDim2.fromScale(0.184, 0.181),
				IconImage = "http://www.roblox.com/asset/?id=16632905202",
				Callback = function() end,
			},
			MenuOpener {
				Text = "Teleport",
				Size = UDim2.fromScale(0.058, 0.099),
				Position = UDim2.fromScale(0.07, 0.555),
				IconSize = UDim2.fromScale(1, 1),
				IconImage = "http://www.roblox.com/asset/?id=16821993560",
				Callback = function() end,
			},
			MenuOpener {
				Text = "Invite",
				Size = UDim2.fromScale(0.058, 0.099),
				Position = UDim2.fromScale(0.007, 0.678),
				IconSize = UDim2.fromScale(0.632, 0.567),
				IconPosition = UDim2.fromScale(0.21, 0.216),
				IconImage = "http://www.roblox.com/asset/?id=16821455743",
				Callback = function() end,
			},
		},
	}).Parent =
		PlayerGui
end)

return 0
