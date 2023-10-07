local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local theme = require(script.Parent.Parent.theme)

--[[
	The base class for a `TextLabel`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@returns Fusion.Component
--]]
local function label(instanceProps: types.dictionaryAny)
	return Fusion.New("TextLabel")(concatTables({
		FontFace = theme.current.font,
		TextColor3 = theme.current.foreground,
		BackgroundTransparency = 1,
	}, instanceProps))
end

return label