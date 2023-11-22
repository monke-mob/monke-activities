local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local modeComponent = require(script.Parent.Parent.Parent.components.mode.modes)

local roundService = Knit.CreateService({
    Name = "round",
    _mapService = nil,
    _modeService = nil,
    _votingService = nil,
    _state = {
        started = false,
        roundType = "",
        players = {},
        map = nil,
        mode = nil,
    },
})

--[[
	@returns never
]]
function roundService:KnitStart()
    self._mapService = Knit.GetService("map")
    self._modeService = Knit.GetService("mode")
    self._votingService = Knit.GetService("voting")
end

--[[
	Starts a round.

	@param {modeComponent.players} players [The players.]
	@returns never
]]
function roundService:start(players: modeComponent.players)
    self._state.started = true

    local results: {[string]: string} = self._votingService:getResults()
    self._mapService:load(results.map)
    self._modeService:load(results.mode, players)
end

--[[
    Returns the game state.

	@returns boolean
]]
function roundService:isStarted()
    return self._state.started
end

--[[
	Stops the currently running round.

	@returns never
]]
function roundService:stop()
    if self:isStarted() == false then
        return
    end

    local scores = self._state.mode:getScores()
    print(scores)

    self._mapService:remove()
    self._modeService:remove()
end

return roundService
