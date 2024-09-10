local ReplicatedStorage = game:GetService "ReplicatedStorage"

local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Zone = require(ReplicatedStorage.Common.lib.ZonePlus)

local Value = Fusion.Value

local nextNode: Fusion.Value<BasePart?> = Value(nil)
local currentNode: Fusion.Value<BasePart?> = Value(nil)

require(script.Animator)(currentNode)
require(script.Mover)(nextNode, function()
	local nextNodeObj = nextNode:get()

	if not nextNodeObj then
		return
	end

	local nextNodeIndex = tonumber(nextNodeObj.Name) :: number
	local newNextNode = (nextNodeObj.Parent :: Folder):FindFirstChild(tostring(nextNodeIndex + 1))

	--TODO: Do win condition stuff when newNextNode is nil

	currentNode:set(nextNode:get())
	nextNode:set(newNextNode)
end)

AsyncHandlers.waitForChild(workspace.AreaStartModels, "ForestClimbStart"):andThen(function()
	for _, startModel in ipairs(workspace.AreaStartModels:GetChildren()) do
		local zone = Zone.new(startModel)
		local debounce = false

		zone.localPlayerEntered:Connect(function()
			if debounce then
				return
			end
			debounce = true

			-- TODO: Check for permissions / stats / whatever to do the climb

			local nodes = workspace.Nodes[startModel.Name:match "(%w+)C"]
			nextNode:set(nodes["1"])
			currentNode:set(nodes["1"])

			task.wait(0.5)
			debounce = false
		end)
	end
end)

return {
	Cancel = function()
		nextNode:set(nil)
	end,
}
