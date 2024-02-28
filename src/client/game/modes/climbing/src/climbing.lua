local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local MOVE_DEBOUNCE: number = 1

local types = require(ReplicatedStorage.types)
local raycastParams: RaycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local playerController
local modeService

Knit.OnStart:andThen(function()
    playerController = Knit.GetController("player")
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
    _lastMove: number,
    _currentLedge: BasePart,
    _maxDistance: number,
    _janitor: types.Janitor,
    _controls: { [Enum.KeyCode]: Vector3 },
    destroy: () -> never,
    _findLedge: (origin: Vector3, direction: Vector3) -> BasePart?,
    _updateControls: () -> never,
    _handleInput: (input: InputObject, processed: boolean) -> never,
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
        _currentLedge = nil,
        _maxDistance = 5,
        _janitor = Janitor.new(),
        _controls = {
            [Enum.KeyCode.W] = Vector3.new(),
            [Enum.KeyCode.S] = Vector3.new(),
            [Enum.KeyCode.A] = Vector3.new(),
            [Enum.KeyCode.D] = Vector3.new(),
        },
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
    Checks if a ledge exists using a raycast.

    @private
    @param {Vector3} origin [The origin of the raycast.]
    @param {Vector3} direction [The direction of the raycast.]
    @returns BasePart?
]]
function class:_findLedge(origin: Vector3, direction: Vector3): BasePart?
    local rasycast: RaycastResult = workspace:Raycast(origin, direction, raycastParams)
    return if rasycast ~= nil then rasycast.Instance :: BasePart else nil
end

--[[
    Updates the control directions based off the current position.

    @private
    @returns never
]]
function class:_updateControls()
    self._controls[Enum.KeyCode.W] = self._currentLedge.CFrame.UpVector * -self._maxDistance
    self._controls[Enum.KeyCode.S] = self._currentLedge.CFrame.UpVector * -self._maxDistance
    self._controls[Enum.KeyCode.A] = self._currentLedge.CFrame.RightVector * -self._maxDistance
    self._controls[Enum.KeyCode.D] = self._currentLedge.CFrame.RightVector * self._maxDistance
end

--[[
    Determines what action to take based on the players input.

    @private
    @param {InputObject} input [The player input.]
    @param {boolean} processed [If the input was processed by the engine.]
    @returns never 
]]
function class:_handleInput(input: InputObject, processed: boolean)
    if processed then
        return
    end

    local direction: Vector3? = self._controls[input.KeyCode]

    if typeof(direction) ~= "Vector3" then
        return
    end

    local currentTime: number = os.clock()

    if currentTime - self._lastMove <= MOVE_DEBOUNCE then
        return
    end

    self._lastMove = currentTime

    local characterRoot: Part = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local nextLedge: BasePart? = self:_findLedge(self._currentLedge.CFrame.Position, direction)

    if nextLedge ~= nil then
        self._currentLedge = nextLedge
        self:_updateControls()
        modeService.Client.event:FireServer("climbMove", nextLedge)
    end
end

return class
