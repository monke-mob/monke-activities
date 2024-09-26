local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local Colors = require(script.Parent.Parent.Parent.Theme.Colors)
local Sizing = require(script.Parent.Parent.Parent.Theme.Sizing)
local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

--[[
	The base class for a `UIStroke`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@returns UIStroke
--]]
function Stroke(instanceProperties: Types.Dictionary): UIStroke
    return Fusion.New("UIStroke")(concatTables({
        Thickness = Sizing.Stroke.Primary,
        Color = Colors.Background.Primary,
    }, instanceProperties)) :: UIStroke
end

return Stroke
