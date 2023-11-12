local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local VOTING_TIMER = require(ReplicatedStorage.constants.VOTING_TIMER)

local optionsAction = require(script.Parent.Parent.app.actions.voting.options)
local stageAction = require(script.Parent.Parent.app.actions.voting.stage)
local timerAction = require(script.Parent.Parent.app.actions.voting.timer)
local updateTimeActionWithAttribute = require(script.Parent.Parent.functions.updateTimeActionWithAttribute)
local votingAction = require(script.Parent.Parent.app.actions.voting.voting)

local votingController = Knit.CreateController({
    Name = "voting",
    _votingService = nil,
})

--[[
	@returns never
--]]
function votingController:KnitInit()
    self._votingService = Knit.GetService("voting")

    self:_isVotingUpdated()

    self._votingService.toggleVoting:Connect(function(...)
        self:_isVotingUpdated(...)
    end)

    self._votingService.setStage:Connect(function(...)
        self:_stageUpdated(...)
    end)

    ReplicatedStorage:GetAttributeChangedSignal(VOTING_TIMER):Connect(function()
        self:_timerUpdated()
    end)
end

--[[
	Updates the voting action.
    
	@private
	@returns never
--]]
function votingController:_isVotingUpdated(isVoting: boolean)
    if typeof(isVoting) ~= "boolean" then
        local _worked: boolean, isVotingPromise: boolean = self._votingService:isStarted():await()
        isVoting = isVotingPromise
    end

    votingAction:set(isVoting)
end

--[[
	Updates the stage action with the new stage.
    
	@private
	@returns never
--]]
function votingController:_stageUpdated(stage: string)
    stageAction:set(stage)

    -- The options need updated, as this is a new stage.
    self._votingService:getOptions():andThen(function(options)
        optionsAction:set(options)
    end)
end

--[[
	Updates the timer action with the new time.
    
	@private
	@returns never
--]]
function votingController:_timerUpdated()
    updateTimeActionWithAttribute(timerAction, VOTING_TIMER)
end

return votingController
