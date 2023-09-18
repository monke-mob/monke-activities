local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local handleButtonSprings = require(script.handleButtonSprings)
local frame = require(script.Parent.Parent.Parent.components.frame)
local list = require(script.Parent.Parent.Parent.components.list)
local subMenuButton = require(script.subMenuButton)

--[[
	Handles the home menu.

	@returns Fusion.Component
--]]
local function home()
	local buttonSprings = handleButtonSprings()

	return frame({
		Size = UDim2.fromScale(0.3, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Fusion.Children] = {
			list({
				Padding = UDim.new(0, 15),
			}),

			subMenuButton({
				text = "players",
				subMenu = "players",
				spring = buttonSprings[1],
			}),

			subMenuButton({
				text = "settings",
				subMenu = "settings",
				spring = buttonSprings[2],
			}),

			subMenuButton({
				text = "credits",
				subMenu = "credits",
				spring = buttonSprings[3],
			}),

			subMenuButton({
				text = "codes",
				subMenu = "codes",
				spring = buttonSprings[3],
			}),
		},
	}, {})
end

return home
