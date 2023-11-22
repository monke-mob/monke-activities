local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local addInstanceToChildren = require(script.Parent.Parent.Parent.functions.addInstanceToChildren)
local concatTables = require(ReplicatedStorage.functions.concatTables)
local frame = require(script.Parent.Parent.Parent.components.frame)
local theme = require(script.Parent.Parent.Parent.theme)
local types = require(ReplicatedStorage.types)

export type componentProps = frame.componentProps & {
    gradient: ColorSequence,
}

--[[
	An extendable class for the round containers.
    
	@extends frame
	@param {dictionaryAny} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function container(instanceProps: types.dictionaryAny, componentProps: componentProps)
    addInstanceToChildren(
        instanceProps,
        Fusion.New("UIGradient")({
            Color = componentProps.gradient,
            Rotation = 90,
        })
    )

    return frame(
        concatTables({
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        }, instanceProps),
        concatTables({
            cornerRadius = theme.cornerRadius.primary,
            hasCornerRadius = true,
        }, componentProps)
    )
end

return container
