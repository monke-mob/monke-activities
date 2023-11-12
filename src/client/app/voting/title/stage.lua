local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local stageAction = require(script.Parent.Parent.Parent.actions.voting.stage)
local strokeLabel = require(script.Parent.Parent.Parent.components.label.stroke)
local theme = require(script.Parent.Parent.Parent.theme)

--[[
    The stage label.
	
	@returns Fusion.Component
--]]
local function timer()
    return strokeLabel({
        Text = stageAction.value,
        FontFace = theme.font.caesar,
        TextColor3 = theme.foreground.primary,
        Size = UDim2.fromScale(1, 0.625),
        TextScaled = true,

        [Fusion.Children] = {
            Fusion.New("UIGradient")({
                Rotation = 90,
                Color = theme.gradient.brand,
            }),
        },
    })
end

return timer
