local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local intermissionService
local roundService

local roundInterfaceService = Knit.CreateService({
    Name = "roundInterface",
    _playerJanitor = Janitor.new(),
    _timer = nil,
    Client = {
        playerCount = Knit.CreateProperty(0),
        timer = Knit.CreateProperty(0),
    },
})

--[[
	@returns never
]]
function roundInterfaceService:KnitStart()
    intermissionService = Knit.GetService("intermission")
    roundService = Knit.GetService("round")

    Players.PlayerAdded:Connect(function(...)
        self:_handlePlayer(...)
    end)

    Players.PlayerRemoving:Connect(function(...)
        self:_playerLeaving(...)
    end)
end

--[[
	Binds the timer to the state allowing the clients to track the time via the timer attribute.

	@param {} timer [The timer instance.]
	@returns never
]]
function roundInterfaceService:bindTimer(timer)
    if self._timer ~= nil then
        self._timer:Disconnect()
        self._timer = nil
    end

    self.Client.timer:Set(timer.timeRemaining)

    self._timer = timer.updated:Connect(function(timeRemaining: number)
        self.Client.timer:Set(timeRemaining)
    end)
end

--[[
	Updates the amount of the player count.

	@param {number} playerCount [The player count.]
	@returns never
]]
function roundInterfaceService:updatePlayerCount(playerCount: number)
    self.Client.playerCount:Set(playerCount)
end

--[[
    Handles a player.

    @private
    @param {Player} player [The new player to handle.]
	@returns never
]]
function roundInterfaceService:_handlePlayer(player: Player)
    local janitor = Janitor.new()
    janitor:Add(player.CharacterAdded:Connect(function(character: Model)
        local characterHumanoid: Humanoid = character:WaitForChild("Humanoid") :: Humanoid

        if characterHumanoid == nil then
            return
        end

        janitor:Add(
            characterHumanoid.Died:Connect(function()
                janitor:Remove("characterDied")
            end),
            "Disconnect",
            "characterDied"
        )
    end))

    self._playerJanitor:Add(janitor, "Destroy", player.UserId)
end

--[[
    Handles a player leaving.

    @private
    @param {Player} player [The player leaving.]
	@returns never
]]
function roundInterfaceService:_playerLeaving(player: Player)
    intermissionService:setReady(player, false)
    self._playerJanitor:Remove(player.UserId)

    if roundService:isStarted() then
        roundService:removePlayer(player)
    end

    intermissionService:attemptStart()
end

return roundInterfaceService
