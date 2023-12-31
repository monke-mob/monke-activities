local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local VOTING_TIMER = require(ReplicatedStorage.constants.VOTING_TIMER)

local canToggleMenuAction = require(script.Parent.Parent.app.actions.menu.canToggle)
local menuOpenAction = require(script.Parent.Parent.app.actions.menu.open)
local optionsAction = require(script.Parent.Parent.app.actions.voting.options)
local roundInfoVisibleAction = require(script.Parent.Parent.app.actions.round.visible)
local stageAction = require(script.Parent.Parent.app.actions.voting.stage)
local timerAction = require(script.Parent.Parent.app.actions.voting.timer)
local types = require(ReplicatedStorage.types)
local updateTimeActionWithAttribute = require(script.Parent.Parent.functions.updateTimeActionWithAttribute)
local votesAction = require(script.Parent.Parent.app.actions.voting.votes)
local votingAction = require(script.Parent.Parent.app.actions.voting.voting)

local votingController = Knit.CreateController({
    Name = "voting",
    _votingService = nil,
    _votes = {},
})

--[[
	@returns never
--]]
function votingController:KnitStart()
    self._votingService = Knit.GetService("voting")

    self:_toggleVoting()

    self._votingService.toggleVoting:Connect(function(...)
        self:_toggleVoting(...)
    end)

    self._votingService.setStage:Connect(function(...)
        self:_stageUpdated(...)
    end)

    self._votingService.updateVoteCount:Connect(function(...)
        self:_updateVoteCount(...)
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
function votingController:_toggleVoting(voting: boolean)
    if typeof(voting) ~= "boolean" then
        local _success: boolean, votingPromise: boolean = self._votingService:isStarted():await()
        voting = votingPromise
    end

    votingAction:set(voting)
    roundInfoVisibleAction:set(not voting)
    menuOpenAction:set(false)
    canToggleMenuAction:set(not voting)
end

--[[
	Updates the stage action with the new stage.
    
	@private
	@returns never
--]]
function votingController:_stageUpdated(stage: string)
    stageAction:set(stage)

    -- The options need updated, as this is a new stage.
    self._votingService:getOptions():andThen(function(options: { types.votingOption })
        for index: number, _option: types.votingOption in ipairs(options) do
            self:_updateVoteCount(index, 0)
        end

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

--[[
	Updates the votes for an option.
    
	@private
	@returns never
--]]
function votingController:_updateVoteCount(id: string, votes: number)
    self._votes[id] = votes
    votesAction:set(self._votes)
end

return votingController
