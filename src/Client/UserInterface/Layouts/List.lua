local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local Sizing = require(script.Parent.Parent.Theme.Sizing)
local concatTables = require(script.Parent.Parent.Functions.concatTables)

--[[
	The base class for a `UIListLayout`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
    @returns UIListLayout
--]]
function UIListLayout(instanceProperties: Types.Dictionary): UIListLayout
    return Fusion.New("UIListLayout")(concatTables({
        Padding = Sizing.Padding.Default,
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, instanceProperties)) :: UIListLayout
end

return UIListLayout
