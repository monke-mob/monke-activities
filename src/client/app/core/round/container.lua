local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local addInstanceToChildren = require(script.Parent.Parent.Parent.components.addInstanceToChildren)
local frame = require(script.Parent.Parent.Parent.components.frame)

export type componentProps = frame.componentProps & {
	gradient: ColorSequence,
}

--[[
	The basic styling for the round component containers.
    
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
			hasCornerRadius = true,
			cornerRadius = UDim.new(0, 15),
		}, componentProps)
	)
end

return container
