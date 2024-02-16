local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)

--[[
    The class for the timer.

    @class
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    _running: boolean,
    _startTick: number?,
    _interval: number,
    _startTime: number,
    timeRemaining: number,
    updated: any,
    ended: any,
    destroy: () -> never,
    start: () -> never,
    stop: () -> never,
    restart: () -> never,
    _nextUpdateInterval: (tick: number) -> never,
    _increment: () -> never,
}

--[[
    Creates a timer object.

    @constructor
    @param {number} startTime [The start time.]
	@param {number?} interval [How often to increment the timer.]
    @returns class
]]
function class.new(startTime: number, interval: number?): class
    local self = setmetatable({
        _running = false,
        _startTick = nil,
        _interval = if typeof(interval) == "number" then interval else 1,
        _startTime = startTime,
        timeRemaining = startTime,
        updated = Signal.new(),
        ended = Signal.new(),
    }, class)
    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    self:stop()

    self.updated:Destroy()
    self.ended:Destroy()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
	Starts the timer.

	@returns never
]]
function class:start()
    self._running = true

    local startTick: number = os.clock()
    self._startTick = startTick
    self:_nextUpdateInterval(self._startTick)
end

--[[
	Stops the timer.

	@returns never
]]
function class:stop()
    self._running = false
end

--[[
	Restarts the timer.

	@returns never
]]
function class:restart()
    self:stop()
    self.timeRemaining = self._startTime
    self:start()
end

--[[
	Waits till the next interval to update.

	@private
	@param {number} tick [The update tick.]
	@returns never
]]
function class:_nextUpdateInterval(tick: number)
    delay(self._interval, function()
        pcall(function()
            if tick ~= self._startTick then
                return
            end

            self:_increment()
        end)
    end)
end

--[[
	Increments the timer state by -1 and waits till the next interval.

	@private
	@returns never
]]
function class:_increment()
    if self._running == false then
        return
    end

    if self.timeRemaining <= 0 then
        self:stop()
        self.ended:Fire()
        return
    end

    self.timeRemaining -= 1
    self.updated:Fire(self.timeRemaining)
    self:_nextUpdateInterval(self._startTick)
end

return class
