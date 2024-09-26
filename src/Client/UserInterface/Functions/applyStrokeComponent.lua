local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Types)

local Stroke = require(script.Parent.Parent.Components.Base.Stroke)
local addInstanceToChildren = require(script.Parent.addInstanceToChildren)

export type componentProperties = {
    strokeThickness: number?,
    strokeColor: Color3?,
}

--[[
	Adds a `Stroke` component to the instance properties child entry.

    NOTE: Only adds one if `strokeThickness` is a number.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@param {componentProperties} componentProperties [The properties to apply to the component.]
	@returns never
--]]
function strokeComponent(instanceProperties: Types.Dictionary, componentProperties: componentProperties)
    if typeof(componentProperties.strokeThickness) ~= "number" then
        return
    end

    addInstanceToChildren(
        instanceProperties,
        Stroke({
            CornerRadius = componentProperties.strokeThickness,
            Color = componentProperties.strokeColor,
        })
    )
end

return strokeComponent
