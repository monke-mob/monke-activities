local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local strokeLabel = require(script.Parent.Parent.Parent.Parent.Parent.Parent.components.app.components.label.stroke)
local modeController

Knit:OnStart():andThen(function()
    modeController = Knit.GetController("mode")
end)

--[[
    Handles the label that displays the current player.
	
	@returns Fusion.Component
--]]
local function title()
    return strokeLabel({
        Text = modeController:getMode().currentPlayerText,
        Position = UDim2.fromScale(0, 0.1),
        Size = UDim2.fromScale(1, 0.05),
        TextScaled = true,
    })
end

return title
