local Players = game:GetService "Players"
local CollectionService = game:GetService "CollectionService"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Promise = require(ReplicatedStorage.Common.lib.Promise)
local Janitor = require(ReplicatedStorage.Common.lib.Janitor)

local Observer = Fusion.Observer

local player = Players.LocalPlayer
local animationsArray = ReplicatedStorage.ClimbAnimations:GetChildren()

local defaultStateValues = {}

AsyncHandlers.getCharacter(player):andThen(function(character)
	AsyncHandlers.waitForChild(character, "Humanoid"):andThen(function(humanoid)
		for _, humanoidStateType in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
			if humanoidStateType == Enum.HumanoidStateType.None then
				continue
			end

			defaultStateValues[humanoidStateType] = humanoid:GetStateEnabled(humanoidStateType)
		end
	end)
end)

local function disableAllStates(humanoid: Humanoid, ignoreList: { Enum.HumanoidStateType })
	for humanoidStateType in pairs(defaultStateValues) do
		if table.find(ignoreList, humanoidStateType) then
			continue
		end
		humanoid:SetStateEnabled(humanoidStateType, false)
	end
end

local function resetAllStates(humanoid: Humanoid)
	for humanoidStateType, defaultValue in pairs(defaultStateValues) do
		humanoid:SetStateEnabled(humanoidStateType, defaultValue)
	end
end

local function loadAnimations()
	return Promise.new(function(resolve)
		local animations: { [string]: string } = {
			WalkAnimation = "rbxassetid://507767714",
			ClimbAnimation = "rbxassetid://507765644",
		}

		local success, humanoidDescription =
			pcall(Players.GetHumanoidDescriptionFromUserId, Players, player.UserId)

		if not success then
			humanoidDescription = Instance.new "HumanoidDescription"
		end

		for _, animation in ipairs(animationsArray) do
			animations[animation.Name] = animation.AnimationId
		end

		for _, node in ipairs(workspace.Nodes:GetDescendants()) do
			local _, animationName = next(CollectionService:GetTags(node))

			if not animationName then
				continue
			end

			local customAnimation = ReplicatedStorage.ClimbAnimations:FindFirstChild(animationName)

			if customAnimation then
				animations[animationName] = customAnimation.AnimationId
			elseif humanoidDescription[animationName] ~= 0 then
				animations[animationName] = humanoidDescription[animationName]
			end
		end

		resolve(animations, success)
	end)
end

return function(node: Fusion.Value<BasePart?>): ()
	loadAnimations():andThen(function(animations, success)
		local lastNode = nil
		local lastAnimationName = nil
		local obliterator = Janitor.new()

		Observer(node):onChange(function()
			if node:get() == nil then
				obliterator:Cleanup()
				lastAnimationName = nil
				return
			end

			local humanoid = if player.Character
				then player.Character:FindFirstChild "Humanoid"
				else nil
			local animator: Animator? = if humanoid
				then humanoid:FindFirstChild "Animator" :: Animator
				else nil

			if not animator then
				return
			end

			disableAllStates(humanoid, { Enum.HumanoidStateType.Flying })

			if not success then
				local humanoidDescription = humanoid:FindFirstChild "HumanoidDescription"

				if humanoidDescription then
					for animationName in pairs(animations) do
						if humanoidDescription[animationName] ~= 0 then
							animations[animationName] =
								`rbxassetid://{humanoidDescription[animationName]}`
						end
					end
					success = true
				end
			end

			if not lastNode then
				lastNode = node:get()
				obliterator:Add(function()
					for _, animationTrack in ipairs(animator:GetPlayingAnimationTracks()) do
						animationTrack:Stop()
					end
					resetAllStates(humanoid)
				end, true)
				return
			end

			local _, animationName = next(CollectionService:GetTags(lastNode))

			if animationName and animationName ~= lastAnimationName then
				obliterator:Cleanup()

				for _, animationTrack in ipairs(animator:GetPlayingAnimationTracks()) do
					animationTrack:Stop()
				end

				local newAnimation = Instance.new "Animation"

				obliterator:Add(newAnimation)
				newAnimation.AnimationId = animations[animationName]

				local animationTrack = animator:LoadAnimation(newAnimation)

				obliterator:Add(animationTrack)
				animationTrack.Looped = true
				animationTrack.Priority = Enum.AnimationPriority.Action
				animationTrack:Play()

				lastAnimationName = animationName
			end

			lastNode = node:get()
		end)
	end)
end
