local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local actionsCheck = Guard.List(Guard.Map(Guard.String, Guard.Any))

return Red.Event("Dispatch", function(actions)
	return actionsCheck(actions)
end)
