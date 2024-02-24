local Players = game:GetService("Players")

--[[
    Teleports a player to a position.

    @param {number} userID [The ID of the player.]
    @param {CFrame} position [The position to teleport the player to.]
    @returns never
]]
local function teleportPlayer(userID: number, position: CFrame)
    local player: Player = Players:GetPlayerByUserId(userID)
    local character: Model = player.Character or player.CharacterAdded:Wait()
    -- Adding the half of the height makes the feet be at the teleport point instead of the torso.
    character:PivotTo(position + Vector3.new(0, character:GetPivot().Y / 2, 0))
end

return teleportPlayer
