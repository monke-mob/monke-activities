local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local demoMode = require(script.Parent.Parent.Parent.components.round.modes.demo.src.main)

local roundService = Knit.CreateService({
	Name = "round",
	_state = {
		started = false,
		roundType = "",
		players = {},
		map = nil,
		mode = nil,
	},
})

--[[
	Starts a round.

	@returns never
]]
function roundService:start(players: { number })
	self._state.started = true

	local mode = demoMode.new(players)
	self._state.mode = mode
	mode:start()
end

--[[
    Returns the game state.

	@returns boolean
]]
function roundService:isStarted()
	return self._state.started
end

--[[
	Stops the currently running round.

	@returns never
]]
function roundService:stop()
	if self:isStarted() == false then
		return
	end

	--local scores = self._state.mode:getScores()

	self._state.mode:destroy()
	self._state.mode = nil
end

return roundService
