local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local petTemplate = require(script.PetTemplate)
local selectors = require(ReplicatedStorage.Common.Selectors)
local Types = require(ReplicatedStorage.Common.Slices.Players.Types)
local producer = require(StarterPlayer.StarterPlayerScripts.Client.Producer)
local Fusion = require(ReplicatedStorage.Common.lib.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local ForValues = Fusion.ForValues
local Children = Fusion.Children

local player = Players.LocalPlayer
local playerPets: Fusion.Value<Types.PlayerPets> = Value({})
local playerPetButtons = ForValues(playerPets, function(pet)
	return petTemplate({
		PetName = (pet :: Types.Pet).Name,
	})
end, function(petButton)
	petButton:Destroy()
end)

producer:subscribe(selectors.selectPlayerPets(player.Name), function(pets)
	playerPets:set(pets)
end)

return New("ScrollingFrame")({
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
		New("UIGridLayout")({
			Name = "UIGridLayout",
			CellPadding = UDim2.fromScale(0.015, 0.025),
			CellSize = UDim2.fromScale(0.234, 0.32),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		playerPetButtons :: any,
	},
})
