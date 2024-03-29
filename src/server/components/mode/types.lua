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
    type: types.teamType,
    customTeamBalancer: ModuleScript?,
    ids: { [number]: teamConfig },
}

type respawningConfig = {
    enabled: boolean,
    scoreDamage: number,
    maxRespawns: number,
}

type scoreType = "basic" | "time" | "custom"

type scoringConfig = {
    type: scoreType,
    time: timeScoringConfig?,
    customScorePlugin: ModuleScript?,
}

type endConditionType = "time" | "score"

type endConditionConfig = {
    type: endConditionType,
    duration: number,
}

export type config = {
    id: string,
    src: Folder,
    respawning: respawningConfig,
    endCondition: endConditionConfig,
    scoring: scoringConfig,
    teams: teamsConfig,
    mode: any,
}

export type info = {
    -- NOTE: The info is still allowed to have the ID as the voting service relies on it to.
    -- The info will simply just take the ID from the config. Doig this just prevents overcomplicated code.
    id: string,
    name: string,
    type: types.teamType,
    description: string,
}

return nil
