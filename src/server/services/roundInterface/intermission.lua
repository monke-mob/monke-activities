local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local ROUND = require(script.Parent.Parent.Parent.constants.ROUND)

local timerComponent = require(script.Parent.Parent.Parent.components.timer)

local intermissionService = Knit.CreateService({
    Name = "intermission",
    _roundInterface = nil,
    _roundService = nil,
    _votingService = nil,
    _state = {
        -- Possible states: "waiting" or "intermission"
        stateName = "",
        players = {},
        timer = nil,
    },
})

--[[
	@returns never
]]
function intermissionService:KnitInit()
    self._state.stateName = "waiting"
end

--[[
	@returns never
]]
function intermissionService:KnitStart()
    self._roundInterface = Knit.GetService("roundInterface")
    self._roundService = Knit.GetService("round")
    self._votingService = Knit.GetService("voting")
end

--[[
    Toggles if a player is ready or unready. This is apart of the intermission service, because being ready
	only really matters whenever the intermission in on-going.

    @param {Player} player [The player.]
    @param {boolean} isReady [The ready state.]
    @returns never
]]
function intermissionService:setReady(player: Player, isReady: boolean)
    local playerIndexInLobby: number? = table.find(self._state.players, player.UserId)

    if isReady and playerIndexInLobby == nil then
        table.insert(self._state.players, player.UserId)
    elseif isReady == false and playerIndexInLobby ~= nil then
        table.remove(self._state.players, playerIndexInLobby)
    end

    self:attemptStart()
    self._roundInterface:updatePlayerCount(#self._state.players)
end

--[[
    @client
    @extends setReady
]]
function intermissionService.Client:setReady(...: any)
    self.Server:setReady(...)
end

--[[
	Determines if the intermission can be started or if the intermission needs to be stopped
    based on the player count.

	@returns never
]]
function intermissionService:attemptStart()
    -- If a round is already started there is no need to determine anything.
    if self._roundService:isStarted() then
        return
    end

    local playersReady: number = #self._state.players

    if self._state.stateName == "waiting" and playersReady >= ROUND.minimumPlayers then
        self:_start()
    elseif self._state.stateName == "intermission" and playersReady < ROUND.minimumPlayers then
        self:_waitForPlayers()
    end
end

--[[
	Starts a intermission.

	@private
	@returns never
]]
function intermissionService:_start()
    local timer = timerComponent.new(ROUND.intermissionTime)

    self._roundInterface:bindTimer(timer)
    self._state.timer = timer

    timer:start()

    -- If this event fires that means that the round can start. So send a request to the interface to start.
    timer.ended:Connect(function()
        self:_stop()
        self._roundService:start(self._state.players)
    end)

    self._votingService:start()
end

--[[
	Stops a intermission.

	@private
	@returns never
]]
function intermissionService:_stop()
    if self._state.timer == nil then
        return
    end

    self._state.timer:destroy()
    self._state.timer = nil
end

--[[
	Sets the state to waiting for players.

	@private
	@returns never
]]
function intermissionService:_waitForPlayers()
    self:stop()
    self._state.stateName = "waiting"
end

return intermissionService
