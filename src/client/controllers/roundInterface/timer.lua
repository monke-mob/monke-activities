local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local TIMER = require(ReplicatedStorage.constants.TIMER)

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

local roundTimerController = Knit.CreateController({
	Name = "roundTimer",
	time = nil,
})

--[[
	@returns never
--]]
function roundTimerController:KnitInit()
	ReplicatedStorage:GetAttributeChangedSignal(TIMER):Connect(function()
		local timeInSeconds: number = ReplicatedStorage:GetAttribute(TIMER)
		local timeFormatted: string = formatTime(timeInSeconds)
		self.time = timeFormatted
		timerAction:set(timeFormatted)
	end)
end

return roundTimerController
