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
    _climbSpeed: number,
    _janitor: types.Janitor,
    _currentPlayer: number,
    _currentPlayerCharacter: Model,
}

--[[
    Creates and starts the controller.

    @constructor
    @returns class
]]
function class.new(): class
    local self = setmetatable({
        _climbSpeed = 1,
        _janitor = Janitor.new(),
        _currentPlayer = nil,
        _currentPlayerCharacter = nil,
    }, class)

    self._janitor:Add(modeService.Client.event:Connect(function(event: string, player: Player, ...)
        if event == "climbMove" and player.UserId == self._currentPlayer then
            self:_move(...)
        end
    end))

    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    self._janitor:Destroy()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Sets it to be a players turn.

    @param {number} userID [The ID of the player.]
    @returns never
]]
function class:setPlayerTurn(userID: number)
    local player: Player = Players:GetPlayerByUserId(userID)
    local character: Model = player.Character or player.CharacterAdded:Wait()
    self._currentPlayer = userID
    self._currentPlayerCharacter = character
end

--[[
    Moves the current player to the next ledge.

    @private
    @param {BasePart} ledge [The ledge to move to.]
    @returns never
]]
function class:_move(ledge: BasePart)
    self._janitor:Add(Fluid:create(self._currentPlayerCharacter, {
        duration = self._climbSpeed,
        easing = "Linear",
        method = "RenderStepped",
    }, { CFrame = ledge.CFrame * self._offset }):play())
end

return class
