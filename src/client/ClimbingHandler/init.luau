local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Zone = require(ReplicatedStorage.Common.lib.ZonePlus)

local Value = Fusion.Value

local node: Fusion.Value<BasePart?> = Value(nil)

require(script.Animator)(node)
require(script.Mover)(node, function()
	local nodeObj = node:get()

	if not nodeObj then
		return
	end

	local nodeIndex = tonumber(nodeObj.Name) :: number
	local nextNode = (nodeObj.Parent :: Folder):FindFirstChild(tostring(nodeIndex + 1))

	--TODO: Do win condition stuff when nextNode is nil

	node:set(nextNode)
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

			local nodes = workspace.Nodes[startModel.Name:match("(%w+)C")]
			node:set(nodes["1"])

			task.wait(0.5)
			debounce = false
		end)
	end
end)

return {
	Cancel = function()
		node:set(nil)
	end,
}
