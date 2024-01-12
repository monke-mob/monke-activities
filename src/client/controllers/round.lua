local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local PLAYER_COUNT = require(ReplicatedStorage.constants.PLAYER_COUNT)
local TIMER = require(ReplicatedStorage.constants.TIMER)

local playerCountAction = require(script.Parent.Parent.components.app.actions.round.playerCount)
local timerAction = require(script.Parent.Parent.components.app.actions.round.timer)
local updateTimeActionWithAttribute = require(script.Parent.Parent.functions.updateTimeActionWithAttribute)

local roundDataController = Knit.CreateController({
    Name = "roundData",
})

--[[
	@returns never
--]]
function roundDataController:KnitInit()
    self:_playerCountUpdated()
    self:_timerUpdated()

    ReplicatedStorage:GetAttributeChangedSignal(PLAYER_COUNT):Connect(self._playerCountUpdated)
    ReplicatedStorage:GetAttributeChangedSignal(TIMER):Connect(self._timerUpdated)
end

--[[
	Updates the player count action with the new player count.
	
    @private
	@returns never
--]]
function roundDataController:_playerCountUpdated()
    local playerCount: number = ReplicatedStorage:GetAttribute(PLAYER_COUNT)
    playerCountAction:set(playerCount)
end

--[[
	Updates the timer action with the new time.
    
	@private
	@returns never
--]]
function roundDataController:_timerUpdated()
    updateTimeActionWithAttribute(timerAction, TIMER)
end

return roundDataController
