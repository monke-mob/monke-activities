local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)

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
