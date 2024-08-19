local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local petIdCheck = Guard.Number

return Red.Event("EquipPet", function(petId)
	return petIdCheck(petId)
end)
