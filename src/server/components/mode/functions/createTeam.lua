local modeTypes = require(script.Parent.Parent.types)

--[[
    Creates a team config from the passed values. If you're wondering why turn this into a function
    its because it helps to reduce config line count.

    @param {string} players [The players.]
    @param {number} config [The mode team config.]
    @returns modeTypes.teamConfig
]]
local function createTeam(id: string, maxPlayers: number): modeTypes.teamConfig
    return {
        id = id,
        maxPlayers = maxPlayers,
    }
end

return createTeam
