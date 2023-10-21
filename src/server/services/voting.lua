-- NOTE: This service is intended to handle map and gamemode voting, while it has the ability to handle any vote it is not recommended!
-- In the future a good idea would be to expand this service to allow for any type of voting.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local IS_VOTING = require(ReplicatedStorage.constants.IS_VOTING)
local VOTING = require(script.Parent.Parent.constants.VOTING)
local VOTING_STAGE = require(ReplicatedStorage.constants.VOTING_STAGE)
local VOTING_TIMER = require(ReplicatedStorage.constants.VOTING_TIMER)

local timerComponent = require(script.Parent.Parent.components.timer)
local types = require(ReplicatedStorage.types)

local votingService = Knit.CreateService({
    Name = "voting",
    _timer = timerComponent.new(VOTING.timePerStage),
    _state = {
        chosen = {
            map = nil,
            gamemode = nil,
        },
        options = {},
    },
})

--[[
	@returns never
]]
function votingService:KnitInit()
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
    self:_setStage("map", {})
end

--[[
    Returns the voting options.

	@returns { types.votingOption }
]]
function votingService.Client:getOptions(): { types.votingOption }
    return self._state.options
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
    Sets the vote stage.

    @private
    @param {string} stage [The stage.]
    @param {{ types.votingOption }} options [The voting options.]
	@returns never
]]
function votingService:_setStage(stage: string, options: { types.votingOption })
    ReplicatedStorage:SetAttribute(VOTING_STAGE, stage)
    self._timer:restart()

    local endedConnection: RBXScriptConnection
    endedConnection = self._timer.ended:Connect(function()
        endedConnection:Disconnect()

        if stage == "map" then
        elseif stage == "voting" then
            self:_stop()
        end
    end)
end

return votingService
