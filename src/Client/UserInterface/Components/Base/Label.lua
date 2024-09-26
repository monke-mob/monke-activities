local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local Colors = require(script.Parent.Parent.Parent.Theme.Colors)
local Fonts = require(script.Parent.Parent.Parent.Theme.Fonts)
local applyStrokeComponent = require(script.Parent.Parent.Parent.Functions.applyStrokeComponent)
local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

export type componentProperties = applyStrokeComponent.componentProperties

--[[
	The base class for a `TextLabel`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@param {componentProperties} componentProperties [The properties to apply to the component.]
    @returns TextLabel
--]]
function Label(instanceProperties: Types.Dictionary, componentProperties: componentProperties): TextLabel
    applyStrokeComponent(
        instanceProperties,
        concatTables({
            strokeThickness = nil,
        }, componentProperties)
    )

    return Fusion.New("TextLabel")(concatTables({
        FontFace = Fonts.Primary,
        TextColor3 = Colors.Foreground.Primary,
        BackgroundTransparency = 1,
        TextScaled = true,
    }, instanceProperties)) :: TextLabel
end

return Label
