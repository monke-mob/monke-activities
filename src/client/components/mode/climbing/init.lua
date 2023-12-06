local modeComponent = require(script.Parent)
local modeDataAction = require(script.Parent.Parent.Parent.app.actions.mode.data)
local actionClass = require(script.Parent.Parent.Parent.app.actions)

local class = {}
class.__index = class
setmetatable(class, modeComponent)

--[[
    Creates the mode.

    @constructor
    @returns class
]]
function class.new()
    local baseClass = modeComponent.new()
    local mode = setmetatable(baseClass, class)

    modeDataAction["player"] = actionClass(0)

    return mode
end

return class
