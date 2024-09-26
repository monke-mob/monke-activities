local ReplicatedFirst = game:GetService("ReplicatedFirst")

local CameraService = require(ReplicatedFirst.Services.Camera)

local Elevator = require(script.Elevator)

local Client = {}

function Client:prepare()
    CameraService:setType(Enum.CameraType.Scriptable)

    Elevator:prepare()
end

function Client:load()
    Elevator:load():Await()
    Elevator:unload():Await()

    self:unload()
end

function Client:unload()
    CameraService:setType(Enum.CameraType.Custom)
end

return Client
