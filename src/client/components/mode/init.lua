local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local modeController

Knit:OnStart():andThen(function()
    modeController = Knit.GetController("mode")
end)

--[[
    The base class for a mode.

    @class
    @public
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    destroy: () -> never,
    _setupUI: () -> never,
    _janitor: any,
}

--[[
    Creates a mode.

    @constructor
    @returns class
]]
function class.new(): class
    local self = setmetatable({}, class)
    self._janitor = Janitor.new()
    return self
end

--[[
    Destroys the object, clears, and freezes it to render is unusable.

    @returns never
]]
function class:destroy()
    self._janitor:Destroy()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Starts the mode.

    @returns never
]]
function class:start()
    self:_setupUI()
end

--[[
    Handles creating the mode UI.

    @returns never
]]
function class:_setupUI()
    local uiController = modeController:getMode().config.ui

    -- If the mode has no UI controller then we dont have to anything.
    if uiController == nil then
        return
    end

    local ui = require(uiController)()
    self._janitor:Add(ui)
end

return class
