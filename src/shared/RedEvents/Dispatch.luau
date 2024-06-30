local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.Guard)

local actionCheck = Guard.List(Guard.Map(Guard.String, Guard.Any))

return Red.Event("dispatch", function(actions)
	return actionCheck(actions)
end)
