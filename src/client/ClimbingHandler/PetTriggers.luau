local CollectionService = game:GetService "CollectionService"
local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"
local TextChatService = game:GetService "TextChatService"
local TweenService = game:GetService "TweenService"

local ClientValues = require(StarterPlayer.StarterPlayerScripts.Client.ClientValues)
local SetPetsVisibility = require(ReplicatedStorage.Common.RedEvents.SetPetsVisibility)
local Producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local Selectors = require(ReplicatedStorage.Common.Selectors)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local PetUtils = require(ReplicatedStorage.Common.Utils.Player.PetUtils)
local ClimbingValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.Climbing.ClimbingValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Janitor = require(ReplicatedStorage.Common.lib.Janitor)

local Observer = Fusion.Observer

local MapName = ClientValues.MapName
local Climbing = ClimbingValues.Climbing

local player = Players.LocalPlayer

local encouragingText = {
	"Keep going!",
	"Don't give up!",
	"Almost there!",
}

return function(currentNode)
	local obliterator = Janitor.new()
	local petTriggers = table.create(3)

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

		for _, object in ipairs(CollectionService:GetTagged(mapName)) do
			local tags = CollectionService:GetTags(object)
			for _, tag in ipairs(tags) do
				if tag:sub(1, 10) == "PetTrigger" then
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

			petModel.Name = "PetModel"
			petModel.PrimaryPart:ClearAllChildren()
			petModel.PrimaryPart.Anchored = true
			petModel.PrimaryPart.CFrame = trigger.Part.CFrame
			petModel.PrimaryPart.Position += Vector3.yAxis
			petModel.Parent = trigger
		end
	end)

	Observer(currentNode):onChange(function()
		local node = currentNode:get()
		if not node then
			return
		end

		local tags = CollectionService:GetTags(node)
		local triggerIndex

		for _, tag in ipairs(tags) do
			if tag:sub(1, 10) == "PetTrigger" then
				print "yes"
				triggerIndex = tonumber(tag:match "%d+")
			end
		end

		if not triggerIndex then
			return
		end

		local petModel = petTriggers[triggerIndex].PetModel
		local tweenUp = TweenService:Create(
			petModel.PrimaryPart,
			TweenInfo.new(0.25, Enum.EasingStyle.Linear),
			{ Position = petModel.PrimaryPart.Position + Vector3.yAxis }
		)
		local tweenBackDown = TweenService:Create(
			petModel.PrimaryPart,
			TweenInfo.new(0.125, Enum.EasingStyle.Linear),
			{ Position = petModel.PrimaryPart.Position }
		)
		local tween180 = TweenService:Create(
			petModel.PrimaryPart,
			TweenInfo.new(0.125, Enum.EasingStyle.Linear),
			{ CFrame = petModel.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(180), 0) }
		)
		local tween360 = TweenService:Create(
			petModel.PrimaryPart,
			TweenInfo.new(0.25, Enum.EasingStyle.Linear),
			{ CFrame = petModel.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(360), 0) }
		)

		obliterator:Add(tweenUp)
		obliterator:Add(tweenBackDown)
		obliterator:Add(tween180)
		obliterator:Add(tween360)

		TextChatService:DisplayBubble(petModel.PrimaryPart, encouragingText[triggerIndex])

		tweenUp:Play()
		tweenUp.Completed:Wait()
		tween180:Play()
		tween180.Completed:Wait()
		tween360:Play()
		tween360.Completed:Wait()
		tweenBackDown:Play()
	end)
end
