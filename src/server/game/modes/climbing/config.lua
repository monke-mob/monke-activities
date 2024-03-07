local modeTypes = require(script.Parent.Parent.Parent.Parent.components.mode.types)

return {
    id = "climbing",

    src = script.Parent.src,

    respawning = {
        enabled = true,
        scoreDamage = 1,
    },

    endCondition = {
        type = "none",
    },

    scoring = {
        type = "basic",
    },

    teams = {
        type = "single",
    },

    mode = {
        timeBetweenSwaps = 10, --[[How long each player gets.]]
        attemptsPerPlayer = 1, --[[The amount of attempts each player gets.]]
        studScoreModifier = 0.5, --[[Change this number to affect the scores. One studs score is equal to this number.]]
    },
} :: modeTypes.config
