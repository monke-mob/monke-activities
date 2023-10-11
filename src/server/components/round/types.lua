export type timeScoringConfig = {
	pointsPerIncrement: number,
}

export type teamConfig = {
	id: string,
	maxPlayers: number,
}

export type teamsConfig = {
	usesCustomTeamBalancer: boolean,
	ids: { [number]: teamConfig },
}

type respawningConfig = {
	enabled: boolean,
	scoreDamage: number,
	maxRespawns: number,
}

type scoreType = "time"

type scoringConfig = {
	type: scoreType,
	time: timeScoringConfig?,
}

type endConditionType = "time" | "score"

type endConditionConfig = {
	type: endConditionType,
	duration: number,
}

type teamType = "single" | "team"

export type config = {
	teamType: teamType,
	respawning: respawningConfig,
	endCondition: endConditionConfig,
	scoring: scoringConfig,
	teams: teamsConfig,
}

return nil
