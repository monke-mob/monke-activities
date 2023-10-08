local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)

--[[
    The class for the timer.

    @class
]]
local class = {}
class.__index = class

--[[
    Creates a timer object.

    @constructor
    @param {number} startTime [The start time.]
	@param {number?} interval [How often to increment the timer.]
    @returns class
]]
function class.new(startTime: number, interval: number?)
	return setmetatable({
		_running = false,
		_startTick = nil,
		_timeRemaining = startTime,
		startTime = startTime,
		interval = interval or 1,
		updated = Signal.new(),
		ended = Signal.new(),
	}, class)
end

--[[
	Starts the timer.

	@returns never
]]
function class:start()
	print("started timer")

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
    Destroys the object, clears, and freezes it to render is unusable.

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
	Waits till the next interval to update.

	@private
	@returns never
]]
function class:_nextUpdateInterval(tick: number)
	delay(self.interval, function()
		pcall(function()
			if tick ~= self._startTick then
				return
			end

			self:count()
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

	if self._timeRemaining <= 0 then
		self:stop()
		self.ended:Fire()
		return
	end

	self._timeRemaining -= 1
	self.updated:Fire(self._timeRemaining)
	self:_nextUpdateInterval(self._startTick)
end

return class
