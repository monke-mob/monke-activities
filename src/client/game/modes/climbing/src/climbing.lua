local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)
local PlayerController

Knit.OnStart:andThen(function()
    PlayerController = Knit:GetController("Player")
end)

--[[
    The class for the climbing controller.

    @class
    @private
]]
local class = {}
class.__index = class

local cooldown: number = 1
local lastClimb: number = 0

--[[
    Creates and starts the controller.

    @constructor
    @returns class
]]
function class.new()
    local self = setmetatable({}, class)
    self._janitor = Janitor.new()

    self._janitor:Add(UserInputService.InputBegan:Connect(_onInputBegan))

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
    Check if their a ledge in the direction the player is inputting.

    @returns instance 
]]
function class:_moveToLedge(origin: Vector3, direction: Vector3)
    local raycastParams: RaycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { Players.LocalPlayer.Character }

    local rasycast: RaycastResult = workspace:Raycast(origin, direction)

    if rasycast ~= nil then
        return rasycast.Instance
    end
end

function _onInputBegan(input: InputObject, gameProcessedEvent: boolean)
    if gameProcessedEvent == true then
        return
    end
    local humanoidRootPart = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    local controls = {
        [Enum.KeyCode.W] = nil,
        [Enum.KeyCode.S] = nil,
        [Enum.KeyCode.A] = nil,
        [Enum.KeyCode.D] = nil,
    }

    if controls[input.KeyCode.KeyCode] then
        if os.clock() - lastClimb > cooldown then
            lastClimb = os.clock()
        end
    end
end

return class
