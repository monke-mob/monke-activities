local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local admins = require(script.Parent.Parent.data.admins)

local playerService = Knit.CreateService({
	Name = "player",
    Client = {},
})

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

return playerService
