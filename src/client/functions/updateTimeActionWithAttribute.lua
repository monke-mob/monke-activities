local ReplicatedStorage = game:GetService("ReplicatedStorage")

local actionClass = require(script.Parent.Parent.app.actions)
local formatTime = require(script.Parent.formatTime)

--[[
	Updates a action with the formatted time from the specified attribute.

	@param {actionClass.class} action [The attribute to update.]
	@param {string} attribute [The attribute name.]
	@returns never
]]
local function updateTimeActionWithAttribute(action: actionClass.class, attribute: string)
    local timeInSeconds: number = ReplicatedStorage:GetAttribute(attribute)
    local timeFormatted: string = formatTime(timeInSeconds)
    action:set(timeFormatted)
end

return updateTimeActionWithAttribute
