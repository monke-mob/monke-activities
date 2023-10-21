local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local gui = require(script.Parent.components.gui)
local title = require(script.title)
local panelContainer = require(script.panelContainer)

--[[
	Handles the voting ui.

	@returns Fusion.Component
--]]
local function voting()
    local enabled = Fusion.Value(true)

    gui({
        Enabled = enabled,

        [Fusion.Children] = {
            title(),
            panelContainer(),
        },
    })
end

return voting
