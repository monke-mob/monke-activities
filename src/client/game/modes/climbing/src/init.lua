local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Knit = require(ReplicatedStorage.Packages.Knit)

local climbingCamera = require(script.camera)
local climbingController = require(script.climbing)
local modeComponent = require(script.Parent.Parent.Parent.Parent.components.mode)
local modeService

Knit.OnStart():andThen(function()
    modeService = Knit.GetService("mode")
end)

--[[
    The class for the climbing mode.

    @class
    @public
]]
local class = {}
class.__index = class
setmetatable(class, modeComponent)

export type class = modeComponent.class & {
    currentPlayer: Player | nil,
    currentPlayerText: any,
    _camera: climbingCamera.class,
    _climbingController: climbingController.class,
    _setPlayerTurn: (userID: number) -> never,
}

--[[
    Creates the mode.

    @constructor
    @returns class
]]
function class.new(): class
    local baseClass = modeComponent.new()
    local self = setmetatable(baseClass, class)

    self.currentPlayer = nil
    self.currentPlayerText = Fusion.Value("")
    self._camera = climbingCamera.new()
    self._janitor:Add(self._camera, "destroy")

    self._janitor:Add(modeService.event:Connect(function(event: string, ...)
        if event == "setPlayerTurn" then
            self:_setPlayerTurn(...)
        end
    end))

    return self
end

--[[
    Sets it to be a players turn.

    @param {number} userID [The ID of the player.]
    @returns never
]]
function class:_setPlayerTurn(userID: number)
    if userID == Players.LocalPlayer.UserId then
        self._climbingController = climbingController.new()
        self._janitor:Add(self._climbingController, "destroy", "climbingController")
    elseif self._climbingController then
        self._climbingController = nil
        self._janitor:Remove("climbingController")
    end

    local player: Player = Players:GetPlayerByUserId(userID)
    self.currentPlayer = player
    self.currentPlayerText:set(player.DisplayName)
    self._camera:changeTarget(player.Character or player.CharacterAdded:Wait())
end

return class
