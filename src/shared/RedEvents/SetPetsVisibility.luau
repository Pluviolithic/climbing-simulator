local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local visibilityCheck = Guard.Boolean

return Red.Event("SetPetsVisibility", function(visible)
	return visibilityCheck(visible)
end)
