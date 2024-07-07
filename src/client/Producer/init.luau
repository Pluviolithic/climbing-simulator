local ReplicatedStorage = game:GetService("ReplicatedStorage")

local slices = require(ReplicatedStorage.Common.Slices)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)

export type RootProducer = Reflex.Producer<RootState, RootActions>

export type RootState = slices.SharedState

type RootActions = slices.SharedActions

-- selene: allow(manual_table_clone)
local rootSlices = {}

for name, slice in pairs(slices) do
	rootSlices[name] = slice
end

return Reflex.combineProducers(rootSlices) :: RootProducer
