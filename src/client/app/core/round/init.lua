local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.components.frame)
local timer = require(script.timer)

--[[
	Handles the round interface.
	
	@returns Fusion.Component
--]]
local function menu()
	return frame({
		Size = UDim2.fromScale(0.3, 0.13),
		Position = UDim2.fromScale(0.5, 0.993),
		AnchorPoint = Vector2.new(0.5, 1),

		[Fusion.Children] = {
			timer(),
		},
	}, {})
end

return menu
