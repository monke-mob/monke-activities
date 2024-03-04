local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local basicEndCondition = require(script.Parent.basic)
local timerComponent = require(script.Parent.Parent.Parent.Parent.timer)
local types = require(ReplicatedStorage.types)
local roundInterface = nil

Knit.OnStart():andThen(function()
    roundInterface = Knit.GetService("roundInterface")
end)

--[[
    The base class for most end conditions. Stops the mode whenever time runs out.

    @class
    @public
    @extends basicEndCondition
]]
local class = {}
class.__index = class
setmetatable(class, basicEndCondition)

export type class = basicEndCondition.class & typeof(setmetatable({}, {})) & {
    timer: timerComponent.class,
    destroy: () -> never,
    start: () -> never,
    _end: () -> never,
    _janitor: types.Janitor,
}

--[[
    Sets up the mode timer.

    @constructor
    @param {number} time [The time that the round will last for.]
    @returns class
]]
function class.new(time: number): class
    local baseClass = basicEndCondition.new()
    local self = setmetatable(baseClass, class)

    self.timer = timerComponent.new(time)
    self._janitor:Add(self.timer, "destroy")

    return self
end

--[[
    Starts the timer and connects the connections.

    @returns never
]]
function class:start()
    roundInterface:bindTimer(self.timer)

    self.timer.ended:Connect(function()
        self:stop()
    end)

    self.timer:start()
end

return class
