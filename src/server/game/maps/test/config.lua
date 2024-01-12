local mapTypes = require(script.Parent.Parent.Parent.Parent.components.map.types)

return {
    src = script.Parent.src,

    compatibleModes = {
        "demo",
    },

    effects = {},
} :: mapTypes.config
