local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local Value = Fusion.Value
local Computed = Fusion.Computed

local meterLevels = ReplicatedStorage.Config.SpeedMeterLevels

local MapName: Fusion.Value<string> = Value "Tree"
local Climbing: Fusion.Value<boolean> = Value(false)
local ClimbProgress: Fusion.Value<number> = Value(0)
local ClimbTarget: Fusion.Value<number?> = Value(nil)
local ClickCount: Fusion.Value<number> = Value(0)
local NextClimbLength: Fusion.Value<number> = Value(0)

local SpeedMultiplier = Computed(function()
	local clickCount = ClickCount:get()
	local prevMultiplier = 1
	for i = 1, #meterLevels:GetChildren() do
		local level = meterLevels[tostring(i)]
		if clickCount >= level.Clicks.Value then
			clickCount -= level.Clicks.Value
			prevMultiplier = level.Multiplier.Value
		else
			return prevMultiplier
		end
	end
	return 1
end)

local ClickProgress = Computed(function()
	local clickCount = ClickCount:get()
	for i = 1, #meterLevels:GetChildren() do
		local level = meterLevels[tostring(i)]
		if clickCount >= level.Clicks.Value then
			clickCount -= level.Clicks.Value
		else
			return clickCount / level.Clicks.Value
		end
	end
	return 0
end)

return {
	MapName = MapName,
	Climbing = Climbing,
	ClickCount = ClickCount,
	ClimbTarget = ClimbTarget,
	ClimbProgress = ClimbProgress,
	ClickProgress = ClickProgress,
	NextClimbLength = NextClimbLength,
	SpeedMultiplier = SpeedMultiplier,
}
