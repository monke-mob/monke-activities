local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local addInstanceToChildren = require(script.Parent.Parent.functions.addInstanceToChildren)
local concatTables = require(ReplicatedStorage.functions.concatTables)
local theme = require(script.Parent.Parent.theme)
local types = require(ReplicatedStorage.types)

export type componentProps = {
    constrained: boolean,
}

--[[
	The base class for a `ImageLabel` that supports `UIAspectRatioConstraint`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function icon(instanceProps: types.dictionaryAny, componentProps: componentProps)
    if componentProps.constrained then
        addInstanceToChildren(
            instanceProps,
            Fusion.New("UIAspectRatioConstraint")({
                AspectType = Enum.AspectType.ScaleWithParentSize,
                DominantAxis = Enum.DominantAxis.Height,
            })
        )
    end

    return Fusion.New("ImageLabel")(concatTables({
        ImageColor3 = theme.foreground.light,
        BackgroundTransparency = 1,
    }, instanceProps))
end

return icon
