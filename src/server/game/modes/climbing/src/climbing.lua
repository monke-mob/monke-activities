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

export type class = typeof(setmetatable({}, {})) & {
    _player: Player,
    _startingLedge: Part,
    _climbSpeed: number,
    _tweenInfo: { any },
}

--[[
    Creates and starts the controller.

    @constructor
    @returns class
]]
function class.new(janitor: types.Janitor): class
    local self = setmetatable({}, class)
    self._offset = CFrame.new(0, 0, 0)
    self._climbSpeed = 1

    self.tweenInfo = {
        duration = self._climbSpeed,
        easing = "Linear",
        method = "RenderStepped",
    }

    janitor:Add(Players.PlayerAdded:Connect(function(...)
        self._player = class:getPlayer(...)
    end))

    class:getStartingLedge(self._startingLedge, self._player)

    janitor:Add(modeService.Client.event:Connect(function(event: string, ...)
        if event ~= "climbMove" then
            return
        end
        class:tweenToLedge(...)
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

function class:getStartingLedge(startingLedge: Part, player: Player)
    local characterRoot: Part = (player.Character :: Model):FindFirstChild("HumanoidRootPart") :: any

    characterRoot.CFrame = startingLedge.CFrame * self._offset
    characterRoot.Anchored = true
end

function class:tweenToLedge(ledge: Part, player: Player)
    local characterRoot: Part = (player.Character :: Model):FindFirstChild("HumanoidRootPart") :: any

    Fluid:create(characterRoot, self._tweenInfo, { CFrame = ledge.CFrame * self._offset }):play()
end

function class:getPlayer(Player: Player)
    return Player
end

return class
