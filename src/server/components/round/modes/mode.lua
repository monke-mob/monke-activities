local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local roundTypes = require(script.Parent.Parent.types)

local singlePlugin = require(script.Parent.Parent.plugins.types.single)
local teamPlugin = require(script.Parent.Parent.plugins.types.team)
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
    The class for a mode.

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
	return setmetatable({
		_janitor = Janitor.new(),
		_config = config,
		_plugin = if config.teamType == "single"
			then singlePlugin.new(players)
			else teamPlugin.new(balanceTeams(players, config.teams)),
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

return class
