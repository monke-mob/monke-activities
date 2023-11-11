local config = require(script.Parent.Parent.config)
local modeComponent = require(script.Parent.Parent.Parent.mode)

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
    return setmetatable(baseClass, class)
end

return class
