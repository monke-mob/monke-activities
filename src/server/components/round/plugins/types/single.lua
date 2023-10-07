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

--[[
    Creates and starts the single player plugin.

    @constructor
    @param {{ number }} players [The players.]
    @returns class
]]
function class.new(players: { number })
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
	local self = setmetatable(baseClass, class)
	return self
end

return class