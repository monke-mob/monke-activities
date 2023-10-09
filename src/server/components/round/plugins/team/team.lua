export type team = {
	score: number,
	players: {
		[number]: number,
	},
}

export type teamID = string | number

export type teams = {
	[teamID]: team,
}

export type constructorTeam = {
	id: teamID,
	players: {
		[number]: number,
	},
}

local UPDATE_ALL_KEY = "UPDATE_ALL"

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
		teams = teams,
	}, class)
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
    Adds or subtracts from a teams score by the passed amount.

    @param {teamID} teamID [The team.]
    @param {number} increment [The amount to increment by.]
    @returns never
]]
function class:incrementTeamScore(teamID: teamID, increment: number)
	if teamID == UPDATE_ALL_KEY then
		for teamID: teamID, _team: team in pairs(self.teams) do
			self:incrementTeamScore(teamID, increment)
		end

		return
	end

	self.teams[teamID].score += increment
end

return class
