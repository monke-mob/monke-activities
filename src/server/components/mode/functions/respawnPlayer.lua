local Players = game:GetService("Players")

--[[
    Respawns a player.

    @param {number} player [The ID of the player.]
    @returns never
]]
local function respawnPlayer(player: number)
    local playerInstance: Player = Players:GetPlayerByUserId(player)
    playerInstance:LoadCharacter()
end

return respawnPlayer
