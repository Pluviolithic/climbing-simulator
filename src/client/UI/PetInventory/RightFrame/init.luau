local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children

return New "Frame" {
	Name = "RightFrame",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Position = UDim2.fromScale(0.605, 0.336),
	Size = UDim2.fromScale(0.146, 0.492),

	[Children] = {
		require(script.DeleteFrame),
		require(script.SelectionFrame),
	},
}
