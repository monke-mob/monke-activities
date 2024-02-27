local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local COOLDOWN: number = 1

local types = require(ReplicatedStorage.types)
local playerController
local raycastParams: RaycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

Knit.OnStart:andThen(function()
    playerController = Knit:GetController("Player")
end)

--[[
    The class for the climbing controller.

    @class
    @private
]]
local class = {}
class.__index = class

export type class = typeof(setmetatable({}, {})) & {
    _lastMove: number,
    _janitor: types.Janitor,
    destroy: () -> never,
    _moveToLedge: (origin: Vector3, direction: Vector3) -> never,
    _onInputBegan: (input: InputObject, gameProcessedEvent: boolean) -> never,
}

--[[
    Creates and starts the controller.

    @constructor
    @returns class
]]
function class.new(): class
    playerController:disableMovement()
    raycastParams.FilterDescendantsInstances = { Players.LocalPlayer.Character }

    local self = setmetatable({
        _lastMove = 0,
        _janitor = Janitor.new(),
    }, class)

    self._janitor:Add(UserInputService.InputBegan:Connect(function(...)
        self:_handleInput(...)
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
    Check if their a ledge in the direction the player is inputting.

    @returns Instance?
]]
function class:_moveToLedge(origin: Vector3, direction: Vector3): Instance?
    local rasycast: RaycastResult = workspace:Raycast(origin, direction, raycastParams)
    return if rasycast ~= nil then rasycast.Instance else nil
end

--[[
    Determines what action to take based on the players input.

    @returns never 
]]
function class:_handleInput(input: InputObject, processed: boolean)
    if processed == true then
        return
    end
    local humanoidRootPart = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    local controls = {
        [Enum.KeyCode.W] = nil,
        [Enum.KeyCode.S] = nil,
        [Enum.KeyCode.A] = nil,
        [Enum.KeyCode.D] = nil,
    }

    if controls[input.KeyCode] then
        if os.clock() - self._lastMove > COOLDOWN then
            self._lastMove = os.clock()
        end
    end
end

return class
