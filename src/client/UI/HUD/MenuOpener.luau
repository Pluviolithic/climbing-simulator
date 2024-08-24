local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Fusion = require(ReplicatedStorage.Common.lib.Fusion)
local Ratelimit = require(ReplicatedStorage.Common.lib.Ratelimit)

local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

return function(props)
	local clickLimiter = Ratelimit(1, 0.25)
	return New "ImageButton" {
		Name = `{props.Text}Opener`,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(27, 42, 53),
		Image = "http://www.roblox.com/asset/?id=16821818232",
		Position = props.Position,
		Size = props.Size,

		[Children] = {
			New "ImageButton" {
				Name = "Icon",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Image = props.IconImage,
				Size = props.IconSize,
				Position = props.IconPosition,
				ZIndex = 0,

				[OnEvent "Activated"] = function()
					if not clickLimiter "Button" then
						return
					end
					props.Callback()
				end,
			},

			New "TextLabel" {
				Name = "Text",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				FontFace = Font.new "rbxasset://fonts/families/FredokaOne.json",
				Position = UDim2.fromScale(-0.078, 0.83),
				Size = UDim2.fromScale(1.16, 0.261),
				Text = props.Text,
				TextColor3 = Color3.fromRGB(253, 253, 253),
				TextScaled = true,
				TextSize = 14,
				TextStrokeColor3 = Color3.fromRGB(30, 30, 30),
				TextStrokeTransparency = 0,
				TextWrapped = true,

				[Children] = {
					New "UIStroke" {
						Name = "UIStroke",
						Color = Color3.fromRGB(0, 74, 109),
						Thickness = 3,
					},
				},
			},
		},
	}
end
