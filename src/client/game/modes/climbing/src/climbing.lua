--[[
    The class for the climbing controller.

    @class
    @private
]]
local class = {}
class.__index = class

--[[
    Creates and starts the controller.

    @constructor
    @returns class
]]
function class.new()
    local self = setmetatable({}, class)
    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

return class
