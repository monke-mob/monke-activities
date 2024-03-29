local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local types = require(ReplicatedStorage.types)

--[[
	The base class for a `ScreenGui`.
	
	@param {dictionaryAny} instanceProps [The instance props.]
	@returns Fusion.Component
--]]
local function gui(instanceProps: types.dictionaryAny)
    return Fusion.New("ScreenGui")(concatTables({
        IgnoreGuiInset = true,
        Parent = Players.LocalPlayer.PlayerGui,
    }, instanceProps))
end

return gui
