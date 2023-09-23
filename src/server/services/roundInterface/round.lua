local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local roundService = Knit.CreateService({
	Name = "round",
	_state = {
		started = false,
		roundType = "",
		players = {},
		map = nil,
		controller = nil,
	},
})

--[[
	Starts a intermission.

	@returns never
]]
function roundService:start()
	
end

--[[
    Returns the game state.

	@returns boolean
]]
function roundService:isStarted()
	return self._state.started
end

return roundService
