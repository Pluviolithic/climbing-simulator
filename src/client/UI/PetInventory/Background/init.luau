local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Children = Fusion.Children

return New("ImageLabel")({
	Name = "Background",
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	Image = "http://www.roblox.com/asset/?id=16865012439",
	Position = UDim2.fromScale(0.235, 0.197),
	Size = UDim2.fromScale(0.53, 0.655),

	[Children] = {
		require(script.PetFrame),
	},
})
