-- NOTE: This service is intended to handle map and gamemode voting, while it has the ability to handle any vote it is not recommended!
-- In the future a good idea would be to expand this service to allow for any type of voting.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local IS_VOTING = require(ReplicatedStorage.constants.IS_VOTING)
local VOTING = require(script.Parent.Parent.constants.VOTING)
local VOTING_STAGE = require(ReplicatedStorage.constants.VOTING_STAGE)
local VOTING_TIMER = require(ReplicatedStorage.constants.VOTING_TIMER)

local mapTypes = require(script.Parent.Parent.components.map.types)
local modeTypes = require(script.Parent.Parent.components.mode.types)
local timerComponent = require(script.Parent.Parent.components.timer)
local types = require(ReplicatedStorage.types)

local votingService = Knit.CreateService({
    Name = "voting",
    _mapService = nil,
    _modeService = nil,
    _timer = timerComponent.new(VOTING.timePerStage),
    _state = {
        chosen = {
            map = nil,
            gamemode = nil,
        },
        options = {},
        alreadyVoted = {},
        votes = {},
        results = {},
    },
})

--[[
	@returns never
]]
function votingService:KnitInit()
    self._mapService = Knit.GetService("map")
    self._modeService = Knit.GetService("mode")

    ReplicatedStorage:SetAttribute(IS_VOTING, false)
    ReplicatedStorage:SetAttribute(VOTING_STAGE, "")
    ReplicatedStorage:SetAttribute(VOTING_TIMER, 0)

    self._timer.updated:Connect(function(timeRemaining: number)
        ReplicatedStorage:SetAttribute(VOTING_TIMER, timeRemaining)
    end)
end

--[[
    Starts the vote.

	@returns never
]]
function votingService:start()
    ReplicatedStorage:SetAttribute(IS_VOTING, true)
    -- TODO: Implement blacklisted maps, aka maps that where used in last rounds selection.
    self:_setStage("map", self._mapService:getRandomMapInfos(2, {}))
end

--[[
    Returns the results.

	@returns { types.votingOption }
]]
function votingService:getResults(): { [string]: string }
    return self._state.results
end

--[[
    Returns the voting options.

	@returns { types.votingOption }
]]
function votingService.Client:getOptions(): { types.votingOption }
    return self.Server._state.options
end

--[[
    Votes for a option.

    @param {Player} player [The player.]
	@returns never
]]
function votingService.Client:vote(player: Player, voteID: number)
    if table.find(self.Server._state.alreadyVoted, player.UserId) or self.Server._state.results[voteID] ~= nil then
        return
    end

    self.Server._state.votes[voteID] += 1
end

--[[
    Stops the vote.

    @private
	@returns never
]]
function votingService:_stop()
    ReplicatedStorage:SetAttribute(IS_VOTING, false)
    self._state.options = {}
end

--[[
    Gets the result of the voting.

    @private
	@returns mapTypes.info | modeTypes.info
]]
function votingService:_getVotingResult(): mapTypes.info | modeTypes.info
    local result: mapTypes.info | modeTypes.info
    local resultVotes: number = 0

    for index: number, votes: number in ipairs(self._state.votes) do
        -- We also make sure that the result is not nil. If it is then we dont want to continue, we to set a result.
        if votes <= resultVotes and result ~= nil then
            continue
        end

        result = self._state.options[index]
        resultVotes = votes
    end

    return result
end

--[[
    Sets the vote stage.

    @private
    @param {string} stage [The stage.]
    @param {{ types.votingOption }} options [The voting options.]
	@returns never
]]
function votingService:_setStage(stage: string, options: { types.votingOption })
    self._state.options = options
    ReplicatedStorage:SetAttribute(VOTING_STAGE, stage)
    self._timer:restart()
    self._state.votes = {}

    -- Set the option votes to 0.
    for index: number, _option: types.votingOption in ipairs(options) do
        self._state.votes[index] = 0
    end

    local endedConnection: RBXScriptConnection
    endedConnection = self._timer.ended:Connect(function()
        endedConnection:Disconnect()
        endedConnection = nil :: any

        local result = self:_getVotingResult()
        self._state.results[stage] = result.id

        if stage == "map" then
            local mapConfig: mapTypes.config = self._mapService:getConfigFromID(result.id)
            self:_setStage("mode", self._modeService:getRandomModesFromMap(3, mapConfig))
        elseif stage == "mode" then
            self:_stop()
        end
    end)
end

return votingService
