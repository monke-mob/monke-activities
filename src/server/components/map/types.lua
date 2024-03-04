export type compatibleModes = { string }

export type config = {
    id: string,
    src: Instance,
    compatibleModes: compatibleModes,
    effects: { string },
    respawns: { [string]: BasePart },
    music: { string },
    data: any,
}

export type info = {
    -- NOTE: The info is still allowed to have the ID as the voting service relies on it to.
    -- The info will simply just take the ID from the config. Doig this just prevents overcomplicated code.
    id: string,
    name: string,
    description: string,
}

return nil
