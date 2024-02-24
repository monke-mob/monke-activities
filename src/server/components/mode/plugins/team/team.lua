local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local teleportPlayer = require(script.Parent.Parent.Parent.functions.teleportPlayer)

type teamPlayer = {
    score: number,
    removed: boolean,
}

export type team = {
    locked: boolean,
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
    _spawns: { BasePart },
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
            locked = false,
            score = 0,
            players = players,
        }
    end

    local self = setmetatable({
        _teams = teams,
        _spawns = {},
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
    Locks a team. Locking a team prevents scoring and respawning.

    @param {teamID} teamID [The ID of the team.]
    @param {boolean} locked [If the team should be locked or not.]
    @returns never
]]
function class:lockTeam(teamID: teamID, locked: boolean)
    self._teams[teamID].locked = locked
end

--[[
    Sets a players removed status to true.

    @param {teamID} teamID [The ID of the team.]
    @param {number} player [The ID of the player.]
    @returns never
]]
function class:removePlayerFromTeam(teamID: teamID, player: number)
    self._teams[teamID].players[player].removed = true
    self:_attemptToLockTeamIfPlayersRemoved(teamID)
end

--[[
    Adds or subtracts from a teams score by the passed amount.

    @param {teamID} teamID [The ID of the team.]
    @param {number} increment [The amount to increment the score by.]
    @param {number?} scoringPlayer [The player that scored the points. The points will also be awarded to this player if provided.]
    @returns never
]]
function class:incrementTeamScore(teamID: teamID, increment: number, scoringPlayer: number?)
    if self._teams[teamID].locked then
        return
    end

    self._teams[teamID].score += increment

    if scoringPlayer ~= nil then
        self._teams[teamID].players[scoringPlayer].score += increment
    end
end

--[[
    Returns the team that the player is in.

    @param {number} player [The ID of the player.]
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
    Kills a player.

    @param {number} player [The ID of the player.]
    @returns never
]]
function class:killPlayer(player: number)
    local playerInstance: Player = Players:GetPlayerByUserId(player)
    local character: Model = playerInstance.Character or playerInstance.CharacterAdded:Wait()
    local characterHumanoid: Humanoid = character:FindFirstChildOfClass("Humanoid") :: Humanoid
    characterHumanoid.Health = 0
end

--[[
    Kills a team.

    @param {teamID} teamID [The ID of the team.]
    @param {boolean} locked [If the team should be locked or not.]
    @returns never
]]
function class:killTeam(teamID: teamID, locked: boolean)
    for player: number, _playerData in pairs(self._teams[teamID].players) do
        self:killPlayer(player)
    end

    self:lockTeam(teamID, locked)
end

function class:respawnPlayer(player: number, spawn: string)
    local spawnInstance: BasePart
    teleportPlayer(player, spawnInstance.CFrame)
end

--[[
    Attempts to lock a team. If all players are removed then it will lock.

    @private
    @param {teamID} teamID [The team.]
    @returns never
]]
function class:_attemptToLockTeamIfPlayersRemoved(teamID: teamID)
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

function class:_handleSpawns()
    for _index, spawnInstance: BasePart in pairs(CollectionService:GetTagged("spawn")) do
        self:_handleNewSpawn(spawnInstance)
    end

    self._janitor:Add(CollectionService:GetInstanceAddedSignal("spawn"):Connect(function(...)
        self:_handleNewSpawn(...)
    end))
end

function class:_handleNewSpawn(spawnInstance: BasePart)
    table.insert(self._spawns, spawnInstance)
end

return class
