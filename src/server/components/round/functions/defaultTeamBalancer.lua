local roundTypes = require(script.Parent.Parent.types)

local teamPlugin = require(script.Parent.Parent.plugins.team.team)

type team = teamPlugin.constructorTeam & {
	maxPlayers: number,
}

--[[
    Balances teams by seperating the players as evenly as possible.

    @param {{ number }} players [The players.]
    @param {roundTypes.teamsConfig} config [The mode team config.]
    @returns { teamPlugin.constructorTeam }
]]
local function balanceTeams(players: { number }, config: roundTypes.teamsConfig): { team }
	local teams: { team } = {}

	for index: number, team: roundTypes.teamConfig in ipairs(config.ids) do
		teams[index] = {
			id = team.id,
			maxPlayers = team.maxPlayers,
			players = {},
		}
	end

	-- This randomizes the players.
	for index: number = #players, 2, -1 do
		local randomIndex: number = math.random(index)
		players[index], players[randomIndex] = players[randomIndex], players[index]
	end

	-- Add the players to teams.
	for _index: number, player: number in ipairs(players) do
		for _index: number, team in ipairs(teams) do
			if #team.players < team.maxPlayers then
				table.insert(team.players, player)
				break
			end
		end
	end

	return teams
end

return balanceTeams
