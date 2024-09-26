local Players = game:GetService("Players")

local PlayerService = {
    characters = {},
    playerCount = #Players:GetPlayers(),
}

Players.PlayerAdded:Connect(function()
    PlayerService.playerCount += 1
end)

Players.PlayerRemoving:Connect(function()
    PlayerService.playerCount -= 1
end)

return PlayerService
