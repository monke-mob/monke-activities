local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local theme = require(script.Parent.Parent.Parent.theme)
local list = require(script.Parent.Parent.Parent.components.list)
local container = require(script.Parent.container)
local playerCountLabel = require(script.playerCountLabel)

--[[
	Handles the round / intermission timer.
	
	@returns Fusion.Component
--]]
local function timer()
	return container({
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.fromScale(0.95, 0.5),
		Size = UDim2.fromScale(0.245, 0.65),

		[Fusion.Children] = {
			list({
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0.065, 0),
			}),

			Fusion.New("ImageLabel")({
				Image = "rbxassetid://14799447549",
				ImageColor3 = theme.current.foreground,
				Size = UDim2.fromScale(0, 0.4),
				BackgroundTransparency = 1,

				[Fusion.Children] = {
					Fusion.New("UIAspectRatioConstraint")({
						AspectType = Enum.AspectType.ScaleWithParentSize,
						DominantAxis = Enum.DominantAxis.Height,
					})
				}
			}),

			playerCountLabel(),
		},
	}, {
		gradient = theme.themes.gradient.dark,
	})
end

return timer
