local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Janitor = require(ReplicatedStorage.Packages.Janitor)

local TIMER = require(ReplicatedStorage.constants.TIMER)

local roundInterfaceService = Knit.CreateService({
	Name = "roundInterface",
	_intermissionService = nil,
	_roundService = nil,
	_playerJanitor = Janitor.new(),
	_timer = nil,
})

--[[
	@returns never
]]
function roundInterfaceService:KnitInit()
	ReplicatedStorage:SetAttribute(TIMER, 0)
end

--[[
	@returns never
]]
function roundInterfaceService:KnitStart()
	self._intermissionService = Knit.GetService("intermission")
	self._roundService = Knit.GetService("round")

	Players.PlayerAdded:Connect(function(...)
		self:_playerAdded(...)
	end)
end

--[[
	Binds the timer to the state allowing the clients to track the time via the timer attribute.

	@param {} timer [The timer instance.]
	@returns never
]]
function roundInterfaceService:bindTimer(timer)
	-- Unbind the last timer.
	if self._timer ~= nil then
		self._timer:Disconnect()
		self._timer = nil
	end

	self._timer = timer.updated:Connect(function(timeRemaining: number)
		ReplicatedStorage:SetAttribute(TIMER, timeRemaining)
	end)
end

--[[
    Handles a player joining.

    @private
    @param {Player} player [The new/joining player to handle.]
	@returns never
]]
function roundInterfaceService:_playerAdded(player: Player)
	local janitor = Janitor.new()
	janitor:Add(player.CharacterAdded:Connect(function(character: Model)
		local characterHumanoid: Humanoid = character:WaitForChild("Humanoid") :: Humanoid

		if characterHumanoid == nil then
			return
		end

		janitor:Add(
			characterHumanoid.Died:Connect(function()
				janitor:Remove("characterDied")
			end),
			"Disconnect",
			"characterDied"
		)
	end))

	self._playerJanitor:Add(janitor, "Destroy", player.UserId)
end

--[[
    Handles a player leaving.

    @private
    @param {Player} player [The player leaving.]
	@returns never
]]
function roundInterfaceService:_playerLeaving(player: Player)
	self._intermissionService:setReady(player, false)
	self._playerJanitor:Remove(player.UserId)

	if self._roundService:isStarted() then
		self._roundService:removePlayer(player)
	end

	self._intermissionService:attemptStart()
end

return roundInterfaceService
