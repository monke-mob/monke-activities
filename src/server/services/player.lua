local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Knit = require(ReplicatedStorage.Packages.Knit)

local ADMINS = require(ServerScriptService.constants.ADMINS)

local playerService = Knit.CreateService({
	Name = "player",
	Client = {},
})

--[[
    Returns true or false depending on if the player is a game admin.

    @param {Player} player [The player.]
    @returns boolean
]]
function playerService:isAdmin(player: Player): boolean
	return table.find(ADMINS, player.UserId) ~= nil
end

--[[
    @client
    @extends isAdmin
]]
function playerService.Client:isAdmin(...: any): boolean
	return self.Server:isAdmin(...)
end

return playerService
