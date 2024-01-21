local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local action = require(script.Parent.Parent.Parent.Parent.actions)
local button = require(script.Parent.Parent.Parent.Parent.components.button)
local frame = require(script.Parent.Parent.Parent.Parent.components.frame)
local strokeLabel = require(script.Parent.Parent.Parent.Parent.components.label.stroke)
local theme = require(script.Parent.Parent.Parent.Parent.theme)

export type componentProps = {
    header: string,
    customSubHeader: string?,
    action: action.class,
}

--[[
	Handles a sub menu header.

	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function header(componentProps: componentProps)
    return frame({
        Size = UDim2.fromScale(1, 0.135),
        Position = UDim2.fromScale(0, 0.1),

        [Fusion.Children] = {
            strokeLabel({
                Text = componentProps.header,
                FontFace = theme.font.caesar,
                Size = UDim2.fromScale(1, 0.625),
                TextScaled = true,

                [Fusion.Children] = {
                    Fusion.New("UIGradient")({
                        Rotation = 90,
                        Color = theme.gradient.brand,
                    }),
                },
            }),

            if typeof(componentProps.customSubHeader) == "string"
                then strokeLabel({
                    Text = componentProps.customSubHeader,
                    FontFace = theme.font.caesar,
                    Size = UDim2.fromScale(1, 0.3),
                    Position = UDim2.fromScale(0, 0.925),
                    AnchorPoint = Vector2.new(0, 1),
                    TextScaled = true,
                })
                else button({
                    FontFace = theme.font.caesar,
                    Text = "< back to menu",
                    Size = UDim2.fromScale(1, 0.3),
                    Position = UDim2.fromScale(0, 0.925),
                    AnchorPoint = Vector2.new(0, 1),
                    BackgroundTransparency = 1,
                    TextScaled = true,

                    [Fusion.Children] = {
                        Fusion.New("UIStroke")({
                            Thickness = 3,
                            Color = theme.foreground.dark,
                        }),
                    },
                }, {}),
        },
    }, {})
end

return header
