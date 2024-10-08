local Players = game:GetService "Players"
local TweenService = game:GetService "TweenService"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local RunService = game:GetService "RunService"
local StarterPlayer = game:GetService "StarterPlayer"

local ClientValues = require(StarterPlayer.StarterPlayerScripts.Client.ClientValues)
local ClimbingValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.Climbing.ClimbingValues)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Janitor = require(ReplicatedStorage.Common.lib.Janitor)

local Value = Fusion.Value
local Observer = Fusion.Observer

local NextNode: Fusion.Value<BasePart?> = Value(nil)
local MapName = ClientValues.MapName
local Climbing = ClimbingValues.Climbing
local ClimbTarget = ClimbingValues.ClimbTarget
local ClimbProgress = ClimbingValues.ClimbProgress
local SpeedMultiplier = ClimbingValues.SpeedMultiplier

local areaData = ReplicatedStorage.Config.AreaData

local player = Players.LocalPlayer

local function getHipAttachment(): Attachment?
	local rootPart = if player.Character
		then player.Character:FindFirstChild "HumanoidRootPart"
		else nil

	if not rootPart then
		return nil
	end

	return rootPart:FindFirstChild "RootRigAttachment"
end

local function getOrCreateConstraints(attachment: Attachment): (AlignPosition, AlignOrientation)
	local alignPosition: any = attachment:FindFirstChild "AlignPosition"
	local alignOrientation: any = attachment:FindFirstChild "AlignOrientation"

	if not alignPosition then
		alignPosition = Instance.new "AlignPosition"
		alignPosition.RigidityEnabled = true
		alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
		alignPosition.Position = attachment.WorldCFrame.Position
		alignPosition.Attachment0 = attachment
		alignPosition.Parent = attachment
	end

	if not alignOrientation then
		alignOrientation = Instance.new "AlignOrientation"
		alignOrientation.RigidityEnabled = true
		alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		alignOrientation.CFrame = attachment.WorldCFrame
		alignOrientation.Attachment0 = attachment
		alignOrientation.Parent = attachment
	end

	return alignPosition, alignOrientation
end

local connection
Observer(Climbing):onChange(function()
	if Climbing:get() then
		local nodes = workspace.Nodes[MapName:get()]
		local nodeCount = #nodes:GetChildren()
		local distances = table.create(nodeCount)
		local currentDistance = 0

		distances[1] = 0
		for i = 2, nodeCount do
			currentDistance += (nodes[i - 1].Position - nodes[i].Position).Magnitude
			distances[i] = currentDistance
		end

		ClimbTarget:set(currentDistance)

		connection = RunService.RenderStepped:Connect(function()
			local node = NextNode:get()
			if not node then
				ClimbProgress:set(currentDistance)
				return
			end

			local attachment = getHipAttachment()
			local humanoid = if player.Character
				then player.Character:FindFirstChild "Humanoid"
				else nil

			if not humanoid or not attachment then
				return
			end

			local goalPosition = node.Position + Vector3.yAxis * humanoid.HipHeight
			ClimbProgress:set(
				distances[tonumber(node.Name) :: number]
					- (goalPosition - attachment.WorldPosition).Magnitude
			)
		end)
	elseif connection then
		connection:Disconnect()
	end
end)

return function(node: Fusion.Value<BasePart?>, completed: () -> ())
	local obliterator = Janitor.new()
	local currentOverride: number? = nil

	Observer(Climbing):onChange(function()
		if not Climbing:get() then
			obliterator:Cleanup()
		end
	end)

	Observer(node):onChange(function()
		local nodeObj = node:get()
		local attachment = getHipAttachment()

		NextNode:set(node:get())

		if not attachment then
			completed()
			currentOverride = nil
			return
		end

		if not nodeObj then
			local alignPosition, alignOrientation = getOrCreateConstraints(attachment)
			alignPosition:Destroy()
			alignOrientation:Destroy()
			currentOverride = nil
			completed()
			return
		end

		local humanoid = player.Character.Humanoid
		local mapName = (nodeObj.Parent :: Instance).Name
		local timeValue = areaData[mapName].TimePerStud.Value

		local goalPosition = nodeObj.Position + Vector3.yAxis * humanoid.HipHeight
		local alignPosition, alignOrientation = getOrCreateConstraints(attachment)

		local tweenPosition = TweenService:Create(
			alignPosition,
			TweenInfo.new(
				(attachment.WorldCFrame.Position - goalPosition).Magnitude
					* (currentOverride or timeValue)
					/ SpeedMultiplier:get(),
				Enum.EasingStyle.Linear
			),
			{
				Position = goalPosition,
			}
		)
		local tweenOrientation = TweenService:Create(
			alignOrientation,
			TweenInfo.new(
				(attachment.WorldCFrame.Position - goalPosition).Magnitude
					* (currentOverride or timeValue)
					/ SpeedMultiplier:get()
					/ 2
			),
			{
				CFrame = nodeObj.CFrame,
			}
		)

		obliterator:Add(tweenPosition)
		obliterator:Add(tweenOrientation)

		if nodeObj.Name == "1" then
			alignPosition.Position = goalPosition
			alignOrientation.CFrame = nodeObj.CFrame

			humanoid.RootPart:PivotTo(
				CFrame.new(goalPosition) * (nodeObj.CFrame - nodeObj.CFrame.Position)
			)

			task.wait(0.5)
		else
			tweenPosition:Play()
			tweenOrientation:Play()

			tweenPosition.Completed:Wait()
		end

		obliterator:Cleanup()

		local override = tonumber(nodeObj:GetAttribute "Override" :: string?)

		if override then
			if override == 0 then
				currentOverride = nil
			else
				currentOverride = override
			end
		end

		completed()
	end)
end
