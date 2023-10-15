local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local button = require(script.Parent.Parent.components.button)
local types = require(ReplicatedStorage.types)

type componentsProps = {
    data: types.votingOption,
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
