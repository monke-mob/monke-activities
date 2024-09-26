local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local Sizing = require(script.Parent.Parent.Theme.Sizing)
local concatTables = require(script.Parent.Parent.Functions.concatTables)

--[[
	The base class for a `UIGridLayout`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
    @returns UIGridLayout
--]]
function UIGridLayout(instanceProperties: Types.Dictionary): UIGridLayout
    return Fusion.New("UIGridLayout")(concatTables({
        CellPadding = Sizing.Padding.Default,
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, instanceProperties)) :: UIGridLayout
end

return UIGridLayout
