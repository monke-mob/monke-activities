export type team = {
	score: number,
	players: {
		[number]: number,
	},
}

type teamID = string | number

type teams = {
	[teamID]: team,
}

export type constructorTeam = {
	id: teamID,
	players: {
		[number]: number,
	},
}

--[[
    The class for a team mode.

    @class
    @public
]]
local class = {}
class.__index = class

--[[
    Creates and starts the team plugin.

    @constructor
    @param {{ constructorTeam }} constructorTeams [The list of teams.]
    @returns class
]]
function class.new(constructorTeams: { constructorTeam })
	local teams: teams = {}

	for _index: number, team: constructorTeam in pairs(constructorTeams) do
		teams[team.id] = {
			score = 0,
			players = team.players,
		}
	end

	return setmetatable({
		_teams = teams,
	}, class)
end

--[[
    Adds or subtracts from a teams score by the passed amount.

    @param {teamID} teamID [The team.]
    @param {number} increment [The amount to increment by.]
    @returns never
]]
function class:incrementTeamScore(teamID: teamID, increment: number)
	self._teams[teamID] += increment
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

return class
