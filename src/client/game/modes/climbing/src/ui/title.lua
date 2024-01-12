local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Knit = require(ReplicatedStorage.Packages.Knit)

local strokeLabel = require(script.Parent.Parent.Parent.Parent.Parent.Parent.components.app.components.label.stroke)
local modeController

Knit:OnStart():andThen(function()
    modeController = Knit.GetController("mode")
end)

--[[
    The label that displays the current person.
	
	@returns Fusion.Component
--]]
local function timer()
    return strokeLabel({
        Position = UDim2.fromScale(0, 0.1),
        Size = UDim2.fromScale(1, 0.05),
        TextScaled = true,

        [Fusion.Ref] = modeController:getMode().currentPlayerLabel,
    })
end

return timer
