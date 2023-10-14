local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Signal = require(ReplicatedStorage.Packages.Signal)

export type action = {
    value: any,
    _lastValue: any,
    _signal: RBXScriptSignal,

    set: <a>(self: a, value: any) -> never,
    get: <a>(self: a) -> any,
    connect: <a>(self: a, ...any) -> RBXScriptConnection,
    _fireSignal: <a>(self: a, value: any) -> never,
}

--[[
	This is a signal class which uses a `Fusion.Value` object
	and a signal object to allow the ui to communicate.

	@class
]]
local class = {}
class.__index = class

--[[
	Exposes the `value:set` method directly and
	fires the signal, if there is one.

	@returns never
--]]
function class:set(value: any)
    -- Dont need to update if its the same
    -- as the last value.
    if value == self._lastValue then
        return
    end

    self._lastValue = value
    self.value:set(value)
    self:_fireSignal(value)
end

--[[
	Exposes the `value:get()` method directly.

	@returns any
--]]
function class:get()
    return self.value:get()
end

--[[
	Exposes the `signal:Connect()` method directly.

	@extends Signal:Connect
	@returns RBXScriptConnection
--]]
function class:connect(...)
    return self._signal:Connect(...)
end

--[[
	Fires the signal, if there is one.

	@private
	@param {any} ... [The data to send over the signal].
	@returns never
--]]
function class:_fireSignal(...: any)
    if self._signal ~= nil then
        self._signal:Fire(...)
    end
end

--[[
	Creates a `action` object.

	@constructor class
	@param [any] value [The starting value.]
	@param [boolean?] hasSignal [Whether the action has a signal.]
	@returns action
--]]
return function(value: any, hasSignal: boolean?): action
    return setmetatable({
        value = Fusion.Value(value),
        _lastValue = value,
        _signal = hasSignal == true and Signal.new() or nil,
    }, class) :: any
end
