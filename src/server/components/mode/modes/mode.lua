local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local modeTypes = require(script.Parent.Parent.types)

local defaultTeamBalancer = require(script.Parent.Parent.functions.defaultTeamBalancer)
local singlePlayerPlugin = require(script.Parent.Parent.plugins.team.single)
local teamTeamPlugin = require(script.Parent.Parent.plugins.team.team)
local timeEndConditionPlugin = require(script.Parent.Parent.plugins.endCondition.time)
local timeScorePlugin = require(script.Parent.Parent.plugins.score.time)

--[[
    Determines which team balancer to use.

    @returns { teamTeamPlugin.constructorTeam }
]]
local function balanceTeams(players: { number }, config: modeTypes.teamsConfig): { teamTeamPlugin.constructorTeam }
    if config.usesCustomTeamBalancer then
        return {}
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
    teamPlugin: teamTeamPlugin.class | singlePlayerPlugin.class,
    endConditionPlugin: timeEndConditionPlugin.class,
    scorePlugin: timeScorePlugin.class,
    destroy: () -> never,
    start: () -> never,
    getScores: () -> teamTeamPlugin.teams,
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
    -- We have to delcare self here because some of the plugins require access
    -- to the other plugins.
    local self = setmetatable({}, class)

    self.teamPlugin = if config.teamType == "single"
        then singlePlayerPlugin.new(players)
        else teamTeamPlugin.new(balanceTeams(players, config.teams))

    self.endConditionPlugin = if config.endCondition.type == "time"
        then timeEndConditionPlugin.new(config.endCondition.duration)
        else timeEndConditionPlugin.new(config.endCondition.duration)

    self.scorePlugin = if config.scoring.type == "time"
        then timeScorePlugin.new(self, config.scoring.time :: any)
        else timeScorePlugin.new(self, config.scoring.time :: any)

    local janitor = Janitor.new()
    janitor:Add(self.teamPlugin, "destroy")
    janitor:Add(self.endConditionPlugin, "destroy")
    self._janitor = janitor

    return self
end

--[[
    Destroys the object, clears, and freezes it to render is unusable.

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
    local teamID: teamTeamPlugin.teamID? = self.teamPlugin:findTeamByPlayer(player)

    if teamID == nil then
        return
    end

    self.teamPlugin:removePlayerFromTeam(teamID, player)
end

--[[
    Returns the scores of each team.

    @returns teamTeamPlugin.teams
]]
function class:getScores(): teamTeamPlugin.teams
    return self.teamPlugin.teams
end

return class
