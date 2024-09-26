local ServerScriptService = game:GetService("ServerScriptService")

local PlayerService = require(ServerScriptService.Services.Player)
local SceneService = require(ServerScriptService.Services.Scene)

local players: number = 1

-- Wait until all the players have loaded.
while PlayerService.playerCount < players do
    task.wait()
end

task.wait(5)

SceneService:load("Intro")