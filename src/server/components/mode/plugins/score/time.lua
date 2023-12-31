local modeTypes = require(script.Parent.Parent.Parent.types)
local teamTeamPlugin = require(script.Parent.Parent.Parent.plugins.team.team)

--[[
    The class for a timed mode that gives player points for the longer they survive.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    _increment: number,
    _incrementScores: () -> never,
}

--[[
    Creates the score plugin.

    @constructor
    @param {modeComponent.class} mode [The mode.]
    @param {modeTypes.timeScoringConfig} config [The config.]
    @returns class
]]
function class.new(mode, config: modeTypes.timeScoringConfig): class
    local self = setmetatable({
        _mode = mode,
        _increment = config.pointsPerIncrement,
    }, class)

    self._mode.endConditionPlugin.timer.updated:Connect(function()
        self:_incrementScores()
    end)

    return self
end

--[[
    Increments every teams score.

    @returns class
]]
function class:_incrementScores()
    for teamID: teamTeamPlugin.teamID, _team: teamTeamPlugin.team in pairs(self._mode.teamPlugin.teams) do
        self._mode.teamPlugin:incrementTeamScore(teamID, self._increment)
    end
end

return class
