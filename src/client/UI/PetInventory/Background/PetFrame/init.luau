local ReplicatedStorage = game:GetService "ReplicatedStorage"
local StarterPlayer = game:GetService "StarterPlayer"

local SharedValues = require(StarterPlayer.StarterPlayerScripts.Client.UI.PetInventory.SharedValues)
local petTemplate = require(script.PetTemplate)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local ForPairs = Fusion.ForPairs
local Children = Fusion.Children

local PlayerPets = SharedValues.PlayerPets

local playerPetButtons = ForPairs(PlayerPets, function(index, pet)
	return index, petTemplate {
		PetIndex = index,
		Pet = pet :: any,
	}
end, function(_, petButton)
	petButton:Destroy()
end)

return New "ScrollingFrame" {
	Name = "PetFrame",
	Active = true,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(27, 42, 53),
	BorderSizePixel = 0,
	CanvasSize = UDim2.fromScale(0, 1),
	Position = UDim2.fromScale(0.0323, 0.216),
	ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
	ScrollBarThickness = 5,
	Size = UDim2.fromScale(0.636, 0.722),

	[Children] = {
		New "UIGridLayout" {
			Name = "UIGridLayout",
			CellPadding = UDim2.fromScale(0.015, 0.025),
			CellSize = UDim2.fromScale(0.234, 0.32),
			SortOrder = Enum.SortOrder.Name,
		},
		playerPetButtons :: any,
	},
}
