local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local handleButtonSprings = require(script.handleButtonSprings)
local frame = require(script.Parent.Parent.Parent.components.frame)
local list = require(script.Parent.Parent.Parent.components.list)
local subMenuButton = require(script.subMenuButton)
local shop = require(script.shop)

--[[
	Handles the home menu.

	@returns Fusion.Component
--]]
local function home()
	local buttonSprings = handleButtonSprings()

	return frame({
		Size = UDim2.fromScale(0.275, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		[Fusion.Children] = {
			list({}),

			subMenuButton({
				text = "players",
				subMenu = "playerList",
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

			shop({
				springs = buttonSprings
			}),
		},
	}, {})
end

return home