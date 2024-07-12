local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Promise = require(ReplicatedStorage.Common.lib.Promise)

local function waitForChild(parent: Instance, name: string)
	return Promise.new(function(resolve)
		resolve(parent:WaitForChild(name))
	end)
end

local function waitForPlayerStats(player: Player)
	return Promise.new(function(resolve) end)
end

return {
	waitForChild = waitForChild,
}
