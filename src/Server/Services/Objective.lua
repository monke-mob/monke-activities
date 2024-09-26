local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local GetObjectivesEvent = require(ReplicatedStorage.Events.Objectives.Get):Server()
local UpdateObjectivesEvent = require(ReplicatedStorage.Events.Objectives.Get):Server()

local ObjectiveService = {
    objectives = {}
}

--[[
    Returns true if there is objectives remaining.

    @returns boolean
]]
function ObjectiveService:isObjectives()
    return #self.objectives > 0
end

--[[
    Creates a new objective.

    @param {string} objective [The objective name.]
    @param {{ any }} meta [The meta data for the objective.]
    @returns never
]]
function ObjectiveService:create(objective: string, meta: { any })
    self.objectives[objective] = meta
    self:_updateClients()
end

--[[
    Updates the meta data for objective.

    @param {string} objective [The objective name.]
    @param {{ any }} meta [The new meta data for the objective.]
    @returns never
]]
function ObjectiveService:update(objective: string, meta: { any })
    self.objectives[objective] = TableUtil.Assign(self.objectives[objective], meta)
    self:_updateClients()
end

--[[
    Completes (deletes) a objective.

    @param {string} objective [The objective name.]
    @returns never
]]
function ObjectiveService:complete(objective: string)
    self.objectives[objective] = nil
    self:_updateClients()
end

--[[
    Updates the clients with the new objectives.

    @returns never
]]
function ObjectiveService:_updateClients()
    UpdateObjectivesEvent:FireAll(self.objectives)
end

GetObjectivesEvent:On(function(player: Player)
    UpdateObjectivesEvent:Fire(player, ObjectiveService.objectives)
end)

return ObjectiveService
