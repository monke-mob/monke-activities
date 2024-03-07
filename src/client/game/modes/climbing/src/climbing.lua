local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local MOVE_DEBOUNCE: number = 1

local types = require(ReplicatedStorage.types)
local raycastParams: RaycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local playerController
local modeService

Knit.OnStart():andThen(function()
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
    _janitor: types.Janitor,
    _cooldown: number,
    _raycastDistance: number,
    _holdDistanceFromWall: number,
    _climbSpeed: number,
    _animationSpeed: number,
    _lastClimb: number,
    _currentPlayer: Player | nil,
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
        _janitor = Janitor.new(),
        _cooldown = 0.25,
        _raycastDistance = 4,
        _holdDistanceFromWall = 2,
        _climbSpeed = 20,
        _animationSpeed = 2,
        _lastClimb = 0,
        _currentPlayer = Players.LocalPlayer,
    }, class)

    self._janitor:Add(RunService.RenderStepped:Connect(function(...)
        self:OnFrameUpdate(...)
    end))

    print("climbing controller has started")

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

function class:_onFrameUpdate(deltaTime: number)
    local raycastResult = self:raycast()

    if raycastResult and self:_checkCooldown() then
        self:_climb(raycastResult, deltaTime)
    end
end

function class:_raycast(deltaTime: number)
    if not self.CFrame then
        self.CFrame = self._currentPlayer.Character.HumanoidRootPart.CFrame
    end

    local position: Vector3 = self.CFrame.Position
    local direction: Vector3 = self.CFrame.LookVector

    local raycastParams: RaycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {}

    local raycastResult: RaycastResult = workspace:Raycast(position, direction * self._raycastDistance, raycastParams)

    return raycastResult
end

function class:_checkCooldown()
    local currentTime: number = os.clock()

    if currentTime - self._lastClimb < self._cooldown then
        return
    end

    return true
end

function class:_getClimbCFrame(rasycastResult: RaycastResult)
    local lookVector: Vector3 = rasycastResult.Normal * -1
    local rightVector: Vector3 = lookVector:Cross(Vector3.yAxis).Unit
    local upVector: Vector3 = rightVector:Cross(lookVector).Unit

    local position = rasycastResult.Position + rasycastResult.Normal * self._holdDistanceFromWall

    return CFrame.fromMatrix(position, rightVector, upVector)
end

function class:_getMoveVector(cframe: CFrame)
    local normalCframe: CFrame = cframe * CFrame.Angles(math.pi / -2, 0, 0)

    local moveDirection: Vector3 = self._currentPlayer.Character.Humanoid.moveDirection

    local relativeMoveDirection = workspace.CurrentCamera.CFrame.Rotation:PointToObjectSpace(moveDirection)
    relativeMoveDirection *= Vector3.new(1, 0, -1)

    if relativeMoveDirection.Magitiude > 0 then
        relativeMoveDirection = relativeMoveDirection.Unit
    end

    local moveVector = normalCframe.Rotation:PointToWorldSpace(relativeMoveDirection)

    return moveVector
end

function class:_climb(rasycastResult: RaycastResult, deltaTime: number)
    self._framerate = 60
    local timeMultiplier = deltaTime * self._framerate * deltaTime
end

return class
