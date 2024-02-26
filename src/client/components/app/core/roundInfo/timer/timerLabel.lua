local label = require(script.Parent.Parent.Parent.Parent.components.label)
local theme = require(script.Parent.Parent.Parent.Parent.theme)
local timerAction = require(script.Parent.Parent.Parent.Parent.actions.roundInfo.timer)

--[[
    The timer label.
	
	@returns Fusion.Component
--]]
local function timerLabel()
    return label({
        Text = timerAction.value,
        FontFace = theme.font.caesar,
        TextColor3 = theme.foreground.dark,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.9, 0.55),
        TextScaled = true,
    })
end

return timerLabel
