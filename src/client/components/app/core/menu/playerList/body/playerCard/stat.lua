local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.Parent.Parent.Parent.Parent.components.frame)
local image = require(script.Parent.Parent.Parent.Parent.Parent.Parent.components.image)
local label = require(script.Parent.Parent.Parent.Parent.Parent.Parent.components.label)
local list = require(script.Parent.Parent.Parent.Parent.Parent.Parent.components.list)
local springComponent = require(script.Parent.Parent.Parent.Parent.Parent.Parent.components.spring)
local theme = require(script.Parent.Parent.Parent.Parent.Parent.Parent.theme)

type componentProps = {
    icon: string,
    value: string,
    spring: springComponent.spring,
}

--[[
	Handles the player stat container.
	
	@returns Fusion.Component
--]]
local function stat(componentProps: componentProps)
    return frame({
        Size = UDim2.fromScale(0, 1),
        AutomaticSize = Enum.AutomaticSize.X,

        [Fusion.Children] = {
            list({
                FillDirection = Enum.FillDirection.Horizontal,
                -- NOTE: If the alignment is not set to left it causes the layout to be bugged.
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
            }),

            image({
                Image = componentProps.icon,
                ImageTransparency = componentProps.spring.Transparency,
                Size = UDim2.fromScale(0, 0.7),
            }, {
                constrained = true,
            }),

            label({
                TextTransparency = componentProps.spring.Transparency,
                Text = componentProps.value,
                FontFace = theme.font.light,
                Size = UDim2.fromScale(0, 0.75),
                TextScaled = true,
                AutomaticSize = Enum.AutomaticSize.X,
            }),
        },
    }, {})
end

return stat
