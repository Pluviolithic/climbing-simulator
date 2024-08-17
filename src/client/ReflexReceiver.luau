local StarterPlayer = game:GetService "StarterPlayer"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local Reflex = require(ReplicatedStorage.Common.lib.Reflex)

local start = require(ReplicatedStorage.Common.RedEvents.Start):Client()
local dispatch = require(ReplicatedStorage.Common.RedEvents.Dispatch):Client()

local receiver = Reflex.createBroadcastReceiver {
	start = function()
		start:Fire()
		return
	end,
}

dispatch:On(function(actions)
	receiver:dispatch(actions)
end)

producer:applyMiddleware(receiver.middleware)

return 0
