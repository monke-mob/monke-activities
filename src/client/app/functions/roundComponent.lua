local ReplicatedStorage = game:GetService("ReplicatedStorage")

local types = require(ReplicatedStorage.types)

local addInstanceToChildren = require(script.Parent.Parent.functions.addInstanceToChildren)
local cornerRadius = require(script.Parent.Parent.components.cornerRadius)

export type componentProps = {
    hasCornerRadius: boolean?,
    cornerRadius: UDim?,
}

--[[
	Adds a corner radius component if one is needed.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns never
--]]
local function roundComponent(instanceProps: types.dictionaryAny, componentProps: componentProps)
    if componentProps.hasCornerRadius == false then
        return
    end

    addInstanceToChildren(
        instanceProps,
        cornerRadius({
            CornerRadius = componentProps.cornerRadius,
        })
    )
end

return roundComponent
