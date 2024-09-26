local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LoadActivityEvent = require(ReplicatedStorage.Events.Activity.Load):Client()
local UnloadActivityEvent = require(ReplicatedStorage.Events.Activity.Unload):Client()
local Activities: Folder = ReplicatedStorage.Activities

local activities: { [string]: Folder } = {}

for _, activityFolder: Folder in ipairs(Activities:GetChildren() :: {}) do
    local activity: string = activityFolder.Name
    activities[activity] = activityFolder
end

local ActivitiesService = {
    activity = nil,
    module = nil,
    map = nil,
}

--[[
    Fetches the activity module and map.

    @returns never
]]
function ActivitiesService:_fetch()
    local activityInstance: Folder = workspace:WaitForChild(self.activity)

    local map: Folder = activityInstance:WaitForChild("Map") :: Folder
    self.map = map

    local module: ModuleScript = activityInstance:WaitForChild("Client") :: ModuleScript
    self.module = require(module)
end

LoadActivityEvent:On(function(action: "prepare" | "load", activity: string)
    ActivitiesService.activity = activity

    if action == "prepare" then
        ActivitiesService:_fetch()
        ActivitiesService.module:prepare()
    elseif action == "load" then
        ActivitiesService.module:load()
    end

    LoadActivityEvent:Fire(action == "prepare")
end)

UnloadActivityEvent:On(function(player: Player)
    ActivitiesService.activity = nil
    ActivitiesService.map = nil
    ActivitiesService.module:unload()
    ActivitiesService.module = nil

    UnloadActivityEvent:Fire()
end)

return ActivitiesService
