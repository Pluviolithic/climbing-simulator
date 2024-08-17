local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local petsCheck = Guard.List(Guard.Number)

return Red.Event("DeletePets", function(pets)
	return petsCheck(pets)
end)
