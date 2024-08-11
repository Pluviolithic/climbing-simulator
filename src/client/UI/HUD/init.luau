local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children

local statDisplay = require(script.StatDisplay)

New("ScreenGui")({
	Name = "HUD",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

	[Children] = {
		statDisplay({
			Name = "Strength",
			Icon = "http://www.roblox.com/asset/?id=16822848077",
			Size = UDim2.fromScale(0.123, 0.0735),
			Position = UDim2.fromScale(0.319, 0.0181),
		}),
		statDisplay({
			Name = "Wins",
			Icon = "http://www.roblox.com/asset/?id=16632906526",
			Size = UDim2.fromScale(0.1, 0.0735),
			Position = UDim2.fromScale(0.465, 0.018),
		}),
		statDisplay({
			Name = "Rebirths",
			Icon = "http://www.roblox.com/asset/?id=16632905202",
			Size = UDim2.fromScale(0.0971, 0.0735),
			Position = UDim2.fromScale(0.583, 0.0181),
		}),
	},
}).Parent =
	game.Players.LocalPlayer.PlayerGui

return 0
