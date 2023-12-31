local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local theme = require(script.Parent.Parent.theme)
local types = require(ReplicatedStorage.types)

export type instanceProps = types.dictionaryAny

--[[
	The base class for a `TextLabel`.
	
	@param {instanceProps} instanceProps [The instance props.]
	@returns Fusion.Component
--]]
local function label(instanceProps: instanceProps)
    return Fusion.New("TextLabel")(concatTables({
        FontFace = theme.font.primary,
        TextColor3 = theme.foreground.primary,
        BackgroundTransparency = 1,
    }, instanceProps))
end

return label
