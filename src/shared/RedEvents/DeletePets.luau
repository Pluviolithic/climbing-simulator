local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local petIdsCheck = Guard.List(Guard.Number)

return Red.Event("DeletePets", function(petIds)
	return petIdsCheck(petIds)
end)
