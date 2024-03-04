local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local currentCamera: Camera = workspace.CurrentCamera

local cameraController = Knit.CreateController({
    Name = "camera",
})

--[[
    Sets the camera type.

    @param {Enum.CameraType} type [The camera type.]
	@returns never
--]]
function cameraController:setCameraType(type: Enum.CameraType)
    repeat
        currentCamera.CameraType = type
    until currentCamera.CameraType == type
end

return cameraController
