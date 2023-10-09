local modeComponent = require(script.Parent.Parent.Parent.mode)
local config = require(script.Parent.Parent.config)

local class = {}
class.__index = class
setmetatable(class, modeComponent)

--[[
    Creates the mode.

    @constructor
    @param {{ number }} players [The players.]
    @returns class
]]
function class.new(players: { number })
	local baseClass = modeComponent.new(players, config)
	return setmetatable(baseClass, class)
end

return class