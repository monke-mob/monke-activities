--[[
	Formats a time (in seconds) to MM:SS.

	@param {number} seconds [The amount of seconds.]
	@returns string
]]
local function formatTime(seconds: number): string
    local minutes: number = math.floor(seconds / 60)
    return string.format("%02d:%02d", minutes, seconds % 60)
end

return formatTime
