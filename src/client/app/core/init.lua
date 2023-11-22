local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local gui = require(script.Parent.components.gui)
local mouseUnlock = require(script.mouseUnlock)
local roundInfo = require(script.roundInfo)

--[[
	Handles the core ui.

	@returns never
--]]
local function core()
    gui({
        [Fusion.Children] = {
            mouseUnlock(),
            roundInfo(),
        },
    })
end

return core
