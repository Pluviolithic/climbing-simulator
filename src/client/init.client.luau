local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)

local player = Players.LocalPlayer

local function selectStrength(state: producer.RootState)
	if state.Stats[player.Name] then
		return state.Stats[player.Name].Strength
	else
		return 0
	end
end

producer:subscribe(selectStrength, function(strength)
	print("Strength:", strength)
end)

require(StarterPlayer.StarterPlayerScripts.Client.ReflexReceiver)
