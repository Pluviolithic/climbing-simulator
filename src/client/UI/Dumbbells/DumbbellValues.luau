local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local Selectors = require(ReplicatedStorage.Common.Selectors)
local Producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local Value = Fusion.Value

local player = Players.LocalPlayer

local Enabled: Fusion.Value<boolean> = Value(false)
local PlayerStrength: Fusion.Value<number> = Value(0)
local EquippedDumbbell: Fusion.Value<string> = Value "2"

Producer:subscribe(Selectors.selectPlayerStatValue(player.Name, "Strength"), function(strength)
	PlayerStrength:set(strength)
end)

Producer:subscribe(Selectors.selectEquippedDumbbell(player.Name), function(dumbbell)
	EquippedDumbbell:set(dumbbell)
end)

return {
	Enabled = Enabled,
	PlayerStrength = PlayerStrength,
	EquippedDumbbell = EquippedDumbbell,
}
