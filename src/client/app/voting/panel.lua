local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local button = require(script.Parent.Parent.components.button)
local clientTypes = require(script.Parent.Parent.Parent.types)

type componentsProps = {
    data: clientTypes.votingOption,
    aspectRatio: number,
}

--[[
    Extendable voting panel component.

    @param {componentsProps} componentsProps [The component props.]
	@returns Fusion.Component
--]]
local function panel(componentsProps: componentsProps)
    return button({
        Text = "hello",
        Size = UDim2.fromScale(0, 1),


        [Fusion.Children] = {},
    }, {})
end

return panel
