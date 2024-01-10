local mapTypes = require(script.Parent.Parent.Parent.types)

return {
    src = script.Parent.src,

    compatibleModes = {
        "demo",
    },

    effects = {},
} :: mapTypes.config
