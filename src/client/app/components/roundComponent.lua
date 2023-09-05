local ReplicatedStorage = game:GetService("ReplicatedStorage")

local types = require(ReplicatedStorage.types)

local addInstanceToChildren = require(script.Parent.addInstanceToChildren)
local cornerRadius = require(script.Parent.cornerRadius)

export type componentProps = {
	hasCornerRadius: boolean?,
	cornerRadius: UDim?,
}

--[[
	Adds an instance to the children array.
	If a child array is not available it will create one.
	
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
