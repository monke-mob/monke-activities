local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)

--[[
    The base class for a mode.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    destroy: () -> never,
    _janitor: any,
}

--[[
    Creates a mode.

    @constructor
    @returns class
]]
function class.new(): class
    local self = setmetatable({}, class)
    self._janitor = Janitor.new()
    return self
end

--[[
    Destroys the object, clears, and freezes it to render is unusable.

    @returns never
]]
function class:destroy()
    self._janitor:Destroy()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

return class
