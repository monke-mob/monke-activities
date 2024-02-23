local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local basicScorePlugin = require(script.plugins.score.basic)
local defaultTeamBalancer = require(script.functions.defaultTeamBalancer)
local modeTypes = require(script.types)
local singlePlayerPlugin = require(script.plugins.team.single)
local teamPlugin = require(script.plugins.team.team)
local timeEndConditionPlugin = require(script.plugins.endCondition.time)
local timeScorePlugin = require(script.plugins.score.time)
local types = require(ReplicatedStorage.types)
local mapService

Knit:OnStart():andThen(function()
    mapService = Knit.GetService("map")
end)

--[[
    Determines which team balancer to use.

    @param {{ number }} players [The players.]
    @param {modeTypes.teamsConfig} config [The team config.]
    @returns { teamPlugin.constructorTeam }
]]
local function balanceTeams(players: { number }, config: modeTypes.teamsConfig): { teamPlugin.constructorTeam }
    if config.customTeamBalancer ~= nil then
        return require(config.customTeamBalancer)(players)
    else
        return defaultTeamBalancer(players, config)
    end
end

--[[
    The base class for a game mode.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    teamPlugin: teamPlugin.class | singlePlayerPlugin.class,
    endConditionPlugin: timeEndConditionPlugin.class,
    scorePlugin: timeScorePlugin.class,
    destroy: () -> never,
    start: () -> never,
    getScores: () -> teamPlugin.teams,
    _janitor: types.Janitor,
    _map: Instance,
}

export type players = { number }

--[[
    Creates a mode.

    @constructor
    @param {players} players [The players.]
    @param {modeTypes.config} config [The config for the mode.]
    @returns class
]]
function class.new(players: players, config: modeTypes.config): class
    local self = setmetatable({}, class)
    self._map = mapService:getMap()

    self.teamPlugin = if config.teams.type == "single"
        then singlePlayerPlugin.new(players)
        else teamPlugin.new(balanceTeams(players, config.teams))

    self.endConditionPlugin = if config.endCondition.type == "time"
        then timeEndConditionPlugin.new(config.endCondition.duration)
        else timeEndConditionPlugin.new(config.endCondition.duration)

    if config.scoring.customScorePlugin ~= nil then
        self.scorePlugin = require(config.scoring.customScorePlugin).new(self)
    elseif config.scoring.type == "basic" then
        self.scorePlugin = basicScorePlugin.new()
    elseif config.scoring.type == "time" then
        -- Have to cast config.scoring.time to any because its type states it could be nil but
        -- if the type is time it wont be as its required.
        self.scorePlugin = timeScorePlugin.new(config.scoring.time :: any)
    end

    local janitor = Janitor.new()
    janitor:Add(self.teamPlugin, "destroy")
    janitor:Add(self.endConditionPlugin, "destroy")
    janitor:Add(self.scorePlugin, "destroy")
    self._janitor = janitor

    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    self._janitor:Destroy()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Starts the mode.

    @returns never
]]
function class:start()
    self.endConditionPlugin:start()
end

--[[
    Removes a player from the round.

	@param {number} player [The player to remove.]
    @returns never
]]
function class:removePlayerFromRound(player: number)
    local teamID: teamPlugin.teamID? = self.teamPlugin:findTeamByPlayer(player)

    if teamID == nil then
        return
    end

    self.teamPlugin:removePlayerFromTeam(teamID, player)
end

--[[
    Returns the scores of each team.

    @returns teamTeamPlugin.teams
]]
function class:getScores(): teamPlugin.teams
    return self.teamPlugin.teams
end

return class
