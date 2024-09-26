local Players = game:GetService("Players")

local PlayerService = require(script.Parent.Parent.Parent.Services.Player)
local AvatarService = require(script.Parent.Parent.Parent.Services.Avatar)
local CollisionService = require(script.Parent.Parent.Parent.Services.Collision)

local avatars: { AvatarService.Avatar } = {}

--[[
    Handles a new player character.

    @returns never
]]
function newCharacter(player: Player, character: Model)
    PlayerService.characters[player.UserId] = character
    AvatarService:apply(character, avatars[player.UserId])
    CollisionService:setInstanceGroup(character, "player")
end

Players.PlayerAdded:Connect(function(player: Player)
    avatars[player.UserId] = AvatarService.DEFAULT_AVATAR

    if player.Character then
        newCharacter(player, player.Character)
    end

    player.CharacterAdded:Connect(function(character: Model)
        newCharacter(player, character)
    end)
end)

Players.PlayerRemoving:Connect(function(player: Player)
    avatars[player.UserId] = nil
    PlayerService.characters[player.UserId] = nil
end)