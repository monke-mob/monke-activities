local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local gui = require(script.Parent.Parent.components.gui)
local modeAction = require(script.Parent.Parent.actions.mode)
local title = require(script.title)

--[[
	Handles the climbing mode ui.

	@returns Fusion.Component
--]]
local function climbing()
    gui({
        Enabled = Fusion.Computed(function()
            return modeAction.value:get() == "climbing"
        end),
        DisplayOrder = 2,

        [Fusion.Children] = {
            title(),
        },
    })
end

return climbing
