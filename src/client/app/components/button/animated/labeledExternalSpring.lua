local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local addInstanceToChildren = require(script.Parent.Parent.Parent.addInstanceToChildren)
local springComponent = require(script.Parent.Parent.Parent.spring)
local label = require(script.Parent.Parent.Parent.label)
local animatedButton = require(script.Parent)

export type instanceProps = animatedButton.instanceProps & {
	label: types.dictionaryAny,
	preLabelChildren: types.dictionaryAny | nil,
}

export type componentProps = animatedButton.componentProps & {
	spring: springComponent.spring,
}

--[[
	Extends the `button` component by adding a `label`
	component and `UIScale` instance. Animates the button
	by taking an external spring as a prop.

	@extends button
	@param {instanceProps} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function labeledExternalSpringButton(instanceProps: instanceProps, componentProps: componentProps)
	instanceProps.button.BackgroundTransparency = componentProps.spring.Transparency
	instanceProps.label.TextTransparency = componentProps.spring.Transparency

	-- Add the component instances to the children.
	addInstanceToChildren(
		instanceProps.button,
		Fusion.New("UIScale")({
			Scale = componentProps.spring.Scale,
		})
	)

	addInstanceToChildren(instanceProps.button, instanceProps.preLabelChildren)

	addInstanceToChildren(
		instanceProps.button,
		label(concatTables({
			Size = UDim2.fromScale(0, 0.9),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			TextScaled = true,
			AutomaticSize = Enum.AutomaticSize.X,
		}, instanceProps.label))
	)

	return animatedButton(instanceProps, componentProps)
end

return labeledExternalSpringButton
