local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local AspectRatio = require(script.Parent.AspectRatio)
local Colors = require(script.Parent.Parent.Parent.Theme.Colors)
local addInstanceToChildren = require(script.Parent.Parent.Parent.Functions.addInstanceToChildren)
local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

export type componentProperties = {
    square: boolean,
}

--[[
	The base class for a `ImageLabel`. Supports using a `UIAspectRatioConstraint`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@param {componentProperties} componentProperties [The properties to apply to the component.]
    @returns ImageLabel
--]]
function Image(instanceProperties: Types.Dictionary, componentProperties: componentProperties): ImageLabel
    if componentProperties.square then
        addInstanceToChildren(instanceProperties, AspectRatio({}))
    end

    return Fusion.New("ImageLabel")(concatTables({
        ImageColor3 = Colors.Foreground.Primary,
        BackgroundTransparency = 1,
    }, instanceProperties)) :: ImageLabel
end

return Image
