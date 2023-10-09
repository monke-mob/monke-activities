local roundTypes = require(script.Parent.Parent.Parent.types)

local baseEndConditionPlugin = require(script.Parent.base)

--[[
    The class for a timed mode that gives player points for the longer they survive.

    @class
    @public
    @extends baseEndConditionPlugin
]]
local class = {}
class.__index = class
setmetatable(class, baseEndConditionPlugin)

--[[
    Creates the end condition.

    @constructor
    @param {roundTypes.endConditionConfig} config [The config.]
    @param {roundTypes.incrementTeamScore} incrementTeamScore [The function to update a teams score.]
    @returns class
]]
function class.new(config: roundTypes.endConditionConfig, incrementTeamScore: roundTypes.incrementTeamScore)
	local baseClass = baseEndConditionPlugin.new(config.duration)
	local self = setmetatable(baseClass, class)

	-- (... :: any) fixes a type warning.
	self._increment = (config.time :: any).pointsPerIncrement
	self._incrementTeamScore = incrementTeamScore

	self.timer.updated:Connect(function()
		self:_incrementScores()
	end)

	return self
end

--[[
    Increments every teams score.

    @returns class
]]
function class:_incrementScores()
	self._incrementTeamScore("UPDATE_ALL", self._increment)
end

return class
