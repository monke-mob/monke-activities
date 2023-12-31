--[[
    The most basic score plugin, it does nothing on its own besides providing a function to increment score.

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
    should gothrough the score plugin.

    @returns class
]]
function class:incrementScore(...)
    self._mode.teamPlugin:incrementTeamScore(...)
end

return class
