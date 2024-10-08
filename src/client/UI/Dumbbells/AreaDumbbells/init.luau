local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Dumbbell = require(script.Dumbbell)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local ForValues = Fusion.ForValues

return function(areaFolder)
	return New "ScrollingFrame" {
		Name = "Tree",
		Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(27, 42, 53),
		BorderSizePixel = 0,
		CanvasSize = UDim2.fromScale(0, 1),
		Position = UDim2.fromScale(0.0389, 0.199),
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		ScrollBarThickness = 5,
		Size = UDim2.fromScale(0.916, 0.748),
		ZIndex = 0,

		[Children] = {
			ForValues(areaFolder:GetChildren(), Dumbbell, function(_, dumbbellDisplay)
				(dumbbellDisplay :: any):Destroy()
			end) :: any,
			New "UIGridLayout" {
				Name = "UIGridLayout",
				CellPadding = UDim2.fromScale(0.01, 0.024),
				CellSize = UDim2.fromScale(0.92, 0.3),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
		},
	}
end
