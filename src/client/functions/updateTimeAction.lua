local actionClass = require(script.Parent.Parent.components.app.actions)
local formatTime = require(script.Parent.formatTime)

--[[
	Updates a action with a formatted time.

	@param {actionClass.class} action [The attribute to update.]
	@param {number} timeInSeconds [The time in seconds.]
	@returns never
]]
local function updateTimeActionWithAttribute(action: actionClass.class, timeInSeconds: number)
    local timeFormatted: string = formatTime(timeInSeconds)
    action:set(timeFormatted)
end

return updateTimeActionWithAttribute
