local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CLIENT_TAGS = require(ReplicatedStorage.Constants.CLIENT_TAGS)

local objects: { [string]: { [Instance]: any } } = {}

local TagService = {}

--[[
    Registers a new tag.

    @param {string} name [The name of the tag.]
    @returns never
]]
function TagService:register(name: string)
    objects[name] = {}

    for _, instance: Instance in pairs(CollectionService:GetTagged(name)) do
        self:_newInstance(name, instance)
    end

    CollectionService:GetInstanceAddedSignal(name):Connect(function(instance: Instance)
        self:_newInstance(name, instance)
    end)

    CollectionService:GetInstanceRemovedSignal(name):Connect(function(instance: Instance)
        self:_removeInstance(name, instance)
    end)
end

--[[
    Handles a new instance as long as it matches the tag instance type.

    @private
    @param {string} name [The name of the tag.]
    @returns never
]]
function TagService:_newInstance(name: string, instance: Instance)
    if not instance:IsA(CLIENT_TAGS[name][1]) or not instance:IsDescendantOf(workspace) then
        return
    end

    objects[name][instance] = CLIENT_TAGS[name][2].new(instance)
end

--[[
    Handles a new instance as long as it matches the tag instance type.

    @private
    @param {string} name [The name of the tag.]
    @returns never
]]
function TagService:_removeInstance(name: string, instance: Instance)
    if objects[name][instance] ~= nil then
        return
    end

    objects[name][instance]:destroy()
end

for name: string, data: { string } in pairs(CLIENT_TAGS) do
    TagService:register(name)
end

return TagService
