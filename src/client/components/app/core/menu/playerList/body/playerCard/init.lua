local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.Parent.Parent.Parent.components.frame)
local label = require(script.Parent.Parent.Parent.Parent.Parent.components.label)
local list = require(script.Parent.Parent.Parent.Parent.Parent.components.list)
local springComponent = require(script.Parent.Parent.Parent.Parent.Parent.components.spring)
local stat = require(script.stat)
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
                        PaddingLeft = UDim.new(0, 25),
                        PaddingRight = UDim.new(0, 25),
                        PaddingTop = UDim.new(0, 12),
                        PaddingBottom = UDim.new(0, 12),
                    }),

                    Fusion.New("UIGradient")({
                        Rotation = 90,
                        Color = theme.gradient.dark,
                    }),

                    -- Name container.
                    frame({
                        Size = UDim2.fromScale(0.6, 1),

                        [Fusion.Children] = {
                            list({
                                Padding = UDim.new(0, 12),
                                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                FillDirection = Enum.FillDirection.Horizontal,
                            }),

                            label({
                                TextTransparency = componentProps.spring.Transparency,
                                Text = "1",
                                TextColor3 = Color3.fromRGB(255, 225, 0),
                                Size = UDim2.fromScale(0.06, 0.8),
                                TextScaled = true,
                                TextXAlignment = Enum.TextXAlignment.Left,
                            }),

                            label({
                                TextTransparency = componentProps.spring.Transparency,
                                Text = `{componentProps.player.DisplayName} <font color="rgb(221, 221, 221)">(@{componentProps.player.Name})</font>`,
                                RichText = true,
                                Size = UDim2.fromScale(0.85, 0.8),
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextScaled = true,
                            }),
                        },
                    }, {}),

                    -- Extra container.
                    frame({
                        Position = UDim2.fromScale(1, 0),
                        AnchorPoint = Vector2.new(1, 0),
                        Size = UDim2.fromScale(0.4, 1),

                        [Fusion.Children] = {
                            list({
                                Padding = UDim.new(0, 25),
                                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                                FillDirection = Enum.FillDirection.Horizontal,
                            }),

                            -- Stats.
                            frame({
                                AutomaticSize = Enum.AutomaticSize.X,
                                Size = UDim2.fromScale(0, 1),

                                [Fusion.Children] = {
                                    list({
                                        Padding = UDim.new(0, 15),
                                        FillDirection = Enum.FillDirection.Horizontal,
                                        -- NOTE: If the alignment is not set to left it causes the layout to be bugged.
                                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                                    }),

                                    stat({
                                        icon = theme.icons.score,
                                        value = "200",
                                        spring = componentProps.spring,
                                    }),
                                },
                            }, {}),

                            -- Friend request button.
                            if componentProps.player ~= Players.LocalPlayer
                                then Fusion.New("ImageButton")({
                                    ImageTransparency = componentProps.spring.Transparency,
                                    Size = UDim2.fromScale(0, 0.9),
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
