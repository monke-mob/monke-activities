local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local addInstanceToChildren = require(script.Parent.Parent.Parent.functions.addInstanceToChildren)
local label = require(script.Parent)

--[[
	Extends the label class and adds a stroke. Replicates the stroke of the game logo text.
	
    @extends label
	@returns Fusion.Component
--]]
local function strokeLabel(instanceProps: label.instanceProps)
    addInstanceToChildren(
        instanceProps,
        Fusion.New("UIStroke")({
            Thickness = 3,
            Color = Color3.fromRGB(0, 0, 0),
        })
    )

    return label(instanceProps)
end

return strokeLabel
