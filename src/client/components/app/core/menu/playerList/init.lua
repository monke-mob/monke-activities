local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local body = require(script.body)
local playerListAction = require(script.Parent.Parent.Parent.actions.menu.playerList)
local subMenu = require(script.Parent.subMenu)

--[[
	Handles the player list.

	@returns Fusion.Component
--]]
local function playerList()
    return subMenu({
        [Fusion.Children] = {
            body(),
        },
    }, {
        header = "players",
        action = playerListAction.open,
    })
end

return playerList
