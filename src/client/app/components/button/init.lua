local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local roundComponent = require(script.Parent.roundComponent)
local theme = require(script.Parent.Parent.theme)

export type componentProps = roundComponent.componentProps

--[[
	The base class for a `TextButton`.

	@param {dictionaryAny} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function button(instanceProps: types.dictionaryAny, componentProps: componentProps)
	roundComponent(instanceProps, componentProps)

	return Fusion.New("TextButton")(concatTables({
		BackgroundColor3 = theme.current.background,
		FontFace = theme.current.font,
		TextColor3 = theme.current.textColor,
		Text = "",
		AutoButtonColor = false,
	}, instanceProps))
end

return button
