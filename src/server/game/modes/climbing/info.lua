local config = require(script.Parent.config)
local modeTypes = require(script.Parent.Parent.Parent.Parent.components.mode.types)

return {
    id = config.id,
    name = "climbing",
    type = "single",
    description = "Who can go the farest?",
} :: modeTypes.info
