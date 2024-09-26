local ReplicatedFirst = game:GetService("ReplicatedFirst")

local Colors = require(ReplicatedFirst.UserInterface.Theme.Colors)
local CreditsValues = require(script.Parent.Parent.Values)
local Label = require(ReplicatedFirst.UserInterface.Components.Base.Label)

--[[
	The credits role label. Displays the role that the person played for the credits.
	
	@returns never
--]]
function NameLabel()
    return Label({
        Text = CreditsValues.role,
        TextTransparency = CreditsValues.transparency,
        TextColor3 = Colors.Foreground.Light,
        Size = UDim2.fromScale(0, 0.055),
        Position = UDim2.fromScale(0.05, 0.542),
        AnchorPoint = Vector2.new(0, 0.5),
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, {})
end

return NameLabel
