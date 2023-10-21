local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local IS_VOTING = require(ReplicatedStorage.constants.IS_VOTING)
local VOTING_STAGE = require(ReplicatedStorage.constants.VOTING_STAGE)
local VOTING_TIMER = require(ReplicatedStorage.constants.VOTING_TIMER)

local updateTimeActionWithAttribute = require(script.Parent.Parent.functions.updateTimeActionWithAttribute)
local timerAction = require(script.Parent.Parent.app.actions.voting.timer)
local stageAction = require(script.Parent.Parent.app.actions.voting.stage)
local votingAction = require(script.Parent.Parent.app.actions.voting.voting)

local votingController = Knit.CreateController({
    Name = "voting",
})

--[[
	@returns never
--]]
function votingController:KnitInit()
    ReplicatedStorage:GetAttributeChangedSignal(IS_VOTING):Connect(self._isVotingUpdated)
    ReplicatedStorage:GetAttributeChangedSignal(VOTING_STAGE):Connect(self._stageUpdated)
    ReplicatedStorage:GetAttributeChangedSignal(VOTING_TIMER):Connect(self._timerUpdated)
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
