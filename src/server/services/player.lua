local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local admins = require(script.Parent.Parent.data.admins)

local playerService = Knit.CreateService({
	Name = "player",
    Client = {},
	_collisionService = nil,
})

--[[
	@returns never
]]
function playerService:KnitStart()
	self._collisionService = Knit.GetService("collision")

	-- Get the players that already joined.
	for _index: number, player: Player in ipairs(Players:GetPlayers()) do
		self:_handlePlayer(player)
	end

	Players.PlayerAdded:Connect(function(player: Player)
		self:_handlePlayer(player)
	end)
end

--[[
    Returns true or false depending on if the player is
    a game admin.

    @param {Player} player [The player.]
    @returns boolean
]]
function playerService:isAdmin(player: Player): boolean
	return table.find(admins, player.UserId) ~= nil
end

--[[
    @client
    @extends isAdmin
]]
function playerService.Client:isAdmin(...: any): boolean
	return self.Server:isAdmin(...)
end

--[[
    Handles a player.

    @private
    @param {Player} player [The player.]
	@returns never
]]
function playerService:_handlePlayer(player: Player)
	-- Get the current player character, if there is one.
	if player.Character then
		self._collisionService:setInstanceGroup(player.Character, "player")
	end

	player.CharacterAdded:Connect(function(character: Model)
		self._collisionService:setInstanceGroup(character, "player")
	end)
end

return playerService
