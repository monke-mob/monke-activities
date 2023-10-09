local teamPlugin = require(script.Parent.plugins.team.team)

export type respawningConfig = {
	enabled: boolean,
	scoreDamage: number,
	maxRespawns: number,
}

export type timeEndConditionConfig = {
	pointsPerIncrement: number,
}

export type endConditionType = "time" | "score"

export type endConditionConfig = {
	type: endConditionType,
	duration: number,
	time: timeEndConditionConfig?,
}

export type teamConfig = {
	id: string,
	maxPlayers: number,
}

export type teamsConfig = {
	usesCustomTeamBalancer: boolean,
	ids: { [number]: teamConfig },
}

export type teamType = "single" | "team"

export type config = {
	teamType: teamType,
	respawning: respawningConfig,
	endCondition: endConditionConfig,
	teams: teamsConfig,
}

export type incrementTeamScore = (teamID: teamPlugin.teamID, increment: number) -> never

return nil
