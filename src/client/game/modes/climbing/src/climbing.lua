local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local LERP_SPEED: number = 0.2
local REACH_DISTANCE: number = 4
local DISTANCE_FROM_SURFACE: number = 2

local types = require(ReplicatedStorage.types)
local raycastParams: RaycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
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
    local character: Model = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()

    local self = setmetatable({
        _speed = 20,
        _janitor = Janitor.new(),
        _currentPosition = nil,
        _characterRoot = character:WaitForChild("HumanoidRootPart"),
        _characterHumanoid = character:WaitForChild("Humanoid"),
    }, class)

    self:_start()

    return self
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    self._janitor:Destroy()

    self._characterRoot.Anchored = false

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Starts the climbing system.

    @private
    @returns never
]]
function class:_start()
    playerController:disableMovement()
    self._characterRoot.Anchored = true

    self._janitor:Add(modeService.event:Connect(function(event: string, ...)
        if event == "getClimbable" then
            raycastParams.FilterDescendantsInstances = { ... }
        end
    end))

    modeService.event:Fire("getClimbable")

    self._janitor:Add(RunService.RenderStepped:Connect(function(...)
        self:_update(...)
    end))
end

--[[
    Updates the position.

    @private
    @param {number} deltaTime [The delta time.]
    @returns never 
]]
function class:_update(deltaTime: number)
    local raycastResult: RaycastResult = self:_raycast()

    if raycastResult == nil then
        return
    end

    local timeMutliplier: number = deltaTime * 60
    local cframe = self:_getCFrame(raycastResult)
    local moveVector = self:_getMoveVector(cframe)

    self._currentPosition = cframe
    self._currentPosition += moveVector * self._speed * deltaTime

    self._characterRoot.Anchored = true
    self._characterRoot.CFrame = self._characterRoot.CFrame:Lerp(self._currentPosition, LERP_SPEED * timeMutliplier)
end

function class:_raycast()
    if not self._currentPosition then
        self._currentPosition = self._characterRoot.CFrame
    end

    return workspace:Raycast(
        self._currentPosition.Position,
        self._currentPosition.LookVector * REACH_DISTANCE,
        raycastParams
    )
end

function class:_getCFrame(raycast: RaycastResult)
    local lookVector = raycast.Normal * -1
    local rightVector = lookVector:Cross(Vector3.yAxis).Unit
    local upVector = rightVector:Cross(lookVector).Unit

    local position = raycast.Position + (raycast.Normal * DISTANCE_FROM_SURFACE)

    return CFrame.fromMatrix(position, rightVector, upVector)
end

function class:_getMoveVector(position: CFrame)
    local normalCFrame = position * CFrame.Angles(math.pi / -2, 0, 0)

    local moveDirection = self._characterHumanoid.MoveDirection

    local relativeMoveDirection = workspace.CurrentCamera.CFrame.Rotation:PointToObjectSpace(moveDirection)
    relativeMoveDirection *= Vector3.new(1, 0, -1)

    if relativeMoveDirection.Magnitude > 0 then
        relativeMoveDirection = relativeMoveDirection.Unit
    end

    local moveVector = normalCFrame.Rotation:PointToWorldSpace(relativeMoveDirection)

    return moveVector
end

return class
