local mapTypes = require(script.Parent.Parent.Parent.Parent.components.map.types)

return {
    id = "test",

    src = script.Parent.src,

    compatibleModes = {
        "demo",
    },

    effects = {},

    respawns = {},
} :: mapTypes.config
