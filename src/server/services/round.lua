local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local roundService = Knit.CreateService({
	Name = "round",
    _state = {
        started = false,
        stateName = "",
        roundType = "",
        players = {},
        map = nil,
    },
})

--[[
	@returns never
]]
function roundService:KnitStart()
	Players.PlayerAdded:Connect(function(...)
		self:_handlePlayer(...)
	end)
end

--[[
    Handles a player.

    @private
    @param {Player} player [The player.]
	@returns never
]]
function roundService:_handlePlayer(player: Player)
	
end

return roundService
