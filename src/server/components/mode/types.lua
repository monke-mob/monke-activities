local ReplicatedStorage = game:GetService("ReplicatedStorage")

local types = require(ReplicatedStorage.types)

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

type scoreType = "none" | "time" | "custom"

type scoringConfig = {
    type: scoreType,
    time: timeScoringConfig?,
    src: ModuleScript?,
}

type endConditionType = "time" | "score"

type endConditionConfig = {
    type: endConditionType,
    duration: number,
}

export type config = {
    src: Folder,
    teamType: types.teamType,
    respawning: respawningConfig,
    endCondition: endConditionConfig,
    scoring: scoringConfig,
    teams: teamsConfig,
    mode: any,
}

export type info = {
    id: string,
    name: string,
    type: types.teamType,
    description: string,
}

return nil
