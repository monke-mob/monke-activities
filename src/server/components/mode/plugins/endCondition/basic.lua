local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local roundService

Knit:OnStart():andThen(function()
    roundService = Knit.GetService("round")
end)

--[[
    The base class for most end conditions. Stops the mode whenever time runs out.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    destroy: () -> never,
    stop: () -> never,
    _janitor: any,
}

--[[
    Creates the basic end condition.

    @constructor
    @returns class
]]
function class.new(): class
    local self = setmetatable({
        _janitor = Janitor.new(),
    }, class)
    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    self._janitor:Destroy()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Handles ending the round.

    @returns never
]]
function class:stop()
    roundService:stop()
end

return class
