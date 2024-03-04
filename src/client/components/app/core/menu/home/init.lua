local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.Parent.components.frame)
local handleButtonSprings = require(script.handleButtonSprings)
local list = require(script.Parent.Parent.Parent.components.list)
local logo = require(script.logo)
local subMenuButton = require(script.subMenuButton)
local theme = require(script.Parent.Parent.Parent.theme)

--[[
	NOTE: This does not use the sub menu component because it is the main menu.
	
	Handles the home menu.

	@returns Fusion.Component
--]]
local function home()
    local buttonSprings = handleButtonSprings()

    return frame({
        Size = UDim2.fromScale(1, 1),

        [Fusion.Children] = {
            logo(),

            frame({
                Size = UDim2.fromScale(0.3, 1),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),

                [Fusion.Children] = {
                    list({
                        Padding = UDim.new(0, 15),
                    }),

                    subMenuButton({
                        text = "players",
                        subMenu = "playerList",
                        spring = buttonSprings[1],
                        icon = theme.icons.player,
                    }),

                    subMenuButton({
                        text = "settings",
                        subMenu = "settings",
                        spring = buttonSprings[2],
                        icon = theme.icons.settings,
                    }),

                    subMenuButton({
                        text = "credits",
                        subMenu = "credits",
                        spring = buttonSprings[3],
                        icon = theme.icons.credits,
                    }),

                    subMenuButton({
                        text = "codes",
                        subMenu = "codes",
                        spring = buttonSprings[3],
                        icon = theme.icons.codes,
                    }),
                },
            }, {}),
        },
    }, {})
end

return home
