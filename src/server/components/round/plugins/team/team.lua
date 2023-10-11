export type team = {
	scoreLocked: boolean,
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

--[[
    The class for a team mode.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
	teams: teams,
	destroy: () -> never,
	incrementTeamScore: (teamID: teamID, increment: number) -> never,
}

--[[
    Creates and starts the team plugin.

    @constructor
    @param {{ constructorTeam }} constructorTeams [The list of teams.]
    @returns class
]]
function class.new(constructorTeams: { constructorTeam }): class
	local teams: teams = {}

	for _index: number, team: constructorTeam in pairs(constructorTeams) do
		teams[team.id] = {
			scoreLocked = false,
			score = 0,
			players = team.players,
		}
	end

	local self = setmetatable({
		teams = teams,
	}, class)
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
    Prevents a team from gaining any score. This will most likely be called whenever a team is dead.

    @param {teamID} teamID [The team.]
    @param {number} increment [The amount to increment by.]
    @returns never
]]
function class:lockTeamScore(teamID: teamID, increment: number)
	self.teams[teamID].scoreLocked += increment
end

--[[
    Adds or subtracts from a teams score by the passed amount.

    @param {teamID} teamID [The team.]
    @param {number} increment [The amount to increment by.]
    @returns never
]]
function class:incrementTeamScore(teamID: teamID, increment: number)
	if self.teams[teamID].scoreLocked then
		return
	end

	self.teams[teamID].score += increment
end

return class
