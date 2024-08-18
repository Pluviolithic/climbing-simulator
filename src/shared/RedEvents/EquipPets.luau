local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local petIndicesCheck = Guard.List(Guard.Number)

return Red.Event("EquipPets", function(petIndices)
	return petIndicesCheck(petIndices)
end)
