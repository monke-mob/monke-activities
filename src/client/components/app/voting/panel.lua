local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Knit = require(ReplicatedStorage.Packages.Knit)

local button = require(script.Parent.Parent.components.button)
local cornerRadius = require(script.Parent.Parent.components.cornerRadius)
local frame = require(script.Parent.Parent.components.frame)
local image = require(script.Parent.Parent.components.image)
local label = require(script.Parent.Parent.components.label)
local list = require(script.Parent.Parent.components.list)
local theme = require(script.Parent.Parent.theme)
local types = require(ReplicatedStorage.types)
local votesAction = require(script.Parent.Parent.actions.voting.votes)

local votingService

Knit.OnStart():andThen(function()
    votingService = Knit.GetService("voting")
end)

type componentsProps = {
    id: number,
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

        [Fusion.OnEvent("Activated")] = function()
            votingService:vote(componentsProps.id)
        end,

        [Fusion.Children] = {
            Fusion.New("UIAspectRatioConstraint")({
                AspectRatio = componentsProps.aspectRatio,
                DominantAxis = Enum.DominantAxis.Height,
                AspectType = Enum.AspectType.ScaleWithParentSize,
            }),

            image({
                Size = UDim2.fromScale(1, 1),
                ScaleType = Enum.ScaleType.Crop,

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
            }, {
                constrained = false,
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
                        TextColor3 = theme.foreground.light,
                        FontFace = theme.font.bold,
                        Size = UDim2.fromScale(1, 0.18),
                        TextScaled = true,
                    }),

                    label({
                        Text = Fusion.Computed(function()
                            local votes: number = votesAction.value:get()[componentsProps.id]
                            return `{votes} {if votes == 1 then "vote" else "votes"}`
                        end),
                        TextColor3 = theme.foreground.light,
                        FontFace = theme.font.light,
                        Size = UDim2.fromScale(1, 0.105),
                        TextScaled = true,
                    }),
                },
            }, {}),
        },
    }, {})
end

return panel
