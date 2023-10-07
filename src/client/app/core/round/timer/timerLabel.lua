local timerAction = require(script.Parent.Parent.Parent.Parent.actions.round.timer)
local theme = require(script.Parent.Parent.Parent.Parent.theme)
local label = require(script.Parent.Parent.Parent.Parent.components.label)

--[[
    The timer label.
	
	@returns Fusion.Component
--]]
local function timerLabel()
	return label({
        Text = timerAction.value,
		Font = theme.themes.font.caesar,
		TextColor3 = theme.themes.textColor.dark,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.9, 0.55),
		TextScaled = true,
	})
end

return timerLabel
