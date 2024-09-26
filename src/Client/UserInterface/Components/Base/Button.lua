local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local applyRoundComponent = require(script.Parent.Parent.Parent.Functions.applyRoundComponent)
local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

export type componentProperties = applyRoundComponent.componentProperties & {
    animated: boolean,
}

--[[
	The base class for a `TextButton`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@param {componentProperties} componentProperties [The properties to apply to the component.]
    @returns TextButton
--]]
function Button(instanceProperties: Types.Dictionary, componentProperties: componentProperties): TextButton
    applyRoundComponent(
        instanceProperties,
        concatTables({
            cornerRadius = nil,
        }, componentProperties)
    )

    return Fusion.New("TextButton")(concatTables({
        Text = "Button",
        AutoButtonColor = false,
    }, instanceProperties)) :: TextButton
end

return Button
