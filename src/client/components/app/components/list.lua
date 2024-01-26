local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local types = require(ReplicatedStorage.types)

--[[
	The base class for a `UIListLayout`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@returns Fusion.Component
--]]
local function list(instanceProps: types.dictionaryAny)
    return Fusion.New("UIListLayout")(concatTables({
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, instanceProps))
end

return list
