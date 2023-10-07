local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local theme = require(script.Parent.Parent.Parent.theme)
local container = require(script.Parent.container)
local timerLabel = require(script.timerLabel)

--[[
	Handles the round / intermission timer.
	
	@returns Fusion.Component
--]]
local function timer()
	return container({
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.35, 0.86),

		[Fusion.Children] = {
			timerLabel(),
		},
	}, {
		cornerRadius = UDim.new(0, 20),
		gradient = theme.themes.gradient.brand,
	})
end

return timer
