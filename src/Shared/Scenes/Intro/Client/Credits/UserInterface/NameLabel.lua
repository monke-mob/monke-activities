local ReplicatedFirst = game:GetService("ReplicatedFirst")

local CreditsValues = require(script.Parent.Parent.Values)
local Fonts = require(ReplicatedFirst.UserInterface.Theme.Fonts)
local Label = require(ReplicatedFirst.UserInterface.Components.Base.Label)

--[[
	The credits name label. Displays a name for the credits.
	
	@returns never
--]]
function NameLabel()
    return Label({
        Text = CreditsValues.name,
        TextTransparency = CreditsValues.transparency,
        FontFace = Fonts.Bold,
        Size = UDim2.fromScale(0, 0.1),
        Position = UDim2.fromScale(0.05, 0.479),
        AnchorPoint = Vector2.new(0, 0.5),
        AutomaticSize = Enum.AutomaticSize.X,
    }, {})
end

return NameLabel
