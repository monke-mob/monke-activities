local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)
local Future = require(ReplicatedStorage.Packages.Future)
local SceneService = require(ReplicatedFirst.Services.Scene)

local DOOR_TWEEN_INFO = {
    duration = 3,
    easing = "EaseInOut",
    destroyOnComplete = true,
}

local Doors = {
    _leftDoorTween = nil,
    _rightDoorTween = nil,
    _lightBlackTween = nil,
    lightTween = nil,
    finished = false,
}

--[[
    Creates the light and door tweens.

    @returns never
]]
function Doors:prepare()
    local container: Model = SceneService.map:FindFirstChild("Elevator"):FindFirstChild("Doors")
    local lightContainer: BasePart = container:FindFirstChild("Light") :: BasePart
    local lightBlack: BasePart = lightContainer:FindFirstChild("Black") :: BasePart

    local leftDoor: Part = container:FindFirstChild("Left") :: Part
    self._leftDoorTween = Fluid:create(leftDoor, DOOR_TWEEN_INFO, {
        Position = (leftDoor:FindFirstChild("Opened") :: Attachment).WorldPosition,
    })

    local rightDoor: Part = container:FindFirstChild("Right") :: Part
    self._rightDoorTween = Fluid:create(rightDoor, DOOR_TWEEN_INFO, {
        Position = (rightDoor:FindFirstChild("Opened") :: Attachment).WorldPosition,
    })

    self._lightBlackTween = Fluid:create(lightBlack, {
        duration = 0.25,
        easing = "EaseInOut",
        destroyOnComplete = true,
    }, {
        Transparency = 1,
    })

    self.lightTween = Fluid:create(lightContainer:FindFirstChild("Light"), {
        duration = 0.2,
        easing = "Linear",
    }, {
        Position = {
            (lightBlack:FindFirstChild("Start") :: Attachment).WorldPosition,
            (lightBlack:FindFirstChild("End") :: Attachment).WorldPosition,
        },
    })
end

--[[
    Destroys the light tween and opens the doors.

    @returns Future
]]
function Doors:unload()
    self.lightTween:destroy()
    self._leftDoorTween:play()
    self._rightDoorTween:play()
    self._lightBlackTween:play()

    return Future.new(function()
        task.wait(DOOR_TWEEN_INFO.duration)

        return
    end)
end

return Doors
