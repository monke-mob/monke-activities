local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local gui = require(script.Parent.Parent.Parent.Parent.Parent.components.app.components.gui)
local title = require(script.title)

--[[
	Handles the mode ui.

	@returns Fusion.Component
--]]
local function ui()
    return gui({
        DisplayOrder = 2,

        [Fusion.Children] = {
            title(),
        },
    })
end

return ui
