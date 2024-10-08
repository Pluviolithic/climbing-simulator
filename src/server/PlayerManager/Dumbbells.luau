local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local Selectors = require(ReplicatedStorage.Common.Selectors)
local Janitor = require(ReplicatedStorage.Common.lib.Janitor)
local Producer = require(ServerScriptService.Server.Producer)

Producer:observe(Selectors.selectDumbbells, Selectors.selectPlayerName, function(_, index)
	local DumbbellObject
	local player = Players:FindFirstChild(index) :: Player
	local obliterator = Janitor.new()

	local function equipDumbbell(character)
		if not DumbbellObject then
			return
		end
		local Dumbbell = DumbbellObject:Clone()
		Dumbbell.Parent = character
	end

	local initialDumbell = Producer:getState(Selectors.selectEquippedDumbbell(player.Name))
	if initialDumbell then
		DumbbellObject = ReplicatedStorage.Dumbbells:FindFirstChild(initialDumbell, true)
		if player.Character then
			equipDumbbell(player.Character)
		end
	end

	local unsubscribe = Producer:subscribe(
		Selectors.selectEquippedDumbbell(index),
		function(equippedDumbbell)
			if not equippedDumbbell then
				return
			end
			DumbbellObject = ReplicatedStorage.Dumbbells[equippedDumbbell]
			if player.Character then
				equipDumbbell(player.Character)
			end
		end
	)

	obliterator:Add(player.CharacterAdded:Connect(function(character)
		equipDumbbell(character)
	end))

	return function()
		obliterator:Destroy()
		unsubscribe()
	end
end)

return 0
