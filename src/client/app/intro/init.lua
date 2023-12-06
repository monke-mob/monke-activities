local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local container = require(script.container)
local gui = require(script.Parent.components.gui)

--[[
	Handles the intro ui.

	@returns never
--]]
local function intro()
    local enabled = Fusion.Value(true)

    gui({
        Enabled = enabled,
        DisplayOrder = 100,

        [Fusion.Children] = {
            container({
                enabled = enabled,
            }),
        },
    })
end

return intro
