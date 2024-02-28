local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Knit = require(ReplicatedStorage.Packages.Knit)

local MOVE_DEBOUNCE: number = 1

local types = require(ReplicatedStorage.types)
local raycastParams: RaycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local controls: { [Enum.KeyCode]: Vector3 } = {
    [Enum.KeyCode.W] = Vector3.new(),
    [Enum.KeyCode.S] = Vector3.new(),
    [Enum.KeyCode.A] = Vector3.new(),
    [Enum.KeyCode.D] = Vector3.new(),
}
local playerController
local modeService

Knit.OnStart:andThen(function()
    playerController = Knit.GetController("Player")
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
    _startingledge: Part,
    _janitor: types.Janitor,
    destroy: () -> never,
    _findLedge: (origin: Vector3, direction: Vector3) -> Instance?,
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
    Checks if a ledge exists using a raycast.

    @private
    @param {Vector3} origin [The origin of the raycast.]
    @param {Vector3} direction [The direction of the raycast.]
    @returns Instance?
]]
function class:_findLedge(origin: Vector3, direction: Vector3): Instance?
    local rasycast: RaycastResult = workspace:Raycast(origin, direction, raycastParams)
    return if rasycast ~= nil then rasycast.Instance else nil
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

    local currentLedge: Part = self._startingLedge

    controls[Enum.KeyCode.W] = currentLedge.CFrame.UpVector * -5
    controls[Enum.KeyCode.S] = currentLedge.CFrame.UpVector * -5
    controls[Enum.KeyCode.A] = currentLedge.CFrame.RightVector * -5
    controls[Enum.KeyCode.D] = currentLedge.CFrame.RightVector * 5

    local direction: Vector3? = controls[input.KeyCode]

    if typeof(direction) ~= "Vector3" then
        return
    end

    local currentTime: number = os.clock()

    if currentTime - self._lastMove <= MOVE_DEBOUNCE then
        return
    end

    self._lastMove = currentTime

    local characterRoot: Part = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local nextLedge: Part? = class:_findLedge(currentLedge.CFrame.Position, direction)

    if nextLedge ~= nil then
        currentLedge = nextLedge
        modeService.Client.event:FireServer(nextLedge)
    end
end

return class
