local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local finalCheck = Guard.Optional(Guard.Boolean)

return Red.Event("ReachedCheckpoint", function(isFinal)
	return finalCheck(isFinal)
end)
