local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local container = require(script.Parent.container)
local list = require(script.Parent.Parent.Parent.components.list)
local playerCountLabel = require(script.playerCountLabel)
local theme = require(script.Parent.Parent.Parent.theme)

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
                ImageColor3 = theme.foreground.light,
                Image = "rbxassetid://15999739064",
                Size = UDim2.fromScale(0, 0.4),
                BackgroundTransparency = 1,

                [Fusion.Children] = {
                    Fusion.New("UIAspectRatioConstraint")({
                        AspectType = Enum.AspectType.ScaleWithParentSize,
                        DominantAxis = Enum.DominantAxis.Height,
                    }),
                },
            }),

            playerCountLabel(),
        },
    }, {
        gradient = theme.gradient.dark,
    })
end

return timer
