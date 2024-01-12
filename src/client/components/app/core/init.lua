local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local gui = require(script.Parent.components.gui)
local mouseUnlock = require(script.mouseUnlock)
local roundInfo = require(script.roundInfo)
local menu = require(script.menu)

--[[
	Handles the core ui.

	@returns never
--]]
local function core()
    gui({
        [Fusion.Children] = {
            mouseUnlock(),
            roundInfo(),
            menu(),
        },
    })
end

return core

