local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local Fluid = require(ReplicatedStorage.Packages.Fluid)

local camera: Camera = workspace.CurrentCamera
local shakerOrigin: CFrame = nil
local shakerActive: boolean = false

local CameraService = {
    shaker = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(cframe: CFrame)
        if not shakerActive then
            return
        end

        camera.CFrame = shakerOrigin * cframe
    end),
}

--[[
    Sets the camera type.

    @param {Enum.CameraType} type [The camera type.]
    @returns never
]]
function CameraService:setType(type: Enum.CameraType)
    repeat
        camera.CameraType = type
        task.wait()
    until camera.CameraType == type
end

--[[
    Sets the camera position.

    @param {CFrame} position [The camera position.]
    @param {number?} speed [If not nil the camera will tween to the position using this speed as the duration.]
    @returns never
]]
function CameraService:setPosition(position: CFrame, speed: number?)
    assert(
        camera.CameraType == Enum.CameraType.Scriptable,
        "'setPosition' method can only be used with the camera type: 'Scriptable'."
    )

    shakerOrigin = position

    if typeof(speed) == "number" then
        Fluid:create(camera, {
            duration = speed,
            easing = "Linear",
            destroyOnComplete = true,
        }, {
            CFrame = position,
        }):play()
    else
        camera.CFrame = position
    end
end

--[[
    Toggles the camera shaker.

    @param {boolean} active [If the shaker should be active.]
    @returns never
]]
function CameraService:toggleShaker(active: boolean)
    assert(
        camera.CameraType == Enum.CameraType.Scriptable,
        "'setPosition' method can only be used with the camera type: 'Scriptable'."
    )

    shakerActive = active

    if active then
        self.shaker:Start()
    else
        self.shaker:Stop()
    end
end

return CameraService
