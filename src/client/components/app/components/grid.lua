local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)

--[[
	The base class for a `UIGridLayout`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@returns Fusion.Component
--]]
local function grid(instanceProps: types.dictionaryAny)
    return Fusion.New("UIGridLayout")(concatTables({
        CellPadding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, instanceProps))
end

return grid
