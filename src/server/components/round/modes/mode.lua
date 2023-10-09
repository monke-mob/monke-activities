local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local roundTypes = require(script.Parent.Parent.types)

local singlePlugin = require(script.Parent.Parent.plugins.team.single)
local teamPlugin = require(script.Parent.Parent.plugins.team.team)
local timePlugin = require(script.Parent.Parent.plugins.endCondition.time)
local defaultTeamBalancer = require(script.Parent.Parent.functions.defaultTeamBalancer)

--[[
    Determines which team balancer to use.

    @returns { teamPlugin.constructorTeam }
]]
local function balanceTeams(players: { number }, config: roundTypes.teamsConfig): { teamPlugin.constructorTeam }
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

--[[
    Creates a mode.

    @constructor
    @returns class
]]
function class.new(players: { number }, config: roundTypes.config)
	local teamPlugin = if config.teamType == "single"
		then singlePlugin.new(players)
		else teamPlugin.new(balanceTeams(players, config.teams))

	local function incrementTeamScore(...)
		teamPlugin:incrementTeamScore(...)
	end

	local endConditionPlugin = if config.endCondition.type == "time"
		then timePlugin.new(config.endCondition, incrementTeamScore)
		else timePlugin.new(config.endCondition, incrementTeamScore)

	local janitor = Janitor.new()
	janitor:Add(teamPlugin, "destroy")
	janitor:Add(endConditionPlugin, "destroy")

	return setmetatable({
		_janitor = janitor,
		_teamPlugin = teamPlugin,
		_endConditionPlugin = endConditionPlugin,
	}, class)
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
	self._endConditionPlugin:start()
end

--[[
    Returns the scores of each team.

    @returns teamPlugin.teams
]]
function class:getScores(): teamPlugin.teams
	return self._teamPlugin.teams
end

return class
