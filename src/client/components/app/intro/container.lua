local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.components.frame)
local groupSplashComponent = require(script.Parent.groupSplash)
local handleLogic = require(script.Parent.handleLogic)
local image = require(script.Parent.Parent.components.image)
local list = require(script.Parent.Parent.components.list)
local theme = require(script.Parent.Parent.theme)

type componentProps = {
    enabled: any,
}

--[[
	The main container for the intro.

    @param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function container(componentProps: componentProps)
    local rootTransparencyGoal = Fusion.Value(0)
    local rootTransparency = Fusion.Tween(rootTransparencyGoal, TweenInfo.new(2, Enum.EasingStyle.Linear))

    local groupSplashTransparencyGoal = Fusion.Value(1)
    local groupSplashTransparency = Fusion.Tween(groupSplashTransparencyGoal, TweenInfo.new(3, Enum.EasingStyle.Linear))

    local groupSplash, groupSplashStart, groupSplashStop = groupSplashComponent({
        ImageTransparency = groupSplashTransparency,
    })

    handleLogic({
        enabled = componentProps.enabled,
        rootTransparency = rootTransparencyGoal,
        groupSplashTransparency = groupSplashTransparencyGoal,
        groupSplashStart = groupSplashStart,
        groupSplashStop = groupSplashStop,
    })

    return frame({
        BackgroundTransparency = rootTransparency,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 10,

        [Fusion.Children] = {
            list({
                Padding = UDim.new(0, 15),
            }),

            groupSplash,

            image({
                ImageTransparency = groupSplashTransparency,
                Image = theme.icons.monkeMob,
                Size = UDim2.fromScale(1, 0.08),
                ScaleType = Enum.ScaleType.Fit,
            }, {
                constrained = false,
            }),
        },
    }, {})
end

return container
