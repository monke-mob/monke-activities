local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local button = require(script.Parent.Parent.components.button)
local cornerRadius = require(script.Parent.Parent.components.cornerRadius)
local frame = require(script.Parent.Parent.components.frame)
local label = require(script.Parent.Parent.components.label)
local list = require(script.Parent.Parent.components.list)
local theme = require(script.Parent.Parent.theme)
local types = require(ReplicatedStorage.types)

type componentsProps = {
    data: types.votingOption,
    aspectRatio: any,
}

--[[
    Extendable voting panel component.

    @param {componentsProps} componentsProps [The component props.]
	@returns Fusion.Component
--]]
local function panel(componentsProps: componentsProps)
    return button({
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),

        [Fusion.Children] = {
            Fusion.New("UIAspectRatioConstraint")({
                AspectRatio = componentsProps.aspectRatio,
                DominantAxis = Enum.DominantAxis.Height,
                AspectType = Enum.AspectType.ScaleWithParentSize,
            }),

            Fusion.New("ImageLabel")({
                Size = UDim2.fromScale(1, 1),
                ScaleType = Enum.ScaleType.Crop,
                BackgroundTransparency = 1,

                [Fusion.Children] = {
                    Fusion.New("UIGradient")({
                        Rotation = 90,
                        Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(0.25, 0),
                            NumberSequenceKeypoint.new(1, 0.735),
                        }),
                    }),

                    cornerRadius({}),
                },
            }),

            frame({
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2,

                [Fusion.Children] = {
                    Fusion.New("UIPadding")({
                        PaddingBottom = UDim.new(0.15, 0),
                    }),

                    list({
                        Padding = UDim.new(0.02, 0),
                        VerticalAlignment = Enum.VerticalAlignment.Bottom,
                    }),

                    label({
                        Text = componentsProps.data.name,
                        TextColor3 = theme.themes.textColor.light,
                        FontFace = theme.themes.font.bold,
                        Size = UDim2.fromScale(1, 0.18),
                        TextScaled = true,
                    }),

                    label({
                        Text = "10 votes",
                        TextColor3 = theme.themes.textColor.light,
                        FontFace = theme.themes.font.light,
                        Size = UDim2.fromScale(1, 0.105),
                        TextScaled = true,
                    }),
                },
            }, {}),
        },
    }, {})
end

return panel