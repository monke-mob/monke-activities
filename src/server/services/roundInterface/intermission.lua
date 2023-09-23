local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local ROUND = require(script.Parent.Parent.Parent.constants.ROUND)

local timerComponent = require(script.Parent.Parent.Parent.components.timer)

local intermissionService = Knit.CreateService({
	Name = "intermission",
	_roundService = nil,
	state = {
		-- Possible states: "waiting" or "intermission"
		stateName = "",
		players = {},
		timer = nil,
	},
})

--[[
	@returns never
]]
function intermissionService:KnitStart()
	self._roundService = Knit.GetService("round")
end

--[[
    Toggles if a player is ready or unready.

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

	local playersReady: number = #self._lobbyState.players

	if self._lobbyState.stateName == "waiting" and playersReady >= ROUND.minimumPlayers then
		self._intermissionService:start()
	elseif self._lobbyState.stateName == "intermission" and playersReady < ROUND.minimumPlayers then
		self._intermissionService:waitForPlayers()
	end
end

--[[
	Starts a intermission.

	@private
	@returns never
]]
function intermissionService:_start()
	local timer = timerComponent.new(ROUND.intermissionTime)
	timer:start()
	self.state.timer = timer

	-- If this event fires that means that the round can start. So send a request to the interface to start.
	timer.ended:Connect(function()
		self:stop()
		self._roundService:start()
	end)
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
