local ServerScriptService = game:GetService("ServerScriptService")

local AvatarService = require(ServerScriptService.Services.Avatar)
local PlayerService = require(ServerScriptService.Services.Player)

local Server = {}

function Server:prepare()
    for _, character: Model in pairs(PlayerService.characters) do
        AvatarService:setTransparency(character, 1);
        (character:FindFirstChild("HumanoidRootPart") :: BasePart).Anchored = true
    end
end

function Server:load() end

function Server:unload()
    for _, character: Model in pairs(PlayerService.characters) do
        AvatarService:setTransparency(character, 0);
        (character:FindFirstChild("HumanoidRootPart") :: BasePart).Anchored = false
    end
end

return Server
