local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local IS_VOTING = require(ReplicatedStorage.constants.IS_VOTING)
local VOTING_STAGE = require(ReplicatedStorage.constants.VOTING_STAGE)
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
    self:_stageUpdated()
    self:_timerUpdated()

    ReplicatedStorage:GetAttributeChangedSignal(IS_VOTING):Connect(function()
        self:_isVotingUpdated()
    end)

    ReplicatedStorage:GetAttributeChangedSignal(VOTING_STAGE):Connect(function()
        self:_stageUpdated()
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
function votingController:_isVotingUpdated()
    votingAction:set(ReplicatedStorage:GetAttribute(IS_VOTING))
end

--[[
	Updates the stage action with the new stage.
    
	@private
	@returns never
--]]
function votingController:_stageUpdated()
    stageAction:set(ReplicatedStorage:GetAttribute(VOTING_STAGE))

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
