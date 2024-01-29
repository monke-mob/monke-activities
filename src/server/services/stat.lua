local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local statService = Knit.CreateService({
    Name = "stat",
    _stats = {},
    Client = {
        stats = Knit.CreateProperty({}),
    },
})

--[[
    Adds a new stat to a player.

    @param {number} userID [The ID of the player.]
    @param {string} stat [The name of the stat.]
    @param {any} value [The starting value.]
    @returns never
]]
function statService:addStat(userID: number, stat: string, value: any)
    self._stats[userID][stat] = value
    self.Client.stats:Set(self._stats)
end

--[[
    Removes a stat from a player.

    @param {number} userID [The ID of the player.]
    @param {string} stat [The name of the stat.]
    @param {any} value [The starting value.]
    @returns never
]]
function statService:removeStat(userID: number, stat: string)
    self._stats[userID][stat] = nil
    self.Client.stats:Set(self._stats)
end

--[[
    Updates a player stat.

    @param {number} userID [The ID of the player.]
    @param {string} stat [The name of the stat.]
    @param {any} value [The new value.]
    @returns never
]]
function statService:updateStat(userID: number, stat: string, value: any)
    self._stats[userID][stat] = value
    self.Client.stats:Set(self._stats)
end

return statService
