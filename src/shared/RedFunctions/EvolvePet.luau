local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local petIdCheck = Guard.Optional(Guard.Number)

return Red.Function("EvolvePet", petIdCheck, petIdCheck)
