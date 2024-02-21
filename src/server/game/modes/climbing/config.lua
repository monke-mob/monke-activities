local createTeam = require(script.Parent.Parent.Parent.Parent.components.mode.functions.createTeam)
local modeTypes = require(script.Parent.Parent.Parent.Parent.components.mode.types)

return {
    id = "climbing",

    src = script.Parent.src,

    respawning = {
        enabled = true,
        scoreDamage = 1,
    },

    endCondition = {
        type = "time",
        duration = 20,
    },

    scoring = {
        type = "basic",
    },

    teams = {
        type = "single",
        ids = {
            [1] = createTeam("rocketer", 1),
            [2] = createTeam("players", 15),
        },
    },

    mode = {
        timeBetweenSwaps = 10, --[[How long each player gets.]]
        attemptsPerPlayer = 1, --[[The amount of attempts each player gets.]]
        studScoreModifier = 0.5, --[[Change this number to affect the scores. One studs score is equal to this number.]]
    },
} :: modeTypes.config
