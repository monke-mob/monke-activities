local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local button = require(script.Parent.Parent.Parent.components.button)
local container = require(script.Parent.container)
local theme = require(script.Parent.Parent.Parent.theme)

--[[
	Handles the menu toggle button.
	
	@returns Fusion.Component
--]]
local function menuToggle()
    return container({
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.05, 0.5),
        Size = UDim2.fromScale(0.245, 0.65),

        [Fusion.Children] = {
            button({
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromScale(1, 1),
                Position = UDim2.fromScale(0.5, 0.5),
                BackgroundTransparency = 1,
                ZIndex = 2,

                [Fusion.OnEvent("Activated")] = function()
                    
                end,
            }, {}),

            Fusion.New("ImageLabel")({
                ImageColor3 = theme.foreground.light,
                Image = "rbxassetid://14800609693",
                Size = UDim2.fromScale(0, 0.4),
                BackgroundTransparency = 1,

                [Fusion.Children] = {
                    Fusion.New("UIAspectRatioConstraint")({
                        AspectType = Enum.AspectType.ScaleWithParentSize,
                        DominantAxis = Enum.DominantAxis.Height,
                    }),
                },
            }),
        },
    }, {
        gradient = theme.gradient.dark,
    })
end

return menuToggle
