local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local ClimbingValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.Climbing.ClimbingValues)
local AsyncHandlers = require(ReplicatedStorage.Common.Utils.Player.AsyncHandlers)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Zone = require(ReplicatedStorage.Common.lib.ZonePlus)

local Value = Fusion.Value

local Climbing = ClimbingValues.Climbing
local ClimbProgress = ClimbingValues.ClimbProgress

local nextNode: Fusion.Value<BasePart?> = Value(nil)
local currentNode: Fusion.Value<BasePart?> = Value(nil)

local function cleanup()
	if not Climbing:get() then
		return
	end

	nextNode:set(nil)
	currentNode:set(nil)
	Climbing:set(false)
	ClimbProgress:set(0)

	ClimbingValues.ClickCount:set(0)
	ClimbingValues.ClickCount:set(0)
	ClimbingValues.ClimbTarget:set(nil)
end

require(script.Animator)(currentNode)
require(script.Mover)(nextNode, function()
	if not Climbing:get() then
		return
	end

	local nextNodeObj = nextNode:get()

	if not nextNodeObj then
		cleanup()
		return
	end

	local nextNodeIndex = tonumber(nextNodeObj.Name) :: number
	local newNextNode = (nextNodeObj.Parent :: Folder):FindFirstChild(tostring(nextNodeIndex + 1))

	--TODO: Do win condition stuff when newNextNode is nil && node index is last
	-- Also some checkpoint stuff here?

	currentNode:set(nextNode:get())
	nextNode:set(newNextNode)
end)

AsyncHandlers.waitForChild(workspace.AreaStartModels, "TreeClimbStart"):andThen(function()
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

			Climbing:set(true)

			task.wait(0.5)
			debounce = false
		end)
	end
end)

return {
	Cancel = cleanup,
	CurrentNode = currentNode,
	NextNode = nextNode,
}
