local teamPlugin = require(script.Parent.team)

--[[
    The class for a single player mode.

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

    for _index: number, player: number in pairs(players) do
        table.insert(teams, {
            id = player,
            players = {
                player,
            },
        })
    end

    local baseClass = teamPlugin.new(teams)
    return setmetatable(baseClass, class)
end

return class
