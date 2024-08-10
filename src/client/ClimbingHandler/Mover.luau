local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local Observer = Fusion.Observer

local player = Players.LocalPlayer

local function getHipAttachment(): Attachment?
	local rootPart = if player.Character then player.Character.RootPart else nil

	if not rootPart then
		return nil
	end

	return rootPart:FindFirstChild("RootRigAttachment")
end

local function getOrCreateConstraints(attachment: Attachment): (AlignPosition, AlignOrientation)
	local alignPosition = attachment:FindFirstChild("AlignPosition")
	local alignOrientation = attachment:FindFirstChild("AlignOrientation")

	if not alignPosition then
		alignPosition = Instance.new("AlignPosition")
		alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
		alignPosition.Position = attachment.WorldCFrame.Position
		alignPosition.Attachment0 = attachment
		alignPosition.Parent = attachment
	end

	if not alignOrientation then
		alignOrientation = Instance.new("AlignOrientation")
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

		if not nodeObj or not attachment then
			return
		end

		local humanoid = player.Character.Humanoid
		local mapName = (nodeObj.Parent :: Instance).Name
		local timeValue = ReplicatedStorage.Config.MapTimes[`{mapName}TimePerStud`].Value

		local override = tonumber(nodeObj:GetAttribute("Override") :: string?)

		if override then
			if override == 0 then
				currentOverride = nil
			else
				currentOverride = override
			end
		end

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

		tweenPosition:Play()
		tweenOrientation:Play()

		tweenPosition.Completed:Wait()

		tweenOrientation:Destroy()
		tweenPosition:Destroy()

		completed()
	end)
end
