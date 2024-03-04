local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local roundInfoVisibleAction = require(script.Parent.Parent.components.app.actions.roundInfo.visible)
local types = require(ReplicatedStorage.types)
local modeController

Knit.OnStart():andThen(function()
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
    _janitor: types.Janitor,
    destroy: () -> never,
    start: () -> never,
    _setupUI: () -> never,
}

--[[
    Creates a mode.

    @constructor
    @returns class
]]
function class.new(): class
    local self = setmetatable({
        _janitor = Janitor.new(),
    }, class)
    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    roundInfoVisibleAction:set(true)
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
    roundInfoVisibleAction:set(false)
    self:_setupUI()
end

--[[
    Creates and starts the mode UI.

    @private
    @returns never
]]
function class:_setupUI()
    local uiController: ModuleScript = modeController:getModeConfig().ui

    -- If the mode has no UI controller then we dont have to anything.
    if typeof(uiController) ~= "ModuleScript" then
        return
    end

    self._janitor:Add(require(uiController)())
end

return class
