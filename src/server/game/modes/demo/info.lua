local config = require(script.Parent.config)
local modeTypes = require(script.Parent.Parent.Parent.Parent.components.mode.types)

return {
    id = config.id,
    name = "demo",
    type = "single",
    description = "A demo game mode.",
} :: modeTypes.info
