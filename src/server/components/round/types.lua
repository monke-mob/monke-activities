export type respawningConfig = {
	enabled: boolean,
	scoreDamage: number,
	maxRespawns: number,
}

export type endingConditionType = "time" | "score"

export type endingConditionConfig = {
	type: endingConditionType,
	duration: number,
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
	endingCondition: endingConditionConfig,
	teams: teamsConfig,
}

return nil
