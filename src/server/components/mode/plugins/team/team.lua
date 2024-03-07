local Players = game:GetService("Players")

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
    lockTeamScore: (teamID: teamID) -> never,
    removePlayerFromTeam: (teamID: teamID, player: number) -> never,
    findTeamFromPlayer: (player: number) -> teamID?,
    _attemptToLockTeamScoreIfPlayersRemoved: (teamID: teamID) -> never,
}

--[[
    Creates and starts the team plugin.

    @constructor
    @param {{ constructorTeam }} constructorTeams [The list of teams.]
    @returns class
]]
function class.new(constructorTeams: { constructorTeam }): class
    local self = setmetatable({
        _teams = {},
    }, class)

    for _index: number, team: constructorTeam in pairs(constructorTeams) do
        local players: { [number]: teamPlayer } = {}

        for _index: number, player: number in ipairs(team.players) do
            players[player] = {
                score = 0,
                removed = false,
            }
        end

        self._teams[team.id] = {
            scoreLocked = false,
            score = 0,
            players = players,
        }
    end

    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Locks a teams score. Locking the score prevents a team from gaining any score. This is most likely called
    whenever a teams players are dead or when they all leave.

    @param {teamID} teamID [The team.]
    @param {boolean} locked [If the score should be locked or not.]
    @returns never
]]
function class:lockTeamScore(teamID: teamID, locked: boolean)
    self._teams[teamID].scoreLocked = locked
end

--[[
    Sets a players removed status to true.

    @param {teamID} teamID [The team.]
	@param {number} player [The player.]
    @returns never
]]
function class:removePlayerFromTeam(teamID: teamID, player: number)
    self._teams[teamID].players[player].removed = true
    self:_attemptToLockTeamScoreIfPlayersRemoved(teamID)
end

--[[
    Adds or subtracts from a teams score by the passed amount.

    @param {teamID} teamID [The team.]
    @param {number} increment [The amount to increment by.]
    @param {number?} scoringPlayer [The player who scored the points, will give this player the points as well.]
    @returns never
]]
function class:incrementTeamScore(teamID: teamID, increment: number, scoringPlayer: number?)
    if self._teams[teamID].scoreLocked then
        return
    end

    self._teams[teamID].score += increment

    if scoringPlayer ~= nil then
        self._teams[teamID].players[scoringPlayer].score += increment

        local player: Player = Players:GetPlayerByUserId(scoringPlayer)
        player:SetAttribute("score", self._teams[teamID].players[scoringPlayer].score)
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

--[[
    Attempts to lock a teams score. If all players are removed then it will lock.

    @private
    @param {teamID} teamID [The team.]
    @returns never
]]
function class:_attemptToLockTeamScoreIfPlayersRemoved(teamID: teamID)
    local allPlayersRemoved: boolean = true

    for player: number, playerData in pairs(self._teams[teamID].players) do
        if playerData.removed == false then
            allPlayersRemoved = false
            break
        end
    end

    if allPlayersRemoved then
        self:lockTeamScore(teamID, true)
    end
end

return class
