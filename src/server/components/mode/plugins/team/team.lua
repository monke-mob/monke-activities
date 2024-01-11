type teamPlayer = {
    score: number,
    removed: boolean,
}

export type team = {
    scoreLocked: boolean,
    score: number,
    players: {
        [number]: teamPlayer,
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
    The basic class for a team plugin.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    _teams: teams,
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
        local players: { [number]: teamPlayer } = {}

        for _index: number, player: number in ipairs(team.players) do
            players[player] = {
                score = 0,
                removed = false,
            }
        end

        teams[team.id] = {
            scoreLocked = false,
            score = 0,
            players = players,
        }
    end

    local self = setmetatable({
        _teams = teams,
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
    Prevents a team from gaining any score. This is most likely called whenever a teams players are dead or when they all leave.

    @param {teamID} teamID [The team.]
    @returns never
]]
function class:lockTeamScore(teamID: teamID)
    self._teams[teamID].scoreLocked = true
end

--[[
    Attempts to lock a teams score. If all players are removed then it will lock.

    @param {teamID} teamID [The team.]
    @returns never
]]
function class:attemptToLockTeamScore(teamID: teamID)
    local allPlayersRemoved: boolean = true

    for player: number, playerData in pairs(self._teams[teamID].players) do
        if playerData.removed == false then
            allPlayersRemoved = false
            break
        end
    end

    if allPlayersRemoved then
        self:lockTeamScore(teamID)
    end
end

--[[
    Sets a players removed status to true.

    @param {teamID} teamID [The team.]
	@param {number} player [The player.]
    @returns never
]]
function class:removePlayerFromTeam(teamID: teamID, player: number)
    self._teams[teamID].players[player].removed = true
    self:attemptToLockTeamScore(teamID)
end

--[[
    Adds or subtracts from a teams score by the passed amount.

    @param {teamID} teamID [The team.]
    @param {number} increment [The amount to increment by.]
    @returns never
]]
function class:incrementTeamScore(teamID: teamID, increment: number, scoringPlayer: number?)
    if self._teams[teamID].scoreLocked then
        return
    end

    self._teams[teamID].score += increment

    if scoringPlayer ~= nil then
        self._teams[teamID].players[scoringPlayer].score += increment
    end
end

--[[
    Returns the team that the player is in.

    @param {number} player [The player.]
    @returns teamID?
]]
function class:findTeamFromPlayer(player: number): teamID?
    for teamID: teamID, team: team in pairs(self._teams) do
        if team.players[player] ~= nil then
            return teamID
        end
    end

    return nil
end

return class
