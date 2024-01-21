local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

--[[
	Handles the player list value.

	@returns springsComponent.springs
--]]
local function handleList()
    local playerList = Fusion.Value({})

    local function updateList()
        local list = {}

        for _index: number, player: Player in pairs(Players:GetPlayers()) do
            table.insert(list, player)
        end

        playerList:set(list)
    end

    updateList()
    Players.PlayerAdded:Connect(updateList)
    Players.PlayerRemoving:Connect(updateList)

    return playerList
end

return handleList
