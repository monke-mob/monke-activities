local config = require(script.Parent.config)
local modeTypes = require(script.Parent.Parent.Parent.Parent.components.mode.types)

return {
    id = config.id,
    name = "Ascend",
    type = "single",
    description = "Ascend to new heights within a time limit, dodging obstacles and outmaneuvering fallen climbers. How high can you go?",
} :: modeTypes.info
