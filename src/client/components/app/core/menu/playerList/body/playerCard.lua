local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.Parent.Parent.Parent.components.frame)
local label = require(script.Parent.Parent.Parent.Parent.Parent.components.label)
local springComponent = require(script.Parent.Parent.Parent.Parent.Parent.components.spring)
local theme = require(script.Parent.Parent.Parent.Parent.Parent.theme)

type componentProps = {
    player: Player,
    spring: springComponent.spring,
}

--[[
	Handles a player card.

	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function playerCard(componentProps: componentProps)
    return frame({
        [Fusion.Children] = {
            frame({
                Size = UDim2.fromScale(1, 1),
                Transparency = componentProps.spring.Transparency,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),

                [Fusion.Children] = {
                    Fusion.New("UIScale")({
                        Scale = componentProps.spring.Scale,
                    }),

                    Fusion.New("UIPadding")({
                        PaddingLeft = UDim.new(0, 30),
                        PaddingRight = UDim.new(0, 30),
                    }),

                    Fusion.New("UIGradient")({
                        Rotation = 90,
                        Color = theme.gradient.dark,
                    }),

                    label({
                        TextTransparency = componentProps.spring.Transparency,
                        Text = `{componentProps.player.DisplayName} <font color="rgb(221, 221, 221)">(@{componentProps.player.Name})</font>`,
                        RichText = true,
                        Size = UDim2.fromScale(0.8, 1),
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextSize = 25,
                    }),

                    frame({
                        Position = UDim2.fromScale(1, 0.5),
                        AnchorPoint = Vector2.new(1, 0.5),
                        Size = UDim2.fromScale(0.15, 0.6),

                        [Fusion.Children] = {
                            Fusion.New("UIListLayout")({
                                Padding = UDim.new(0, 5),
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                            }),

                            if componentProps.player ~= Players.LocalPlayer
                                then Fusion.New("ImageButton")({
                                    ImageTransparency = componentProps.spring.Transparency,
                                    Size = UDim2.fromScale(0, 1),
                                    Image = theme.icons.friendRequest,
                                    ImageColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1,

                                    [Fusion.OnEvent("Activated")] = function()
                                        StarterGui:SetCore("PromptSendFriendRequest", componentProps.player)
                                    end,

                                    [Fusion.Children] = {
                                        Fusion.New("UIAspectRatioConstraint")({
                                            AspectType = Enum.AspectType.ScaleWithParentSize,
                                            DominantAxis = Enum.DominantAxis.Height,
                                        }),
                                    },
                                })
                                else nil,
                        },
                    }, {}),
                },
            }, {
                hasCornerRadius = true,
            }),
        },
    }, {})
end

return playerCard
