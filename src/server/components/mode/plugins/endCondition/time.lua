local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local timerComponent = require(script.Parent.Parent.Parent.Parent.timer)
local roundInterface = nil
local roundService = nil

Knit:OnStart():andThen(function()
    roundInterface = Knit.GetService("roundInterface")
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
    timer: timerComponent.class,
    destroy: () -> never,
    start: () -> never,
    _end: () -> never,
}

--[[
    Sets up the mode timer.

    @constructor
    @param {number} time [The time that the round will last for.]
    @returns class
]]
function class.new(time: number): class
    local self = setmetatable({
        timer = timerComponent.new(time),
    }, class)
    return self
end

--[[
    Destroys the object, clears, and freezes it to render is unusable.

    @returns never
]]
function class:destroy()
    self.timer:destroy()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Starts the timer and connects the connections.

    @returns never
]]
function class:start()
    roundInterface:bindTimer(self.timer)

    self.timer.ended:Connect(function()
        self:_end()
    end)

    self.timer:start()
end

--[[
    Handles ending the round.

    @returns never
]]
function class:_end()
    roundService:stop()
end

return class
