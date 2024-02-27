local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local types = require(ReplicatedStorage.types)
local modeService

Knit:OnStart():andThen(function()
    modeService = Knit.GetService("mode")
end)

--[[
    The class for the climbing controller.

    @class
    @private
]]
local class = {}
class.__index = class

--[[
    Creates and starts the controller.

    @constructor
    @returns class
]]
function class.new(janitor: types.Janitor)
    local self = setmetatable({}, class)

    janitor:Add(modeService.Client.event:Connect(function(event: string)
        if event ~= "climbMove" then
            return
        end
    end))

    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

function class:getStartingLedge()
    return 
end

return class