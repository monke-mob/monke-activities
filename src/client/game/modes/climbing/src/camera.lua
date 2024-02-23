local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Janitor = require(ReplicatedStorage.Packages.Janitor)

local types = require(ReplicatedStorage.types)
local currentCamera = workspace.CurrentCamera

--[[
    The class for the camera controller.

    @class
    @private
]]
local class = {}
class._index = class

export type class = typeof(setmetatable({}, {})) & {
    _target: Instance | nil,
    _janitor: types.Janitor,
}

--[[
    Creates and starts the camera.

    @constructor
    @returns class
]]
function class.new(): class
    local self = setmetatable({
        _janitor = Janitor.new(),
    }, class)

    self:start()

    return self
end

--[[
    Changes the cameras target to the passed player.
    
    @param {Model} target [The target character.]
    @returns never 
]]
function class:changeTarget(target: Model)
    self._target = target:FindFirstChild("HumanoidRootPart")
end

--[[
    Destroys the object, clears, and freezes it to render it unusable.

    @returns never
]]
function class:destroy()
    self._janitor:Destroy()

    repeat
        currentCamera.CameraType = Enum.CameraType.Custom
    until currentCamera.CameraType == Enum.CameraType.Custom

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Starts the camera.
    
    @private
    @returns never
]]
function class:_start()
    repeat
        currentCamera.CameraType = Enum.CameraType.Scriptable
    until currentCamera.CameraType == Enum.CameraType.Scriptable

    self._janitor:Add(RunService.RenderStepped:Connect(function()
        if self.target == nil then
            return
        end

        local forwardVector = self.target.CFrame.LookVector
        local newCameraPosition = self.target.Position - forwardVector * Vector3.new(0, 0, 25)
        currentCamera.CFrame = CFrame.new(newCameraPosition, self.target.Position)
    end))
end

return class
