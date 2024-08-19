local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local petIdCheck = Guard.Optional(Guard.Number)

local function petNameAndIdCheck(petName, petId)
	return Guard.String(petName), Guard.Number(petId)
end

return Red.Function("EvolvePet", petNameAndIdCheck, petIdCheck)
