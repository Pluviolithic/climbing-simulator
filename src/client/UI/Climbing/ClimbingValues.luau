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

local SpeedMultiplier = Computed(function()
	local clickCount = ClickCount:get()
	local prevMultiplier = 1
	local meterLevelCount = #meterLevels:GetChildren()
	for i = 1, meterLevelCount do
		local level = meterLevels[tostring(i)]
		if clickCount >= level.Clicks.Value then
			if meterLevelCount == i then
				return level.Multiplier.Value
			end
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
	local meterLevelCount = #meterLevels:GetChildren()
	for i = 1, meterLevelCount do
		local level = meterLevels[tostring(i)]
		if clickCount >= level.Clicks.Value then
			if meterLevelCount == i then
				return 1
			end
			clickCount -= level.Clicks.Value
		else
			return clickCount / level.Clicks.Value
		end
	end
	return 0
end)

local MeterText = Computed(function()
	local clickCount = ClickCount:get()
	local meterLevelCount = #meterLevels:GetChildren()
	for i = 1, meterLevelCount do
		local level = meterLevels[tostring(i)]
		if clickCount >= level.Clicks.Value then
			if meterLevelCount == i then
				return level.HypeText.Value :: string
			end
			clickCount -= level.Clicks.Value
		else
			return level.HypeText.Value :: string
		end
	end
	return ""
end)

return {
	MapName = MapName,
	MeterText = MeterText,
	Climbing = Climbing,
	ClickCount = ClickCount,
	ClimbTarget = ClimbTarget,
	ClimbProgress = ClimbProgress,
	ClickProgress = ClickProgress,
	SpeedMultiplier = SpeedMultiplier,
}
