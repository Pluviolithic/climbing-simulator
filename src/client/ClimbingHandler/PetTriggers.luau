local CollectionService = game:GetService "CollectionService"
local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local SetPetsVisibility = require(ReplicatedStorage.Common.RedEvents.SetPetsVisibility)
local Producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local Selectors = require(ReplicatedStorage.Common.Selectors)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local ClimbingValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.Climbing.ClimbingValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Janitor = require(ReplicatedStorage.Common.lib.Janitor)

local Observer = Fusion.Observer

local MapName = ClimbingValues.MapName
local Climbing = ClimbingValues.Climbing

local player = Players.LocalPlayer

return function(currentNode)
	local obliterator = Janitor.new()

	Observer(Climbing):onChange(function()
		if Climbing:get() then
			SetPetsVisibility:Client():Fire(false)
		else
			SetPetsVisibility:Client():Fire(true)
			obliterator:Cleanup()
		end
	end)

	Observer(MapName):onChange(function()
		local mapName = MapName:get()
		if not mapName then
			return
		end

		local petTriggers = table.create(3)
		for _, object in ipairs(CollectionService:GetTagged(mapName)) do
			local tags = CollectionService:GetTags(object)
			for _, tag in ipairs(tags) do
				if tag:match "PetTrigger" then
					petTriggers[tonumber(tag:match "%d+") :: number] = object
				end
			end
		end

		local petModels = {}
		for _, pet: Types.Pet in
			ipairs(Producer:getState(Selectors.selectPlayerPets(player.Name)) :: any)
		do
			local petModel = (PetUtils.getPet(pet.Name) :: PetUtils.PetModel):Clone()
			obliterator:Add(petModel)
			table.insert(petModels, petModel)
		end

		table.sort(petModels, function(petA, petB)
			return petA.Multiplier.Value > petB.Multiplier.Value
		end)

		for idx, trigger in ipairs(petTriggers) do
			local petModel = petModels[idx]
			if not petModel or not petModel.PrimaryPart then
				return
			end

			petModel.PrimaryPart:ClearAllChildren()
			petModel.PrimaryPart.Anchored = true
			petModel.PrimaryPart.CFrame = trigger.Part.CFrame
			petModel.PrimaryPart.Position += Vector3.yAxis
			petModel.PrimaryPart.Parent = workspace
		end
	end)

	Observer(currentNode):onChange(function()
		local node = currentNode:get()
		if not node then
			return
		end
	end)
end
