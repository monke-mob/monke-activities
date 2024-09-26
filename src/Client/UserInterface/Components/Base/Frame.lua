local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local Colors = require(script.Parent.Parent.Parent.Theme.Colors)
local applyRoundComponent = require(script.Parent.Parent.Parent.Functions.applyRoundComponent)
local applyStrokeComponent = require(script.Parent.Parent.Parent.Functions.applyStrokeComponent)
local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

export type componentProperties = applyRoundComponent.componentProperties & applyStrokeComponent.componentProperties

--[[
	The base class for a `Frame`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@param {componentProperties} componentProperties [The properties to apply to the component.]
    @returns Frame
--]]
function Frame(instanceProperties: Types.Dictionary, componentProperties: componentProperties): Frame
    applyRoundComponent(
        instanceProperties,
        concatTables({
            cornerRadius = nil,
        }, componentProperties)
    )

    applyStrokeComponent(
        instanceProperties,
        concatTables({
            strokeThickness = nil,
        }, componentProperties)
    )

    return Fusion.New("Frame")(concatTables({
        BackgroundColor3 = Colors.Background.Primary,
        BackgroundTransparency = 1,
    }, instanceProperties)) :: Frame
end

return Frame
