local mapTypes = require(script.Parent.Parent.Parent.types)

return {
    src = script.Parent.src.Model,

    compatibleModes = {
        "climbing",
    },

    effects = {},
} :: mapTypes.config
