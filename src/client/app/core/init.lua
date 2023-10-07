local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local gui = require(script.Parent.components.gui)
local mouseUnlock = require(script.mouseUnlock)
local round = require(script.round)

--[[
	Handles the core ui.

	@returns never
--]]
local function core()
	gui({
		[Fusion.Children] = {
			mouseUnlock(),
			round(),
		},
	})
end

return core
