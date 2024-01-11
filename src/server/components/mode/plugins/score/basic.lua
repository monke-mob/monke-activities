--[[
    The most basic score plugin, it does nothing on its own besides providing a function to increment score.
    This plugin is intended for use with modes that have a custom scoring system but dont need a plugin to do assign scoring.
    Take the climbing mode for example: it gives users a score whenever their turn is finished and based on how far they went, no need
    for it to be a custom plugin but just use this plugin to give scores.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    incrementScore: () -> never,
}

--[[
    Creates the score plugin.

    @constructor
    @param {modeComponent.class} mode [The mode.]
    @returns class
]]
function class.new(mode): class
    local self = setmetatable({
        _mode = mode,
    }, class)
    return self
end

--[[
    Increments a team score. This is just a wrapper around `incrementTeamScore` but all scoring
    should go through the score plugin.

    @returns class
]]
function class:incrementScore(...)
    self._mode.teamPlugin:incrementTeamScore(...)
end

return class
