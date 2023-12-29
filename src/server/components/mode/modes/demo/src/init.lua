local config = require(script.Parent.config)
local modeComponent = require(script.Parent.Parent)

local class = {}
class.__index = class
setmetatable(class, modeComponent)

--[[
    Creates the mode.

    @constructor
    @param {modeComponent.players} players [The players.]
    @returns class
]]
function class.new(players: modeComponent.players)
    local baseClass = modeComponent.new(players, config)
    local mode = setmetatable(baseClass, class)
    return mode
end

return class
