local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local gui = require(script.Parent.components.gui)
local container = require(script.container)

--[[
	Handles the intro ui.

	@returns never
--]]
local function intro()
	local enabled = Fusion.Value(true)

	gui({
		Enabled = enabled,

		[Fusion.Children] = {
			container({
				enabled = enabled,
			}),
		},
	})
end

return intro
