local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local theme = require(script.Parent.Parent.theme)

--[[
	The base class for a `UICorner`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@returns Fusion.Component
--]]
local function cornerRadius(instanceProps: types.dictionaryAny)
	return Fusion.New("UICorner")(concatTables({
		CornerRadius = theme.current.cornerRadius,
	}, instanceProps))
end

return cornerRadius
