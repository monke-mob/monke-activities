local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

--[[
	The base class for a `UIAspectRatioConstraint`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
    @returns UIAspectRatioConstraint
--]]
function AspectRatio(instanceProperties: Types.Dictionary): UIAspectRatioConstraint
    return Fusion.New("UIAspectRatioConstraint")(concatTables({
        AspectType = Enum.AspectType.ScaleWithParentSize,
        DominantAxis = Enum.DominantAxis.Height,
    }, instanceProperties)) :: UIAspectRatioConstraint
end

return AspectRatio
