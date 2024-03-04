local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local button = require(script.Parent.Parent.Parent.components.button)
local frame = require(script.Parent.Parent.Parent.components.frame)
local image = require(script.Parent.Parent.Parent.components.image)
local menuOpenAction = require(script.Parent.Parent.Parent.actions.menu.open)
local theme = require(script.Parent.Parent.Parent.theme)

--[[
	Handles the menu toggle button.
	
	@returns Fusion.Component
--]]
local function menuToggle()
    return frame({
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.05, 0.5),
        Size = UDim2.fromScale(0.245, 0.65),
        BackgroundTransparency = 1,

        [Fusion.Children] = {
            button({
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.fromScale(1, 0.5),
                Size = UDim2.fromScale(0, 1),
                BackgroundTransparency = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),

                [Fusion.OnEvent("Activated")] = function()
                    menuOpenAction:set(true)
                end,

                [Fusion.Children] = {
                    Fusion.New("UIAspectRatioConstraint")({
                        AspectType = Enum.AspectType.ScaleWithParentSize,
                        DominantAxis = Enum.DominantAxis.Height,
                    }),

                    Fusion.New("UIGradient")({
                        Color = theme.gradient.dark,
                        Rotation = 90,
                    }),

                    image({
                        Image = theme.icons.menu,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.fromScale(0, 0.4),
                        Position = UDim2.fromScale(0.5, 0.5),
                    }, {
                        constrained = true,
                    }),
                },
            }, {}),
        },
    }, {})
end

return menuToggle
