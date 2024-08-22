local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local Value = Fusion.Value

local OpenMenuValue: Fusion.Value<Fusion.Value<boolean>?> = Value(nil)

return {
	OpenMenuValue = OpenMenuValue,
}
