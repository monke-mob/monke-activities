local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local strokeLabel = require(script.Parent.Parent.Parent.components.label.stroke)
local theme = require(script.Parent.Parent.Parent.theme)
local stageAction = require(script.Parent.Parent.Parent.actions.voting.stage)

--[[
    The stage label.
	
	@returns Fusion.Component
--]]
local function timer()
    return strokeLabel({
        Text = stageAction.value,
        FontFace = theme.themes.font.caesar,
        TextColor3 = theme.themes.textColor.default,
        Size = UDim2.fromScale(1, 0.625),
        TextScaled = true,

        [Fusion.Children] = {
            Fusion.New("UIGradient")({
                Rotation = 90,
                Color = theme.themes.gradient.brand,
            })
        }
    })
end

return timer