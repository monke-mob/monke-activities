local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local addInstanceToChildren = require(script.Parent.Parent.addInstanceToChildren)
local springComponent = require(script.Parent.Parent.spring)
local frame = require(script.Parent.Parent.frame)
local button = require(script.Parent)

export type instanceProps = {
	wrapper: types.dictionaryAny,
	button: types.dictionaryAny,
}

export type componentProps = button.componentProps & {
	gradient: ColorSequence,
}

--[[
	Extends a `button` component and adds hover effects.

	@extends button
	@param {instanceProps} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function animatedButton(instanceProps: instanceProps, componentProps: componentProps)
	-- Check to see if the `Position` property was passed
	-- as it is needed for the hover effect.
	if instanceProps.button.Position == nil then
		instanceProps.button.Position = UDim2.fromScale(0.5, 0.5)
	end

	-- We must get the button position and save it.
	-- We cant leave it because it will overwrite
	-- the spring.
	local buttonPosition: UDim2 = instanceProps.button.Position
	instanceProps.button.Position = nil

	local hoverSpring, updateHoverSpring = springComponent({
		Position = buttonPosition,
	}, {
		speed = 25,
		damping = 0.85,
	})

	addInstanceToChildren(
		instanceProps.button,
		Fusion.New("UIGradient")({
			Rotation = 90,
			Color = componentProps.gradient or ColorSequence.new(Color3.fromRGB(0, 0, 0)),
		})
	)

	addInstanceToChildren(
		instanceProps.wrapper,
		button(
			concatTables({
				Position = hoverSpring.Position,
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),

				[Fusion.OnEvent("MouseEnter")] = function()
					updateHoverSpring({
						Position = buttonPosition + UDim2.fromOffset(0, -4),
					})
				end,

				[Fusion.OnEvent("MouseLeave")] = function()
					updateHoverSpring({
						Position = buttonPosition,
					})
				end,
			}, instanceProps.button),
			componentProps
		)
	)

	return frame(instanceProps.wrapper, {})
end

return animatedButton
