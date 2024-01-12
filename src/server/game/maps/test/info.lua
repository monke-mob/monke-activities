local config = require(script.Parent.config)
local mapTypes = require(script.Parent.Parent.Parent.Parent.components.map.types)

return {
    id = config.id,
    name = "test",
    description = "A large scale map.",
} :: mapTypes.info
