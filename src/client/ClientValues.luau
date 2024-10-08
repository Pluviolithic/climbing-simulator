local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local Value = Fusion.Value

local MapName: Fusion.Value<string?> = Value(nil)

return {
	MapName = MapName,
}
