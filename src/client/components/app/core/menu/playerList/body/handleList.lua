local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

--[[
	Handles the player list and player stats.

	@returns springsComponent.springs
--]]
local function handleList()
    local playerList = {
        players = Fusion.Value({}),
        stats = {},
    }

    --[[
        Updates the player list.

        @returns never
    --]]
    local function updateList()
        local list = {}
        local oldStats = playerList.stats
        playerList.stats = {}

        for _index: number, player: Player in pairs(Players:GetPlayers()) do
            table.insert(list, player)

            if oldStats[player.UserId] ~= nil then
                playerList.stats[player.UserId] = oldStats[player.UserId]
            else
                playerList.stats[player.UserId] = {}
                playerList.stats[player.UserId].score = Fusion.Value(0)

                player:GetAttributeChangedSignal("score"):Connect(function()
                    playerList.stats[player.UserId].score:set(player:GetAttribute("score"))
                end)
            end
        end

        playerList.players:set(list)
    end

    updateList()
    Players.PlayerAdded:Connect(updateList)
    Players.PlayerRemoving:Connect(updateList)

    return playerList
end

return handleList
