local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local roundComponent = require(script.Parent.Parent.functions.roundComponent)
local theme = require(script.Parent.Parent.theme)
local types = require(ReplicatedStorage.types)

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
        BackgroundColor3 = theme.background.primary,
        FontFace = theme.font.primary,
        TextColor3 = theme.foreground.primary,
        Text = "",
        AutoButtonColor = false,
    }, instanceProps))
end

return button
