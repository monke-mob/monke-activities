local teamPlugin = require(script.Parent.team)

--[[
    This plugin simply extends the team plugin and assigns each player their own team.

    @class
    @public
    @extends teamPlugin
]]
local class = {}
class.__index = class
setmetatable(class, teamPlugin)

export type class = teamPlugin.class

--[[
    Creates and starts the single player plugin.

    @constructor
    @param {{ number }} players [The players.]
    @returns class
]]
function class.new(players: { number }): class
    local teams: { teamPlugin.constructorTeam } = {}

    -- Assign each player their own team.
    for _index: number, player: number in pairs(players) do
        table.insert(teams, {
            id = player,
            players = {
                player,
            },
        })
    end

    local baseClass = teamPlugin.new(teams)
    local self = setmetatable(baseClass, class)
    return self
end

--[[
    This is the same thing as the incrementTeamScore in the teamPlugin but is adds the `scoringPlayer` param.

    @extends teamPlugin.incrementTeamScore
    @returns never
]]
function class:incrementTeamScore(...)
    teamPlugin.incrementTeamScore(self, ..., self.id)
end

return class
