local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local selectors = require(ReplicatedStorage.Common.Selectors)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local Value = Fusion.Value

local player = Players.LocalPlayer

export type petAndIdx = {
	Idx: number,
	Pet: Types.Pet,
}

local DeleteModeEnabled: Fusion.Value<boolean> = Value(false)
local PlayerPets: Fusion.Value<Types.PlayerPets> = Value {}
local SelectedPetData: Fusion.Value<petAndIdx?> = Value(nil)
local PetsToDelete: Fusion.Value<{ number }> = Value {}
local ConfirmingDelete: Fusion.Value<boolean> = Value(false)

producer:subscribe(selectors.selectPlayerPets(player.Name), function(pets)
	PlayerPets:set(pets)
end)

return {
	DeleteModeEnabled = DeleteModeEnabled,
	PlayerPets = PlayerPets,
	SelectedPetData = SelectedPetData,
	PetsToDelete = PetsToDelete,
	ConfirmingDelete = ConfirmingDelete,
}
