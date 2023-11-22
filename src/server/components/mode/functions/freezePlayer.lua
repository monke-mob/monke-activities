--[[
    Freezes a player and makes them invisible.

    @param {Player} player [The player.]
    @param {boolean} frozen [Whether to freeze the player or not.]
    @returns never
]]
local function freezePlayer(player: Player, frozen: boolean)
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
