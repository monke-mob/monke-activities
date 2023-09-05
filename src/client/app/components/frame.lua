local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local roundComponent = require(script.Parent.roundComponent)
local theme = require(script.Parent.Parent.theme)

export type componentProps = roundComponent.componentProps

--[[
	The base class for a `Frame`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function button(instanceProps: types.dictionaryAny, componentProps: componentProps)
	roundComponent(
		instanceProps,
		concatTables({
			hasCornerRadius = false,
		}, componentProps)
	)

	return Fusion.New("Frame")(concatTables({
		BackgroundColor3 = theme.current.background,
		BackgroundTransparency = 1,
	}, instanceProps))
end

return button
