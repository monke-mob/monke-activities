local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local modeComponent = require(script.Parent.Parent.Parent.components.mode.modes)

local mapService
local modeService
local votingService

local roundService = Knit.CreateService({
    Name = "round",
    _state = {
        started = false,
        roundType = "",
        players = {},
    },
})

--[[
	@returns never
]]
function roundService:KnitStart()
    mapService = Knit.GetService("map")
    modeService = Knit.GetService("mode")
    votingService = Knit.GetService("voting")
end

--[[
	Starts a round.

	@param {modeComponent.players} players [The players.]
	@returns never
]]
function roundService:start(players: modeComponent.players)
    self._state.started = true

    local results: { [string]: string } = votingService:getResults()
    mapService:load(results.map)
    modeService:load(results.mode, players)
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

    local scores = modeService:getMode():getScores()
    print(scores)

    mapService:remove()
    modeService:remove()
end

return roundService
