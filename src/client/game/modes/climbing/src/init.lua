local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Knit = require(ReplicatedStorage.Packages.Knit)

local camera = require(script.camera)
local modeComponent = require(script.Parent.Parent.Parent.Parent.components.mode)
local modeService

Knit:OnStart():andThen(function()
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

--[[
    Creates the mode.

    @constructor
    @returns class
]]
function class.new()
    local baseClass = modeComponent.new()
    local self = setmetatable(baseClass, class)
    camera.start()

    self.currentPlayer = nil
    self.currentPlayerText = Fusion.Value("")

    self._janitor:Add(modeService.event:Connect(function(event: string, ...)
        if event == "setPlayerTurn" then
            self:setPlayerTurn(...)
        end
    end))

    self._janitor:Add(camera, "cleanup")

    return self
end

--[[
    Sets it to be a players turn.

    @param {number} userID [The player.]
    @returns never
]]
function class:setPlayerTurn(userID: number)
    local player = Players:GetPlayerByUserId(userID)
    self.currentPlayer = player
    self.currentPlayerText:set(player.DisplayName)
    camera.changeTarget(player.Character or player.CharacterAdded:Wait())
end

return class
