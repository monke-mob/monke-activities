local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local PLAYER_COUNT = require(ReplicatedStorage.constants.PLAYER_COUNT)
local TIMER = require(ReplicatedStorage.constants.TIMER)

local playerCountAction = require(script.Parent.Parent.Parent.app.actions.round.playerCount)
local timerAction = require(script.Parent.Parent.Parent.app.actions.round.timer)

--[[
	Formats a time (in seconds) to MM:SS.

	@param {number} seconds [The amount of seconds.]
	@returns string
]]
local function formatTime(seconds: number): string
    local minutes: number = math.floor(seconds / 60)
    return string.format("%02d:%02d", minutes, seconds % 60)
end

local roundDataController = Knit.CreateController({
    Name = "roundData",
})

--[[
	@returns never
--]]
function roundDataController:KnitInit()
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
    local timeInSeconds: number = ReplicatedStorage:GetAttribute(TIMER)
    local timeFormatted: string = formatTime(timeInSeconds)
    timerAction:set(timeFormatted)
end

return roundDataController
