local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local modeService

Knit:OnStart():andThen(function()
    modeService = Knit.GetService("mode")
end)

--[[
    NOTE: All scores are held by the team plugins the score plugins give a wrapper around the team plugin functions
    and handle any extra features. However, all scoring should go through the score plugins regardless.

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
    @returns class
]]
function class.new(): class
    local self = setmetatable({}, class)
    return self
end

--[[
    Destroys the object, clears, and freezes it to render is unusable.

    @returns never
]]
function class:destroy()
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Increments a team score. This is just a wrapper around `incrementTeamScore` but all scoring
    should go through the score plugin.

    @returns class
]]
function class:incrementScore(...)
    modeService:getMode().teamPlugin:incrementTeamScore(...)
end

return class
