local playerCountAction = require(script.Parent.Parent.Parent.Parent.actions.round.playerCount)
local theme = require(script.Parent.Parent.Parent.Parent.theme)
local label = require(script.Parent.Parent.Parent.Parent.components.label)

--[[
    The player count label.
	
	@returns Fusion.Component
--]]
local function timerLabel()
	return label({
        Text = playerCountAction.value,
		TextColor3 = theme.current.foreground,
		FontFace = theme.themes.font.light,
		Size = UDim2.fromScale(0, 0.4),
		TextScaled = true,
		AutomaticSize = Enum.AutomaticSize.X,
	})
end

return timerLabel