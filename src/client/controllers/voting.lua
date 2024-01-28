local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local canToggleMenuAction = require(script.Parent.Parent.components.app.actions.menu.canToggle)
local menuOpenAction = require(script.Parent.Parent.components.app.actions.menu.open)
local optionsAction = require(script.Parent.Parent.components.app.actions.voting.options)
local roundInfoVisibleAction = require(script.Parent.Parent.components.app.actions.round.visible)
local stageAction = require(script.Parent.Parent.components.app.actions.voting.stage)
local timerAction = require(script.Parent.Parent.components.app.actions.voting.timer)
local types = require(ReplicatedStorage.types)
local updateTimeAction = require(script.Parent.Parent.functions.updateTimeAction)
local votesAction = require(script.Parent.Parent.components.app.actions.voting.votes)
local votingAction = require(script.Parent.Parent.components.app.actions.voting.voting)
local votingService

local votingController = Knit.CreateController({
    Name = "voting",
    _votes = {},
})

--[[
	@returns never
--]]
function votingController:KnitStart()
    votingService = Knit.GetService("voting")

    self:_toggleVoting()

    votingService.toggleVoting:Connect(function(...)
        self:_toggleVoting(...)
    end)

    votingService.setStage:Connect(function(...)
        self:_stageUpdated(...)
    end)

    votingService.updateVoteCount:Connect(function(...)
        self:_updateVoteCount(...)
    end)

    votingService.timer:Observe(function(time: number)
        updateTimeAction(timerAction, time)
    end)
end

--[[
	Updates the voting action.
    
	@private
	@returns never
--]]
function votingController:_toggleVoting(voting: boolean)
    if typeof(voting) ~= "boolean" then
        local _success: boolean, isStarted: boolean = votingService:isStarted():await()
        voting = isStarted
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
    votingService:getOptions():andThen(function(options: { types.votingOption })
        for index: number, _option: types.votingOption in ipairs(options) do
            self:_updateVoteCount(index, 0)
        end

        optionsAction:set(options)
    end)
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
