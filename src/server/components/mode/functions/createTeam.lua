local modeTypes = require(script.Parent.Parent.types)

--[[
    NOTE: This is simply a helper function for the mode configs.
    
    Creates a team config from the passed values.

    @param {string} id [The team ID.]
    @param {number} maxPlayers [That max number of players that the team can have.]
    @returns modeTypes.teamConfig
]]
local function createTeam(id: string, maxPlayers: number): modeTypes.teamConfig
    return {
        id = id,
        maxPlayers = maxPlayers,
    }
end

return createTeam
