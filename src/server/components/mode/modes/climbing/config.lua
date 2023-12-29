local createTeam = require(script.Parent.Parent.Parent.functions.createTeam)
local modeTypes = require(script.Parent.Parent.Parent.types)

return {
    src = script.Parent.src,

    teamType = "team",

    respawning = {
        enabled = true,
        scoreDamage = 1,
    },

    endCondition = {
        type = "time",
        duration = 20,
    },

    scoring = {
        type = "time",
        time = {
            pointsPerIncrement = 1,
        },
    },

    teams = {
        usesCustomTeamBalancer = false,
        ids = {
            [1] = createTeam("rocketer", 1),
            [2] = createTeam("players", 15),
        },
    },

    mode = {
        timeBetweenSwaps = 10,
        amountOfTriesPerPlayer = 2,
    },
} :: modeTypes.config
