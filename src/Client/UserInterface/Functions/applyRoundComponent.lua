local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Types)

local CornerRadius = require(script.Parent.Parent.Components.Base.CornerRadius)
local addInstanceToChildren = require(script.Parent.addInstanceToChildren)

export type componentProperties = {
    cornerRadius: UDim?,
}

--[[
	Adds a `CornerRadius` component to the instance properties child entry.

    NOTE: Only adds one if `cornerRadius` is a UDim.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@param {componentProperties} componentProperties [The properties to apply to the component.]
	@returns never
--]]
function roundComponent(instanceProperties: Types.Dictionary, componentProperties: componentProperties)
    if typeof(componentProperties.cornerRadius) ~= "UDim" then
        return
    end

    addInstanceToChildren(
        instanceProperties,
        CornerRadius({
            CornerRadius = componentProperties.cornerRadius,
        })
    )
end

return roundComponent
