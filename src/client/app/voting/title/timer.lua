local strokeLabel = require(script.Parent.Parent.Parent.components.label.stroke)
local theme = require(script.Parent.Parent.Parent.theme)
local timerAction = require(script.Parent.Parent.Parent.actions.voting.timer)

--[[
    The timer label.
	
	@returns Fusion.Component
--]]
local function timer()
    return strokeLabel({
        Text = timerAction.value,
        FontFace = theme.themes.font.caesar,
        TextColor3 = theme.themes.textColor.default,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(1, 0.375),
        TextScaled = true,
    })
end

return timer
