local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local roundComponent = require(script.Parent.Parent.functions.roundComponent)
local theme = require(script.Parent.Parent.theme)
local types = require(ReplicatedStorage.types)

export type componentProps = roundComponent.componentProps

--[[
	The base class for a `Frame`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function frame(instanceProps: types.dictionaryAny, componentProps: componentProps)
    roundComponent(
        instanceProps,
        concatTables({
            hasCornerRadius = false,
        }, componentProps)
    )

    return Fusion.New("Frame")(concatTables({
        BackgroundColor3 = theme.background.primary,
        BackgroundTransparency = 1,
    }, instanceProps))
end

return frame
