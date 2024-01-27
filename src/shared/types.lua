export type dictionaryStringAny = { [string]: any }

export type dictionaryAny = { [any]: any }

export type teamType = "single" | "team"

export type votingOption = {
    name: string,
    description: string,
    teamType: teamType?,
}

export type lightingConfig = {
    main: dictionaryStringAny,
    effects: dictionaryStringAny,
}

return nil
