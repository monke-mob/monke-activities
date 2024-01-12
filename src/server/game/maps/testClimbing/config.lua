local mapTypes = require(script.Parent.Parent.Parent.Parent.components.map.types)

return {
    id = "testClimbing",

    src = game.ServerStorage.Model,

    compatibleModes = {
        "climbing",
    },

    effects = {},
} :: mapTypes.config
