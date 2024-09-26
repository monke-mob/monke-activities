local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Future = require(ReplicatedStorage.Packages.Future)
local PlayerService = require(script.Parent.Player)

local LoadActivityEvent = require(ReplicatedStorage.Events.Activity.Load):Server()
local UnloadActivityEvent = require(ReplicatedStorage.Events.Activity.Unload):Server()
local Activities: Folder = ReplicatedStorage.Activities

local playerActivities: { [number]: { ["prepared"]: boolean, ["activity"]: string | nil } } = {}
local activities: { [string]: Folder } = {}

for _, activityFolder: Folder in ipairs(Activities:GetChildren() :: {}) do
    local activity: string = activityFolder.Name
    activities[activity] = activityFolder
end

--[[
    Checks a player activities against a condition. Halts the thread until all players match the condition.

    EXAMPLE: Checking if all the players are on the same activity.

    @param {(data: any) -> boolean} condition [The condition to check.]
    @returns never
]]
local function waitForPlayers(condition: (data: any) -> boolean)
    Future.new(function()
        local matched: number = 0

        while matched < PlayerService.playerCount do
            matched = 0

            for _, data in pairs(playerActivities) do
                if condition(data) then
                    matched += 1
                end
            end

            task.wait()
        end

        return
    end):Await()
end

local ActivitiesService = {
    activity = nil,
    module = nil,
    map = nil,
}

--[[
    Loads a new activity.

    @param {string} activity [The activity name.]
    @returns never
]]
function ActivitiesService:load(activity: string)
    -- Confirm that the scene is valid.
    assert(activities[activity], ("'%s' is an invalid activity."):format(activity))

    self:unload()

    self.activity = activity
    self:_load()

    self.module:prepare()
    LoadActivityEvent:FireAll("prepare", activity)

    waitForPlayers(function(data)
        return data.prepared
    end)

    self.module:load()
    LoadActivityEvent:FireAll("load", activity)

    waitForPlayers(function(data)
        return data.activity == activity
    end)
end

--[[
    Unloads the current activity.

    @returns never
]]
function ActivitiesService:unload()
    if self.activity == nil then
        return
    end

    UnloadActivityEvent:FireAll()

    waitForPlayers(function(data)
        return data.activity == nil
    end)

    self.activity = nil
    self.map = nil
    self.module:unload()
    self.module = nil
end

--[[
    Loads the scene map and modules into the game.

    @returns never
]]
function ActivitiesService:_load()
    local activityInstance = activities[self.activity]:Clone()
    activityInstance.Parent = workspace

    local map = activityInstance:WaitForChild("Map")
    self.map = map

    local module: ModuleScript = activityInstance:WaitForChild("Server")
    self.module = require(module)
end

LoadActivityEvent:On(function(player: Player, prepared: boolean)
    playerActivities[player.UserId] = {
        prepared = true,
        activity = if not prepared then ActivitiesService.activity else nil,
    }
end)

UnloadActivityEvent:On(function(player: Player)
    playerActivities[player.UserId] = {
        prepared = false,
        activity = nil,
    }
end)

return ActivitiesService
