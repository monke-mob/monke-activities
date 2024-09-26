local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

--[[
	The base class for a `ScreenGui`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@returns ScreenGui
--]]
function GUI(instanceProperties: Types.Dictionary): ScreenGui
    return Fusion.New("ScreenGui")(concatTables({
        Parent = Players.LocalPlayer.PlayerGui,
        IgnoreGuiInset = true,
    }, instanceProperties)) :: ScreenGui
end

return GUI
