local Players = game:GetService("Players")

--[[
    Freezes a player and makes them invisible.

    @param {number} userID [The ID of the player.]
    @param {boolean} frozen [Whether to freeze the player or not.]
    @returns never
]]
local function freezePlayer(userID: number, frozen: boolean)
    local player: Player = Players:GetPlayerByUserId(userID)
    local character: Model = player.Character or player.CharacterAdded:Wait()
    local characterRoot: Part = character:FindFirstChild("HumanoidRootPart") :: any
    characterRoot.Anchored = frozen

    for _index: number, instance: BasePart in pairs(character:GetChildren() :: any) do
        if instance.Name == "HumanoidRootPart" or instance:IsA("BasePart") == false then
            continue
        end

        instance.Transparency = if frozen then 1 else 0
    end
end

return freezePlayer
