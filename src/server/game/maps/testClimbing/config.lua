local mapTypes = require(script.Parent.Parent.Parent.Parent.components.map.types)

return {
    id = "testClimbing",

    src = script.Parent.src.Model,

    compatibleModes = {
        "climbing",
    },

    effects = {},
} :: mapTypes.config
