local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local timerComponent = require(script.Parent.Parent.Parent.Parent.timer)
local roundInterface = nil
local roundService = nil

--[[
    The base class for most end conditions. Stops the mode whenever time runs out.

    @class
    @public
]]
local class = {}
class.__index = class

--[[
    Sets up the mode timer.

    @constructor
    @param {number} time [The time.]
    @returns class
]]
function class.new(time: number)
	-- We have to communicate with the round interface and round service, so if they
	-- have not been set then we have to set them.
	if roundInterface == nil or roundService == nil then
		roundInterface = Knit.GetService("roundInterface")
		roundService = Knit.GetService("round")
	end

	return setmetatable({
		timer = timerComponent.new(time),
	}, class)
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
