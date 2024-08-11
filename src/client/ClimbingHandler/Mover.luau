local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local Observer = Fusion.Observer

local player = Players.LocalPlayer

local function getHipAttachment(): Attachment?
	local rootPart = if player.Character
		then player.Character:FindFirstChild("HumanoidRootPart")
		else nil

	if not rootPart then
		return nil
	end

	return rootPart:FindFirstChild("RootRigAttachment")
end

local function getOrCreateConstraints(attachment: Attachment): (AlignPosition, AlignOrientation)
	local alignPosition = attachment:FindFirstChild("AlignPosition") :: AlignPosition?
	local alignOrientation = attachment:FindFirstChild("AlignOrientation") :: AlignOrientation?

	if not alignPosition then
		alignPosition = Instance.new("AlignPosition")
		alignPosition.RigidityEnabled = true
		alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
		alignPosition.Position = attachment.WorldCFrame.Position
		alignPosition.Attachment0 = attachment
		alignPosition.Parent = attachment
	end

	if not alignOrientation then
		alignOrientation = Instance.new("AlignOrientation")
		alignOrientation.RigidityEnabled = true
		alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		alignOrientation.CFrame = attachment.WorldCFrame
		alignOrientation.Attachment0 = attachment
		alignOrientation.Parent = attachment
	end

	return alignPosition, alignOrientation
end

return function(node: Fusion.Value<BasePart?>, completed: () -> ())
	local currentOverride: number? = nil
	Observer(node):onChange(function()
		local nodeObj = node:get()
		local attachment = getHipAttachment()

		if not attachment then
			return
		end

		if not nodeObj then
			local alignPosition, alignOrientation = getOrCreateConstraints(attachment)
			alignPosition:Destroy()
			alignOrientation:Destroy()
			return
		end

		local humanoid = player.Character.Humanoid
		local mapName = (nodeObj.Parent :: Instance).Name
		local timeValue = ReplicatedStorage.Config.MapTimes[`{mapName}TimePerStud`].Value

		local goalPosition = nodeObj.Position + Vector3.yAxis * humanoid.HipHeight
		local alignPosition, alignOrientation = getOrCreateConstraints(attachment)

		local tweenPosition = TweenService:Create(
			alignPosition,
			TweenInfo.new(
				(attachment.WorldCFrame.Position - goalPosition).Magnitude
					* (currentOverride or timeValue),
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
					/ 2
			),
			{
				CFrame = nodeObj.CFrame,
			}
		)

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

		tweenOrientation:Destroy()
		tweenPosition:Destroy()

		local override = tonumber(nodeObj:GetAttribute("Override") :: string?)

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
